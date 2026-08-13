import 'package:domina_app/app/di/di.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/Recipes/bloc/recipes_brand_bloc.dart';
import 'package:domina_app/presentation/Recipes/pages/update_recipes.dart';
import 'package:domina_app/presentation/Recipes/pages/update_recipes_hospital.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/resources/responsive/app_ui.dart';
import 'package:domina_app/presentation/uniti/stateWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class AllRecip extends StatelessWidget {
  const AllRecip({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final ui = AppUi.of(context);

    // =========================================================
    // نفس السلوك الأصلي
    // =========================================================
    Future.microtask(() {
      if (context.mounted) {
        context
            .read<RecipesBrandBloc>()
            .add(
          AllReciEvent(),
        );
      }
    });

    return Scaffold(
      backgroundColor: const Color(
        0xFFF8FAFC,
      ),

      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.white,

        title: Text(
          'سجل الوصفات',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: ui.isMobile ? 18 : 21,
            fontWeight: FontWeight.w700,
            color: ColorManager.medicalPrimary,
          ),
        ),
      ),

      body: _bodyBuild(
        context,
        ui,
      ),
    );
  }

  // ===========================================================
  // Body
  // ===========================================================

  Widget _bodyBuild(
      BuildContext context,
      AppUi ui,
      ) {
    return BlocBuilder<
        RecipesBrandBloc,
        RecipesBrandState>(
      // =====================================================
      // نفس buildWhen الأصلي
      // =====================================================
      buildWhen: (previous, current) =>
      current is AllReciLoadingState ||
          current is AllReciState ||
          current is AllReciErrorState ||
          current is AllReciEmptyState,

      builder: (context, state) {
        // =====================================================
        // Loading
        // =====================================================
        if (state is AllReciLoadingState) {
          return loadingFullScreen(
            context,
          );
        }

        // =====================================================
        // Empty
        // =====================================================
        if (state is AllReciEmptyState) {
          return emptyFullScreen(
            context,
          );
        }

        // =====================================================
        // Error
        // =====================================================
        if (state is AllReciErrorState) {
          return errorFullScreen(
            context,
            mes: state.failure.massage,
            func: () {},
          );
        }

        // =====================================================
        // Data
        // =====================================================
        if (state is AllReciState) {
          final List<ReciModel> recis =
              state.reci;

          // نفس النمط المتفق عليه:
          // صفحات الـ List لا تتمدد كثيراً بالتابلت Landscape.
          final double contentMaxWidth =
          ui.isTabletLandscape
              ? 760
              : ui.pageMaxWidth;

          return Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: contentMaxWidth,
              ),

              child: CustomScrollView(
                physics:
                const BouncingScrollPhysics(),

                slivers: [
                  // =================================================
                  // Header
                  // =================================================
                  SliverToBoxAdapter(
                    child: _buildTitleSection(
                      ui,
                    ),
                  ),

                  // =================================================
                  // Recipes
                  // =================================================
                  SliverPadding(
                    padding: EdgeInsets.fromLTRB(
                      ui.pagePadding,
                      ui.listTopPadding,
                      ui.pagePadding,
                      ui.listBottomPadding,
                    ),

                    sliver: AnimationLimiter(
                      child: SliverList(
                        delegate:
                        SliverChildBuilderDelegate(
                              (
                              context,
                              index,
                              ) {
                            final item =
                            recis[index];

                            final bool isClinic =
                                item.recipeType ==
                                    '1';

                            // =========================================
                            // نفس Animation الأصلي
                            // =========================================
                            return AnimationConfiguration
                                .staggeredList(
                              position: index,
                              duration:
                              const Duration(
                                milliseconds:
                                600,
                              ),
                              delay:
                              const Duration(
                                milliseconds:
                                50,
                              ),

                              child:
                              SlideAnimation(
                                verticalOffset:
                                30,

                                child:
                                FadeInAnimation(
                                  child:
                                  _buildSmartCard(
                                    context,
                                    ui,
                                    item,
                                    isClinic,
                                  ),
                                ),
                              ),
                            );
                          },

                          childCount:
                          recis.length,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }

  // ===========================================================
  // Page Header
  // ===========================================================

  Widget _buildTitleSection(
      AppUi ui,
      ) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        ui.pagePadding,
        ui.headerTopPadding,
        ui.pagePadding,
        ui.headerBottomPadding,
      ),

      child: Row(
        crossAxisAlignment:
        CrossAxisAlignment.start,

        children: [
          // =================================================
          // Title
          // =================================================
          Expanded(
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,

              children: [
                Text(
                  'قائمة الوصفات',
                  maxLines: 1,
                  overflow:
                  TextOverflow.ellipsis,

                  style: TextStyle(
                    fontSize:
                    ui.pageTitleSize,
                    fontWeight:
                    FontWeight.w800,
                    color:
                    ColorManager.medicalText,
                  ),
                ),

                SizedBox(
                  height:
                  ui.smallSpacing,
                ),

                Text(
                  'استعراض كافة الوصفات الصادرة لهذا المندوب',
                  maxLines: 2,
                  overflow:
                  TextOverflow.ellipsis,

                  style: TextStyle(
                    color: const Color(
                      0xFF64748B,
                    ),
                    fontSize:
                    ui.pageSubtitleSize,
                    fontWeight:
                    FontWeight.w500,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(
            width: ui.mediumSpacing,
          ),

          // =================================================
          // Accent
          // =================================================
          Container(
            margin: const EdgeInsets.only(
              top: 7,
            ),
            height: 5,
            width: 42,
            decoration: BoxDecoration(
              color:
              ColorManager.medicalPrimary,
              borderRadius:
              BorderRadius.circular(
                20,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ===========================================================
  // Recipe Card
  // ===========================================================

  Widget _buildSmartCard(
      BuildContext context,
      AppUi ui,
      ReciModel item,
      bool isClinic,
      ) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: ui.cardSpacing,
      ),

      child: Container(
        width: double.infinity,

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
            ui.cardRadius - 1,
          ),

          child: Material(
            color: Colors.white,

            child: InkWell(
              // ===============================================
              // نفس التنقل الأصلي تماماً
              // ===============================================
              onTap: () {
                initBrandRecModule();

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                    isClinic
                        ? UpdateRecipesPage(
                      recipeId:
                      int.parse(
                        item.id ?? '0',
                      ),
                      docId:
                      int.parse(
                        item.docId,
                      ),
                      st: 1,
                    )
                        : UpdateRecipesHospital(
                      recipeId:
                      int.parse(
                        item.id ?? '0',
                      ),
                      HospitalId:
                      int.parse(
                        item.docId,
                      ),
                      st: 1,
                    ),
                  ),
                );
              },

              child: Padding(
                padding: EdgeInsets.all(
                  ui.cardPadding,
                ),

                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,

                  children: [
                    // =========================================
                    // Badge + Date
                    // =========================================
                    Row(
                      crossAxisAlignment:
                      CrossAxisAlignment.center,

                      children: [
                        _buildTypeBadge(
                          ui,
                          isClinic,
                        ),

                        const Spacer(),

                        Flexible(
                          child:
                          _buildDateSection(
                            ui,
                            item.create_date ??
                                '',
                          ),
                        ),
                      ],
                    ),

                    SizedBox(
                      height:
                      ui.sectionSpacing,
                    ),

                    // =========================================
                    // Doctor / Hospital
                    // =========================================
                    Row(
                      crossAxisAlignment:
                      CrossAxisAlignment.center,

                      children: [
                        Container(
                          width: ui.iconBoxSize - 8,
                          height: ui.iconBoxSize - 8,

                          alignment:
                          Alignment.center,

                          decoration:
                          BoxDecoration(
                            color: ColorManager
                                .medicalPrimary
                                .withOpacity(
                              0.07,
                            ),

                            borderRadius:
                            BorderRadius.circular(
                              ui.smallRadius,
                            ),
                          ),

                          child: Icon(
                            isClinic
                                ? Icons
                                .person_outline_rounded
                                : Icons
                                .apartment_outlined,

                            size:
                            ui.smallIconSize +
                                3,

                            color: ColorManager
                                .medicalPrimary,
                          ),
                        ),

                        SizedBox(
                          width:
                          ui.mediumSpacing,
                        ),

                        Expanded(
                          child: Text(
                            isClinic
                                ? 'د. ${item.docName ?? ''}'
                                : item.docName ??
                                '',

                            maxLines: 2,
                            overflow:
                            TextOverflow
                                .ellipsis,

                            style: TextStyle(
                              fontSize:
                              ui.isMobile
                                  ? 14
                                  : 16,

                              color:
                              const Color(
                                0xFF475569,
                              ),

                              fontWeight:
                              FontWeight.w600,

                              height: 1.35,
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(
                      height:
                      ui.sectionSpacing,
                    ),

                    Divider(
                      height: 1,
                      thickness: 1,
                      color: ColorManager
                          .medicalPrimary
                          .withOpacity(
                        0.12,
                      ),
                    ),

                    SizedBox(
                      height:
                      ui.sectionSpacing,
                    ),

                    // =========================================
                    // Notes + Quantity
                    // =========================================
                    _buildBottomSection(
                      ui,
                      item,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ===========================================================
  // Bottom Section
  // ===========================================================

  Widget _buildBottomSection(
      AppUi ui,
      ReciModel item,
      ) {
    final String note =
    item.note_emp?.trim().isNotEmpty ==
        true
        ? item.note_emp!.trim()
        : 'لا توجد ملاحظات مدونة';

    return Row(
      crossAxisAlignment:
      CrossAxisAlignment.center,

      children: [
        Expanded(
          child: Text(
            'ملاحظات مدونة: $note',

            maxLines: 2,
            overflow:
            TextOverflow.ellipsis,

            style: TextStyle(
              fontSize:
              ui.smallTextSize,
              color: const Color(
                0xFF64748B,
              ),
              fontStyle:
              FontStyle.italic,
              height: 1.4,
            ),
          ),
        ),

        SizedBox(
          width: ui.mediumSpacing,
        ),

        Text(
          'وحدة',
          style: TextStyle(
            fontSize:
            ui.smallTextSize,
            color: const Color(
              0xFF94A3B8,
            ),
            fontWeight:
            FontWeight.w500,
          ),
        ),

        SizedBox(
          width: ui.smallSpacing,
        ),

        _buildQuantityBubble(
          ui,
          item.total ?? '0',
        ),
      ],
    );
  }

  // ===========================================================
  // Type Badge
  // ===========================================================

  Widget _buildTypeBadge(
      AppUi ui,
      bool isClinic,
      ) {
    final Color color = isClinic
        ? const Color(0xFF3F7FBF)
        : const Color(0xFF2D947A);

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: ui.mediumSpacing,
        vertical: 6,
      ),

      decoration: BoxDecoration(
        color: color.withOpacity(
          0.10,
        ),

        borderRadius:
        BorderRadius.circular(
          ui.smallRadius,
        ),
      ),

      child: Text(
        isClinic
            ? 'وصفة عيادة'
            : 'وصفة مشفى',

        style: TextStyle(
          color: color,
          fontSize:
          ui.smallTextSize,
          fontWeight:
          FontWeight.w700,
        ),
      ),
    );
  }

  // ===========================================================
  // Date
  // ===========================================================

  Widget _buildDateSection(
      AppUi ui,
      String date,
      ) {
    return Row(
      mainAxisSize:
      MainAxisSize.min,

      mainAxisAlignment:
      MainAxisAlignment.end,

      children: [
        Icon(
          Icons.calendar_today_outlined,
          size: ui.smallIconSize,
          color: const Color(
            0xFF94A3B8,
          ),
        ),

        SizedBox(
          width: ui.smallSpacing,
        ),

        Flexible(
          child: Text(
            date,
            maxLines: 1,
            overflow:
            TextOverflow.ellipsis,

            style: TextStyle(
              color: const Color(
                0xFF64748B,
              ),
              fontSize:
              ui.smallTextSize,
              fontWeight:
              FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  // ===========================================================
  // Quantity
  // ===========================================================

  Widget _buildQuantityBubble(
      AppUi ui,
      String quantity,
      ) {
    return Container(
      constraints: const BoxConstraints(
        minWidth: 38,
      ),

      padding: EdgeInsets.symmetric(
        horizontal: ui.mediumSpacing,
        vertical: 6,
      ),

      alignment: Alignment.center,

      decoration: BoxDecoration(
        color:
        ColorManager.medicalPrimary,

        borderRadius:
        BorderRadius.circular(
          ui.smallRadius,
        ),
      ),

      child: Text(
        quantity,

        maxLines: 1,

        style: TextStyle(
          color: Colors.white,
          fontWeight:
          FontWeight.w700,
          fontSize:
          ui.isMobile ? 13 : 14,
        ),
      ),
    );
  }
}