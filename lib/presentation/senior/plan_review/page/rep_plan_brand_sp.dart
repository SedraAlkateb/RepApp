// ignore_for_file: must_be_immutable

import 'package:domina_app/app/user_info.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/resources/responsive/app_responsive.dart';
import 'package:domina_app/presentation/resources/responsive/app_ui.dart';
import 'package:domina_app/presentation/senior/plan_review/bloc/future_rep_bloc.dart';
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
  BrandAmountModel  brandAmount=BrandAmountModel(0, 0, 0);
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
                   brandAmount=state.brandAmountModel;
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
                      buildSampleStatisticsSummaryCard(brandAmount),

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
                            "الشكل الصيدلاني: ${item.phTitle}",

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

  Widget buildSampleStatisticsSummaryCard(BrandAmountModel planBrandSp) {
    return Builder(
      builder: (context) {
        final deviceType = AppResponsive.deviceType(context);

        double cardPadding;
        double cardRadius;
        double titleFontSize;
        double labelFontSize;
        double countFontSize;
        double iconSize;
        double spacing;

        switch (deviceType) {
          case AppDeviceType.mobilePortrait:
            cardPadding = 16;
            cardRadius = 20;
            titleFontSize = 14;
            labelFontSize = 11;
            countFontSize = 18;
            iconSize = 18;
            spacing = 8;
            break;

          case AppDeviceType.tabletPortrait:
            cardPadding = 20;
            cardRadius = 24;
            titleFontSize = 16;
            labelFontSize = 13;
            countFontSize = 22;
            iconSize = 22;
            spacing = 12;
            break;

          case AppDeviceType.tabletLandscape:
            cardPadding = 18;
            cardRadius = 22;
            titleFontSize = 15;
            labelFontSize = 12;
            countFontSize = 20;
            iconSize = 20;
            spacing = 10;
            break;
        }

        return Container(
          margin: const EdgeInsets.symmetric(vertical: 8),
          padding: EdgeInsets.all(cardPadding),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(cardRadius),
            border: Border.all(color: const Color(0xFFE2E8F0)),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF1F4E79).withOpacity(0.06),
                blurRadius: 16,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // العنوان الرئيسي للبطاقة
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEFF6FF),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      Icons.analytics_outlined,
                      size: 18,
                      color: Color(0xFF1F4E79),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    "إجمالي توزيع العينات بالخطة",
                    style: TextStyle(
                      fontSize: titleFontSize,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF1F4E79),
                    ),
                  ),
                ],
              ),
              SizedBox(height: spacing * 1.5),

              // قسم الأرقام والإحصائيات مقسمة بانتظام
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: _buildStatItem(
                      title: "الأطباء",
                      count: planBrandSp.numDoctor,
                      icon: Icons.person_outline_rounded,
                      color: const Color(0xFF2563EB),
                      bgColor: const Color(0xFFEFF6FF),
                      labelSize: labelFontSize,
                      countSize: countFontSize,
                      iconSize: iconSize,
                    ),
                  ),
                  _buildDivider(),
                  Expanded(
                    child: _buildStatItem(
                      title: "المستشفيات",
                      count: planBrandSp.numHospital,
                      icon: Icons.local_hospital_outlined,
                      color: const Color(0xFF0D9488),
                      bgColor: const Color(0xFFF0FDFA),
                      labelSize: labelFontSize,
                      countSize: countFontSize,
                      iconSize: iconSize,
                    ),
                  ),
                  _buildDivider(),
                  Expanded(
                    child: _buildStatItem(
                      title: "الشعب",
                      count: planBrandSp.numDepartment,
                      icon: Icons.meeting_room_outlined,
                      color: const Color(0xFFD97706),
                      bgColor: const Color(0xFFFFFBEB),
                      labelSize: labelFontSize,
                      countSize: countFontSize,
                      iconSize: iconSize,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildStatItem({
    required String title,
    required int count,
    required IconData icon,
    required Color color,
    required Color bgColor,
    required double labelSize,
    required double countSize,
    required double iconSize,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: bgColor,
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            size: iconSize,
            color: color,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          "$count",
          style: TextStyle(
            fontSize: countSize,
            fontWeight: FontWeight.w800,
            color: const Color(0xFF1E293B),
          ),
        ),
        const SizedBox(height: 2),
        Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: labelSize,
            fontWeight: FontWeight.w600,
            color: Colors.grey.shade600,
          ),
        ),
      ],
    );
  }

  Widget _buildDivider() {
    return Container(
      height: 40,
      width: 1,
      color: const Color(0xFFE2E8F0),
    );
  }
}
