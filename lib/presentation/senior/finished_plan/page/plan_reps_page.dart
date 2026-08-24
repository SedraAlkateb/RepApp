import 'package:domina_app/app/di/di.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/resources/responsive/app_ui.dart';
import 'package:domina_app/presentation/senior/finished_plan/bloc/finished_plan_bloc.dart';
import 'package:domina_app/presentation/senior/representative/page/rep_profile.dart';
import 'package:domina_app/presentation/uniti/search_field.dart';
import 'package:domina_app/presentation/uniti/unread_visit_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PlanRepsPage extends StatefulWidget {
  const PlanRepsPage({
    super.key,
  });

  @override
  State<PlanRepsPage> createState() =>
      _PlanRepsPageState();
}

class _PlanRepsPageState
    extends State<PlanRepsPage> {
  final TextEditingController _searchController =
  TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // =====================================================
    // كل Responsive/UI المشترك صار مركزي
    // =====================================================
    final ui = AppUi.of(context);

    return Scaffold(
      backgroundColor:
      const Color(
        0xFFF8FAFC,
      ),

      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor:
        Colors.transparent,

        title:
        const Text(
          "سجل المندوبين",
        ),
      ),

      body: Center(
        child: ConstrainedBox(
          constraints:
          BoxConstraints(
            maxWidth:
            ui.pageMaxWidth,
          ),

          child:
          CustomScrollView(
            physics:
            const BouncingScrollPhysics(),

            keyboardDismissBehavior:
            ScrollViewKeyboardDismissBehavior
                .onDrag,

            slivers: [
              // =================================================
              // Header
              // =================================================
              SliverPadding(
                padding:
                EdgeInsets.fromLTRB(
                  ui.pagePadding,
                  ui.headerTopPadding,
                  ui.pagePadding,
                  ui.headerBottomPadding,
                ),

                sliver:
                SliverToBoxAdapter(
                  child:
                  _buildHeader(
                    context,
                  ),
                ),
              ),

              // =================================================
              // Search
              // =================================================
              SliverPadding(
                padding:
                EdgeInsets.fromLTRB(
                  ui.pagePadding,
                  ui.searchTopPadding,
                  ui.pagePadding,
                  ui.searchBottomPadding,
                ),

                sliver:
                SliverToBoxAdapter(
                  child:
                  SearchField(
                    searchController:
                    _searchController,

                    onPressed:
                        (value) {
                      context
                          .read<
                          FinishedPlanBloc>()
                          .add(
                        SearchPlanRepsEvent(
                          value,
                        ),
                      );
                    },
                  ),
                ),
              ),

              // =================================================
              // Bloc Content
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
                  is PlanRepsLoading ||
                      current
                      is PlanRepsLoaded ||
                      current
                      is PlanRepsError;
                },

                builder:
                    (context, state) {
                  // ===============================================
                  // Loading
                  // ===============================================
                  if (state
                  is PlanRepsLoading) {
                    return SliverFillRemaining(
                      hasScrollBody:
                      false,

                      child:
                      _buildLoadingState(
                        context,
                      ),
                    );
                  }

                  // ===============================================
                  // Loaded
                  // ===============================================
                  if (state
                  is PlanRepsLoaded) {
                    // =============================================
                    // Empty Search Result
                    // =============================================
                    if (state.reps.isEmpty) {
                      return SliverFillRemaining(
                        hasScrollBody:
                        false,

                        child:
                        _buildEmptyState(
                          context,
                        ),
                      );
                    }

                    // =============================================
                    // Reps List
                    // =============================================
                    return SliverPadding(
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
                            final rep =
                            state.reps[
                            index];

                            return RepCard(
                              repName:
                              rep,

                              repPlanId:
                              int.parse(
                                rep.repPlan,
                              ),
                            );
                          },

                          childCount:
                          state.reps.length,
                        ),
                      ),
                    );
                  }

                  // ===============================================
                  // Error
                  // ===============================================
                  if (state
                  is PlanRepsError) {
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

  Widget _buildHeader(
      BuildContext context,
      ) {
    final ui =
    AppUi.of(context);

    return Row(
      crossAxisAlignment:
      CrossAxisAlignment.center,

      children: [
        // =================================================
        // Header Text
        // =================================================
        Expanded(
          child: Column(
            crossAxisAlignment:
            CrossAxisAlignment.start,

            children: [
              Text(
                'سجل المندوبين',

                maxLines: 1,

                overflow:
                TextOverflow.ellipsis,

                style:
                TextStyle(
                  fontSize:
                  ui.pageTitleSize,

                  fontWeight:
                  FontWeight.w800,

                  color:
                  ColorManager
                      .medicalPrimary,

                  height: 1.25,
                ),
              ),

              SizedBox(
                height:
                ui.smallSpacing,
              ),

              Text(
                'عرض أسماء المندوبين المشاركين في هذه الخطة',

                maxLines: 2,

                overflow:
                TextOverflow.ellipsis,

                style:
                TextStyle(
                  fontSize:
                  ui.pageSubtitleSize,

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

        SizedBox(
          width:
          ui.largeSpacing,
        ),

        // =================================================
        // Visual Identity Indicator
        // =================================================
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
  // Loading
  // =====================================================

  Widget _buildLoadingState(
      BuildContext context,
      ) {
    final ui =
    AppUi.of(context);

    return Padding(
      padding:
      EdgeInsets.symmetric(
        horizontal:
        ui.pagePadding,
        vertical:
        ui.sectionSpacing,
      ),

      child: Column(
        mainAxisAlignment:
        MainAxisAlignment.center,

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
            'جاري تحميل المندوبين...',

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
    );
  }

  // =====================================================
  // Empty
  // =====================================================

  Widget _buildEmptyState(
      BuildContext context,
      ) {
    final ui =
    AppUi.of(context);

    return Center(
      child: Padding(
        padding:
        EdgeInsets.all(
          ui.pagePadding,
        ),

        child: Column(
          mainAxisSize:
          MainAxisSize.min,

          children: [
            Container(
              width:
              ui.iconBoxSize +
                  18,

              height:
              ui.iconBoxSize +
                  18,

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
                  ui.cardRadius,
                ),
              ),

              child: Icon(
                Icons
                    .person_search_outlined,

                size:
                ui.iconSize +
                    10,

                color: ColorManager
                    .medicalPrimary
                    .withOpacity(
                  0.65,
                ),
              ),
            ),

            SizedBox(
              height:
              ui.sectionSpacing,
            ),

            Text(
              'لا يوجد نتائج تطابق البحث',

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
              'جرّب البحث باسم مندوب آخر',

              textAlign:
              TextAlign.center,

              style:
              TextStyle(
                fontSize:
                ui.smallTextSize,

                color:
                const Color(
                  0xFF94A3B8,
                ),

                fontWeight:
                FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // =====================================================
  // Error
  // =====================================================

  Widget _buildErrorState(
      BuildContext context,
      String message,
      ) {
    final ui =
    AppUi.of(context);

    return Center(
      child: Padding(
        padding:
        EdgeInsets.all(
          ui.pagePadding,
        ),

        child: Column(
          mainAxisSize:
          MainAxisSize.min,

          children: [
            Container(
              width:
              ui.iconBoxSize +
                  14,

              height:
              ui.iconBoxSize +
                  14,

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

              child: Icon(
                Icons
                    .error_outline_rounded,

                size:
                ui.iconSize +
                    8,

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
// Representative Card
// =======================================================

class RepCard extends StatelessWidget {
  final PlanRepsModel repName;
  final int repPlanId;

  const RepCard({
    super.key,
    required this.repName,
    required this.repPlanId,
  });

  @override
  Widget build(BuildContext context) {
    final ui =
    AppUi.of(context);

    return Padding(
      padding:
      EdgeInsets.only(
        bottom:
        ui.cardSpacing,
      ),

      child: Material(
        color:
        Colors.transparent,

        child: PersonProgressCard(name: repName.name,
          unreadCount: repName.totalUnReadVisit,
          totalCount: repName.totalVisit,
          onTap: () {

            initSeniorProfModule();
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) =>
                    RepProfile(
                      isFinal: true,
                      index: -1,
                      repPlanId:
                      repPlanId,
                      id:  int.parse(
                        repName.id,
                      ),
                    ),
              ),
            );
          },
          remainingTitle: 'استعراض تقرير المندوب في هذه الخطة',
        ),
      ),
    );
  }
}