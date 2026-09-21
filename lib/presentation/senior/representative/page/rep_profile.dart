import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/resources/responsive/app_ui.dart';
import 'package:domina_app/presentation/senior/representative/bloc/senior_prof_bloc.dart';
import 'package:domina_app/presentation/senior/representative/widget/rep_profile_widget/build_stats_grid_widget.dart';
import 'package:domina_app/presentation/senior/representative/widget/rep_profile_widget/rep_coverage_section.dart';
import 'package:domina_app/presentation/senior/representative/widget/rep_profile_widget/rep_details_list.dart';
import 'package:domina_app/presentation/senior/representative/widget/rep_profile_widget/rep_hero_header.dart';
import 'package:domina_app/presentation/senior/representative/widget/rep_profile_widget/rep_hero_header_tablet.dart';
import 'package:domina_app/presentation/senior/representative/widget/rep_profile_widget/rep_quick_actions.dart';
import 'package:domina_app/presentation/uniti/stateWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class RepProfile extends StatefulWidget {
  const RepProfile({
    super.key,
    required this.id,
    required this.repPlanId,
    this.index = 0,
    this.isFinal = false,
  });

  final int id;
  final int repPlanId;

  /// يستخدم بالتقارير التفصيلية في الملف الكامل.
  /// بالخطة المنتهية لا نحتاجه.
  final int index;

  /// false => ملف المندوب الكامل
  ///
  /// true => ملف الخطة المنتهية:
  /// Hero + Statistics + Finished Coverage
  final bool isFinal;

  @override
  State<RepProfile> createState() =>
      _RepProfileState();
}

class _RepProfileState
    extends State<RepProfile> {
  // =====================================================
  // Shortcut Getters
  // =====================================================

  int get id =>
      widget.id;

  int get repPlanId =>
      widget.repPlanId;

  int get index =>
      widget.index;

  bool get isFinal =>
      widget.isFinal;

  @override
  void initState() {
    super.initState();
    context
        .read<SeniorProfBloc>()
        .add(
      getInfoRepEvent(
        id,
        repPlanId,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final keyboardInset =
        MediaQuery.viewInsetsOf(
          context,
        ).bottom;

    final ui =
    AppUi.of(context);

    return PopScope(
      canPop: true,
      onPopInvoked: (_) {},

      child: Scaffold(
        backgroundColor:
        const Color(
          0xFFF8FAFC,
        ),

        // =================================================
        // نحافظ على Hero من الانضغاط عند ظهور Keyboard
        // =================================================
        resizeToAvoidBottomInset:
        false,

        appBar: AppBar(
          elevation: 0,
          scrolledUnderElevation: 0,
          surfaceTintColor:
          Colors.transparent,

          title: Text(
            isFinal
                ? "ملف المندوب - الخطة المنتهية"
                : "ملف المندوب",

            maxLines: 1,

            overflow:
            TextOverflow.ellipsis,
          ),

          leading: IconButton(
            icon:
            const Icon(
              Icons
                  .arrow_back_ios_new_rounded,

              color:
              Color(
                0xFF1F4E79,
              ),
            ),

            onPressed: () {
              Navigator.pop(
                context,
              );
            },
          ),
        ),

        body: SafeArea(
          top: false,

          child: AnimatedPadding(
            duration:
            const Duration(
              milliseconds: 220,
            ),

            curve:
            Curves.easeOut,

            padding:
            EdgeInsets.only(
              bottom:
              keyboardInset,
            ),

            child: BlocBuilder<
                SeniorProfBloc,
                SeniorProfState>(
              buildWhen:
                  (
                  previous,
                  current,
                  ) {
                return current
                is RepInfoState ||
                    current
                    is RepInfoLoadingState ||
                    current
                    is RepInfoErrorState;
              },

              builder:
                  (context, state) {
                // =============================================
                // Loading
                // =============================================
                if (state
                is RepInfoLoadingState) {
                  return loadingFullScreen(
                    context,
                  );
                }

                // =============================================
                // Error
                // =============================================
                if (state
                is RepInfoErrorState) {
                  return errorFullScreen(
                    context,
                  );
                }

                // =============================================
                // Loaded
                // =============================================
                if (state
                is RepInfoState) {
                  final InfoRep rep =
                      state.infoRep;

                  final String currentRepName =
                      rep.name;

                  final int currentRepPlan =
                      rep.repPlanId;

                  // ===========================================
                  // Tablet Landscape
                  // ===========================================
                  if (ui
                      .isTabletLandscape) {
                    return _buildTabletLandscapeLayout(
                      context,
                      rep,
                      currentRepName,
                      currentRepPlan,
                    );
                  }

                  // ===========================================
                  // Mobile + Tablet Portrait
                  // ===========================================
                  return _buildPortraitLayout(
                    context,
                    rep,
                    currentRepName,
                    currentRepPlan,
                  );
                }

                return const SizedBox
                    .shrink();
              },
            ),
          ),
        ),
      ),
    );
  }

  // =====================================================
  // Shared Profile Content
  //
  // هون جوهر الدمج كله.
  // =====================================================

  List<Widget> _buildProfileContent({
    required BuildContext context,
    required InfoRep rep,
    required String currentRepName,
    required int currentRepPlan,
    required bool tabletLandscape,
  }) {
    final ui =
    AppUi.of(context);

    return [
      // =================================================
      // Statistics
      //
      // موجودة بالحالتين
      // =================================================
      if (tabletLandscape)
        buildStatsGridTablet(
          rep,
        )
      else
        buildStatsGrid(
          context,
          rep,
        ),

      SizedBox(
        height:
        ui.sectionSpacing,
      ),

      // =================================================
      // Personal / Quick Actions
      //
      // فقط بالملف الكامل
      // =================================================
      if (!isFinal) ...[

        buildQuickActions(
          context,
          id: id,
          repPlanId: repPlanId,
        ),

        SizedBox(
          height:
          ui.sectionSpacing,
        ),
      ],

      // =================================================
      // Coverage
      //
      // موجودة بالحالتين
      // لكن المحتوى يتغير حسب isFinal
      // =================================================
      buildCoverageSection(
          context,
          rep,
          isFinal: isFinal,
          id: id,
          repPlanId: repPlanId,
      ),


      // =================================================
      // Detailed Reports
      //
      // فقط بالملف الكامل
      // =================================================
      if (!isFinal) ...[
        SizedBox(
          height:
          ui.sectionSpacing,
        ),
        (rep.repType!=5&&rep.repType!=6)?
        buildDetailsListRep(
          context,
          rep,
          currentRepName,
          currentRepPlan,
          rep.mobile,
          id: id,
          index: index,
        ): buildDetailsList(
          context,
          rep,
          currentRepName,
          currentRepPlan,
          rep.mobile,
          id: id,
        ),
      ],
    ];
  }

  // =====================================================
  // Tablet Landscape
  // =====================================================

  Widget _buildTabletLandscapeLayout(
      BuildContext context,
      InfoRep rep,
      String currentRepName,
      int currentRepPlan,
      ) {
    final ui =
    AppUi.of(context);

    return SingleChildScrollView(
      physics:
      const BouncingScrollPhysics(),

      keyboardDismissBehavior:
      ScrollViewKeyboardDismissBehavior
          .onDrag,

      padding:
      EdgeInsets.fromLTRB(
        ui.pagePadding,
        ui.pageTopPadding,
        ui.pagePadding,
        ui.pageBottomPadding,
      ),

      child: Center(
        child: ConstrainedBox(
          constraints:
          BoxConstraints(
            maxWidth:
            ui.widePageMaxWidth,
          ),

          child: Row(
            crossAxisAlignment:
            CrossAxisAlignment.start,

            children: [
              // =================================================
              // Hero
              // =================================================
              SizedBox(
                width: 300,

                child:
                buildHeroHeaderTablet(
                  context,
                  rep,
                  isFinal: isFinal,
                ),
              ),

              SizedBox(
                width:
                ui.sectionSpacing +
                    10,
              ),

              // =================================================
              // Content
              // =================================================
              Expanded(
                child:
                AnimationLimiter(
                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment
                        .stretch,

                    children:
                    AnimationConfiguration
                        .toStaggeredList(
                      duration:
                      const Duration(
                        milliseconds:
                        450,
                      ),

                      childAnimationBuilder:
                          (child) =>
                          SlideAnimation(
                            horizontalOffset:
                            35,

                            child:
                            FadeInAnimation(
                              child:
                              child,
                            ),
                          ),

                      children:
                      _buildProfileContent(
                        context:
                        context,

                        rep:
                        rep,

                        currentRepName:
                        currentRepName,

                        currentRepPlan:
                        currentRepPlan,

                        tabletLandscape:
                        true,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // =====================================================
  // Mobile + Tablet Portrait
  // =====================================================

  Widget _buildPortraitLayout(
      BuildContext context,
      InfoRep rep,
      String currentRepName,
      int currentRepPlan,
      ) {
    final ui =
    AppUi.of(context);

    return SingleChildScrollView(
      physics:
      const BouncingScrollPhysics(),

      keyboardDismissBehavior:
      ScrollViewKeyboardDismissBehavior
          .onDrag,

      padding:
      EdgeInsets.only(
        top:
        ui.pageTopPadding,

        bottom:
        ui.pageBottomPadding +
            12,
      ),

      child: Center(
        child: ConstrainedBox(
          constraints:
          BoxConstraints(
            maxWidth:
            ui.pageMaxWidth,
          ),

          child: Column(
            children: [
              // =================================================
              // Hero
              // =================================================
              Padding(
                padding:
                EdgeInsets.symmetric(
                  horizontal:
                  ui.pagePadding,
                ),

                child:
                buildHeroHeader(
                  context,
                  rep,
                  isFinal: isFinal,
                ),
              ),

              // =================================================
              // Main Content
              // =================================================
              AnimationLimiter(
                child: Padding(
                  padding:
                  EdgeInsets.symmetric(
                    horizontal:
                    ui.pagePadding,
                  ),

                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment
                        .stretch,

                    children:
                    AnimationConfiguration
                        .toStaggeredList(
                      duration:
                      const Duration(
                        milliseconds:
                        450,
                      ),

                      childAnimationBuilder:
                          (child) =>
                          SlideAnimation(
                            verticalOffset:
                            28,

                            child:
                            FadeInAnimation(
                              child:
                              child,
                            ),
                          ),

                      children: [
                        SizedBox(
                          height:
                          ui.sectionSpacing +
                              6,
                        ),

                        ..._buildProfileContent(
                          context:
                          context,

                          rep:
                          rep,

                          currentRepName:
                          currentRepName,

                          currentRepPlan:
                          currentRepPlan,

                          tabletLandscape:
                          false,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
