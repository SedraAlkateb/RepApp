import 'package:domina_app/app/user_info.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/drawer/pages/drawer_launcher.dart';
import 'package:domina_app/presentation/place_visit/bloc/visit_place_bloc.dart';
import 'package:domina_app/presentation/place_visit/widget/animation_press.dart';
import 'package:domina_app/presentation/places/bloc/place_bloc.dart';
import 'package:domina_app/presentation/places/widget/places_search.dart';
import 'package:domina_app/presentation/places/widget/places_sync_warning.dart';
import 'package:domina_app/presentation/resources/app_palette.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/resources/responsive/app_responsive.dart';
import 'package:domina_app/presentation/resources/routes_manager.dart';
import 'package:domina_app/presentation/uniti/stateWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// صفحة المناطق. كل ويدجت الصفحة (التخطيط، المحتوى، القائمة، حوار أول دخول)
/// موجودة هنا كويدجت خاصة؛ المشترك مع الأرشيف فقط (البحث + تحذير المزامنة)
/// بقي في مجلد widget.
class Places extends StatefulWidget {
  const Places({super.key});

  @override
  State<Places> createState() => _PlacesState();
}

class _PlacesState extends State<Places> {
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();

    context.read<PlaceBloc>().add(NumEvent());

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showFirstEntryDialog();
    });
  }

  Future<void> _showFirstEntryDialog() async {
    if (!mounted) return;

    final placeBloc = context.read<PlaceBloc>();

    if (placeBloc.k != 0) {
      return;
    }

    // لمنع ظهور الإشعار مرة أخرى بسبب rebuild.
    placeBloc.k = 1;

    await showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (_) => const _FirstEntryDialog(),
    );
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: context.palette.bg,
        drawer: DrawerPage(),
        appBar: _buildAppBar(context),
        body: _Body(searchController: searchController),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: context.palette.bg,
      surfaceTintColor: Colors.transparent,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: Container(
          color: context.palette.border,
          height: 1,
        ),
      ),
      leading: Builder(
        builder: (context) {
          return IconButton(
            icon: Icon(
              Icons.menu,
              size: 30,
              color: context.palette.title,
            ),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          );
        },
      ),
      title: const Text('المناطق'),
    );
  }
}

/// المقاسات حسب نوع الجهاز.
class _Metrics {
  final double pageMaxWidth;
  final double listMaxWidth;
  final double horizontalPadding;
  final double fabInset;

  const _Metrics({
    required this.pageMaxWidth,
    required this.listMaxWidth,
    required this.horizontalPadding,
    required this.fabInset,
  });

  factory _Metrics.of(BuildContext context) {
    return switch (AppResponsive.deviceType(context)) {
      AppDeviceType.mobilePortrait => const _Metrics(
          pageMaxWidth: 600,
          listMaxWidth: 600,
          horizontalPadding: 16,
          fabInset: 18,
        ),
      AppDeviceType.tabletPortrait => const _Metrics(
          pageMaxWidth: 900,
          listMaxWidth: 720,
          horizontalPadding: 28,
          fabInset: 30,
        ),
      AppDeviceType.tabletLandscape => const _Metrics(
          pageMaxWidth: 1200,
          listMaxWidth: 780,
          horizontalPadding: 32,
          fabInset: 30,
        ),
    };
  }
}

class _Body extends StatelessWidget {
  final TextEditingController searchController;

  const _Body({required this.searchController});

  @override
  Widget build(BuildContext context) {
    final m = _Metrics.of(context);

    return Stack(
      children: [
        Positioned.fill(
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: m.pageMaxWidth),
              child: _Content(
                searchController: searchController,
                metrics: m,
              ),
            ),
          ),
        ),
        Positioned(
          left: m.fabInset,
          bottom: m.fabInset,
          child: SafeArea(
            child: FloatingActionButton(
              heroTag: 'places_sync_fab',
              backgroundColor: ColorManager.secondaryColor1,
              onPressed: () => Navigator.pushNamed(context, Routes.sync),
              child: Icon(
                Icons.wifi_protected_setup_outlined,
                color: ColorManager.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _Content extends StatelessWidget {
  final TextEditingController searchController;
  final _Metrics metrics;

  const _Content({
    required this.searchController,
    required this.metrics,
  });

  @override
  Widget build(BuildContext context) {
    final placeBloc = context.watch<PlaceBloc>();
    final showSyncWarning = UserInfo.endDate == placeBloc.data;

    Widget limited(Widget child) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: metrics.horizontalPadding),
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: metrics.listMaxWidth),
            child: child,
          ),
        ),
      );
    }

    return Column(
      children: [
        const SizedBox(height: 12),
        if (showSyncWarning) ...[
          limited(const PlacesSyncWarning()),
          const SizedBox(height: 12),
        ],
        limited(PlacesSearch(controller: searchController)),
        const SizedBox(height: 16),
        Expanded(child: _PlacesList(metrics: metrics)),
      ],
    );
  }
}

class _PlacesList extends StatelessWidget {
  final _Metrics metrics;

  const _PlacesList({required this.metrics});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PlaceBloc, PlaceState>(
      listener: _listener,
      builder: (context, state) {
        List<PlaceModel> places = context.watch<PlaceBloc>().placeSearchModel;

        if (state is AllPlaceState) {
          places = state.places;
        }

        if (state is SearchPlaceState) {
          places = state.places;
        }

        if (places.isEmpty) {
          return emptyFullScreen(context);
        }

        // ملاحظة: بدون ConstrainedBox خارجي حول الـ ListView، حتى يضل
        // السكرول بالماوس يشتغل فوق الفراغ الجانبي بالعرض؛ قيد maxWidth
        // يُطبَّق داخلياً على كل بطاقة لحالها.
        return ListView.separated(
          padding: EdgeInsets.fromLTRB(
            metrics.horizontalPadding,
            0,
            metrics.horizontalPadding,
            110,
          ),
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          itemCount: places.length,
          separatorBuilder: (_, __) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final place = places[index];

            return Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: metrics.listMaxWidth),
                child: AnimatedPlaceCard(
                  isRep: UserInfo.repType == 7,
                  place: place,
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      Routes.placeVisitPage,
                      arguments: place.placeId,
                    );

                    context.read<VisitPlaceBloc>().add(
                      DoctorByPlace(place.placeId, 0),
                    );
                  },
                ),
              ),
            );
          },
        );
      },
    );
  }

  void _listener(BuildContext context, PlaceState state) {
    if (state is AllPlaceErrorState) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!context.mounted) return;

        error(context, state.failure.massage, state.failure.code);
      });
    }

    if (state is CheckRepState && state.isCheck == false) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!context.mounted) return;

        Navigator.pushNamedAndRemoveUntil(
          context,
          Routes.logout,
          (route) => false,
          arguments: true, // بدون رفع: المندوب غير موجود بالسيرفر
        );
      });
    }
  }
}

class _FirstEntryDialog extends StatelessWidget {
  const _FirstEntryDialog();

  @override
  Widget build(BuildContext context) {
    final deviceType = AppResponsive.deviceType(context);

    final maxWidth = switch (deviceType) {
      AppDeviceType.mobilePortrait => 420.0,
      AppDeviceType.tabletPortrait => 520.0,
      AppDeviceType.tabletLandscape => 560.0,
    };

    final horizontalMargin = switch (deviceType) {
      AppDeviceType.mobilePortrait => 20.0,
      AppDeviceType.tabletPortrait => 40.0,
      AppDeviceType.tabletLandscape => 48.0,
    };

    final titleSize = switch (deviceType) {
      AppDeviceType.mobilePortrait => 19.0,
      AppDeviceType.tabletPortrait => 22.0,
      AppDeviceType.tabletLandscape => 22.0,
    };

    return Dialog(
      insetPadding: EdgeInsets.symmetric(
        horizontal: horizontalMargin,
        vertical: 24,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      backgroundColor: context.palette.surface,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 28, 24, 22),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: context.palette.primary.withOpacity(0.08),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.location_on_outlined,
                  size: 34,
                  color: context.palette.primary,
                ),
              ),
              const SizedBox(height: 22),
              Text(
                'اختيار المنطقة',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: titleSize,
                  fontWeight: FontWeight.bold,
                  color: context.palette.title,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'اختر إحدى المناطق لإظهار (الأطباء، المشافي) في المنطقة المختارة',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: titleSize - 2,
                  height: 1.6,
                  fontWeight: FontWeight.w500,
                  color: context.palette.text,
                ),
              ),
              const SizedBox(height: 26),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorManager.secondaryColor1,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () => Navigator.pop(context),
                  child: const Text(
                    'موافق',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
