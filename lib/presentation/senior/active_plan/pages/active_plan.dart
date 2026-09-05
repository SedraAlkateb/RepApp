import 'package:domina_app/app/di/di.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/resources/responsive/app_responsive.dart';
import 'package:domina_app/presentation/senior/active_plan/bloc/bloc/active_plan_bloc.dart';
import 'package:domina_app/presentation/uniti/search_field.dart';
import 'package:domina_app/presentation/uniti/stateWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ActivePlanPage extends StatefulWidget {
  const ActivePlanPage({
    super.key,
    required this.planId,
  });

  final int planId;

  @override
  State<ActivePlanPage> createState() =>
      _BrandPlanActivePageState();
}

class _BrandPlanActivePageState
    extends State<ActivePlanPage>
    with AutomaticKeepAliveClientMixin {
  final TextEditingController searchController =
  TextEditingController();

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return BlocProvider(
      // =================================================
      // نفس التهيئة والسلوك الأصلي
      // =================================================
      lazy: false,

      create: (context) =>
      instance<ActivePlanBloc>()
        ..add(
          GetActivePlanEvent(
            widget.planId,
          ),
        ),

      child: Scaffold(
        backgroundColor:
        const Color(
          0xFFF8FAFC,
        ),

        appBar: AppBar(
          title:
          const Text(
            'الخطة الفعالة',
          ),

          elevation: 0,

          surfaceTintColor:
          Colors.transparent,
        ),

        body: BlocConsumer<
            ActivePlanBloc,
            ActivePlanState>(
          listener:
              (context, state) {
            if (state
            is AllActivePlanErrorState) {
              error(
                context,
                state.failure.massage,
                state.failure.code,
              );
            }
          },

          builder:
              (context, state) {
            final deviceType =
            AppResponsive.deviceType(
              context,
            );

            double pageMaxWidth;

            double horizontalPadding;

            double searchTopPadding;
            double searchBottomPadding;

            double listTopPadding;
            double listBottomPadding;

        //    double shimmerHorizontalPadding;
            double shimmerVerticalSpacing;
            double shimmerHeight;
            double shimmerRadius;

            switch (deviceType) {
            // ===========================================
            // Mobile
            // ===========================================
              case AppDeviceType.mobilePortrait:
                pageMaxWidth = 600;

                horizontalPadding = 16;

                searchTopPadding = 16;
                searchBottomPadding = 12;

                listTopPadding = 4;
                listBottomPadding = 28;

             //   shimmerHorizontalPadding = 16;
                shimmerVerticalSpacing = 16;
                shimmerHeight = 150;
                shimmerRadius = 18;
                break;

            // ===========================================
            // Tablet Portrait
            // ===========================================
              case AppDeviceType.tabletPortrait:
                pageMaxWidth = 800;

                horizontalPadding = 28;

                searchTopPadding = 22;
                searchBottomPadding = 16;

                listTopPadding = 6;
                listBottomPadding = 34;

              //  shimmerHorizontalPadding = 28;
                shimmerVerticalSpacing = 18;
                shimmerHeight = 170;
                shimmerRadius = 20;
                break;

            // ===========================================
            // Tablet Landscape
            // ===========================================
              case AppDeviceType.tabletLandscape:
                pageMaxWidth = 1000;

                horizontalPadding = 32;

                searchTopPadding = 18;
                searchBottomPadding = 14;

                listTopPadding = 4;
                listBottomPadding = 30;

             //   shimmerHorizontalPadding = 32;
                shimmerVerticalSpacing = 14;
                shimmerHeight = 155;
                shimmerRadius = 18;
                break;
            }

            final activePlanBloc =
            BlocProvider.of<
                ActivePlanBloc>(
              context,
            );

            final List<
                ActivePlanBrandModel>
            planBrandModel =
            List<ActivePlanBrandModel>.from(
              activePlanBloc
                  .activePlanSearch,
            );

            // =============================================
            // Loading
            // =============================================
            if (state
            is AllActivePlanLoadingState) {
              return Center(
                child: ConstrainedBox(
                  constraints:
                  BoxConstraints(
                    maxWidth:
                    pageMaxWidth,
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
                constraints:
                BoxConstraints(
                  maxWidth:
                  pageMaxWidth,
                ),

                child:
                CustomScrollView(
                  physics:
                  const BouncingScrollPhysics(),

                  keyboardDismissBehavior:
                  ScrollViewKeyboardDismissBehavior
                      .onDrag,

                  slivers: [
                    // ===========================================
                    // Search
                    // ===========================================
                    SliverPadding(
                      padding:
                      EdgeInsets.fromLTRB(
                        horizontalPadding,
                        searchTopPadding,
                        horizontalPadding,
                        searchBottomPadding,
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

                            onPressed:
                                (value) {
                              BlocProvider.of<
                                  ActivePlanBloc>(
                                context,
                              ).add(
                                SearchActivePlanEvent(
                                  value,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),

                    // ===========================================
                    // Empty
                    // ===========================================
                    if (planBrandModel
                        .isEmpty)
                      SliverFillRemaining(
                        hasScrollBody:
                        false,

                        child: Center(
                          child:
                          emptyFullScreen(
                            context,
                          ),
                        ),
                      )

                    // ===========================================
                    // List
                    // ===========================================
                    else
                      SliverPadding(
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
                              return _buildFluidAnimation(
                                index:
                                index + 1,

                                child:
                                BrandPlanCard(
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
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  // =====================================================
  // Entry Animation
  // =====================================================

  Widget _buildFluidAnimation({
    required Widget child,
    required int index,
  }) {
    return TweenAnimationBuilder<
        double>(
      tween: Tween<double>(
        begin: 0,
        end: 1,
      ),

      duration:
      const Duration(
        milliseconds: 280,
      ),

      curve:
      Curves.easeOutCubic,

      builder:
          (
          context,
          value,
          child,
          ) {
        return Opacity(
          opacity: value,

          child:
          Transform.translate(
            offset: Offset(
              0,
              18 * (1 - value),
            ),

            child:
            Transform.scale(
              scale:
              0.98 +
                  (0.02 *
                      value),

              alignment:
              Alignment.topCenter,

              child:
              child,
            ),
          ),
        );
      },

      child:
      child,
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
    final deviceType =
    AppResponsive.deviceType(context);

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

    switch (deviceType) {
    // =================================================
    // Mobile
    // =================================================
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
        break;

    // =================================================
    // Tablet Portrait
    // =================================================
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
        break;

    // =================================================
    // Tablet Landscape
    // =================================================
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
        break;
    }

    return Directionality(
      textDirection:
      TextDirection.rtl,

      child: Container(
        margin: EdgeInsets.only(
          bottom:
          cardBottomSpacing,
        ),

        decoration:
        BoxDecoration(
          color:
          Colors.white,

          borderRadius:
          BorderRadius.circular(
            cardRadius,
          ),

          border: Border.all(
            color:
            const Color(
              0xFFE2E8F0,
            ),
          ),

          boxShadow: [
            BoxShadow(
              color: Colors.black
                  .withOpacity(
                0.025,
              ),

              blurRadius: 12,

              offset:
              const Offset(
                0,
                4,
              ),
            ),
          ],
        ),

        clipBehavior:
        Clip.antiAlias,

        child: Column(
          crossAxisAlignment:
          CrossAxisAlignment.stretch,

          children: [
            // =================================================
            // Header
            // =================================================
            Container(
              padding:
              EdgeInsets.symmetric(
                horizontal:
                headerHorizontalPadding,

                vertical:
                headerVerticalPadding,
              ),

              color:
              const Color(
                0xFFF8FAFC,
              ),

              child: Row(
                crossAxisAlignment:
                CrossAxisAlignment.center,

                children: [
                  // =============================================
                  // Brand Icon
                  // =============================================
                  Container(
                    width:
                    iconBoxSize,

                    height:
                    iconBoxSize,

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
                        iconRadius,
                      ),
                    ),

                    child: Icon(
                      Icons
                          .medication_outlined,

                      size:
                      iconSize,

                      color:
                      const Color(
                        0xFF2563EB,
                      ),
                    ),
                  ),

                  SizedBox(
                    width:
                    iconSpacing,
                  ),

                  // =============================================
                  // Brand Info
                  // =============================================
                  Expanded(
                    child: Column(
                      mainAxisSize:
                      MainAxisSize.min,

                      crossAxisAlignment:
                      CrossAxisAlignment
                          .start,

                      children: [
                        Text(
                          model.title,

                          maxLines: 2,

                          overflow:
                          TextOverflow
                              .ellipsis,

                          style:
                          TextStyle(
                            fontSize:
                            titleFontSize,

                            fontWeight:
                            FontWeight
                                .w700,

                            color:
                            const Color(
                              0xFF1E3A8A,
                            ),

                            height:
                            1.25,
                          ),
                        ),

                        if (model
                            .pharmaceuticalFormTitle
                            .trim()
                            .isNotEmpty) ...[
                          const SizedBox(
                            height: 4,
                          ),

                          Text(
                            model
                                .pharmaceuticalFormTitle,

                            maxLines: 1,

                            overflow:
                            TextOverflow
                                .ellipsis,

                            style:
                            TextStyle(
                              fontSize:
                              formFontSize,

                              color:
                              const Color(
                                0xFF64748B,
                              ),

                              fontWeight:
                              FontWeight
                                  .w500,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),

                  const SizedBox(
                    width: 10,
                  ),

                  // =============================================
                  // Existing Badge
                  // =============================================
                  Type.buildBadge(
                    model.type,
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
                contentPadding,
              ),

              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,

                children: [
                  // =============================================
                  // Section Header
                  // =============================================
                  Row(
                    children: [
                      Container(
                        width:
                        iconSize + 10,

                        height:
                        iconSize + 10,

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
                            8,
                          ),
                        ),

                        child: Icon(
                          Icons
                              .bar_chart_rounded,

                          size:
                          iconSize - 3,

                          color:
                          const Color(
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

                          overflow:
                          TextOverflow
                              .ellipsis,

                          style:
                          TextStyle(
                            fontSize:
                            sectionTitleFontSize,

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
                    sectionSpacing,
                  ),

                  // =============================================
                  // Empty Specialties
                  // =============================================
                  if (model
                      .spPlan
                      .isEmpty)
                    _buildEmptySpecialties(
                      context,
                    )

                  // =============================================
                  // Specialties
                  //
                  // ما في ListView داخلي
                  // =============================================
                  else
                    ...model.spPlan
                        .asMap()
                        .entries
                        .map(
                          (entry) {
                        final item =
                            entry.value;

                        final isLast =
                            entry.key ==
                                model.spPlan
                                    .length -
                                    1;

                        return Container(
                          margin:
                          EdgeInsets.only(
                            bottom: isLast
                                ? 0
                                : itemBottomSpacing,
                          ),

                          padding:
                          EdgeInsets.symmetric(
                            horizontal:
                            itemHorizontalPadding,

                            vertical:
                            itemVerticalPadding,
                          ),

                          decoration:
                          BoxDecoration(
                            color:
                            const Color(
                              0xFFFAFCFF,
                            ),

                            borderRadius:
                            BorderRadius
                                .circular(
                              itemRadius,
                            ),

                            border:
                            Border.all(
                              color:
                              const Color(
                                0xFFE9EEF5,
                              ),
                            ),
                          ),

                          child: Row(
                            children: [
                              // =================================
                              // Specialty
                              // =================================
                              Expanded(
                                child:
                                Text(
                                  item.name,

                                  maxLines:
                                  2,

                                  overflow:
                                  TextOverflow
                                      .ellipsis,

                                  style:
                                  TextStyle(
                                    fontSize:
                                    specialtyFontSize,

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

                              const SizedBox(
                                width: 12,
                              ),

                              // =================================
                              // Target Amount
                              // =================================
                              Container(
                                constraints:
                                const BoxConstraints(
                                  minWidth:
                                  46,
                                ),

                                padding:
                                const EdgeInsets
                                    .symmetric(
                                  horizontal:
                                  10,
                                  vertical:
                                  6,
                                ),

                                decoration:
                                BoxDecoration(
                                  color:
                                  const Color(
                                    0xFFEFF6FF,
                                  ),

                                  borderRadius:
                                  BorderRadius
                                      .circular(
                                    9,
                                  ),
                                ),

                                child:
                                Text(
                                  item.amount,

                                  textAlign:
                                  TextAlign.center,

                                  maxLines:
                                  1,

                                  overflow:
                                  TextOverflow
                                      .ellipsis,

                                  style:
                                  TextStyle(
                                    fontSize:
                                    amountFontSize,

                                    height:
                                    1,

                                    fontWeight:
                                    FontWeight
                                        .w800,

                                    color:
                                    const Color(
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

  // =====================================================
  // Empty Specialties
  // =====================================================

  Widget _buildEmptySpecialties(
      BuildContext context,
      ) {
    final deviceType =
    AppResponsive.deviceType(context);

    final double fontSize =
    deviceType ==
        AppDeviceType
            .mobilePortrait
        ? 11.5
        : deviceType ==
        AppDeviceType
            .tabletPortrait
        ? 13
        : 12;

    return Container(
      width:
      double.infinity,

      padding:
      const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 18,
      ),

      decoration:
      BoxDecoration(
        color:
        const Color(
          0xFFF8FAFC,
        ),

        borderRadius:
        BorderRadius.circular(
          12,
        ),

        border:
        Border.all(
          color:
          const Color(
            0xFFE2E8F0,
          ),
        ),
      ),

      child: Column(
        mainAxisSize:
        MainAxisSize.min,

        children: [
          const Icon(
            Icons
                .assignment_outlined,

            size: 24,

            color:
            Color(
              0xFF94A3B8,
            ),
          ),

          const SizedBox(
            height: 7,
          ),

          Text(
            'لا يوجد توزيع اختصاصات لهذه المادة',

            textAlign:
            TextAlign.center,

            style:
            TextStyle(
              fontSize:
              fontSize,

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
    );
  }
}