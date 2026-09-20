import 'package:domina_app/app/di/di.dart';
import 'package:domina_app/app/user_info.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/senior/representative/page/rep_profile.dart';
import 'package:domina_app/presentation/drawer/pages/drawer_launcher.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/resources/responsive/app_ui.dart';
import 'package:domina_app/presentation/senior/all_city/bloc/bloc/all_city_bloc.dart';
import 'package:domina_app/presentation/senior/places/bloc/senior_reps_bloc.dart';
import 'package:domina_app/presentation/senior/places/widget/city_filter_search_widget.dart';
import 'package:domina_app/presentation/senior/places/widget/rep_card_widget.dart';
import 'package:domina_app/presentation/uniti/stateWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class AllRepSenior extends StatefulWidget {
  const AllRepSenior({
    super.key,
  });

  @override
  State<AllRepSenior> createState() => _AllRepSeniorState();
}

class _AllRepSeniorState extends State<AllRepSenior> {
  final TextEditingController _searchController = TextEditingController();
  final RefreshController _refreshController = RefreshController(initialRefresh: false);

  int? _lastLoadedCityId;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadSelectedCity();
    });
  }

  void _loadSelectedCity({bool force = false}) {
    if (!mounted) return;

    final cityBloc = context.read<AllCityBloc>();
    final int? cityId = cityBloc.selectedCityId;

    if (cityId == null || cityId < 0) return;
    if (!force && _lastLoadedCityId == cityId) return;

    _lastLoadedCityId = cityId;
    _searchController.clear();

    context.read<SeniorRepsBloc>().add(
      AllSeniorRepEvent(
        cityId,
        UserInfo.repId,
      ),
    );
  }

  void _onRefresh() {
    _loadSelectedCity(force: true);
    _refreshController.refreshCompleted();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ui = AppUi.of(context);
    final cityBloc = context.watch<AllCityBloc>();
    final cityState = cityBloc.state;

    final double contentMaxWidth = ui.isTabletLandscape ? 760 : ui.pageMaxWidth;

    return BlocListener<AllCityBloc, AllCityState>(
      listener: (context, state) {
        if (state is GetAllCityState) {
          _loadSelectedCity();
        }
      },
      child: Scaffold(
        drawer: UserInfo.repType.i == 6 ? const DrawerPage() : null,
        backgroundColor: const Color(0xFFF8FAFC),
        appBar: AppBar(
          elevation: 0,
          scrolledUnderElevation: 0,
          surfaceTintColor: Colors.transparent,
          backgroundColor: Colors.white,
          title: Text(
            cityBloc.selectedCityName.isEmpty
                ? 'تقارير المندوبين'
                : ' تقارير المندوبين (${cityBloc.selectedCityName})',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: ui.isMobile ? 18 : 21,
              fontWeight: FontWeight.w700,
              color: ColorManager.medicalPrimary,
            ),
          ),
          leading: Builder(
            builder: (context) {
              if (UserInfo.repType.i == 6) {
                return IconButton(
                  tooltip: 'القائمة',
                  icon: Icon(
                    Icons.menu_rounded,
                    size: ui.isMobile ? 26 : 28,
                    color: ColorManager.medicalPrimary,
                  ),
                  onPressed: () => Scaffold.of(context).openDrawer(),
                );
              }

              return IconButton(
                tooltip: 'رجوع',
                icon: Icon(
                  Icons.arrow_back_rounded,
                  size: ui.isMobile ? 24 : 27,
                  color: ColorManager.medicalPrimary,
                ),
                onPressed: () => Navigator.pop(context),
              );
            },
          ),
        ),
        body: Directionality(
          textDirection: TextDirection.rtl,
          // ✅ الـ SmartRefresher يأخذ كامل عرض الشاشة للتمرير والسحب من الأطراف
          child: SmartRefresher(
            controller: _refreshController,
            onRefresh: _onRefresh,
            enablePullDown: true,
            header: const WaterDropHeader(),
            child: CustomScrollView(
              physics: const AlwaysScrollableScrollPhysics(
                parent: BouncingScrollPhysics(),
              ),
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              slivers: [
                // =========================================
                // Header
                // =========================================
                SliverPadding(
                  padding: EdgeInsets.fromLTRB(
                    ui.pagePadding,
                    ui.headerTopPadding,
                    ui.pagePadding,
                    0,
                  ),
                  sliver: SliverToBoxAdapter(
                    child: Center(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(maxWidth: contentMaxWidth),
                        child: _buildHeader(ui),
                      ),
                    ),
                  ),
                ),

                // =========================================
                // Search + City Filter
                // =========================================
                SliverPadding(
                  padding: EdgeInsets.fromLTRB(
                    ui.pagePadding,
                    ui.searchTopPadding,
                    ui.pagePadding,
                    ui.searchBottomPadding,
                  ),
                  sliver: SliverToBoxAdapter(
                    child: Center(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(maxWidth: contentMaxWidth),
                        child: SearchWithCityFilter(
                          searchController: _searchController,
                          onSearch: (value) {
                            context.read<SeniorRepsBloc>().add(
                              SenSearchRepEvent(value),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),

                // =========================================
                // City Loading
                // =========================================
                if (cityState is AllCityLoadingState)
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: loadingFullScreen(context),
                  )

                // =========================================
                // City Error
                // =========================================
                else if (cityState is AllCityErrorState)
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: errorFullScreen(
                      context,
                      mes: cityState.failure.massage,
                      func: () {
                        context.read<AllCityBloc>().add(
                          const GetAllCityEvent(),
                        );
                      },
                    ),
                  )

                // =========================================
                // No Cities
                // =========================================
                else if (cityBloc.selectedCityId == null)
                    SliverFillRemaining(
                      hasScrollBody: false,
                      child: emptyFullScreen(
                        context,
                        message: 'لا توجد محافظات متاحة',
                      ),
                    )

                  // =========================================
                  // Representatives
                  // =========================================
                  else
                    SliverPadding(
                      padding: EdgeInsets.fromLTRB(
                        ui.pagePadding,
                        ui.listTopPadding,
                        ui.pagePadding,
                        ui.listBottomPadding,
                      ),
                      sliver: _buildRepsList(ui, contentMaxWidth),
                    ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(AppUi ui) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Text(
                'إدارة المندوبين',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: ui.pageTitleSize,
                  fontWeight: FontWeight.w800,
                  color: ColorManager.medicalPrimary,
                ),
              ),
            ),
            SizedBox(width: ui.mediumSpacing),
            Container(
              width: 40,
              height: 5,
              decoration: BoxDecoration(
                color: ColorManager.medicalPrimary,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ],
        ),
        SizedBox(height: ui.smallSpacing),
        Text(
          'اختر مندوباً لمراجعة الأداء والتقارير',
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: ui.pageSubtitleSize,
            color: const Color(0xFF64748B),
            fontWeight: FontWeight.w500,
            height: 1.4,
          ),
        ),
      ],
    );
  }

  Widget _buildRepsList(AppUi ui, double contentMaxWidth) {
    return BlocBuilder<SeniorRepsBloc, SeniorRepsState>(
      builder: (context, state) {
        List<AllRepresentative> list =
            context.read<SeniorRepsBloc>().allRepresentative;

        if (state is AllSeniorRepLoadingState) {
          return SliverToBoxAdapter(
            child: Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: contentMaxWidth),
                child: loadingShimmer(
                  context,
                  5,
                  100,
                  20,
                  BorderRadius.circular(ui.cardRadius),
                ),
              ),
            ),
          );
        }

        if (state is AllSeniorRepErrorState) {
          return SliverFillRemaining(
            hasScrollBody: false,
            child: errorFullScreen(
              context,
              func: _onRefresh,
            ),
          );
        }

        if (state is AllSeniorRepState) {
          list = state.representatives;
        }

        if (list.isEmpty) {
          return SliverFillRemaining(
            hasScrollBody: false,
            child: emptyFullScreen(context),
          );
        }

        return SliverList(
          delegate: SliverChildBuilderDelegate(
                (context, index) {
              final rep = list[index];

              return Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: contentMaxWidth),
                  child: Padding(
                    padding: EdgeInsets.only(bottom: ui.cardSpacing),
                    child: RepresentativeCard(
                      allRepresentative: rep,
                      onTap: () {
                        initSeniorProfModule();
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => RepProfile(
                              index: index,
                              repPlanId: rep.activePlan,
                              id: rep.id,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              );
            },
            childCount: list.length,
          ),
        );
      },
    );
  }
}