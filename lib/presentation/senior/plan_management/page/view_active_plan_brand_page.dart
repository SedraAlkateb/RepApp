import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/resources/responsive/app_ui.dart';
import 'package:domina_app/presentation/senior/plan_management/bloc/plan_management_bloc.dart';
import 'package:domina_app/presentation/uniti/search_field.dart';
import 'package:domina_app/presentation/uniti/stateWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ViewActivePlanBrandPage extends StatefulWidget {
  const ViewActivePlanBrandPage({
    super.key,
  });

  @override
  State<ViewActivePlanBrandPage> createState() =>
      _ViewActivePlanBrandPageState();
}

class _ViewActivePlanBrandPageState
    extends State<ViewActivePlanBrandPage> {
  final TextEditingController searchController =
  TextEditingController();

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ui = AppUi.of(context);

    return BlocBuilder<
        PlanManagementBloc,
        PlanManagementState>(
      // =====================================================
      // نفس buildWhen الأصلي
      // =====================================================
      buildWhen: (previous, current) =>
      previous.activeStatus != current.activeStatus ||
          previous.searchActiveBrands !=
              current.searchActiveBrands,

      builder: (context, state) {
        // =====================================================
        // Loading
        // =====================================================
        if (state.activeStatus ==
            PlanStatus.loading) {
          return _buildLoadingState(
            context,
          );
        }

        // =====================================================
        // Error
        // =====================================================
        if (state.activeStatus ==
            PlanStatus.error) {
          return _buildErrorState(
            context,
            state.activeFailure?.massage ??
                'حدث خطأ غير متوقع',
          );
        }

        final List<ActivePlanBrandModel>
        planBrandModel =
            state.searchActiveBrands;

        return Container(
          color: const Color(
            0xFFF8FAFC,
          ),

          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: ui.isTabletLandscape
                    ? ui.widePageMaxWidth
                    : ui.pageMaxWidth,
              ),

              child: CustomScrollView(
                physics:
                const BouncingScrollPhysics(),

                keyboardDismissBehavior:
                ScrollViewKeyboardDismissBehavior
                    .onDrag,

                slivers: [
                  // =================================================
                  // Search
                  // =================================================
                  SliverPadding(
                    padding: EdgeInsets.fromLTRB(
                      ui.pagePadding,
                      ui.searchTopPadding,
                      ui.pagePadding,
                      ui.searchBottomPadding,
                    ),

                    sliver:
                    SliverToBoxAdapter(
                      child:
                      _buildFluidAnimation(
                        index: 0,

                        child:
                        SearchField(
                          searchController:
                          searchController,

                          // =========================================
                          // نفس Event الأصلي
                          // =========================================
                          onPressed:
                              (value) {
                            context
                                .read<
                                PlanManagementBloc>()
                                .add(
                              SearchActivePlanBrandEvent(
                                value,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),

                  // =================================================
                  // Empty
                  // =================================================
                  if (planBrandModel.isEmpty)
                    SliverFillRemaining(
                      hasScrollBody:
                      false,

                      child:
                      Center(
                        child:
                        emptyFullScreen(
                          context,

                          message:
                          'لا توجد نتائج مطابقة للبحث في الخطة الفعالة',
                        ),
                      ),
                    )

                  // =================================================
                  // List
                  // =================================================
                  else
                    SliverPadding(
                      padding:
                      EdgeInsets.fromLTRB(
                        ui.pagePadding,
                        ui.listTopPadding,
                        ui.pagePadding,
                        ui.listBottomPadding,
                      ),

                      sliver:
                      SliverList(
                        delegate:
                        SliverChildBuilderDelegate(
                              (
                              context,
                              index,
                              ) {
                            return Padding(
                              padding:
                              EdgeInsets.only(
                                bottom:
                                ui.cardSpacing,
                              ),

                              child:
                              _buildFluidAnimation(
                                index:
                                index + 1,

                                child:
                                BrandPlanCard(
                                  model:
                                  planBrandModel[
                                  index],
                                ),
                              ),
                            );
                          },

                          childCount:
                          planBrandModel
                              .length,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // ===========================================================
  // Loading
  // ===========================================================

  Widget _buildLoadingState(
      BuildContext context,
      ) {
    final ui = AppUi.of(context);

    return Container(
      color: const Color(
        0xFFF8FAFC,
      ),

      child: Center(
        child: Padding(
          padding:
          EdgeInsets.all(
            ui.pagePadding,
          ),

          child: Column(
            mainAxisSize:
            MainAxisSize.min,

            children: [
              SizedBox(
                width:
                ui.iconSize + 6,

                height:
                ui.iconSize + 6,

                child:
                CircularProgressIndicator(
                  strokeWidth:
                  2.5,

                  color:
                  ColorManager
                      .medicalPrimary,
                ),
              ),

              SizedBox(
                height:
                ui.sectionSpacing,
              ),

              Text(
                'جاري تحميل الخطة الفعالة...',

                textAlign:
                TextAlign.center,

                style:
                TextStyle(
                  fontSize:
                  ui.bodyTextSize,

                  color:
                  const Color(
                    0xFF64748B,
                  ),

                  fontWeight:
                  FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ===========================================================
  // Error
  // ===========================================================

  Widget _buildErrorState(
      BuildContext context,
      String message,
      ) {
    final ui = AppUi.of(context);

    return Container(
      color: const Color(
        0xFFF8FAFC,
      ),

      child: Center(
        child:
        SingleChildScrollView(
          physics:
          const BouncingScrollPhysics(),

          padding:
          EdgeInsets.all(
            ui.pagePadding,
          ),

          child:
          ConstrainedBox(
            constraints:
            const BoxConstraints(
              maxWidth: 420,
            ),

            child:
            Column(
              mainAxisSize:
              MainAxisSize.min,

              children: [
                Container(
                  width:
                  ui.iconBoxSize + 16,

                  height:
                  ui.iconBoxSize + 16,

                  alignment:
                  Alignment.center,

                  decoration:
                  BoxDecoration(
                    color:
                    const Color(
                      0xFFFEF2F2,
                    ),

                    borderRadius:
                    BorderRadius.circular(
                      ui.cardRadius,
                    ),
                  ),

                  child:
                  Icon(
                    Icons
                        .error_outline_rounded,

                    size:
                    ui.iconSize + 8,

                    color:
                    const Color(
                      0xFFEF4444,
                    ),
                  ),
                ),

                SizedBox(
                  height:
                  ui.sectionSpacing,
                ),

                Text(
                  'حدث خطأ',

                  textAlign:
                  TextAlign.center,

                  style:
                  TextStyle(
                    fontSize:
                    ui.cardTitleSize,

                    fontWeight:
                    FontWeight.w700,

                    color:
                    const Color(
                      0xFF334155,
                    ),
                  ),
                ),

                SizedBox(
                  height:
                  ui.smallSpacing,
                ),

                Text(
                  message,

                  textAlign:
                  TextAlign.center,

                  style:
                  TextStyle(
                    fontSize:
                    ui.bodyTextSize,

                    color:
                    const Color(
                      0xFF64748B,
                    ),

                    fontWeight:
                    FontWeight.w500,

                    height:
                    1.5,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ===========================================================
  // Fluid Animation
  // ===========================================================

  Widget _buildFluidAnimation({
    required Widget child,
    required int index,
  }) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(
        begin: 0,
        end: 1,
      ),

      duration:
      const Duration(
        milliseconds: 150,
      ),

      curve:
      Curves.easeOut,

      builder:
          (
          context,
          value,
          animatedChild,
          ) {
        return Transform.translate(
          offset:
          Offset(
            0,
            20 * (1 - value),
          ),

          child:
          Transform.scale(
            scale:
            0.98 +
                (0.02 * value),

            alignment:
            Alignment.center,

            child:
            Opacity(
              opacity:
              value,

              child:
              animatedChild,
            ),
          ),
        );
      },

      child:
      child,
    );
  }
}

// =============================================================
// Active Plan Brand Card
// =============================================================

class BrandPlanCard extends StatelessWidget {
  const BrandPlanCard({
    super.key,
    required this.model,
  });

  final ActivePlanBrandModel model;

  @override
  Widget build(BuildContext context) {
    final ui = AppUi.of(context);

    return Container(
      width:
      double.infinity,

      decoration:
      BoxDecoration(
        color:
        Colors.white,

        borderRadius:
        BorderRadius.circular(
          ui.cardRadius,
        ),

        border:
        Border.all(
          color:
          const Color(
            0xFFE2E8F0,
          ),
        ),

        boxShadow: [
          BoxShadow(
            color:
            Colors.black
                .withOpacity(
              0.03,
            ),

            blurRadius:
            12,

            offset:
            const Offset(
              0,
              4,
            ),
          ),
        ],
      ),

      child:
      ClipRRect(
        borderRadius:
        BorderRadius.circular(
          ui.cardRadius - 1,
        ),

        child:
        Column(
          crossAxisAlignment:
          CrossAxisAlignment.start,

          children: [
            // =================================================
            // Header
            // =================================================
            Container(
              width:
              double.infinity,

              padding:
              EdgeInsets.all(
                ui.cardPadding,
              ),

              color:
              const Color(
                0xFFF8FAFC,
              ),

              child:
              Row(
                crossAxisAlignment:
                CrossAxisAlignment.start,

                children: [
                  // =============================================
                  // Icon
                  // =============================================
                  Container(
                    width:
                    ui.iconBoxSize,

                    height:
                    ui.iconBoxSize,

                    alignment:
                    Alignment.center,

                    decoration:
                    BoxDecoration(
                      color:
                      ColorManager
                          .medicalPrimary
                          .withOpacity(
                        0.07,
                      ),

                      borderRadius:
                      BorderRadius.circular(
                        ui.smallRadius + 2,
                      ),
                    ),

                    child:
                    Icon(
                      Icons
                          .medication_outlined,

                      size:
                      ui.iconSize,

                      color:
                      ColorManager
                          .medicalPrimary,
                    ),
                  ),

                  SizedBox(
                    width:
                    ui.sectionSpacing,
                  ),

                  // =============================================
                  // Brand Info
                  // =============================================
                  Expanded(
                    child:
                    Column(
                      mainAxisSize:
                      MainAxisSize.min,

                      crossAxisAlignment:
                      CrossAxisAlignment.start,

                      children: [
                        Text(
                          model.title,

                          maxLines:
                          2,

                          overflow:
                          TextOverflow.ellipsis,

                          style:
                          TextStyle(
                            fontSize:
                            ui.cardTitleSize,

                            fontWeight:
                            FontWeight.w700,

                            color:
                            const Color(
                              0xFF1E293B,
                            ),

                            height:
                            1.3,
                          ),
                        ),

                        SizedBox(
                          height:
                          ui.smallSpacing,
                        ),

                        Text(
                          model.pharmaceuticalFormTitle,

                          maxLines:
                          2,

                          overflow:
                          TextOverflow.ellipsis,

                          style:
                          TextStyle(
                            fontSize:
                            ui.bodyTextSize,

                            color:
                            const Color(
                              0xFF64748B,
                            ),

                            fontWeight:
                            FontWeight.w500,

                            height:
                            1.4,
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(
                    width:
                    ui.mediumSpacing,
                  ),

                  // =============================================
                  // Type Badge
                  // =============================================
                  Flexible(
                    flex:
                    0,

                    child:
                    Type.buildBadge(
                      model.type,
                    ),
                  ),
                ],
              ),
            ),

            // =================================================
            // Content
            // =================================================
            Padding(
              padding:
              EdgeInsets.all(
                ui.cardPadding,
              ),

              child:
              Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,

                children: [
                  Row(
                    children: [
                      Container(
                        width:
                        ui.iconBoxSize - 12,

                        height:
                        ui.iconBoxSize - 12,

                        alignment:
                        Alignment.center,

                        decoration:
                        BoxDecoration(
                          color:
                          const Color(
                            0xFFF1F5F9,
                          ),

                          borderRadius:
                          BorderRadius.circular(
                            ui.smallRadius,
                          ),
                        ),

                        child:
                        Icon(
                          Icons
                              .bar_chart_rounded,

                          size:
                          ui.smallIconSize,

                          color:
                          const Color(
                            0xFF64748B,
                          ),
                        ),
                      ),

                      SizedBox(
                        width:
                        ui.smallSpacing,
                      ),

                      Expanded(
                        child:
                        Text(
                          'توزيع الأهداف حسب الاختصاص',

                          maxLines:
                          2,

                          overflow:
                          TextOverflow.ellipsis,

                          style:
                          TextStyle(
                            fontSize:
                            ui.bodyTextSize,

                            color:
                            const Color(
                              0xFF475569,
                            ),

                            fontWeight:
                            FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(
                    height:
                    ui.sectionSpacing,
                  ),

                  // =============================================
                  // Specializations
                  // =============================================
                  ListView.separated(
                    shrinkWrap:
                    true,

                    padding:
                    EdgeInsets.zero,

                    physics:
                    const NeverScrollableScrollPhysics(),

                    itemCount:
                    model.spPlan.length,

                    separatorBuilder:
                        (
                        context,
                        index,
                        ) =>
                        SizedBox(
                          height:
                          ui.smallSpacing,
                        ),

                    itemBuilder:
                        (
                        context,
                        index,
                        ) {
                      final item =
                      model.spPlan[index];

                      return Container(
                        padding:
                        EdgeInsets.symmetric(
                          horizontal:
                          ui.cardPadding,

                          vertical:
                          ui.mediumSpacing + 2,
                        ),

                        decoration:
                        BoxDecoration(
                          color:
                          const Color(
                            0xFFF8FAFC,
                          ),

                          borderRadius:
                          BorderRadius.circular(
                            ui.smallRadius + 2,
                          ),

                          border:
                          Border.all(
                            color:
                            const Color(
                              0xFFE9EEF3,
                            ),
                          ),
                        ),

                        child:
                        Row(
                          children: [
                            Expanded(
                              child:
                              Text(
                                item.name,

                                maxLines:
                                2,

                                overflow:
                                TextOverflow.ellipsis,

                                style:
                                TextStyle(
                                  fontSize:
                                  ui.bodyTextSize,

                                  color:
                                  const Color(
                                    0xFF334155,
                                  ),

                                  fontWeight:
                                  FontWeight.w600,

                                  height:
                                  1.35,
                                ),
                              ),
                            ),

                            SizedBox(
                              width:
                              ui.mediumSpacing,
                            ),

                            Container(
                              constraints:
                              const BoxConstraints(
                                minWidth:
                                42,
                              ),

                              padding:
                              EdgeInsets.symmetric(
                                horizontal:
                                ui.mediumSpacing,

                                vertical:
                                5,
                              ),

                              decoration:
                              BoxDecoration(
                                color:
                                ColorManager
                                    .medicalPrimary
                                    .withOpacity(
                                  0.07,
                                ),

                                borderRadius:
                                BorderRadius.circular(
                                  ui.smallRadius,
                                ),
                              ),

                              alignment:
                              Alignment.center,

                              child:
                              Text(
                                item.amount,

                                maxLines:
                                1,

                                overflow:
                                TextOverflow.ellipsis,

                                style:
                                TextStyle(
                                  fontSize:
                                  ui.cardTitleSize,

                                  fontWeight:
                                  FontWeight.w700,

                                  color:
                                  ColorManager
                                      .medicalPrimary,
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
}
