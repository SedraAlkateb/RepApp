// ignore_for_file: deprecated_member_use

import 'package:domina_app/app/user_info.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/brand_plan/bloc/brand_plan_bloc.dart';
import 'package:domina_app/presentation/brand_plan/pages/brand_plan_other_page.dart';
import 'package:domina_app/presentation/brand_plan/widget/save_send_bottom.dart';
import 'package:domina_app/presentation/resources/assets_manager.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/resources/responsive/app_ui.dart';
import 'package:domina_app/presentation/uniti/stateWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SpecPlanPage extends StatelessWidget {
  const SpecPlanPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final ui = AppUi.of(context);

    return Scaffold(
      backgroundColor: const Color(
        0xFFF8FAFC,
      ),

      body: Stack(
        children: [
          // =====================================================
          // Main Content
          // =====================================================
          BlocConsumer<BrandPlanBloc, BrandPlanState>(
            listener: (
                context,
                state,
                ) {
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
              List<OtherBrandSpPlanModel>
              planBrandModel =
                  context
                      .watch<BrandPlanBloc>()
                      .planBrand;

              // =================================================
              // نفس السلوك الأصلي
              // =================================================
              if (state is SumState) {
                planBrandModel =
                    state.planBrands;
              }

              // =================================================
              // Empty
              // =================================================
              if (state is AllBrandPlanEmptyState ||
                  planBrandModel.isEmpty) {
                return Center(
                  child: emptyFullScreen(
                    context,
                  ),
                );
              }

              return OrientationBuilder(
                builder: (
                    context,
                    orientation,
                    ) {
                  // ===============================================
                  // نفس توزيع الأعمدة السابق
                  // ===============================================
                  final int crossAxisCount;

                  if (ui.isTabletLandscape) {
                    crossAxisCount = 4;
                  } else if (ui.isTabletPortrait) {
                    crossAxisCount = 3;
                  } else {
                    crossAxisCount =
                    orientation ==
                        Orientation.landscape
                        ? 3
                        : 2;
                  }

                  return Center(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth:
                        ui.widePageMaxWidth,
                      ),

                      child: CustomScrollView(
                        physics:
                        const BouncingScrollPhysics(),

                        slivers: [
                          // =========================================
                          // Header
                          // نفس مكان وترتيب التصميم الأصلي
                          // =========================================
                          SliverToBoxAdapter(
                            child: Padding(
                              padding:
                              EdgeInsets.symmetric(
                                horizontal:
                                ui.pagePadding,
                              ),

                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,

                                children: [
                                  SizedBox(
                                    height:
                                    ui.isMobile
                                        ? 14
                                        : 16,
                                  ),

                                  // =================================
                                  // Plan Date
                                  // =================================
                                  Center(
                                    child: Container(
                                      padding:
                                      EdgeInsets.symmetric(
                                        horizontal:
                                        ui.isMobile
                                            ? 24
                                            : 30,

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
                                        BorderRadius.circular(
                                          ui.isMobile
                                              ? 15
                                              : 17,
                                        ),

                                        border:
                                        Border.all(
                                          color:
                                          const Color(
                                            0xFFF1F5F9,
                                          ),
                                        ),

                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black
                                                .withOpacity(
                                              0.01,
                                            ),

                                            blurRadius:
                                            10,

                                            offset:
                                            const Offset(
                                              0,
                                              2,
                                            ),
                                          ),
                                        ],
                                      ),

                                      child: Text(
                                        'تاريخ الخطة: '
                                            '${UserInfo.otherStartDate} - '
                                            '${UserInfo.otherEndDate}',

                                        textAlign:
                                        TextAlign.center,

                                        maxLines: 2,

                                        overflow:
                                        TextOverflow
                                            .ellipsis,

                                        style:
                                        TextStyle(
                                          fontSize:
                                          ui.isMobile
                                              ? 14
                                              : 15,

                                          color:
                                          ColorManager
                                              .medicalPrimary,

                                          fontWeight:
                                          FontWeight
                                              .w900,

                                          height:
                                          1.3,
                                        ),
                                      ),
                                    ),
                                  ),

                                  SizedBox(
                                    height:
                                    ui.isMobile
                                        ? 25
                                        : 28,
                                  ),

                                  // =================================
                                  // Title
                                  // =================================
                                  Text(
                                    'توزيع العينات حسب الاختصاص',

                                    maxLines: 2,

                                    overflow:
                                    TextOverflow
                                        .ellipsis,

                                    style:
                                    TextStyle(
                                      fontSize:
                                      ui.pageTitleSize,

                                      fontWeight:
                                      FontWeight.bold,

                                      color:
                                      const Color(
                                        0xFF0F172A,
                                      ),

                                      height:
                                      1.3,
                                    ),
                                  ),

                                  SizedBox(
                                    height:
                                    ui.smallSpacing,
                                  ),

                                  // =================================
                                  // Description
                                  // =================================
                                  Text(
                                    'يمكنك استعراض عدد العينات المتاحة لكل اختصاص '
                                        'وتعديلها أو إرسالها للمراجعة',

                                    style:
                                    TextStyle(
                                      fontSize:
                                      ui.pageSubtitleSize,

                                      color:
                                      const Color(
                                        0xFF64748B,
                                      ),

                                      height:
                                      1.4,
                                    ),
                                  ),

                                  SizedBox(
                                    height:
                                    ui.isMobile
                                        ? 20
                                        : 22,
                                  ),
                                ],
                              ),
                            ),
                          ),

                          // =========================================
                          // Grid
                          // نفس مكانه السابق
                          // =========================================
                          SliverPadding(
                            padding:
                            EdgeInsets.symmetric(
                              horizontal:
                              ui.pagePadding,

                              vertical:
                              ui.isMobile
                                  ? 10
                                  : 12,
                            ),

                            sliver: SliverGrid(
                              gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount:
                                crossAxisCount,

                                crossAxisSpacing:
                                ui.gridSpacing,

                                mainAxisSpacing:
                                ui.gridSpacing,

                                // قريب جداً من الشكل الأصلي
                                childAspectRatio:
                                _getChildAspectRatio(
                                  ui,
                                ),
                              ),

                              delegate:
                              SliverChildBuilderDelegate(
                                    (
                                    context,
                                    index,
                                    ) {
                                  final item =
                                  planBrandModel[
                                  index];

                                  // =================================
                                  // نفس الشرط الأصلي تماماً
                                  // =================================
                                  if (item.brandk ==
                                      0) {
                                    return const SizedBox
                                        .shrink();
                                  }

                                  return _buildSpecItem(
                                    context,
                                    ui,
                                    item,
                                    index,
                                  );
                                },

                                childCount:
                                planBrandModel
                                    .length,
                              ),
                            ),
                          ),

                          // =========================================
                          // نفس المساحة السفلية للزر
                          // =========================================
                          SliverToBoxAdapter(
                            child: SizedBox(
                              height:
                              ui.isMobile
                                  ? 120
                                  : 130,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),

          // =====================================================
          // Save / Send
          // نفس مكانه وسلوكه الأصلي
          // =====================================================
          context
              .watch<BrandPlanBloc>()
              .planBrand
              .isNotEmpty
              ? BlocListener<
              BrandPlanBloc,
              BrandPlanState>(
            listener: (
                context,
                state,
                ) {
              if (state
              is UpdateAmountErrorState) {
                error(
                  context,
                  state.failure.massage,
                  state.failure.code,
                );
              }

              if (state
              is UpdateAmountState) {
                context
                    .read<BrandPlanBloc>()
                    .add(
                  UpdateSaveEvent(),
                );

                dismissDialog(
                  context,
                );

                successWithMessage(
                  context,
                  'تم حفظ التغيرات',
                );
              }

              if (state
              is UpdateAmountSendState) {
                dismissDialog(
                  context,
                );

                successWithMessage(
                  context,
                  'تم الارسال يرجى المزامنة ',
                );
              }
            },

            child:
            const SaveSendBottom(),
          )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }

  // ===========================================================
  // Grid Ratio
  // ===========================================================

  double _getChildAspectRatio(
      AppUi ui,
      ) {
    if (ui.isMobile) {
      return 0.68;
    }

    if (ui.isTabletPortrait) {
      return 0.78;
    }

    return 0.86;
  }

  // ===========================================================
  // Spec Card
  // نفس شكل وترتيب الكرت السابق
  // ===========================================================

  Widget _buildSpecItem(
      BuildContext context,
      AppUi ui,
      OtherBrandSpPlanModel model,
      int index,
      ) {
    return Material(
      color: Colors.transparent,

      child: InkWell(
        borderRadius:
        BorderRadius.circular(
          ui.isMobile
              ? 20
              : 22,
        ),

        // =====================================================
        // نفس Navigation الأصلي
        // =====================================================
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (
                  context,
                  ) =>
                  BrandPlanOtherPage(
                    otherBrandSpPlanModel:
                    model,
                    index1:
                    index,
                  ),
            ),
          );
        },

        child: Container(
          decoration: BoxDecoration(
            color:
            Colors.white,

            borderRadius:
            BorderRadius.circular(
              ui.isMobile
                  ? 20
                  : 22,
            ),

            border: Border.all(
              color:
              const Color(
                0xFFE2E8F0,
              ),
            ),

            boxShadow: [
              BoxShadow(
                color:
                Colors.black.withOpacity(
                  0.03,
                ),

                blurRadius:
                10,

                offset:
                const Offset(
                  0,
                  4,
                ),
              ),
            ],
          ),

          child: Padding(
            padding:
            EdgeInsets.symmetric(
              horizontal:
              ui.isMobile
                  ? 10
                  : 12,

              vertical:
              ui.isMobile
                  ? 10
                  : 12,
            ),

            child: Column(
              mainAxisAlignment:
              MainAxisAlignment.center,

              children: [
                // ===============================================
                // Icon
                // نفس مكانه بالأعلى
                // ===============================================
                Container(
                  width:
                  ui.isMobile
                      ? 54
                      : 60,

                  height:
                  ui.isMobile
                      ? 54
                      : 60,

                  alignment:
                  Alignment.center,

                  padding:
                  EdgeInsets.all(
                    ui.isMobile
                        ? 10
                        : 11,
                  ),

                  decoration:
                  BoxDecoration(
                    color:
                    ColorManager
                        .medicalSecondary
                        .withOpacity(
                      0.10,
                    ),

                    shape:
                    BoxShape.circle,
                  ),

                  child:
                  Image.asset(
                    ImageAssetsSpec()
                        .getImage(
                      model
                          .specModel
                          .id,
                    ),

                    width:
                    ui.isMobile
                        ? 35
                        : 38,

                    height:
                    ui.isMobile
                        ? 35
                        : 38,

                    fit:
                    BoxFit.contain,

                    color:
                    ColorManager
                        .medicalSecondary
                        .withOpacity(
                      0.8,
                    ),

                    colorBlendMode:
                    BlendMode
                        .modulate,

                    errorBuilder: (
                        context,
                        error,
                        stackTrace,
                        ) {
                      return Icon(
                        Icons
                            .medical_services,

                        size:
                        ui.iconSize,

                        color:
                        ColorManager
                            .medicalSecondary,
                      );
                    },
                  ),
                ),

                SizedBox(
                  height:
                  ui.isMobile
                      ? 10
                      : 12,
                ),

                // ===============================================
                // Specialization Name
                // ===============================================
                Text(
                  model
                      .specModel
                      .title,

                  textAlign:
                  TextAlign.center,

                  maxLines: 1,

                  overflow:
                  TextOverflow.ellipsis,

                  style:
                  TextStyle(
                    color:
                    const Color(
                      0xFF1E293B,
                    ),

                    fontWeight:
                    FontWeight.bold,

                    fontSize:
                    ui.isMobile
                        ? 14
                        : 15,
                  ),
                ),

                SizedBox(
                  height:
                  ui.smallSpacing,
                ),

                // ===============================================
                // Stats
                // نفس مكانها وترتيبها
                // ===============================================
                Padding(
                  padding:
                  EdgeInsets.symmetric(
                    horizontal:
                    ui.isMobile
                        ? 2
                        : 4,
                  ),

                  child: Column(
                    children: [
                      _buildStatItem(
                        ui,
                        'زيارات أطباء',
                        '${model.specModel.sumDoctor}',
                      ),

                      _buildDivider(
                        ui,
                      ),

                      _buildStatItem(
                        ui,
                        'زيارات المشافي',
                        '${model.specModel.sumHospital}',
                      ),

                      _buildDivider(
                        ui,
                      ),

                      _buildStatItem(
                        ui,
                        'عينات',
                        '${model.brandk / UserInfo.samplesCount}',
                      ),
                    ],
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
  // Divider
  // ===========================================================

  Widget _buildDivider(
      AppUi ui,
      ) {
    return Divider(
      height:
      ui.isMobile
          ? 12
          : 14,

      color:
      const Color(
        0xFFE2E8F0,
      ).withOpacity(
        0.65,
      ),

      thickness:
      1,
    );
  }

  // ===========================================================
  // Stat Row
  // ===========================================================

  Widget _buildStatItem(
      AppUi ui,
      String label,
      String value,
      ) {
    return Row(
      children: [
        Expanded(
          child: Text(
            label,

            maxLines: 1,

            overflow:
            TextOverflow.ellipsis,

            style:
            TextStyle(
              fontSize:
              ui.isMobile
                  ? 10.5
                  : 11.5,

              color:
              const Color(
                0xFF94A3B8,
              ),

              fontWeight:
              FontWeight.w500,
            ),
          ),
        ),

        SizedBox(
          width:
          ui.smallSpacing,
        ),

        Flexible(
          child: Text(
            value,

            maxLines: 1,

            overflow:
            TextOverflow.ellipsis,

            style:
            TextStyle(
              fontSize:
              ui.isMobile
                  ? 11.5
                  : 13,

              color:
              const Color(
                0xFF0F172A,
              ),

              fontWeight:
              FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}