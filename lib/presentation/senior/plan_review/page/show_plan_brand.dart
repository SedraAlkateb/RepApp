import 'package:domina_app/app/di/di.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/uniti/type_style.dart';
import 'package:domina_app/presentation/resources/responsive/app_responsive.dart';
import 'package:domina_app/presentation/senior/plan_review/bloc/plan_brands_info/plan_brands_info_bloc.dart';
import 'package:domina_app/presentation/uniti/search_field.dart';
import 'package:domina_app/presentation/uniti/stateWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class ShowPlanBrand extends StatefulWidget {
  const ShowPlanBrand({
    super.key,
    required this.planId,
  });

  final int planId;

  @override
  State<ShowPlanBrand> createState() => _ShowPlanBrandState();
}

class _ShowPlanBrandState extends State<ShowPlanBrand>
    with AutomaticKeepAliveClientMixin {
  final TextEditingController searchController = TextEditingController();

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return BlocProvider(
      lazy: false,
      create: (context) => instance<PlanBrandsInfoBloc>()
        ..add(
          GetPlanBrandsInfoEvent(
            widget.planId,
          ),
        ),
      child: BlocConsumer<PlanBrandsInfoBloc, PlanBrandsInfoState>(
        listener: (context, state) {
          if (state is PlanBrandsInfoErrorState) {
            error(
              context,
              state.failure.massage,
              state.failure.code,
            );
          }
        },
        builder: (context, state) {
          final deviceType = AppResponsive.deviceType(
            context,
          );

          double pageMaxWidth;
          double horizontalPadding;
          double searchTopPadding;
          double searchBottomPadding;
          double listTopPadding;
          double listBottomPadding;

          double shimmerVerticalSpacing;
          double shimmerHeight;
          double shimmerRadius;

          switch (deviceType) {
            case AppDeviceType.mobilePortrait:
              pageMaxWidth = 600;
              horizontalPadding = 16;
              searchTopPadding = 16;
              searchBottomPadding = 12;
              listTopPadding = 4;
              listBottomPadding = 28;
              shimmerVerticalSpacing = 16;
              shimmerHeight = 150;
              shimmerRadius = 18;
              break;

            case AppDeviceType.tabletPortrait:
              pageMaxWidth = 800;
              horizontalPadding = 28;
              searchTopPadding = 22;
              searchBottomPadding = 16;
              listTopPadding = 6;
              listBottomPadding = 34;
              shimmerVerticalSpacing = 18;
              shimmerHeight = 170;
              shimmerRadius = 20;
              break;

            case AppDeviceType.tabletLandscape:
              pageMaxWidth = 1000;
              horizontalPadding = 32;
              searchTopPadding = 18;
              searchBottomPadding = 14;
              listTopPadding = 4;
              listBottomPadding = 30;
              shimmerVerticalSpacing = 14;
              shimmerHeight = 155;
              shimmerRadius = 18;
              break;
          }

          final loaded = state is PlanBrandsInfoLoadedState ? state : null;

          // =============================================
          // Loading
          // =============================================
          if (state is PlanBrandsInfoLoadingState) {
            return Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: pageMaxWidth,
                ),
                child: loadingShimmer(
                  context,
                  6,
                  shimmerVerticalSpacing,
                  shimmerHeight,
                  BorderRadius.circular(
                    shimmerRadius,
                  ),
                ),
              ),
            );
          }

          return Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: pageMaxWidth,
              ),
              // =========================================================
              // إضافة RefreshIndicator للسحب والإعادة
              // =========================================================
              child: RefreshIndicator(
                onRefresh: () async {
                  searchController.clear();
                  BlocProvider.of<PlanBrandsInfoBloc>(context).add(
                    GetPlanBrandsInfoEvent(widget.planId),
                  );
                },
                color: const Color(0xFF2563EB),
                backgroundColor: Colors.white,
                child: CustomScrollView(
                  // BouncingScrollPhysics تضمن عمل الـ Refresh بسلاسة على iOS و Android
                  physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics(),
                  ),
                  keyboardDismissBehavior:
                  ScrollViewKeyboardDismissBehavior.onDrag,
                  slivers: [
                    // ===========================================
                    // Search
                    // ===========================================
                    SliverPadding(
                      padding: EdgeInsets.fromLTRB(
                        horizontalPadding,
                        searchTopPadding,
                        horizontalPadding,
                        searchBottomPadding,
                      ),
                      sliver: SliverToBoxAdapter(
                        child: _buildFluidAnimation(
                          index: 0,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: SearchField(
                                  searchController: searchController,
                                  onPressed: (value) {
                                    BlocProvider.of<PlanBrandsInfoBloc>(
                                      context,
                                    ).add(
                                      SearchPlanBrandsInfoEvent(
                                        value,
                                      ),
                                    );
                                  },
                                ),
                              ),
                              const SizedBox(width: 12),
                              _buildFilterButton(context, loaded),
                            ],
                          ),
                        ),
                      ),
                    ),

                    // ===========================================
                    // Empty
                    // ===========================================
                    if (loaded == null || loaded.brands.isEmpty)
                      SliverFillRemaining(
                        hasScrollBody: false,
                        child: Center(
                          child: emptyFullScreen(
                            context,
                          ),
                        ),
                      )

                    // ===========================================
                    // List
                    // ===========================================
                    else
                      SliverPadding(
                        padding: EdgeInsets.fromLTRB(
                          horizontalPadding,
                          listTopPadding,
                          horizontalPadding,
                          listBottomPadding,
                        ),
                        sliver: SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (context, index) {
                              return _buildFluidAnimation(
                                index: index + 1,
                                child: BrandPlanCard(
                                  model: loaded.brands[index],
                                ),
                              );
                            },
                            childCount: loaded.brands.length,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // =====================================================
  // Filter (هدف ممتلئ / هدف صفري / مساعد)
  // =====================================================

  static const Map<PlanBrandsInfoFilter, String> _filterTitles = {
    PlanBrandsInfoFilter.target: 'الهدف الممتلئ',
    PlanBrandsInfoFilter.zeroTarget: 'الهدف الصفري',
    PlanBrandsInfoFilter.assistant: 'المساعد',
  };

  Widget _buildFilterButton(
    BuildContext context,
    PlanBrandsInfoLoadedState? loaded,
  ) {
    final active = loaded?.activeFilters ?? PlanBrandsInfoFilter.values.toSet();
    final bool isFiltered = loaded != null && !loaded.isAllFiltersActive;

    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: loaded == null ? null : () => _showFilterSheet(context, active),
      child: Container(
        height: 48,
        width: 48,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isFiltered
                ? ColorManager.medicalPrimary
                : const Color(0xFFE2E8F0),
          ),
        ),
        child: Icon(
          Icons.filter_alt_outlined,
          size: 22,
          color: ColorManager.medicalPrimary,
        ),
      ),
    );
  }

  // اختيار أكثر من نوع ثم «تم» لتطبيق الفلتر وإغلاق القائمة
  Future<void> _showFilterSheet(
    BuildContext context,
    Set<PlanBrandsInfoFilter> current,
  ) {
    final bloc = BlocProvider.of<PlanBrandsInfoBloc>(context);
    final selected = Set<PlanBrandsInfoFilter>.of(current);

    return showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (sheetContext) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: StatefulBuilder(
            builder: (context, setSheetState) {
              return SafeArea(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text(
                        'فلترة الأصناف',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF1E3A8A),
                        ),
                      ),
                      const SizedBox(height: 8),
                      for (final entry in _filterTitles.entries)
                        CheckboxListTile(
                          contentPadding: EdgeInsets.zero,
                          controlAffinity: ListTileControlAffinity.leading,
                          activeColor: ColorManager.medicalPrimary,
                          title: Text(entry.value),
                          value: selected.contains(entry.key),
                          onChanged: (value) {
                            setSheetState(() {
                              if (value == true) {
                                selected.add(entry.key);
                              } else {
                                selected.remove(entry.key);
                              }
                            });
                          },
                        ),
                      const SizedBox(height: 8),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColorManager.medicalPrimary,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () {
                          bloc.add(ApplyInfoFiltersEvent(selected));
                          Navigator.pop(sheetContext);
                        },
                        child: const Text(
                          'تم',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  // =====================================================
  // Entry Animation
  // =====================================================

  Widget _buildFluidAnimation({
    required Widget child,
    required int index,
  }) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(
        begin: 0,
        end: 1,
      ),
      duration: const Duration(
        milliseconds: 280,
      ),
      curve: Curves.easeOutCubic,
      builder: (
          context,
          value,
          child,
          ) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(
              0,
              18 * (1 - value),
            ),
            child: Transform.scale(
              scale: 0.98 + (0.02 * value),
              alignment: Alignment.topCenter,
              child: child,
            ),
          ),
        );
      },
      child: child,
    );
  }

  @override
  bool get wantKeepAlive => true;
}

// =======================================================
// Brand Plan Card
// =======================================================

class BrandPlanCard extends StatelessWidget {
  final ActivePlanBrandModel model;

  const BrandPlanCard({
    super.key,
    required this.model,
  });

  @override
  Widget build(BuildContext context) {
    final deviceType = AppResponsive.deviceType(context);

    double cardBottomSpacing;
    double cardRadius;
    double headerHorizontalPadding;
    double headerVerticalPadding;
    double contentPadding;
    double iconBoxSize;
    double iconSize;
    double iconRadius;
    double iconSpacing;
    double titleFontSize;
    double formFontSize;
    double sectionTitleFontSize;
    double sectionSpacing;
    double itemHorizontalPadding;
    double itemVerticalPadding;
    double itemRadius;
    double itemBottomSpacing;
    double specialtyFontSize;
    double amountFontSize;

    // قيم تجاوب جديدة خاصة بـ Total
    double totalBadgeFontSize;
    double totalBadgePaddingH;
    double totalBadgePaddingV;

    switch (deviceType) {
      case AppDeviceType.mobilePortrait:
        cardBottomSpacing = 14;
        cardRadius = 18;
        headerHorizontalPadding = 14;
        headerVerticalPadding = 14;
        contentPadding = 14;
        iconBoxSize = 40;
        iconSize = 20;
        iconRadius = 11;
        iconSpacing = 10;
        titleFontSize = 16;
        formFontSize = 12;
        sectionTitleFontSize = 11.5;
        sectionSpacing = 12;
        itemHorizontalPadding = 12;
        itemVerticalPadding = 11;
        itemRadius = 11;
        itemBottomSpacing = 8;
        specialtyFontSize = 13;
        amountFontSize = 16;
        totalBadgeFontSize = 11.5;
        totalBadgePaddingH = 8;
        totalBadgePaddingV = 3;
        break;

      case AppDeviceType.tabletPortrait:
        cardBottomSpacing = 18;
        cardRadius = 20;
        headerHorizontalPadding = 20;
        headerVerticalPadding = 18;
        contentPadding = 20;
        iconBoxSize = 48;
        iconSize = 24;
        iconRadius = 13;
        iconSpacing = 14;
        titleFontSize = 19;
        formFontSize = 14;
        sectionTitleFontSize = 13;
        sectionSpacing = 16;
        itemHorizontalPadding = 16;
        itemVerticalPadding = 14;
        itemRadius = 13;
        itemBottomSpacing = 10;
        specialtyFontSize = 15;
        amountFontSize = 19;
        totalBadgeFontSize = 13.5;
        totalBadgePaddingH = 10;
        totalBadgePaddingV = 4;
        break;

      case AppDeviceType.tabletLandscape:
        cardBottomSpacing = 15;
        cardRadius = 18;
        headerHorizontalPadding = 18;
        headerVerticalPadding = 15;
        contentPadding = 17;
        iconBoxSize = 44;
        iconSize = 22;
        iconRadius = 12;
        iconSpacing = 12;
        titleFontSize = 18;
        formFontSize = 13;
        sectionTitleFontSize = 12;
        sectionSpacing = 13;
        itemHorizontalPadding = 14;
        itemVerticalPadding = 12;
        itemRadius = 12;
        itemBottomSpacing = 8;
        specialtyFontSize = 14;
        amountFontSize = 17;
        totalBadgeFontSize = 12.5;
        totalBadgePaddingH = 9;
        totalBadgePaddingV = 3.5;
        break;
    }

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        margin: EdgeInsets.only(
          bottom: cardBottomSpacing,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(
            cardRadius,
          ),
          border: Border.all(
            color: const Color(
              0xFFE2E8F0,
            ),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(
                0.025,
              ),
              blurRadius: 12,
              offset: const Offset(
                0,
                4,
              ),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // ===========================================
            // Header
            // ===========================================
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: headerHorizontalPadding,
                vertical: headerVerticalPadding,
              ),
              color: const Color(
                0xFFF8FAFC,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: iconBoxSize,
                    height: iconBoxSize,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: const Color(
                        0xFFEFF6FF,
                      ),
                      borderRadius: BorderRadius.circular(
                        iconRadius,
                      ),
                    ),
                    child: Icon(
                      Icons.medication_outlined,
                      size: iconSize,
                      color: const Color(
                        0xFF2563EB,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: iconSpacing,
                  ),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          model.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: titleFontSize,
                            fontWeight: FontWeight.w700,
                            color: const Color(
                              0xFF1E3A8A,
                            ),
                            height: 1.25,
                          ),
                        ),
                        if (model.pharmaceuticalFormTitle.trim().isNotEmpty) ...[
                          const SizedBox(
                            height: 4,
                          ),
                          Text(
                            model.pharmaceuticalFormTitle,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: formFontSize,
                              color: const Color(
                                0xFF64748B,
                              ),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  TypeBadge(
                    model.type,
                  ),
                ],
              ),
            ),

            // ===========================================
            // Content
            // ===========================================
            Padding(
              padding: EdgeInsets.all(
                contentPadding,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: iconSize + 10,
                        height: iconSize + 10,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: const Color(
                            0xFFF1F5F9,
                          ),
                          borderRadius: BorderRadius.circular(
                            8,
                          ),
                        ),
                        child: Icon(
                          Icons.bar_chart_rounded,
                          size: iconSize - 3,
                          color: const Color(
                            0xFF64748B,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        child: Text(
                          "توزيع الصنف حسب الاختصاص",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: sectionTitleFontSize,
                            color: const Color(
                              0xFF64748B,
                            ),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      if (model.spPlan.isNotEmpty && model.total > 0)
                        Text(
                          "(${model.spPlan.length} اختصاصات)",
                          style: TextStyle(
                            fontSize: sectionTitleFontSize * 0.9,
                            color: const Color(0xFF94A3B8),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                    ],
                  ),

                  if (model.total > 0) ...[
                    const SizedBox(
                      height: 6,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: totalBadgePaddingH,
                        vertical: totalBadgePaddingV,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1E3A8A).withOpacity(0.08),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: const Color(0xFF1E3A8A).withOpacity(0.15),
                        ),
                      ),
                      child: Text(
                        "المجموع: ${model.total}",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: totalBadgeFontSize,
                          color: const Color(0xFF1E3A8A),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                  SizedBox(
                    height: sectionSpacing,
                  ),
                  if (model.spPlan.isEmpty)
                    _buildEmptySpecialties(
                      context,
                    )
                  else
                    ...model.spPlan.asMap().entries.map(
                          (entry) {
                        final item = entry.value;
                        final isLast = entry.key == model.spPlan.length - 1;

                        return Container(
                          margin: EdgeInsets.only(
                            bottom: isLast ? 0 : itemBottomSpacing,
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: itemHorizontalPadding,
                            vertical: itemVerticalPadding,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(
                              0xFFFAFCFF,
                            ),
                            borderRadius: BorderRadius.circular(
                              itemRadius,
                            ),
                            border: Border.all(
                              color: const Color(
                                0xFFE9EEF5,
                              ),
                            ),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  item.name,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: specialtyFontSize,
                                    color: const Color(
                                      0xFF334155,
                                    ),
                                    fontWeight: FontWeight.w500,
                                    height: 1.3,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 12,
                              ),
                              Container(
                                constraints: const BoxConstraints(
                                  minWidth: 46,
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(
                                    0xFFEFF6FF,
                                  ),
                                  borderRadius: BorderRadius.circular(
                                    9,
                                  ),
                                ),
                                child: Text(
                                  item.amount,
                                  textAlign: TextAlign.center,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: amountFontSize,
                                    height: 1,
                                    fontWeight: FontWeight.w800,
                                    color: const Color(
                                      0xFF1E3A8A,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptySpecialties(
      BuildContext context,
      ) {
    final deviceType = AppResponsive.deviceType(context);

    final double fontSize = deviceType == AppDeviceType.mobilePortrait
        ? 11.5
        : deviceType == AppDeviceType.tabletPortrait
        ? 13
        : 12;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 18,
      ),
      decoration: BoxDecoration(
        color: const Color(
          0xFFF8FAFC,
        ),
        borderRadius: BorderRadius.circular(
          12,
        ),
        border: Border.all(
          color: const Color(
            0xFFE2E8F0,
          ),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.assignment_outlined,
            size: 24,
            color: Color(
              0xFF94A3B8,
            ),
          ),
          const SizedBox(
            height: 7,
          ),
          Text(
            'لا يوجد توزيع اختصاصات لهذه المادة',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: fontSize,
              color: const Color(
                0xFF64748B,
              ),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
