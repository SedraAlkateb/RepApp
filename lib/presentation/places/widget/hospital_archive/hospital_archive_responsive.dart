import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/places/bloc/place_bloc.dart';
import 'package:domina_app/presentation/places/widget/hospital_archive/hospital_archive_card.dart';
import 'package:domina_app/presentation/resources/responsive/app_responsive.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/uniti/search_field.dart';
import 'package:domina_app/presentation/uniti/stateWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HospitalArchiveResponsive extends StatelessWidget {
  const HospitalArchiveResponsive({
    super.key,
    required this.searchController,
  });

  final TextEditingController searchController;

  @override
  Widget build(BuildContext context) {
    final deviceType = AppResponsive.deviceType(context);

    double maxWidth;
    double horizontalPadding;
    double searchHorizontalPadding;
    double topPadding;
    double titleSize;
    double cardSpacing;

    switch (deviceType) {
      case AppDeviceType.mobilePortrait:
        maxWidth = 600;
        horizontalPadding = 12;
        searchHorizontalPadding = 12;
        topPadding = 12;
        titleSize = 17;
        cardSpacing = 14;
        break;

      case AppDeviceType.tabletPortrait:
        maxWidth = 720;
        horizontalPadding = 20;
        searchHorizontalPadding = 20;
        topPadding = 18;
        titleSize = 19;
        cardSpacing = 16;
        break;

      case AppDeviceType.tabletLandscape:
        maxWidth = 780;
        horizontalPadding = 24;

        // فقط السيرش بدون padding أفقي بالعرض
        searchHorizontalPadding = 0;

        topPadding = 14;
        titleSize = 19;
        cardSpacing = 16;
        break;
    }

    return ColoredBox(
      color: const Color(0xFFF8FAFC),
      child: BlocBuilder<PlaceBloc, PlaceState>(
        buildWhen: (previous, current) {
          return current is AllHospitalArchiveByPlaceState ||
              current is AllHospitalArchiveByPlaceErrorState ||
              current is EmptyArchiveState;
        },
        builder: (context, state) {
          if (state is AllHospitalArchiveByPlaceState) {
            return _HospitalArchiveSuccess(
              state: state,
              searchController: searchController,
              maxWidth: maxWidth,
              horizontalPadding: horizontalPadding,
              searchHorizontalPadding: searchHorizontalPadding,
              topPadding: topPadding,
              titleSize: titleSize,
              cardSpacing: cardSpacing,
            );
          }

          if (state is EmptyArchiveState) {
            return _HospitalArchiveEmpty(
              maxWidth: maxWidth,
            );
          }

          if (state is AllHospitalArchiveByPlaceErrorState) {
            return _HospitalArchiveError(
              maxWidth: maxWidth,
            );
          }

          return const _HospitalArchiveLoading();
        },
      ),
    );
  }
}

class _HospitalArchiveSuccess extends StatelessWidget {
  const _HospitalArchiveSuccess({
    required this.state,
    required this.searchController,
    required this.maxWidth,
    required this.horizontalPadding,
    required this.searchHorizontalPadding,
    required this.topPadding,
    required this.titleSize,
    required this.cardSpacing,
  });

  final AllHospitalArchiveByPlaceState state;
  final TextEditingController searchController;

  final double maxWidth;
  final double horizontalPadding;
  final double searchHorizontalPadding;
  final double topPadding;
  final double titleSize;
  final double cardSpacing;

  @override
  Widget build(BuildContext context) {
    final List<HospitalSpAllModel> hospitals =
    List<HospitalSpAllModel>.from(
      state.searchData,
    );

    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        // =========================
        // البحث
        // =========================
        SliverToBoxAdapter(
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: maxWidth,
              ),
              child: Padding(
                padding: EdgeInsets.fromLTRB(
                  searchHorizontalPadding,
                  topPadding,
                  searchHorizontalPadding,
                  0,
                ),
                child: SearchField(
                  searchController: searchController,
                  onPressed: (value) {
                    context.read<PlaceBloc>().add(
                      SearchHospitalArchive(
                        value,
                        state.baseData,
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ),

        // =========================
        // العنوان + العدد
        // =========================
        SliverToBoxAdapter(
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: maxWidth,
              ),
              child: Padding(
                padding: EdgeInsets.fromLTRB(
                  horizontalPadding,
                  20,
                  horizontalPadding,
                  14,
                ),
                child: _HospitalArchiveHeader(
                  count: hospitals.length,
                  titleSize: titleSize,
                ),
              ),
            ),
          ),
        ),

        // =========================
        // القائمة فارغة بعد البحث
        // =========================
        if (hospitals.isEmpty)
          SliverFillRemaining(
            hasScrollBody: false,
            child: Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: maxWidth,
                ),
                child: emptyFullScreen(context),
              ),
            ),
          )
        else

        // =========================
        // قائمة المشافي
        // =========================
          SliverPadding(
            padding: EdgeInsets.fromLTRB(
              horizontalPadding,
              0,
              horizontalPadding,
              32,
            ),
            sliver: SliverList.separated(
              itemCount: hospitals.length,
              separatorBuilder: (context, index) {
                return SizedBox(
                  height: cardSpacing,
                );
              },
              itemBuilder: (context, index) {
                final hospital = hospitals[index];

                return Center(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: maxWidth,
                    ),
                    child: HospitalArchiveCard(
                      hospital: hospital,
                    ),
                  ),
                );
              },
            ),
          ),

        const SliverToBoxAdapter(
          child: SizedBox(
            height: 24,
          ),
        ),
      ],
    );
  }
}

class _HospitalArchiveHeader extends StatelessWidget {
  const _HospitalArchiveHeader({
    required this.count,
    required this.titleSize,
  });

  final int count;
  final double titleSize;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            'قائمة المشافي المسجلين',
            textAlign: TextAlign.start,
            style: TextStyle(
              color: ColorManager.medicalText.withOpacity(0.8),
              fontWeight: FontWeight.bold,
              fontSize: titleSize,
            ),
          ),
        ),

        const SizedBox(width: 12),

        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 6,
          ),
          decoration: BoxDecoration(
            color: ColorManager.medicalPrimary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            '$count مشفى',
            style: TextStyle(
              color: ColorManager.medicalPrimary,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}

class _HospitalArchiveEmpty extends StatelessWidget {
  const _HospitalArchiveEmpty({
    required this.maxWidth,
  });

  final double maxWidth;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: maxWidth,
        ),
        child: emptyFullScreen(context),
      ),
    );
  }
}

class _HospitalArchiveError extends StatelessWidget {
  const _HospitalArchiveError({
    required this.maxWidth,
  });

  final double maxWidth;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: maxWidth,
        ),
        child: errorFullScreen(context),
      ),
    );
  }
}

class _HospitalArchiveLoading extends StatelessWidget {
  const _HospitalArchiveLoading();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: ColorManager.medicalPrimary,
      ),
    );
  }
}