import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/resources/responsive/app_responsive.dart';
import 'package:domina_app/presentation/senior/finished_plan/bloc/finished_plan_bloc.dart';
import 'package:domina_app/presentation/senior/finished_plan/widgets/date_plan_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FinishedPlanPage extends StatefulWidget {
  const FinishedPlanPage({
    super.key,
    required this.cityId,
  });

  final int cityId;

  @override
  State<FinishedPlanPage> createState() =>
      _FinishedPlanPageState();
}

class _FinishedPlanPageState
    extends State<FinishedPlanPage> {
  @override
  void initState() {
    super.initState();

    context
        .read<FinishedPlanBloc>()
        .add(
      GetFinishedPlansEvent(
        cityId: widget.cityId,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final deviceType =
    AppResponsive.deviceType(context);

    double pageMaxWidth;

    double horizontalPadding;

    double headerTopPadding;
    double headerBottomPadding;

    double titleFontSize;
    double subtitleFontSize;

    double listTopPadding;
    double listBottomPadding;

    switch (deviceType) {
    // =================================================
    // Mobile
    // =================================================
      case AppDeviceType.mobilePortrait:
        pageMaxWidth = 600;

        horizontalPadding = 16;

        headerTopPadding = 20;
        headerBottomPadding = 14;

        titleFontSize = 21;
        subtitleFontSize = 12.5;

        listTopPadding = 4;
        listBottomPadding = 28;
        break;

    // =================================================
    // Tablet Portrait
    // =================================================
      case AppDeviceType.tabletPortrait:
        pageMaxWidth = 800;

        horizontalPadding = 28;

        headerTopPadding = 28;
        headerBottomPadding = 18;

        titleFontSize = 26;
        subtitleFontSize = 14;

        listTopPadding = 6;
        listBottomPadding = 34;
        break;

    // =================================================
    // Tablet Landscape
    // =================================================
      case AppDeviceType.tabletLandscape:
        pageMaxWidth = 950;

        horizontalPadding = 32;

        headerTopPadding = 22;
        headerBottomPadding = 16;

        titleFontSize = 24;
        subtitleFontSize = 13;

        listTopPadding = 4;
        listBottomPadding = 30;
        break;
    }

    return Scaffold(
      backgroundColor:
      const Color(
        0xFFF8FAFC,
      ),

      appBar: AppBar(
        elevation: 0,

        scrolledUnderElevation:
        0,

        surfaceTintColor:
        Colors.transparent,

        title:
        const Text(
          "سجل الخطط",
        ),
      ),

      body: Center(
        child: ConstrainedBox(
          constraints:
          BoxConstraints(
            maxWidth:
            pageMaxWidth,
          ),

          child:
          CustomScrollView(
            physics:
            const BouncingScrollPhysics(),

            slivers: [
              // =================================================
              // Header
              // =================================================
              SliverPadding(
                padding:
                EdgeInsets.fromLTRB(
                  horizontalPadding,
                  headerTopPadding,
                  horizontalPadding,
                  headerBottomPadding,
                ),

                sliver:
                SliverToBoxAdapter(
                  child:
                  _buildHeader(
                    titleFontSize:
                    titleFontSize,

                    subtitleFontSize:
                    subtitleFontSize,
                  ),
                ),
              ),

              // =================================================
              // Bloc
              // =================================================
              BlocBuilder<
                  FinishedPlanBloc,
                  FinishedPlanState>(
                buildWhen:
                    (
                    previous,
                    current,
                    ) {
                  return current
                  is FinishedPlanLoading ||
                      current
                      is FinishedPlanLoaded ||
                      current
                      is FinishedPlanError;
                },

                builder:
                    (context, state) {
                  // ===============================================
                  // Loading
                  // ===============================================
                  if (state
                  is FinishedPlanLoading) {
                    return const SliverFillRemaining(
                      hasScrollBody:
                      false,

                      child:
                      Center(
                        child:
                        CircularProgressIndicator(),
                      ),
                    );
                  }

                  // ===============================================
                  // Loaded
                  // ===============================================
                  if (state
                  is FinishedPlanLoaded) {
                    if (state.plans.isEmpty) {
                      return SliverFillRemaining(
                        hasScrollBody:
                        false,

                        child:
                        _buildEmptyState(
                          context,
                        ),
                      );
                    }

                    return SliverPadding(
                      padding:
                      EdgeInsets.fromLTRB(
                        horizontalPadding,
                        listTopPadding,
                        horizontalPadding,
                        listBottomPadding,
                      ),

                      sliver:
                      SliverList(
                        delegate:
                        SliverChildBuilderDelegate(
                              (
                              context,
                              index,
                              ) {
                            return PlanCard(
                              plan:
                              state.plans[index],
                            );
                          },

                          childCount:
                          state.plans.length,
                        ),
                      ),
                    );
                  }

                  // ===============================================
                  // Error
                  // ===============================================
                  if (state
                  is FinishedPlanError) {
                    return SliverFillRemaining(
                      hasScrollBody:
                      false,

                      child:
                      _buildErrorState(
                        context,
                        state.message,
                      ),
                    );
                  }

                  return const SliverToBoxAdapter(
                    child:
                    SizedBox.shrink(),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  // =====================================================
  // Header
  // =====================================================

  Widget _buildHeader({
    required double titleFontSize,
    required double subtitleFontSize,
  }) {
    return Row(
      crossAxisAlignment:
      CrossAxisAlignment.center,

      children: [
        Expanded(
          child: Column(
            crossAxisAlignment:
            CrossAxisAlignment.start,

            children: [
              Text(
                'سجل الخطط السابقة',

                maxLines: 1,

                overflow:
                TextOverflow.ellipsis,

                style:
                TextStyle(
                  fontSize:
                  titleFontSize,

                  fontWeight:
                  FontWeight.w800,

                  color:
                  ColorManager
                      .medicalPrimary,

                  height: 1.25,
                ),
              ),

              const SizedBox(
                height: 5,
              ),

              Text(
                'تصفح تقارير ونتائج الدورات المنتهية',

                maxLines: 2,

                overflow:
                TextOverflow.ellipsis,

                style:
                TextStyle(
                  fontSize:
                  subtitleFontSize,

                  color:
                  const Color(
                    0xFF64748B,
                  ),

                  fontWeight:
                  FontWeight.w500,

                  height: 1.4,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(
          width: 16,
        ),

        Container(
          height: 5,
          width: 44,

          decoration:
          BoxDecoration(
            color:
            ColorManager
                .medicalPrimary,

            borderRadius:
            BorderRadius.circular(
              10,
            ),
          ),
        ),
      ],
    );
  }

  // =====================================================
  // Empty State
  // =====================================================

  Widget _buildEmptyState(
      BuildContext context,
      ) {
    final deviceType =
    AppResponsive.deviceType(context);

    final double iconSize;
    final double titleSize;
    final double subtitleSize;

    switch (deviceType) {
      case AppDeviceType.mobilePortrait:
        iconSize = 42;
        titleSize = 15;
        subtitleSize = 12;
        break;

      case AppDeviceType.tabletPortrait:
        iconSize = 52;
        titleSize = 18;
        subtitleSize = 14;
        break;

      case AppDeviceType.tabletLandscape:
        iconSize = 48;
        titleSize = 17;
        subtitleSize = 13;
        break;
    }

    return Center(
      child: Padding(
        padding:
        const EdgeInsets.all(
          24,
        ),

        child: Column(
          mainAxisSize:
          MainAxisSize.min,

          children: [
            Container(
              width:
              iconSize + 24,

              height:
              iconSize + 24,

              alignment:
              Alignment.center,

              decoration:
              BoxDecoration(
                color:
                const Color(
                  0xFFEFF6FF,
                ),

                borderRadius:
                BorderRadius.circular(
                  20,
                ),
              ),

              child: Icon(
                Icons
                    .history_rounded,

                size:
                iconSize,

                color:
                ColorManager
                    .medicalPrimary,
              ),
            ),

            const SizedBox(
              height: 14,
            ),

            Text(
              'لا توجد خطط سابقة',

              style:
              TextStyle(
                fontSize:
                titleSize,

                fontWeight:
                FontWeight.w700,

                color:
                const Color(
                  0xFF334155,
                ),
              ),
            ),

            const SizedBox(
              height: 5,
            ),

            Text(
              'ستظهر الخطط المنتهية هنا عند توفرها',

              textAlign:
              TextAlign.center,

              style:
              TextStyle(
                fontSize:
                subtitleSize,

                color:
                const Color(
                  0xFF94A3B8,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // =====================================================
  // Error State
  // =====================================================

  Widget _buildErrorState(
      BuildContext context,
      String message,
      ) {
    return Center(
      child: Padding(
        padding:
        const EdgeInsets.all(
          24,
        ),

        child: Column(
          mainAxisSize:
          MainAxisSize.min,

          children: [
            const Icon(
              Icons
                  .error_outline_rounded,

              size: 42,

              color:
              Color(
                0xFFEF4444,
              ),
            ),

            const SizedBox(
              height: 12,
            ),

            Text(
              message,

              textAlign:
              TextAlign.center,

              style:
              const TextStyle(
                color:
                Color(
                  0xFF64748B,
                ),

                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// =======================================================
// Plan Card
// =======================================================

