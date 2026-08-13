// ignore_for_file: must_be_immutable

import 'package:domina_app/app/di/di.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/resources/responsive/app_responsive.dart';
import 'package:domina_app/presentation/senior/general_reports/bloc/bloc/general_reports_bloc.dart';
import 'package:domina_app/presentation/senior/general_reports/pages/all-rep-general-reports.dart';
import 'package:domina_app/presentation/senior/places/bloc/senior_reps_bloc.dart';
import 'package:domina_app/presentation/uniti/stateWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class TeamLeader extends StatefulWidget {
  const TeamLeader({
    super.key,
  });

  @override
  State<TeamLeader> createState() =>
      _TeamLeaderState();
}

class _TeamLeaderState extends State<TeamLeader>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);

    final deviceType =
    AppResponsive.deviceType(context);

    double pageMaxWidth;

    double horizontalPadding;

    double headerTopPadding;
    double headerBottomPadding;

    double headerTitleFontSize;
    double headerSubtitleFontSize;

    double listTopPadding;
    double listBottomPadding;

 //   double loadingHorizontalPadding;
    double loadingVerticalSpacing;
    double loadingHeight;
    double loadingRadius;

    switch (deviceType) {
    // =================================================
    // Mobile
    // =================================================
      case AppDeviceType.mobilePortrait:
        pageMaxWidth = 600;

        horizontalPadding = 16;

        headerTopPadding = 20;
        headerBottomPadding = 14;

        headerTitleFontSize = 21;
        headerSubtitleFontSize = 12;

        listTopPadding = 6;
        listBottomPadding = 30;

       // loadingHorizontalPadding = 16;
        loadingVerticalSpacing = 16;
        loadingHeight = 100;
        loadingRadius = 18;
        break;

    // =================================================
    // Tablet Portrait
    // =================================================
      case AppDeviceType.tabletPortrait:
        pageMaxWidth = 800;

        horizontalPadding = 28;

        headerTopPadding = 28;
        headerBottomPadding = 18;

        headerTitleFontSize = 26;
        headerSubtitleFontSize = 14;

        listTopPadding = 8;
        listBottomPadding = 36;

      //  loadingHorizontalPadding = 28;
        loadingVerticalSpacing = 18;
        loadingHeight = 120;
        loadingRadius = 20;
        break;

    // =================================================
    // Tablet Landscape
    // =================================================
      case AppDeviceType.tabletLandscape:
        pageMaxWidth = 950;

        horizontalPadding = 32;

        headerTopPadding = 22;
        headerBottomPadding = 16;

        headerTitleFontSize = 24;
        headerSubtitleFontSize = 13;

        listTopPadding = 6;
        listBottomPadding = 32;

     //   loadingHorizontalPadding = 32;
        loadingVerticalSpacing = 14;
        loadingHeight = 105;
        loadingRadius = 18;
        break;
    }

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
          "إدارة التقارير العامة",
        ),
      ),

      body: Center(
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

            slivers: [
              // =================================================
              // Header
              // =================================================
              SliverToBoxAdapter(
                child:
                _buildHeader(
                  context,

                  horizontalPadding:
                  horizontalPadding,

                  topPadding:
                  headerTopPadding,

                  bottomPadding:
                  headerBottomPadding,

                  titleFontSize:
                  headerTitleFontSize,

                  subtitleFontSize:
                  headerSubtitleFontSize,
                ),
              ),

              // =================================================
              // Data
              // =================================================
              BlocBuilder<
                  GeneralReportsBloc,
                  GeneralReportsState>(
                builder:
                    (context, state) {
                  // ===============================================
                  // نفس المصدر الموجود عندك
                  // ===============================================
                  final List<SeniorCityModel>
                  seniors =
                      context
                          .read<
                          GeneralReportsBloc>()
                          .dataseniors;

                  // ===============================================
                  // Loading
                  // ===============================================
                  if (state
                  is TeamLeaderAndCityLoadingState) {
                    return SliverFillRemaining(
                      hasScrollBody:
                      false,

                      child:
                      Padding(
                        padding:
                        EdgeInsets.symmetric(
                          horizontal:
                          horizontalPadding,
                        ),

                        child:
                        loadingShimmer(
                          context,

                          5,

                          loadingVerticalSpacing,

                          loadingHeight,

                          BorderRadius
                              .circular(
                            loadingRadius,
                          ),
                        ),
                      ),
                    );
                  }

                  // ===============================================
                  // Error
                  // ===============================================
                  if (state
                  is TeamLeaderAndCityErrorState) {
                    return SliverFillRemaining(
                      hasScrollBody:
                      false,

                      child:
                      errorFullScreen(
                        context,

                        // نفس السلوك الحالي
                        func: () {},
                      ),
                    );
                  }

                  // ===============================================
                  // Empty
                  // ===============================================
                  if (seniors.isEmpty) {
                    return SliverFillRemaining(
                      hasScrollBody:
                      false,

                      child:
                      emptyFullScreen(
                        context,
                      ),
                    );
                  }

                  // ===============================================
                  // List
                  // ===============================================
                  return SliverPadding(
                    padding:
                    EdgeInsets.fromLTRB(
                      horizontalPadding,
                      listTopPadding,
                      horizontalPadding,
                      listBottomPadding,
                    ),

                    sliver:
                    AnimationLimiter(
                      child:
                      SliverList(
                        delegate:
                        SliverChildBuilderDelegate(
                              (
                              context,
                              index,
                              ) {
                            return AnimationConfiguration
                                .staggeredList(
                              position:
                              index,

                              duration:
                              const Duration(
                                milliseconds:
                                450,
                              ),

                              delay:
                              const Duration(
                                milliseconds:
                                40,
                              ),

                              child:
                              SlideAnimation(
                                verticalOffset:
                                22,

                                child:
                                FadeInAnimation(
                                  child:
                                  _buildRepSmartCard(
                                    context,

                                    seniors[
                                    index],
                                  ),
                                ),
                              ),
                            );
                          },

                          childCount:
                          seniors.length,
                        ),
                      ),
                    ),
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
      BuildContext context, {
        required double horizontalPadding,
        required double topPadding,
        required double bottomPadding,
        required double titleFontSize,
        required double subtitleFontSize,
      }) {
    return Padding(
      padding:
      EdgeInsets.fromLTRB(
        horizontalPadding,
        topPadding,
        horizontalPadding,
        bottomPadding,
      ),

      child: Row(
        crossAxisAlignment:
        CrossAxisAlignment.center,

        children: [
          // =================================================
          // Text
          // =================================================
          Expanded(
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,

              children: [
                Text(
                  "تيم ليدر دومنا",

                  maxLines: 1,

                  overflow:
                  TextOverflow.ellipsis,

                  style:
                  TextStyle(
                    fontSize:
                    titleFontSize,

                    fontWeight:
                    FontWeight.w800,

                    color:
                    ColorManager
                        .medicalPrimary,

                    height: 1.25,
                  ),
                ),

                const SizedBox(
                  height: 5,
                ),

                Text(
                  "قائمة التيم ليدر المتاحين في دومنا",

                  maxLines: 2,

                  overflow:
                  TextOverflow.ellipsis,

                  style:
                  TextStyle(
                    color:
                    const Color(
                      0xFF64748B,
                    ),

                    fontSize:
                    subtitleFontSize,

                    fontWeight:
                    FontWeight.w500,

                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(
            width: 16,
          ),

          // =================================================
          // Decorative Indicator
          // =================================================
          Container(
            width: 44,
            height: 5,

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
      ),
    );
  }

  // =====================================================
  // Team Leader Card
  // =====================================================

  Widget _buildRepSmartCard(
      BuildContext context,
      SeniorCityModel senior,
      ) {
    final deviceType =
    AppResponsive.deviceType(context);

    double cardBottomSpacing;

    double cardRadius;
    double cardPadding;

    double iconBoxSize;
    double iconSize;
    double iconRadius;
    double iconSpacing;

    double titleFontSize;
    double subtitleFontSize;

    double arrowBoxSize;
    double arrowIconSize;

    switch (deviceType) {
    // =================================================
    // Mobile
    // =================================================
      case AppDeviceType.mobilePortrait:
        cardBottomSpacing = 12;

        cardRadius = 18;
        cardPadding = 15;

        iconBoxSize = 46;
        iconSize = 23;
        iconRadius = 13;
        iconSpacing = 12;

        titleFontSize = 16;
        subtitleFontSize = 11;

        arrowBoxSize = 34;
        arrowIconSize = 16;
        break;

    // =================================================
    // Tablet Portrait
    // =================================================
      case AppDeviceType.tabletPortrait:
        cardBottomSpacing = 15;

        cardRadius = 20;
        cardPadding = 20;

        iconBoxSize = 54;
        iconSize = 27;
        iconRadius = 15;
        iconSpacing = 16;

        titleFontSize = 19;
        subtitleFontSize = 13;

        arrowBoxSize = 40;
        arrowIconSize = 18;
        break;

    // =================================================
    // Tablet Landscape
    // =================================================
      case AppDeviceType.tabletLandscape:
        cardBottomSpacing = 12;

        cardRadius = 18;
        cardPadding = 17;

        iconBoxSize = 50;
        iconSize = 25;
        iconRadius = 14;
        iconSpacing = 14;

        titleFontSize = 18;
        subtitleFontSize = 12;

        arrowBoxSize = 36;
        arrowIconSize = 17;
        break;
    }

    return Padding(
      padding:
      EdgeInsets.only(
        bottom:
        cardBottomSpacing,
      ),

      child: Material(
        color:
        Colors.transparent,

        child: InkWell(
          borderRadius:
          BorderRadius.circular(
            cardRadius,
          ),

          onTap: () {
            // ===============================================
            // نفس ترتيب المنطق الأصلي
            // ===============================================
            initSeniorModule();

            Navigator.push(
              context,

              MaterialPageRoute(
                builder:
                    (context) {
                  return AllRepSeniorGenerlReports(
                    cityname:
                    senior.city_name,

                    cityId:
                    int.parse(
                      senior.city_id,
                    ),

                    repId:
                    int.parse(
                      senior.rep_id,
                    ),
                  );
                },
              ),
            );

            BlocProvider.of<
                SeniorRepsBloc>(
              context,
            ).add(
              AllSeniorRepEvent(
                int.parse(
                  senior.city_id,
                ),

                int.parse(
                  senior.rep_id,
                ),
              ),
            );
          },

          child: Container(
            padding:
            EdgeInsets.all(
              cardPadding,
            ),

            decoration:
            BoxDecoration(
              color:
              Colors.white,

              borderRadius:
              BorderRadius.circular(
                cardRadius,
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

                  blurRadius: 12,

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
                Container(
                  width:
                  iconBoxSize,

                  height:
                  iconBoxSize,

                  alignment:
                  Alignment.center,

                  decoration:
                  BoxDecoration(
                    color: ColorManager
                        .secondaryColor1
                        .withOpacity(
                      0.08,
                    ),

                    borderRadius:
                    BorderRadius
                        .circular(
                      iconRadius,
                    ),
                  ),

                  child: Icon(
                    Icons
                        .person_pin_rounded,

                    size:
                    iconSize,

                    color:
                    ColorManager
                        .secondaryColor1,
                  ),
                ),

                SizedBox(
                  width:
                  iconSpacing,
                ),

                // =============================================
                // Information
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
                        senior.rep_name,

                        maxLines: 1,

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

                          color: ColorManager
                              .secondaryColor1,

                          height: 1.25,
                        ),
                      ),

                      const SizedBox(
                        height: 5,
                      ),

                      Row(
                        children: [
                          Icon(
                            Icons
                                .location_on_outlined,

                            size:
                            subtitleFontSize +
                                3,

                            color:
                            const Color(
                              0xFF94A3B8,
                            ),
                          ),

                          const SizedBox(
                            width: 4,
                          ),

                          Expanded(
                            child:
                            Text(
                              "اضغط لاستعراض السينيور في ${senior.city_name}",

                              maxLines: 1,

                              overflow:
                              TextOverflow
                                  .ellipsis,

                              style:
                              TextStyle(
                                fontSize:
                                subtitleFontSize,

                                color:
                                const Color(
                                  0xFF94A3B8,
                                ),

                                fontWeight:
                                FontWeight
                                    .w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(
                  width: 10,
                ),

                // =============================================
                // Arrow
                // =============================================
                Container(
                  width:
                  arrowBoxSize,

                  height:
                  arrowBoxSize,

                  alignment:
                  Alignment.center,

                  decoration:
                  BoxDecoration(
                    color:
                    const Color(
                      0xFFF8FAFC,
                    ),

                    borderRadius:
                    BorderRadius
                        .circular(
                      10,
                    ),
                  ),

                  child: Icon(
                    Icons
                        .arrow_forward_ios_rounded,

                    size:
                    arrowIconSize,

                    color:
                    const Color(
                      0xFF94A3B8,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}