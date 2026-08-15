// ignore_for_file: deprecated_member_use

import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/resources/responsive/app_ui.dart';
import 'package:domina_app/presentation/resources/routes_manager.dart';
import 'package:domina_app/presentation/senior/representative/bloc/senior_prof_bloc.dart';
import 'package:domina_app/presentation/uniti/stateWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class AllRecipesForView extends StatelessWidget {
  const AllRecipesForView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final ui = AppUi.of(context);

    final double contentMaxWidth =
    ui.isTabletLandscape
        ? 760
        : ui.pageMaxWidth;

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
          'الوصفات',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: ui.isMobile ? 18 : 21,
            fontWeight: FontWeight.w700,
            color: ColorManager.medicalPrimary,
          ),
        ),
      ),

      body: SafeArea(
        top: false,

        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: contentMaxWidth,
            ),

            child: _bodyBuild(
              context,
              ui,
            ),
          ),
        ),
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
        SeniorProfBloc,
        SeniorProfState>(
      buildWhen: (
          previous,
          current,
          ) =>
      current is AllReciLoadingState ||
          current is AllReciState ||
          current is AllReciErrorState ||
          current is AllReciEmptyState,

      builder: (
          context,
          state,
          ) {
        // =====================================================
        // Loading
        // =====================================================
        if (state is AllReciLoadingState) {
          return loadingFullScreen(
            context,
          );
        }

        // =====================================================
        // Data
        // =====================================================
        if (state is AllReciState) {
          final List<ReciModel> recis =
              state.reci;

          return CustomScrollView(
            physics:
            const BouncingScrollPhysics(),

            keyboardDismissBehavior:
            ScrollViewKeyboardDismissBehavior
                .onDrag,

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
                  0,
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

                          child: SlideAnimation(
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
          );
        }

        // =====================================================
        // Error
        // =====================================================
        if (state is AllReciErrorState) {
          return errorFullScreen(
            context,
            mes:
            state.failure.massage,
            func: () {},
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

        return const SizedBox.shrink();
      },
    );
  }
}

// ============================================================================
// Title
// ============================================================================

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
      CrossAxisAlignment.center,

      children: [
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

                  color: ColorManager
                      .medicalText,

                  height: 1.25,
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
          width:
          ui.mediumSpacing,
        ),

        Container(
          height: 5,
          width:
          ui.isMobile ? 40 : 45,

          decoration: BoxDecoration(
            color: ColorManager
                .medicalPrimary,

            borderRadius:
            BorderRadius.circular(
              10,
            ),
          ),
        ),
      ],
    ),
  );
}

// ============================================================================
// Recipe Card
// ============================================================================

Widget _buildSmartCard(
    BuildContext context,
    AppUi ui,
    ReciModel item,
    bool isClinic,
    ) {
  return Container(
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
          color: Colors.black
              .withOpacity(
            0.03,
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

    child: ClipRRect(
      borderRadius:
      BorderRadius.circular(
        ui.cardRadius,
      ),

      child: Material(
        color: Colors.white,

        child: InkWell(
          // ===================================================
          // نفس السلوك الأصلي تماماً
          // ===================================================
          onTap: () {
            context
                .read<
                SeniorProfBloc>()
                .add(
              GetRepReciEvent(
                int.parse(
                  item.id ?? '0',
                ),
                isClinic,
                item.docName ?? '',
              ),
            );

            Navigator.pushNamed(
              context,
              Routes.viewRecipe,
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
                // ===============================================
                // Type + Date
                // ===============================================
                Row(
                  crossAxisAlignment:
                  CrossAxisAlignment.center,

                  children: [
                    _buildTypeBadge(
                      ui,
                      isClinic,
                    ),

                    SizedBox(
                      width:
                      ui.mediumSpacing,
                    ),

                    Expanded(
                      child: Align(
                        alignment:
                        AlignmentDirectional
                            .centerEnd,

                        child:
                        _buildDateSection(
                          ui,
                          item.create_date ??
                              '',
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(
                  height:
                  ui.sectionSpacing,
                ),

                // ===============================================
                // Doctor / Hospital
                // ===============================================
                Row(
                  crossAxisAlignment:
                  CrossAxisAlignment.center,

                  children: [
                    Container(
                      width:
                      ui.isMobile
                          ? 34
                          : 38,

                      height:
                      ui.isMobile
                          ? 34
                          : 38,

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
                        BorderRadius
                            .circular(
                          ui.smallRadius,
                        ),
                      ),

                      child: Icon(
                        isClinic
                            ? Icons
                            .person_outline_rounded
                            : Icons
                            .local_hospital_outlined,

                        size:
                        ui.smallIconSize +
                            2,

                        color:
                        ColorManager
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

                        style:
                        TextStyle(
                          fontSize: ui
                              .bodyTextSize,

                          color:
                          const Color(
                            0xFF475569,
                          ),

                          fontWeight:
                          FontWeight
                              .w600,

                          height: 1.35,
                        ),
                      ),
                    ),
                  ],
                ),

                Padding(
                  padding:
                  EdgeInsets.symmetric(
                    vertical:
                    ui.sectionSpacing,
                  ),

                  child: Divider(
                    height: 1,
                    thickness: 0.6,

                    color:
                    const Color(
                      0xFFE2E8F0,
                    ),
                  ),
                ),

                // ===============================================
                // Note + Quantity
                // ===============================================
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
  );
}

// ============================================================================
// Bottom Section
// ============================================================================

Widget _buildBottomSection(
    AppUi ui,
    ReciModel item,
    ) {
  // بالموبايل منخلي المساحة مرنة أكتر
  // حتى النص الطويل ما يعمل Overflow.
  return Row(
    crossAxisAlignment:
    CrossAxisAlignment.center,

    children: [
      Expanded(
        child: Row(
          crossAxisAlignment:
          CrossAxisAlignment.start,

          children: [
            Icon(
              Icons
                  .notes_rounded,

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
                'ملاحظات مدونة: '
                    '${_noteText(item.note_emp)}',

                maxLines:
                ui.isMobile
                    ? 2
                    : 3,

                overflow:
                TextOverflow
                    .ellipsis,

                style: TextStyle(
                  fontSize:
                  ui.smallTextSize,

                  color:
                  const Color(
                    0xFF64748B,
                  ),

                  fontStyle:
                  FontStyle.italic,

                  height: 1.4,
                ),
              ),
            ),
          ],
        ),
      ),

      SizedBox(
        width:
        ui.mediumSpacing,
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
        width:
        ui.smallSpacing,
      ),

      _buildQuantityBubble(
        ui,
        item.total ?? '0',
      ),
    ],
  );
}

// ============================================================================
// Type Badge
// ============================================================================

Widget _buildTypeBadge(
    AppUi ui,
    bool isClinic,
    ) {
  return Container(
    padding: EdgeInsets.symmetric(
      horizontal:
      ui.mediumSpacing,
      vertical: 6,
    ),

    decoration: BoxDecoration(
      color: isClinic
          ? const Color(
        0xFFE3F2FD,
      )
          : const Color(
        0xFFE8F5E9,
      ),

      borderRadius:
      BorderRadius.circular(
        ui.smallRadius,
      ),
    ),

    child: Row(
      mainAxisSize:
      MainAxisSize.min,

      children: [
        Icon(
          isClinic
              ? Icons
              .medical_information_outlined
              : Icons
              .local_hospital_outlined,

          size:
          ui.smallIconSize,

          color: isClinic
              ? const Color(
            0xFF1976D2,
          )
              : const Color(
            0xFF388E3C,
          ),
        ),

        SizedBox(
          width:
          ui.smallSpacing,
        ),

        Text(
          isClinic
              ? 'وصفة عيادة'
              : 'وصفة مشفى',

          style: TextStyle(
            color: isClinic
                ? const Color(
              0xFF1976D2,
            )
                : const Color(
              0xFF388E3C,
            ),

            fontSize:
            ui.smallTextSize,

            fontWeight:
            FontWeight.w700,
          ),
        ),
      ],
    ),
  );
}

// ============================================================================
// Date
// ============================================================================

Widget _buildDateSection(
    AppUi ui,
    String date,
    ) {
  return Row(
    mainAxisSize:
    MainAxisSize.min,

    children: [
      Icon(
        Icons
            .calendar_today_outlined,

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

      Flexible(
        child: Text(
          date,

          maxLines: 1,

          overflow:
          TextOverflow.ellipsis,

          style: TextStyle(
            color:
            const Color(
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

// ============================================================================
// Quantity
// ============================================================================

Widget _buildQuantityBubble(
    AppUi ui,
    String quantity,
    ) {
  return Container(
    constraints:
    const BoxConstraints(
      minWidth: 38,
    ),

    alignment:
    Alignment.center,

    padding: EdgeInsets.symmetric(
      horizontal:
      ui.mediumSpacing,
      vertical: 6,
    ),

    decoration: BoxDecoration(
      color: ColorManager
          .medicalPrimary,

      borderRadius:
      BorderRadius.circular(
        ui.smallRadius,
      ),

      boxShadow: [
        BoxShadow(
          color: ColorManager
              .medicalPrimary
              .withOpacity(
            0.15,
          ),

          blurRadius: 6,

          offset:
          const Offset(
            0,
            3,
          ),
        ),
      ],
    ),

    child: Text(
      quantity,

      maxLines: 1,

      style: TextStyle(
        color: Colors.white,

        fontWeight:
        FontWeight.w700,

        fontSize:
        ui.bodyTextSize,
      ),
    ),
  );
}

// ============================================================================
// Helpers
// ============================================================================

String _noteText(
    String? note,
    ) {
  if (note == null ||
      note.trim().isEmpty) {
    return 'لا توجد ملاحظات مدونة';
  }

  return note;
}