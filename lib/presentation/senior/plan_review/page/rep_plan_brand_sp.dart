// ignore_for_file: must_be_immutable

import 'package:domina_app/app/user_info.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/resources/responsive/app_ui.dart';
import 'package:domina_app/presentation/senior/plan_review/bloc/future_rep_bloc.dart';
import 'package:domina_app/presentation/uniti/num_list.dart';
import 'package:domina_app/presentation/uniti/search_field.dart';
import 'package:domina_app/presentation/uniti/stateWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RepPlanBrandSpPage extends StatefulWidget {
  const RepPlanBrandSpPage({
    super.key,
    required this.title,
    this.flag,
  });

  final String title;
  final int? flag;

  @override
  State<RepPlanBrandSpPage> createState() =>
      _RepPlanBrandSpPageState();
}

class _RepPlanBrandSpPageState
    extends State<RepPlanBrandSpPage>
    with AutomaticKeepAliveClientMixin {
  List<PlanBrandSp> planBrandsp = [];

  // =====================================================
  // Search Controller
  //
  // كان ينخلق داخل build بكل rebuild.
  // هلق صار تابع للـState ويتم تنظيفه بشكل صحيح.
  // =====================================================

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

    final ui = AppUi.of(context);

    return Scaffold(
      backgroundColor:
      const Color(
        0xFFF8FAFC,
      ),

      // =====================================================
      // Save Changes
      // =====================================================
      floatingActionButton:
      FloatingActionButton.extended(
        elevation: 3,

        backgroundColor:
        ColorManager.secondaryColor1,

        shape:
        RoundedRectangleBorder(
          borderRadius:
          BorderRadius.circular(
            ui.cardRadius - 4,
          ),
        ),

        icon:
        Icon(
          Icons.save_as_rounded,
          color: Colors.white,
          size: ui.iconSize,
        ),

        label:
        Text(
          "حفظ التعديلات",

          style:
          TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: ui.bodyTextSize,
          ),
        ),

        // =================================================
        // نفس الحدث الأصلي
        // =================================================
        onPressed: () {
          BlocProvider.of<
              FutureRepBloc>(
            context,
          ).add(
            UpdateAmountEvent(),
          );
        },
      ),

      // =====================================================
      // Nested Scroll
      // =====================================================
      body: NestedScrollView(
        headerSliverBuilder:
            (
            context,
            innerBoxIsScrolled,
            ) {
          return [
            // =================================================
            // AppBar
            // =================================================
            SliverAppBar(
              pinned: true,
              floating: true,

              elevation: 0,

              scrolledUnderElevation:
              1,

              surfaceTintColor:
              Colors.transparent,

              title:
              Text(
                widget.title,

                maxLines: 1,

                overflow:
                TextOverflow.ellipsis,
              ),
            ),

            // =================================================
            // Search
            //
            // ما زال يتحرك مع الـScroll مثل النسخة الأصلية
            // =================================================
            SliverToBoxAdapter(
              child: Container(
                color:
                const Color(
                  0xFFF8FAFC,
                ),

                child: Center(
                  child: ConstrainedBox(
                    constraints:
                    BoxConstraints(
                      maxWidth:
                      ui.pageMaxWidth,
                    ),

                    child: Padding(
                      padding:
                      EdgeInsets.fromLTRB(
                        ui.pagePadding,
                        ui.searchTopPadding,
                        ui.pagePadding,
                        ui.searchBottomPadding,
                      ),

                      child:
                      SearchField(
                        searchController:
                        searchController,

                        onPressed:
                            (value) {
                          // =====================================
                          // نفس Search Event
                          // =====================================
                          BlocProvider.of<
                              FutureRepBloc>(
                            context,
                          ).add(
                            SearchPlanBrandsEvent(
                              value,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ];
        },

        // =====================================================
        // Page Content
        // =====================================================
        body: Center(
          child: ConstrainedBox(
            constraints:
            BoxConstraints(
              maxWidth:
              ui.pageMaxWidth,
            ),

            child: BlocConsumer<
                FutureRepBloc,
                FutureRepState>(
              // =================================================
              // Listener
              // نفس السلوك والترتيب الأصلي
              // =================================================
              listener:
                  (context, state) {
                if (state
                is FutureRepPlanBrandSpErrorState) {
                  error(
                    context,
                    state.failure.massage,
                    state.failure.code,
                  );
                }

                if (state
                is SumErrorState) {
                  error(
                    context,
                    state.failure.massage,
                    state.failure.code,
                  );
                }

                if (state
                is FutureSpRepErrorState) {
                  error(
                    context,
                    state.failure.massage,
                    state.failure.code,
                  );
                }

                if (state
                is UpdateAmountLoadingState) {
                  loading(
                    context,
                  );
                }

                if (state
                is UpdateAmountState) {
                  // =============================================
                  // نفس الترتيب الأصلي تماماً
                  // =============================================
                  success(
                    context,
                  );

                  Navigator.pop(
                    context,
                  );
                }
              },

              builder:
                  (context, state) {
                // =================================================
                // Loaded
                // =================================================
                if (state
                is FutureRepPlanBrandSpState) {
                  planBrandsp =
                      state.planBrandSp;
                }

                // =================================================
                // Loading
                // =================================================
                if (state
                is FutureRepPlanBrandSpLoadingState) {
                  return loadingFullScreen(
                    context,
                  );
                }

                // =================================================
                // Empty
                // =================================================
                if (state
                is FutureRepPlanBrandSpEmptyState) {
                  return emptyFullScreen(
                    context,
                  );
                }

                // =================================================
                // Content
                // =================================================
                return SingleChildScrollView(
                  physics:
                  const BouncingScrollPhysics(),

                  keyboardDismissBehavior:
                  ScrollViewKeyboardDismissBehavior
                      .onDrag,

                  padding:
                  EdgeInsets.fromLTRB(
                    ui.pagePadding,
                    ui.listTopPadding +
                        8,
                    ui.pagePadding,

                    // مساحة للـFAB
                    ui.pageBottomPadding +
                        90,
                  ),

                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment
                        .stretch,

                    children: [
                      // =============================================
                      // Summary
                      // =============================================
                      buildTotalReportsCard(
                        BlocProvider.of<
                            FutureRepBloc>(
                          context,
                        ).number,
                        "إحصائيات توزيع العينات",
                        "إجمالي العينات المحددة بالخطة",
                      ),

                      SizedBox(
                        height:
                        ui.sectionSpacing,
                      ),

                      // =============================================
                      // Cards
                      // =============================================
                      ListView.builder(
                        physics:
                        const NeverScrollableScrollPhysics(),

                        shrinkWrap:
                        true,

                        padding:
                        EdgeInsets.zero,

                        itemCount:
                        planBrandsp.length,

                        itemBuilder:
                            (
                            context,
                            index,
                            ) {
                          return _buildModernCard(
                            context,
                            index,
                            state,
                          );
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }



  // =====================================================
  // Brand Card
  // =====================================================

  Widget _buildModernCard(
      BuildContext context,
      int index,
      FutureRepState state,
      ) {
    final ui =
    AppUi.of(context);

    final PlanBrandSp item =
    planBrandsp[index];

    // =====================================================
    // نفس شرط التعديل الأصلي
    // =====================================================
    final bool isEditable =
        widget.flag ==
            UserInfo.statusPlan;

    return Padding(
      padding:
      EdgeInsets.only(
        bottom:
        ui.cardSpacing,
      ),

      child: Container(
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
                0.025,
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

        clipBehavior:
        Clip.antiAlias,

        child: Stack(
          children: [
            // =================================================
            // Content
            // =================================================
            Padding(
              padding:
              EdgeInsets.fromLTRB(
                ui.cardPadding,
                ui.cardPadding,

                // مساحة للشريط الجانبي
                ui.cardPadding + 5,

                ui.cardPadding,
              ),

              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment
                    .stretch,

                children: [
                  // =================================================
                  // Header
                  // =================================================
                  Row(
                    crossAxisAlignment:
                    CrossAxisAlignment
                        .center,

                    children: [
                      // =============================================
                      // Medication Icon
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
                          item.brandType
                              .color
                              .withOpacity(
                            0.08,
                          ),

                          borderRadius:
                          BorderRadius
                              .circular(
                            ui.smallRadius +
                                2,
                          ),
                        ),

                        child: Icon(
                          Icons
                              .medication_rounded,

                          color:
                          item.brandType
                              .color,

                          size:
                          ui.iconSize,
                        ),
                      ),

                      SizedBox(
                        width:
                        ui.sectionSpacing,
                      ),

                      // =============================================
                      // Brand Name
                      // =============================================
                      Expanded(
                        child: Text(
                          item.titleAr,

                          maxLines:
                          2,

                          overflow:
                          TextOverflow
                              .ellipsis,

                          style:
                          TextStyle(
                            fontSize:
                            ui.cardTitleSize,

                            fontWeight:
                            FontWeight
                                .w700,

                            color:
                            ColorManager
                                .secondaryColor1,

                            height:
                            1.3,
                          ),
                        ),
                      ),

                      SizedBox(
                        width:
                        ui.mediumSpacing,
                      ),

                      // =============================================
                      // Existing Type Badge
                      // =============================================
                      Type.buildBadge(
                        item.brandType,
                      ),
                    ],
                  ),

                  SizedBox(
                    height:
                    ui.sectionSpacing,
                  ),

                  // =================================================
                  // Pharmaceutical Type
                  // =================================================
                  Container(
                    padding:
                    EdgeInsets.symmetric(
                      horizontal:
                      ui.mediumSpacing,

                      vertical:
                      ui.smallSpacing +
                          2,
                    ),

                    decoration:
                    BoxDecoration(
                      color:
                      const Color(
                        0xFFF8FAFC,
                      ),

                      borderRadius:
                      BorderRadius.circular(
                        ui.smallRadius,
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
                        Icon(
                          Icons
                              .category_outlined,

                          size:
                          ui.smallIconSize,

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
                            "النوع: ${item.phTitle}",

                            maxLines:
                            1,

                            overflow:
                            TextOverflow
                                .ellipsis,

                            style:
                            TextStyle(
                              color:
                              const Color(
                                0xFF64748B,
                              ),

                              fontSize:
                              ui.bodyTextSize,

                              fontWeight:
                              FontWeight
                                  .w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(
                    height:
                    ui.sectionSpacing,
                  ),

                  const Divider(
                    height: 1,

                    thickness:
                    1,

                    color:
                    Color(
                      0xFFF1F5F9,
                    ),
                  ),

                  SizedBox(
                    height:
                    ui.sectionSpacing,
                  ),

                  // =================================================
                  // Amount
                  // =================================================
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment
                              .start,

                          mainAxisSize:
                          MainAxisSize
                              .min,

                          children: [
                            Text(
                              "العدد المطلوب",

                              style:
                              TextStyle(
                                fontWeight:
                                FontWeight
                                    .w600,

                                fontSize:
                                ui.bodyTextSize,

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
                              isEditable
                                  ? "يمكن تعديل الكمية"
                                  : "الكمية للعرض فقط",

                              style:
                              TextStyle(
                                fontSize:
                                ui.smallTextSize,

                                color:
                                const Color(
                                  0xFF94A3B8,
                                ),

                                fontWeight:
                                FontWeight
                                    .w500,
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(
                        width:
                        ui.sectionSpacing,
                      ),

                      // =============================================
                      // Amount Input
                      // =============================================
                      SizedBox(
                        width:
                        ui.isMobile
                            ? 92
                            : 110,

                        height:
                        ui.isMobile
                            ? 42
                            : 46,

                        child: TextField(
                          keyboardType:
                          TextInputType
                              .number,

                          textAlign:
                          TextAlign.center,

                          enabled:
                          isEditable,

                          // =========================================
                          // نفس الـLogic الأصلي تماماً
                          // =========================================
                          onChanged:
                              (value) {
                            if (value
                                .isNotEmpty) {
                              BlocProvider.of<
                                  FutureRepBloc>(
                                context,
                              ).add(
                                ChangeFieldEvent(
                                  int.parse(
                                    value,
                                  ),
                                  index,
                                ),
                              );
                            }
                          },

                          style:
                          TextStyle(
                            fontWeight:
                            FontWeight
                                .w700,

                            fontSize:
                            ui.bodyTextSize +
                                1,

                            color:
                            isEditable
                                ? item
                                .brandType
                                .color
                                : const Color(
                              0xFF94A3B8,
                            ),
                          ),

                          decoration:
                          InputDecoration(
                            hintText:
                            item.totalAmount
                                .toString(),

                            hintStyle:
                            TextStyle(
                              color:
                              item.brandType
                                  .color
                                  .withOpacity(
                                isEditable
                                    ? 0.65
                                    : 0.4,
                              ),

                              fontWeight:
                              FontWeight
                                  .w700,
                            ),

                            filled:
                            true,

                            fillColor:
                            isEditable
                                ? item
                                .brandType
                                .color
                                .withOpacity(
                              0.055,
                            )
                                : const Color(
                              0xFFF8FAFC,
                            ),

                            contentPadding:
                            EdgeInsets.symmetric(
                              horizontal:
                              ui.smallSpacing,

                              vertical:
                              10,
                            ),

                            enabledBorder:
                            OutlineInputBorder(
                              borderRadius:
                              BorderRadius
                                  .circular(
                                ui.smallRadius,
                              ),

                              borderSide:
                              BorderSide(
                                color:
                                item
                                    .brandType
                                    .color
                                    .withOpacity(
                                  0.22,
                                ),
                              ),
                            ),

                            focusedBorder:
                            OutlineInputBorder(
                              borderRadius:
                              BorderRadius
                                  .circular(
                                ui.smallRadius,
                              ),

                              borderSide:
                              BorderSide(
                                color:
                                item
                                    .brandType
                                    .color,

                                width:
                                1.5,
                              ),
                            ),

                            disabledBorder:
                            OutlineInputBorder(
                              borderRadius:
                              BorderRadius
                                  .circular(
                                ui.smallRadius,
                              ),

                              borderSide:
                              const BorderSide(
                                color:
                                Color(
                                  0xFFE2E8F0,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // =================================================
            // Brand Type Side Stripe
            //
            // نفس دلالة اللون القديمة لكن موحدة مع كروت التطبيق
            // =================================================
            Positioned(
              top: 0,
              bottom: 0,
              right: 0,

              child: Container(
                width: 5,

                color:
                item.brandType.color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive =>
      true;
}