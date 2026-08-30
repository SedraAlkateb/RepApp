import 'package:domina_app/app/di/di.dart';
import 'package:domina_app/app/user_info.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/resources/responsive/app_ui.dart';
import 'package:domina_app/presentation/resources/routes_manager.dart';
import 'package:domina_app/presentation/senior/report_Inventory/bloc/report_inventory_bloc.dart';
import 'package:domina_app/presentation/senior/report_Inventory/page/report_inventory.dart';
import 'package:domina_app/presentation/senior/report_visit_doctor/bloc/report_visit_doctor_bloc.dart';
import 'package:domina_app/presentation/senior/report_visit_doctor/page/report_visit_doctor.dart';
import 'package:domina_app/presentation/senior/report_visit_doctor/page/report_visit_hospital.dart';
import 'package:domina_app/presentation/senior/representative/bloc/senior_prof_bloc.dart';
import 'package:domina_app/presentation/senior/representative/page/no_visit_doctor.dart';
import 'package:domina_app/presentation/senior/representative/page/no_visit_hos.dart';
import 'package:domina_app/presentation/senior/representative/page/remaining_visits.dart';
import 'package:domina_app/presentation/senior/representative/page/remaining_visits_hos.dart';
import 'package:domina_app/presentation/senior/representative/page/sen_visit_doctor.dart';
import 'package:domina_app/presentation/senior/representative/page/sen_visit_hospital.dart';
import 'package:domina_app/presentation/senior/representative/widget/rep_profile_widget/build_stats_grid_widget.dart';
import 'package:domina_app/presentation/uniti/stateWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
      _buildCoverageSection(
          context,
          rep
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
        _buildDetailsListRep(
          context,
          rep,
          currentRepName,
          currentRepPlan,
          rep.mobile,
        ): _buildDetailsList(
          context,
          rep,
          currentRepName,
          currentRepPlan,
          rep.mobile,
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
                _buildHeroHeaderTablet(
                  context,
                  rep,
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
                _buildHeroHeader(
                  context,
                  rep,
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

  // =====================================================
  // Hero
  // Mobile + Tablet Portrait
  // =====================================================

  Widget _buildHeroHeader(
      BuildContext context,
      InfoRep rep,
      ) {
    final ui =
    AppUi.of(context);

    // =====================================================
    // Hero-specific dimensions.
    //
    // هدول خاصين بالـHero لذلك ما لازم نحول AppUi
    // لمخزن لكل رقم بالمشروع.
    // =====================================================

    final double verticalPadding =
    ui.isMobile
        ? 28
        : 34;

    final double horizontalPadding =
    ui.isMobile
        ? 20
        : 28;

    final double avatarSize =
    ui.isMobile
        ? 80
        : 92;

    final double avatarRadius =
    ui.isMobile
        ? 22
        : 26;

    final double initialFontSize =
    ui.isMobile
        ? 30
        : 34;

    final double nameFontSize =
    ui.isMobile
        ? 22
        : 26;

    final double addressFontSize =
    ui.isMobile
        ? 13
        : 15;

    return Hero(
      tag:
      'rep_card_${rep.id}',

      child: Material(
        color:
        Colors.transparent,

        child: Container(
          width:
          double.infinity,

          padding:
          EdgeInsets.symmetric(
            vertical:
            verticalPadding,

            horizontal:
            horizontalPadding,
          ),

          decoration:
          BoxDecoration(
            // ===============================================
            // الهوية الأساسية للبروفايل
            // ===============================================
            color:
            const Color(
              0xFF164683,
            ),

            borderRadius:
            BorderRadius.circular(
              ui.cardRadius + 6,
            ),

            boxShadow: [
              BoxShadow(
                color:
                const Color(
                  0xFF1F4E79,
                ).withOpacity(
                  0.14,
                ),

                blurRadius:
                14,

                offset:
                const Offset(
                  0,
                  6,
                ),
              ),
            ],
          ),

          child: Column(
            mainAxisSize:
            MainAxisSize.min,

            children: [
              // =================================================
              // Avatar
              // =================================================
              Container(
                width:
                avatarSize,

                height:
                avatarSize,

                alignment:
                Alignment.center,

                decoration:
                BoxDecoration(
                  color:
                  Colors.white
                      .withOpacity(
                    0.14,
                  ),

                  border:
                  Border.all(
                    color:
                    Colors.white
                        .withOpacity(
                      0.25,
                    ),

                    width:
                    1.5,
                  ),

                  borderRadius:
                  BorderRadius.circular(
                    avatarRadius,
                  ),
                ),

                child: Text(
                  rep.name.isNotEmpty
                      ? rep.name
                      .substring(
                    0,
                    1,
                  )
                      : "",

                  style:
                  TextStyle(
                    fontSize:
                    initialFontSize,

                    color:
                    Colors.white,

                    fontWeight:
                    FontWeight
                        .w900,
                  ),
                ),
              ),

              SizedBox(
                height:
                ui.largeSpacing,
              ),

              // =================================================
              // Name
              // =================================================
              Text(
                rep.name,

                textAlign:
                TextAlign.center,

                maxLines:
                2,

                overflow:
                TextOverflow
                    .ellipsis,

                style:
                TextStyle(
                  fontSize:
                  nameFontSize,

                  color:
                  Colors.white,

                  fontWeight:
                  FontWeight
                      .w700,

                  height:
                  1.25,
                ),
              ),

              // =================================================
              // Address
              // =================================================
              if (rep
                  .address
                  .isNotEmpty) ...[
                SizedBox(
                  height:
                  ui.mediumSpacing,
                ),

                Row(
                  mainAxisAlignment:
                  MainAxisAlignment
                      .center,

                  children: [
                    Icon(
                      Icons
                          .location_on_outlined,

                      size:
                      addressFontSize +
                          3,

                      color:
                      Colors.white
                          .withOpacity(
                        0.75,
                      ),
                    ),

                    const SizedBox(
                      width: 5,
                    ),

                    Flexible(
                      child: Text(
                        rep.address,

                        maxLines:
                        2,

                        overflow:
                        TextOverflow
                            .ellipsis,

                        textAlign:
                        TextAlign
                            .center,

                        style:
                        TextStyle(
                          fontSize:
                          addressFontSize,

                          color:
                          Colors.white
                              .withOpacity(
                            0.85,
                          ),

                          fontWeight:
                          FontWeight
                              .w500,

                          height:
                          1.35,
                        ),
                      ),
                    ),
                  ],
                ),
              ],

              // =================================================
              // Finished Plan Badge
              // =================================================
              if (isFinal) ...[
                SizedBox(
                  height:
                  ui.sectionSpacing,
                ),

                Container(
                  padding:
                  const EdgeInsets
                      .symmetric(
                    horizontal:
                    12,

                    vertical:
                    6,
                  ),

                  decoration:
                  BoxDecoration(
                    color:
                    Colors.white
                        .withOpacity(
                      0.12,
                    ),

                    borderRadius:
                    BorderRadius.circular(
                      10,
                    ),

                    border:
                    Border.all(
                      color:
                      Colors.white
                          .withOpacity(
                        0.20,
                      ),
                    ),
                  ),

                  child:
                  const Row(
                    mainAxisSize:
                    MainAxisSize
                        .min,

                    children: [
                      Icon(
                        Icons
                            .history_rounded,

                        size: 15,

                        color:
                        Colors.white,
                      ),

                      SizedBox(
                        width: 6,
                      ),

                      Text(
                        'خطة منتهية',

                        style:
                        TextStyle(
                          fontSize:
                          11.5,

                          color:
                          Colors.white,

                          fontWeight:
                          FontWeight
                              .w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  // =====================================================
  // Hero Tablet Landscape
  // =====================================================

  Widget _buildHeroHeaderTablet(
      BuildContext context,
      InfoRep rep,
      ) {
    final ui =
    AppUi.of(context);

    return Hero(
      tag:
      'rep_card_${rep.id}',

      child: Material(
        color:
        Colors.transparent,

        child: Container(
          width:
          double.infinity,

          padding:
          const EdgeInsets.symmetric(
            vertical:
            32,

            horizontal:
            22,
          ),

          decoration:
          BoxDecoration(
            color:
            const Color(
              0xFF164683,
            ),

            borderRadius:
            BorderRadius.circular(
              ui.cardRadius + 8,
            ),

            boxShadow: [
              BoxShadow(
                color:
                const Color(
                  0xFF1F4E79,
                ).withOpacity(
                  0.14,
                ),

                blurRadius:
                14,

                offset:
                const Offset(
                  0,
                  6,
                ),
              ),
            ],
          ),

          child: Column(
            mainAxisSize:
            MainAxisSize.min,

            children: [
              Container(
                width: 84,
                height: 84,

                alignment:
                Alignment.center,

                decoration:
                BoxDecoration(
                  color:
                  Colors.white
                      .withOpacity(
                    0.14,
                  ),

                  border:
                  Border.all(
                    color:
                    Colors.white
                        .withOpacity(
                      0.25,
                    ),

                    width:
                    1.5,
                  ),

                  borderRadius:
                  BorderRadius.circular(
                    24,
                  ),
                ),

                child: Text(
                  rep.name.isNotEmpty
                      ? rep.name
                      .substring(
                    0,
                    1,
                  )
                      : "",

                  style:
                  const TextStyle(
                    fontSize:
                    30,

                    color:
                    Colors.white,

                    fontWeight:
                    FontWeight
                        .w900,
                  ),
                ),
              ),

              const SizedBox(
                height: 18,
              ),

              Text(
                rep.name,

                maxLines:
                2,

                overflow:
                TextOverflow
                    .ellipsis,

                textAlign:
                TextAlign.center,

                style:
                const TextStyle(
                  fontSize:
                  22,

                  color:
                  Colors.white,

                  fontWeight:
                  FontWeight
                      .w700,

                  height:
                  1.25,
                ),
              ),

              if (rep
                  .address
                  .isNotEmpty) ...[
                const SizedBox(
                  height: 10,
                ),

                Row(
                  mainAxisAlignment:
                  MainAxisAlignment
                      .center,

                  children: [
                    Icon(
                      Icons
                          .location_on_outlined,

                      size:
                      16,

                      color:
                      Colors.white
                          .withOpacity(
                        0.75,
                      ),
                    ),

                    const SizedBox(
                      width: 5,
                    ),

                    Flexible(
                      child: Text(
                        rep.address,

                        maxLines:
                        3,

                        overflow:
                        TextOverflow
                            .ellipsis,

                        textAlign:
                        TextAlign
                            .center,

                        style:
                        TextStyle(
                          fontSize:
                          13,

                          color:
                          Colors.white
                              .withOpacity(
                            0.85,
                          ),

                          fontWeight:
                          FontWeight
                              .w500,

                          height:
                          1.35,
                        ),
                      ),
                    ),
                  ],
                ),
              ],

              if (isFinal) ...[
                SizedBox(
                  height:
                  ui.sectionSpacing,
                ),

                Container(
                  padding:
                  const EdgeInsets
                      .symmetric(
                    horizontal:
                    12,

                    vertical:
                    6,
                  ),

                  decoration:
                  BoxDecoration(
                    color:
                    Colors.white
                        .withOpacity(
                      0.12,
                    ),

                    borderRadius:
                    BorderRadius.circular(
                      10,
                    ),

                    border:
                    Border.all(
                      color:
                      Colors.white
                          .withOpacity(
                        0.20,
                      ),
                    ),
                  ),

                  child:
                  const Row(
                    mainAxisSize:
                    MainAxisSize
                        .min,

                    children: [
                      Icon(
                        Icons
                            .history_rounded,

                        size: 15,

                        color:
                        Colors.white,
                      ),

                      SizedBox(
                        width: 6,
                      ),

                      Text(
                        'خطة منتهية',

                        style:
                        TextStyle(
                          color:
                          Colors.white,

                          fontSize:
                          11.5,

                          fontWeight:
                          FontWeight
                              .w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  // =====================================================
  // Quick Actions
  // =====================================================

  Widget buildQuickActions(
      BuildContext context,
      ) {
    final ui =
    AppUi.of(context);

    return Column(
      crossAxisAlignment:
      CrossAxisAlignment.start,

      children: [
        _buildSectionTitle(
          context,
          title:
          "معلومات شخصية",
        ),

        SizedBox(
          height:
          ui.sectionSpacing,
        ),

        Container(
          width:
          double.infinity,

          padding:
          EdgeInsets.all(
            ui.cardPadding,
          ),

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

          child: Wrap(
            alignment:
            WrapAlignment
                .spaceAround,

            runAlignment:
            WrapAlignment.center,

            spacing:
            ui.sectionSpacingMobileZero,

            runSpacing:
            ui.sectionSpacingMobileZero,

            children: [
              // ===============================================
              // Specializations
              // ===============================================
              buildIconBtn(
                context,
                FontAwesomeIcons.tag,
                "الإختصاص",
                const Color(
                  0xFFFF9F43,
                ),
                    () {
                  context
                      .read<
                      SeniorProfBloc>()
                      .add(
                    SenAllSpecEvent(
                      id,
                    ),
                  );

                  Navigator.pushNamed(
                    context,
                    Routes.seniorSpec,
                  );
                },
              ),

              // ===============================================
              // Places
              // ===============================================
              buildIconBtn(
                context,
                FontAwesomeIcons
                    .locationDot,
                "المناطق",
                const Color(
                  0xFF45AAF2,
                ),
                    () {
                  context
                      .read<
                      SeniorProfBloc>()
                      .add(
                    SenAllPlaceEvent(
                      id,
                    ),
                  );

                  Navigator.pushNamed(
                    context,
                    Routes.seniorPlaces,
                      arguments: false
                  );
                },
              ),

              // ===============================================
              // Doctors
              // ===============================================
              buildIconBtn(
                context,
                FontAwesomeIcons
                    .userDoctor,
                "الأطباء",
                const Color(
                  0xFFEB4D4B,
                ),
                    () {
                  context
                      .read<
                      SeniorProfBloc>()
                      .add(
                    SenAllDoctorEvent(
                      id,
                    ),
                  );

                  Navigator.pushNamed(
                    context,
                    Routes.seniorDoc,
                  );
                },
              ),

              // ===============================================
              // Hospitals
              // ===============================================
              buildIconBtn(
                context,
                FontAwesomeIcons
                    .hospitalUser,
                "المشافي",
                const Color(
                  0xFFE3D909,
                ),
                    () {
                  context
                      .read<
                      SeniorProfBloc>()
                      .add(
                    SenAllHospitalEvent(
                      id,
                    ),
                  );

                  Navigator.pushNamed(
                    context,
                    Routes.seniorHos,
                  );
                },
              ),

              // ===============================================
              // Brands
              // ===============================================
              buildIconBtn(
                context,
                FontAwesomeIcons
                    .hospital,
                "الأصناف",
                const Color(
                  0xFF26DE81,
                ),
                    () {
                  context
                      .read<
                      SeniorProfBloc>()
                      .add(
                    SenAllBrandEvent(
                      repPlanId,false
                    ),
                  );

                  Navigator.pushNamed(
                    context,
                    Routes.allBrand,
                    arguments: false
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  // =====================================================
  // Coverage Router
  // =====================================================

  Widget _buildCoverageSection(
      BuildContext context
  ,InfoRep rep
      ) {
    if((isFinal)&&(rep.repType!=5&&rep.repType!=6) ){
      return _buildFullCoverageSection(
        context,
      );
    }else if((isFinal)&&(rep.repType==5||rep.repType==6)){
      return   InteractiveActionTile(
        title:
        "الخطة الشهرية الفعالة",

        icon:
        FontAwesomeIcons
            .calendarCheck,

        color:
        const Color(
          0xFF2D947A,
        ),

        onTap: () {
          Navigator.pushNamed(
            context,
            Routes.activePlanPage,

            arguments:
            rep.repPlanId,
          );
        },
      );
    }
if(!isFinal&&(rep.repType==5||rep.repType==6)){
  return SizedBox();
}
    return _buildFullCoverageSection(
      context,
    );
  }

  // =====================================================
  // Full Profile Coverage
  //
  // Doctor + Hospital
  // =====================================================

  Widget _buildFullCoverageSection(
      BuildContext context,
      ) {
    return _buildSectionLayout(
      context,
      "إحصائيات التغطية",
      [
        // =================================================
        // Completed Visits
        // =================================================
        InteractiveActionTile(
          title:
          "الزيارات التي تمت",

          icon:
          Icons
              .check_circle_outline,

          color:
          const Color(
            0xFF2D947A,
          ),

          onTap: () {
            context
                .read<
                SeniorProfBloc>()
                .add(
              VisitDocEvent(
                id,
                repPlanId,
              ),
            );

            Navigator.pushNamed(
              context,
              Routes.senVisit,

              arguments: {
                'onTapDoctor': () {
                  context
                      .read<
                      SeniorProfBloc>()
                      .add(
                    VisitDocEvent(
                      id,
                      repPlanId,
                    ),
                  );
                },

                'onTapHospital': () {
                  context
                      .read<
                      SeniorProfBloc>()
                      .add(
                    VisitHosEvent(
                      id,
                      repPlanId,
                    ),
                  );
                },

                'title':
                "الزيارات التي تمت",

                'doctor':
                SenVisitDoctor(),

                'hospital':
                SenVisitHospital(),
              },
            );
          },
        ),

        // =================================================
        // Not Visited
        // =================================================
        InteractiveActionTile(
          title:
          "الزيارات التي لم تتم بعد",

          icon:
          Icons.cancel_outlined,

          color:
          const Color(
            0xFFE74C3C,
          ),

          onTap: () {
            context
                .read<
                SeniorProfBloc>()
                .add(
              NoVisitDocEvent(
                id,
                repPlanId,
              ),
            );

            Navigator.pushNamed(
              context,
              Routes.senVisit,

              arguments: {
                'onTapDoctor': () {
                  context
                      .read<
                      SeniorProfBloc>()
                      .add(
                    NoVisitDocEvent(
                      id,
                      repPlanId,
                    ),
                  );
                },

                'onTapHospital': () {
                  context
                      .read<
                      SeniorProfBloc>()
                      .add(
                    NoVisitHosEvent(
                      id,
                      repPlanId,
                    ),
                  );
                },

                'title':
                "الزيارات التي لم تتم بعد",

                'doctor':
                NoVisitDoctor(),

                'hospital':
                NoVisitHos(),
              },
            );
          },
        ),

        // =================================================
        // Remaining
        // =================================================
        InteractiveActionTile(
          title:
          "الزيارات التي تمت ولم تكتمل",

          icon:
          Icons
              .hourglass_empty_rounded,

          color:
          const Color(
            0xFFF39C12,
          ),

          onTap: () {
            context
                .read<
                SeniorProfBloc>()
                .add(
              RemainingVisitsDocEvent(
                id,
                repPlanId,
              ),
            );

            Navigator.pushNamed(
              context,
              Routes.senVisit,

              arguments: {
                'onTapDoctor': () {
                  context
                      .read<
                      SeniorProfBloc>()
                      .add(
                    RemainingVisitsDocEvent(
                      id,
                      repPlanId,
                    ),
                  );
                },

                'onTapHospital': () {
                  context
                      .read<
                      SeniorProfBloc>()
                      .add(
                    RemainingVisitsHosEvent(
                      id,
                      repPlanId,
                    ),
                  );
                },

                'title':
                "الزيارات التي تمت ولم تكتمل",

                'doctor':
                RemainingVisits(),

                'hospital':
                RemainingVisitsHos(),
              },
            );
          },
        ),

        // =================================================
        // Inventory
        // =================================================
        _buildInventoryAction(
          context,
        ),
      ],
    );
  }

  // =====================================================
  // Inventory
  //
  // مشترك بين الملف الكامل والخطة المنتهية
  // =====================================================

  Widget _buildInventoryAction(
      BuildContext context,
      ) {
    return InteractiveActionTile(
      title:
      "تقرير توزيع العينات (الجرد)",

      icon:
      FontAwesomeIcons
          .clipboardList,

      color:
      const Color(
        0xFF1F4E79,
      ),

      onTap: () {
        initSeniorReportInventoryModule();

        Navigator.push(
          context,

          MaterialPageRoute(
            builder:
                (routeContext) {
              context
                  .read<
                  ReportInventoryBloc>()
                  .add(
                SenAllInventoryEvent(
                  id,
                  repPlanId,
                ),
              );

              return ReportInventory();
            },
          ),
        );
      },
    );
  }

  // =====================================================
  // Detailed Reports
  //
  // فقط Full Profile
  // =====================================================

  Widget _buildDetailsList(
      BuildContext context,
      InfoRep rep,
      String name,
      int plan,
      String phone,
      ) {
    return _buildSectionLayout(
      context,
      "التقارير التفصيلية",
      [
        InteractiveActionTile(
          title:
          "سجل الوصفات الطبية",

          icon:
          FontAwesomeIcons
              .receipt,

          color:
          const Color(
            0xFF7C3AED,
          ),

          onTap: () {
            Navigator.pushNamed(
              context,
              Routes.allRecipe,
            );

            context
                .read<
                SeniorProfBloc>()
                .add(
              AllReciEvent(
                id,
              ),
            );
          },
        ),

        // =================================================
        // Active Plan
        // =================================================
        InteractiveActionTile(
          title:
          "الخطة الشهرية الفعالة",

          icon:
          FontAwesomeIcons
              .calendarCheck,

          color:
          const Color(
            0xFF2D947A,
          ),

          onTap: () {
            Navigator.pushNamed(
              context,
              Routes.activePlanPage,

              arguments:
              plan,
            );
          },
        ),
      ],
    );
  }
  Widget _buildDetailsListRep(
      BuildContext context,
      InfoRep rep,
      String name,
      int plan,
      String phone,
      ) {
    return _buildSectionLayout(
      context,
      "التقارير التفصيلية",
      [
        // =================================================
        // Doctor Visit Reports
        // =================================================
        InteractiveActionTile(
          title:
          "تقرير زيارات الأطباء",

          icon:
          FontAwesomeIcons
              .fileMedical,

          color:
          const Color(
            0xFF1F4E79,
          ),

          onTap: () {
            initReportVisitDoctorModule();

            Navigator.push(
              context,

              MaterialPageRoute(
                builder:
                    (routeContext) =>
                    ReportVisitDoctorPage(
                      iscanedite:
                      true,

                      repId:
                      id,

                      userId:
                      UserInfo.repId,

                      repName:
                      name,

                      phone:
                      phone,

                      indexRep:
                      index,

                      repPlan:
                      plan,
                    ),
              ),
            );

            // =============================================
            // نفس ترتيب المنطق الأصلي
            // =============================================
            context
                .read<
                ReportVisitDoctorBloc>()
                .add(
              AllReportVisitDoctorEvent(
                VisitRepSen(
                  id,
                  UserInfo.repId,
                ),
                false,
              ),
            );
          },
        ),

        // =================================================
        // Hospital Visit Reports
        // =================================================
        InteractiveActionTile(
          title:
          "تقرير زيارات المشافي",

          icon:
          FontAwesomeIcons
              .hospitalUser,

          color:
          const Color(
            0xFF1F4E79,
          ),

          onTap: () {
            initReportVisitDoctorModule();

            Navigator.push(
              context,

              MaterialPageRoute(
                builder:
                    (routeContext) =>
                    ReportVisitHospital(
                      iscanedite:
                      true,

                      repId:
                      id,

                      userId:
                      UserInfo.repId,

                      repName:
                      name,

                      phone:
                      phone,

                      indexRep:
                      index,

                      repPlan:
                      plan,
                    ),
              ),
            );

            // =============================================
            // نفس ترتيب المنطق الأصلي
            // =============================================
            context
                .read<
                ReportVisitDoctorBloc>()
                .add(
              AllReportVisitHospitalEvent(
                VisitRepSen(
                  id,
                  UserInfo.repId,
                ),
                false,
              ),
            );
          },
        ),

        // =================================================
        // Recipes
        // =================================================
        InteractiveActionTile(
          title:
          "سجل الوصفات الطبية",

          icon:
          FontAwesomeIcons
              .receipt,

          color:
          const Color(
            0xFF7C3AED,
          ),

          onTap: () {
            Navigator.pushNamed(
              context,
              Routes.allRecipe,
            );

            context
                .read<
                SeniorProfBloc>()
                .add(
              AllReciEvent(
                id,
              ),
            );
          },
        ),

        // =================================================
        // Active Plan
        // =================================================
        InteractiveActionTile(
          title:
          "الخطة الشهرية الفعالة",

          icon:
          FontAwesomeIcons
              .calendarCheck,

          color:
          const Color(
            0xFF2D947A,
          ),

          onTap: () {
            Navigator.pushNamed(
              context,
              Routes.activePlanPage,

              arguments:
              plan,
            );
          },
        ),
      ],
    );
  }

  // =====================================================
  // Unified Section Layout
  // =====================================================

  Widget _buildSectionLayout(
      BuildContext context,
      String title,
      List<Widget> items,
      ) {
    final ui =
    AppUi.of(context);

    return Column(
      crossAxisAlignment:
      CrossAxisAlignment.start,

      children: [
        // =================================================
        // Section Title
        // =================================================
        _buildSectionTitle(
          context,
          title:
          title,
        ),

        SizedBox(
          height:
          ui.sectionSpacing,
        ),

        // =================================================
        // Tablet Landscape
        //
        // 2 Columns
        // =================================================
        if (ui
            .isTabletLandscape) ...[
          for (
          int i = 0;
          i < items.length;
          i += 2
          ) ...[
            Row(
              crossAxisAlignment:
              CrossAxisAlignment
                  .start,

              children: [
                Expanded(
                  child:
                  items[i],
                ),

                SizedBox(
                  width:
                  ui.sectionSpacing,
                ),

                Expanded(
                  child: i + 1 <
                      items.length
                      ? items[
                  i + 1]
                      : const SizedBox
                      .shrink(),
                ),
              ],
            ),

            if (i + 2 <
                items.length)
              SizedBox(
                height:
                ui.sectionSpacing,
              ),
          ],
        ] else ...[
          // =================================================
          // Mobile + Tablet Portrait
          // =================================================
          ...items,
        ],
      ],
    );
  }

  // =====================================================
  // Section Title
  // =====================================================

  Widget _buildSectionTitle(
      BuildContext context, {
        required String title,
      }) {
    final ui =
    AppUi.of(context);

    return Row(
      children: [
        Container(
          width: 4,

          height:
          ui.isMobile
              ? 20
              : 22,

          decoration:
          BoxDecoration(
            color:
            const Color(
              0xFF1F4E79,
            ),

            borderRadius:
            BorderRadius.circular(
              10,
            ),
          ),
        ),

        SizedBox(
          width:
          ui.mediumSpacing,
        ),

        Expanded(
          child: Text(
            title,

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
              FontWeight.w700,

              color:
              const Color(
                0xFF2C3E50,
              ),

              height:
              1.3,
            ),
          ),
        ),
      ],
    );
  }
}

// =======================================================
// Interactive Action Tile
//
// مستخدم بالملف الكامل والخطة المنتهية
// =======================================================

class InteractiveActionTile
    extends StatefulWidget {
  const InteractiveActionTile({
    super.key,
    required this.title,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  final String title;
  final dynamic icon;
  final Color color;
  final VoidCallback onTap;

  @override
  State<InteractiveActionTile>
  createState() =>
      _InteractiveActionTileState();
}

class _InteractiveActionTileState
    extends State<InteractiveActionTile> {
  bool isPressed =
  false;

  @override
  Widget build(BuildContext context) {
    final ui =
    AppUi.of(context);

    final double minHeight =
    ui.isMobile
        ? 68
        : ui.isTabletPortrait
        ? 78
        : 70;

    final double tileHorizontalPadding =
    ui.isMobile
        ? 14
        : ui.isTabletPortrait
        ? 18
        : 15;

    final double tileVerticalPadding =
    ui.isTabletPortrait
        ? 15
        : 12;

    final double tileRadius =
        ui.cardRadius - 2;

    final double iconBoxSize =
    ui.isTabletPortrait
        ? 50
        : 44;

    final double actionIconSize =
    ui.isTabletPortrait
        ? 21
        : 18;

    final double arrowBoxSize =
    ui.isTabletPortrait
        ? 36
        : 32;

    final double arrowSize =
    ui.isTabletPortrait
        ? 14
        : 13;

    return GestureDetector(
      onTapDown: (_) {
        setState(() {
          isPressed =
          true;
        });
      },

      onTapUp: (_) {
        setState(() {
          isPressed =
          false;
        });
      },

      onTapCancel: () {
        setState(() {
          isPressed =
          false;
        });
      },

      onTap:
      widget.onTap,

      child:
      AnimatedScale(
        duration:
        const Duration(
          milliseconds: 120,
        ),

        scale:
        isPressed
            ? 0.985
            : 1,

        child:
        AnimatedContainer(
          duration:
          const Duration(
            milliseconds:
            160,
          ),

          constraints:
          BoxConstraints(
            minHeight:
            minHeight,
          ),

          // =================================================
          // بالـLandscape الصفوف نفسها مسؤولة عن المسافة
          // =================================================
          margin:
          EdgeInsets.only(
            bottom: ui
                .isTabletLandscape
                ? 0
                : ui.cardSpacing,
          ),

          padding:
          EdgeInsets.symmetric(
            horizontal:
            tileHorizontalPadding,

            vertical:
            tileVerticalPadding,
          ),

          decoration:
          BoxDecoration(
            color:
            isPressed
                ? widget
                .color
                .withOpacity(
              0.025,
            )
                : Colors
                .white,

            borderRadius:
            BorderRadius.circular(
              tileRadius,
            ),

            border:
            Border.all(
              color:
              isPressed
                  ? widget
                  .color
                  .withOpacity(
                0.22,
              )
                  : const Color(
                0xFFE2E8F0,
              ),
            ),

            boxShadow: [
              BoxShadow(
                color: isPressed
                    ? widget.color
                    .withOpacity(
                  0.055,
                )
                    : Colors.black
                    .withOpacity(
                  0.025,
                ),

                blurRadius:
                isPressed
                    ? 8
                    : 12,

                offset:
                const Offset(
                  0,
                  4,
                ),
              ),
            ],
          ),

          child: Row(
            children: [
              // =============================================
              // Icon
              // =============================================
              AnimatedContainer(
                duration:
                const Duration(
                  milliseconds:
                  160,
                ),

                width:
                iconBoxSize,

                height:
                iconBoxSize,

                alignment:
                Alignment.center,

                decoration:
                BoxDecoration(
                  color:
                  isPressed
                      ? widget
                      .color
                      : widget
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

                child: widget.icon
                is IconData
                    ? Icon(
                  widget.icon,

                  size:
                  actionIconSize,

                  color:
                  isPressed
                      ? Colors
                      .white
                      : widget
                      .color,
                )
                    : FaIcon(
                  widget.icon
                  as FaIconData,

                  size:
                  actionIconSize -
                      1,

                  color:
                  isPressed
                      ? Colors
                      .white
                      : widget
                      .color,
                ),
              ),

              SizedBox(
                width:
                ui.sectionSpacing,
              ),

              // =============================================
              // Title
              // =============================================
              Expanded(
                child: Text(
                  widget.title,

                  maxLines:
                  2,

                  overflow:
                  TextOverflow
                      .ellipsis,

                  style:
                  TextStyle(
                    fontSize:
                    ui.bodyTextSize +
                        1,

                    height:
                    1.3,

                    fontWeight:
                    FontWeight
                        .w600,

                    color:
                    const Color(
                      0xFF34495E,
                    ),
                  ),
                ),
              ),

              SizedBox(
                width:
                ui.mediumSpacing,
              ),

              // =============================================
              // Arrow
              // =============================================
              AnimatedContainer(
                duration:
                const Duration(
                  milliseconds:
                  160,
                ),

                width:
                arrowBoxSize,

                height:
                arrowBoxSize,

                alignment:
                Alignment.center,

                decoration:
                BoxDecoration(
                  color:
                  isPressed
                      ? widget
                      .color
                      .withOpacity(
                    0.08,
                  )
                      : const Color(
                    0xFFF8FAFC,
                  ),

                  borderRadius:
                  BorderRadius
                      .circular(
                    ui.smallRadius,
                  ),
                ),

                child: Icon(
                  Icons
                      .arrow_forward_ios_rounded,

                  size:
                  arrowSize,

                  color:
                  isPressed
                      ? widget
                      .color
                      : const Color(
                    0xFFCBD5E1,
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