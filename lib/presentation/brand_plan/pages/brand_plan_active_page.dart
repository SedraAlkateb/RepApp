// ignore_for_file: deprecated_member_use

import 'package:domina_app/app/user_info.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/brand_plan/bloc/brand_plan_bloc.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/resources/responsive/app_ui.dart';
import 'package:domina_app/presentation/uniti/search_field.dart';
import 'package:domina_app/presentation/uniti/stateWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BrandPlanActivePage extends StatefulWidget {
  const BrandPlanActivePage({
    super.key,
  });

  @override
  State<BrandPlanActivePage> createState() =>
      _BrandPlanActivePageState();
}

class _BrandPlanActivePageState
    extends State<BrandPlanActivePage>
    with AutomaticKeepAliveClientMixin {
  final TextEditingController searchController =
  TextEditingController();

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final ui = AppUi.of(context);

    // =========================================================
    // صفحة List بعمود واحد
    // لذلك لا نسمح لها بالتمدد الزائد على Tablet Landscape
    // =========================================================
    final double contentMaxWidth =
    ui.isTabletLandscape
        ? 760
        : ui.pageMaxWidth;

    return Scaffold(
      backgroundColor: const Color(
        0xFFF8FAFC,
      ),

      body: BlocConsumer<
          BrandPlanBloc,
          BrandPlanState>(
        listener: (
            context,
            state,
            ) {
          // =====================================================
          // نفس السلوك الأصلي
          // =====================================================
          if (state is AllBrandPlanErrorState) {
            error(
              context,
              state.failure.massage,
              state.failure.code,
            );
          }
        },

        builder: (
            context,
            state,
            ) {
          // =====================================================
          // نفس مصدر البيانات الأصلي
          // =====================================================
          List<BrandSpPlanModel> planBrandModel =
              context
                  .read<BrandPlanBloc>()
                  .planBrandActive;

          // =====================================================
          // نفس سلوك البحث الأصلي
          // =====================================================
          if (state is SearchBrandState) {
            planBrandModel =
                state.brand;
          }

          return Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth:
                contentMaxWidth,
              ),

              child: CustomScrollView(
                physics:
                const BouncingScrollPhysics(),

                keyboardDismissBehavior:
                ScrollViewKeyboardDismissBehavior
                    .onDrag,

                slivers: [
                  // =================================================
                  // Header
                  // نفس ترتيب الويدجت الأصلي
                  // =================================================
                  SliverToBoxAdapter(
                    child: Padding(
                      padding:
                      EdgeInsets.symmetric(
                        horizontal:
                        ui.pagePadding,
                      ),

                      child: Column(
                        crossAxisAlignment:
                        CrossAxisAlignment
                            .start,

                        children: [
                          SizedBox(
                            height:
                            ui.pageTopPadding,
                          ),

                          // =========================================
                          // Plan Date
                          // =========================================
                          _buildFluidAnimation(
                            index: 0,

                            child: Center(
                              child: Container(
                                constraints:
                                const BoxConstraints(
                                  maxWidth: 560,
                                ),

                                padding:
                                EdgeInsets.symmetric(
                                  horizontal:
                                  ui.isMobile
                                      ? 18
                                      : 24,

                                  vertical:
                                  ui.isMobile
                                      ? 10
                                      : 12,
                                ),

                                decoration:
                                BoxDecoration(
                                  color:
                                  Colors.white,

                                  borderRadius:
                                  BorderRadius
                                      .circular(
                                    ui.smallRadius +
                                        3,
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
                                      color: Colors
                                          .black
                                          .withOpacity(
                                        0.025,
                                      ),

                                      blurRadius:
                                      10,

                                      offset:
                                      const Offset(
                                        0,
                                        3,
                                      ),
                                    ),
                                  ],
                                ),

                                child: Text(
                                  'تاريخ الخطة: '
                                      '${UserInfo.startDate} - '
                                      '${UserInfo.endDate}',

                                  textAlign:
                                  TextAlign
                                      .center,

                                  maxLines: 2,

                                  overflow:
                                  TextOverflow
                                      .ellipsis,

                                  style:
                                  TextStyle(
                                    fontSize: ui
                                        .bodyTextSize,

                                    color:
                                    ColorManager
                                        .medicalPrimary,

                                    fontWeight:
                                    FontWeight
                                        .w800,

                                    height: 1.35,
                                  ),
                                ),
                              ),
                            ),
                          ),

                          SizedBox(
                            height:
                            ui.isMobile
                                ? 22
                                : 25,
                          ),

                          // =========================================
                          // Title
                          // =========================================
                          _buildFluidAnimation(
                            index: 1,

                            child: Text(
                              'أصناف الخطة الحالية',

                              maxLines: 2,

                              overflow:
                              TextOverflow
                                  .ellipsis,

                              style:
                              TextStyle(
                                fontSize: ui
                                    .pageTitleSize,

                                fontWeight:
                                FontWeight
                                    .w800,

                                color:
                                const Color(
                                  0xFF0F172A,
                                ),

                                height: 1.3,
                              ),
                            ),
                          ),

                          SizedBox(
                            height:
                            ui.smallSpacing,
                          ),

                          // =========================================
                          // Subtitle
                          // =========================================
                          _buildFluidAnimation(
                            index: 2,

                            child: Text(
                              'عرض جميع الأصناف المدرجة في الخطة الحالية '
                                  'مع امكانية البحث عن منتج معين',

                              style:
                              TextStyle(
                                fontSize: ui
                                    .pageSubtitleSize,

                                color:
                                const Color(
                                  0xFF64748B,
                                ),

                                height: 1.45,
                              ),
                            ),
                          ),

                          SizedBox(
                            height:
                            ui.largeSpacing,
                          ),

                          // =========================================
                          // Search
                          // نفس المكان والسلوك الأصلي
                          // =========================================
                          _buildFluidAnimation(
                            index: 3,

                            child: SearchField(
                              searchController:
                              searchController,

                              onPressed:
                                  (value) {
                                context
                                    .read<
                                    BrandPlanBloc>()
                                    .add(
                                  SearchBrandEvent(
                                    value:
                                    value,

                                    brand:
                                    planBrandModel,
                                  ),
                                );
                              },
                            ),
                          ),

                          SizedBox(
                            height:
                            ui.sectionSpacing,
                          ),
                        ],
                      ),
                    ),
                  ),

                  // =================================================
                  // Empty
                  // السيرش والهيدر يظلون ظاهرين
                  // =================================================
                  planBrandModel.isEmpty
                      ? SliverFillRemaining(
                    hasScrollBody:
                    false,

                    child: Center(
                      child:
                      emptyFullScreen(
                        context,
                      ),
                    ),
                  )

                  // =================================================
                  // Brands List
                  // =================================================
                      : SliverPadding(
                    padding:
                    EdgeInsets.fromLTRB(
                      ui.pagePadding,
                      0,
                      ui.pagePadding,
                      0,
                    ),

                    sliver:
                    SliverList(
                      delegate:
                      SliverChildBuilderDelegate(
                            (
                            context,
                            index,
                            ) {
                          return _buildFluidAnimation(
                            index:
                            index + 4,

                            child:
                            ActiveBrandPlanCard(
                              model:
                              planBrandModel[
                              index],
                            ),
                          );
                        },

                        childCount:
                        planBrandModel
                            .length,
                      ),
                    ),
                  ),

                  // =================================================
                  // نفس المساحة السفلية الأصلية
                  // =================================================
                  SliverToBoxAdapter(
                    child: SizedBox(
                      height:
                      ui.isMobile
                          ? 100
                          : 110,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // ===========================================================
  // نفس Animation الأصلي
  // ===========================================================

  Widget _buildFluidAnimation({
    required Widget child,
    required int index,
  }) {
    return TweenAnimationBuilder<double>(
      tween: Tween(
        begin: 0,
        end: 1,
      ),

      duration: const Duration(
        milliseconds: 600,
      ),

      curve: Interval(
        (index * 0.05).clamp(
          0.0,
          0.5,
        ),
        1,
        curve:
        Curves.easeOutCubic,
      ),

      builder: (
          context,
          value,
          child,
          ) {
        return Transform.translate(
          offset: Offset(
            0,
            40 * (1 - value),
          ),

          child: Transform.scale(
            scale:
            0.95 +
                (0.05 * value),

            child: child,
          ),
        );
      },

      child: child,
    );
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;
}

// ============================================================================
// Active Brand Plan Card
// نفس بناء الكرت ومواقع المحتوى الأصلي
// ============================================================================

class ActiveBrandPlanCard
    extends StatelessWidget {
  const ActiveBrandPlanCard({
    super.key,
    required this.model,
  });

  final BrandSpPlanModel model;

  @override
  Widget build(BuildContext context) {
    final ui = AppUi.of(context);

    return Container(
      width: double.infinity,

      margin: EdgeInsets.only(
        bottom: ui.cardSpacing,
      ),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius:
        BorderRadius.circular(
          ui.cardRadius,
        ),

        border: Border.all(
          color: const Color(
            0xFFE2E8F0,
          ),
        ),

        boxShadow: [
          BoxShadow(
            color:
            Colors.black.withOpacity(
              0.03,
            ),

            blurRadius: 12,

            offset: const Offset(
              0,
              4,
            ),
          ),
        ],
      ),

      child: ClipRRect(
        borderRadius:
        BorderRadius.circular(
          ui.cardRadius,
        ),

        child: Column(
          crossAxisAlignment:
          CrossAxisAlignment.start,

          children: [
            // =================================================
            // Header
            // نفس مكان الاسم والشركة والـBadge
            // =================================================
            Container(
              width: double.infinity,

              padding: EdgeInsets.symmetric(
                horizontal:
                ui.cardPadding,

                vertical:
                ui.isMobile
                    ? 14
                    : 16,
              ),

              decoration:
              const BoxDecoration(
                color:
                Color(0xFFE2E8F0),

                border: Border(
                  bottom: BorderSide(
                    color:
                    Color(0xFFCBD5E1),
                    width: 1,
                  ),
                ),
              ),

              child: Row(
                crossAxisAlignment:
                CrossAxisAlignment
                    .center,

                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment
                          .start,

                      children: [
                        Text(
                          model.brandModel
                              .title,

                          maxLines: 2,

                          overflow:
                          TextOverflow
                              .ellipsis,

                          style:
                          TextStyle(
                            fontSize: ui
                                .cardTitleSize,

                            fontWeight:
                            FontWeight
                                .w700,

                            color:
                            const Color(
                              0xFF1E3A8A,
                            ),

                            height: 1.3,
                          ),
                        ),

                        SizedBox(
                          height:
                          ui.smallSpacing /
                              2,
                        ),

                        Text(
                          model.brandModel
                              .phTitle,

                          maxLines: 2,

                          overflow:
                          TextOverflow
                              .ellipsis,

                          style:
                          TextStyle(
                            fontSize: ui
                                .bodyTextSize,

                            color:
                            const Color(
                              0xFF64748B,
                            ),

                            height: 1.3,
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
                  // نفس الـBadge الأصلي
                  // =============================================
                  Type.buildBadge(
                    model
                        .spPlan[0]
                        .brandType,
                  ),
                ],
              ),
            ),

            // =================================================
            // Details
            // =================================================
            Padding(
              padding: EdgeInsets.all(
                ui.cardPadding,
              ),

              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment
                    .start,

                children: [
                  // =============================================
                  // Section Title
                  // =============================================
                  Row(
                    children: [
                      Icon(
                        Icons
                            .bar_chart_rounded,

                        size:
                        ui.smallIconSize +
                            1,

                        color:
                        const Color(
                          0xFF94A3B8,
                        ),
                      ),

                      SizedBox(
                        width:
                        ui.smallSpacing,
                      ),

                      Expanded(
                        child: Text(
                          'توزيع الأهداف حسب الاختصاص',

                          maxLines: 1,

                          overflow:
                          TextOverflow
                              .ellipsis,

                          style:
                          TextStyle(
                            fontSize: ui
                                .smallTextSize,

                            color:
                            const Color(
                              0xFF64748B,
                            ),

                            fontWeight:
                            FontWeight
                                .w600,
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
                  // نفس ListView الداخلي
                  // =============================================
                  ListView.builder(
                    shrinkWrap: true,

                    padding:
                    EdgeInsets.zero,

                    physics:
                    const NeverScrollableScrollPhysics(),

                    itemCount:
                    model.spPlan.length,

                    itemBuilder: (
                        context,
                        i,
                        ) {
                      return Container(
                        margin:
                        EdgeInsets.only(
                          bottom:
                          ui.smallSpacing +
                              2,
                        ),

                        padding:
                        EdgeInsets.symmetric(
                          horizontal:
                          ui.isMobile
                              ? 12
                              : 14,

                          vertical:
                          ui.isMobile
                              ? 10
                              : 12,
                        ),

                        decoration:
                        BoxDecoration(
                          color:
                          Colors.white,

                          borderRadius:
                          BorderRadius
                              .circular(
                            ui.smallRadius +
                                1,
                          ),

                          border:
                          Border.all(
                            color:
                            const Color(
                              0xFFF1F5F9,
                            ),
                          ),
                        ),

                        child: Row(
                          children: [
                            // ===================================
                            // Specialization Name
                            // ===================================
                            Expanded(
                              child: Text(
                                model
                                    .spPlan[i]
                                    .title,

                                maxLines: 2,

                                overflow:
                                TextOverflow
                                    .ellipsis,

                                style:
                                TextStyle(
                                  fontSize: ui
                                      .bodyTextSize,

                                  color:
                                  const Color(
                                    0xFF334155,
                                  ),

                                  fontWeight:
                                  FontWeight
                                      .w500,

                                  height:
                                  1.3,
                                ),
                              ),
                            ),

                            SizedBox(
                              width: ui
                                  .mediumSpacing,
                            ),

                            // ===================================
                            // Amount
                            // ===================================
                            Text(
                              '${model.spPlan[i].amount}',

                              maxLines: 1,

                              style:
                              TextStyle(
                                fontSize: ui
                                    .cardTitleSize,

                                fontWeight:
                                FontWeight
                                    .w700,

                                color:
                                const Color(
                                  0xFF1E3A8A,
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