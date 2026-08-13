// ignore_for_file: must_be_immutable, file_names

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

class SeniorByCityId extends StatelessWidget {
  final String cityname;
  final int cityid;

  const SeniorByCityId({
    super.key,
    required this.cityid,
    required this.cityname,
  });

  @override
  Widget build(BuildContext context) {
    final deviceType = AppResponsive.deviceType(context);

    double pageMaxWidth;

    double headerHorizontalPadding;
    double headerTopPadding;
    double headerBottomPadding;

    double listHorizontalPadding;
    double listVerticalPadding;

    double headerTitleFontSize;
    double headerSubtitleFontSize;

    double cardPadding;
    double cardBottomMargin;
    double cardRadius;

    double avatarSize;
    double avatarIconSize;
    double avatarSpacing;

    double nameFontSize;
    double subtitleFontSize;
    double arrowSize;

    switch (deviceType) {
    // ============================================
    // Mobile
    // ============================================
      case AppDeviceType.mobilePortrait:
        pageMaxWidth = 600;

        headerHorizontalPadding = 20;
        headerTopPadding = 25;
        headerBottomPadding = 15;

        listHorizontalPadding = 16;
        listVerticalPadding = 8;

        headerTitleFontSize = 24;
        headerSubtitleFontSize = 13;

        cardPadding = 18;
        cardBottomMargin = 16;
        cardRadius = 18;

        avatarSize = 50;
        avatarIconSize = 24;
        avatarSpacing = 16;

        nameFontSize = 17;
        subtitleFontSize = 11;
        arrowSize = 18;
        break;

    // ============================================
    // Tablet Portrait
    // ============================================
      case AppDeviceType.tabletPortrait:
        pageMaxWidth = 760;

        headerHorizontalPadding = 28;
        headerTopPadding = 28;
        headerBottomPadding = 18;

        listHorizontalPadding = 24;
        listVerticalPadding = 10;

        headerTitleFontSize = 28;
        headerSubtitleFontSize = 15;

        cardPadding = 22;
        cardBottomMargin = 18;
        cardRadius = 20;

        avatarSize = 58;
        avatarIconSize = 28;
        avatarSpacing = 18;

        nameFontSize = 20;
        subtitleFontSize = 13;
        arrowSize = 20;
        break;

    // ============================================
    // Tablet Landscape
    // ============================================
      case AppDeviceType.tabletLandscape:
        pageMaxWidth = 900;

        headerHorizontalPadding = 32;
        headerTopPadding = 22;
        headerBottomPadding = 16;

        listHorizontalPadding = 28;
        listVerticalPadding = 10;

        headerTitleFontSize = 28;
        headerSubtitleFontSize = 15;

        cardPadding = 22;
        cardBottomMargin = 18;
        cardRadius = 20;

        avatarSize = 58;
        avatarIconSize = 28;
        avatarSpacing = 18;

        nameFontSize = 20;
        subtitleFontSize = 13;
        arrowSize = 20;
        break;
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: Text(
          cityname,
        ),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: pageMaxWidth,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // =========================================
              // Header
              // =========================================
              _buildHeader(
                horizontalPadding: headerHorizontalPadding,
                topPadding: headerTopPadding,
                bottomPadding: headerBottomPadding,
                titleFontSize: headerTitleFontSize,
                subtitleFontSize: headerSubtitleFontSize,
              ),

              // =========================================
              // Seniors List
              // =========================================
              BlocBuilder<GeneralReportsBloc, GeneralReportsState>(
                builder: (context, state) {
                  List<SeniorCityModel> seniors = context
                      .watch<GeneralReportsBloc>()
                      .dataseniorsbycityid;

                  if (state is SeniorByCityIdState) {
                    seniors = state.data;
                  }

                  // =====================================
                  // Loading
                  // نفس السلوك
                  // =====================================
                  if (state is SeniorByCityIdLoadingState) {
                    return Expanded(
                      child: loadingShimmer(
                        context,
                        10,
                        20,
                        20,
                        BorderRadius.circular(
                          cardRadius,
                        ),
                      ),
                    );
                  }

                  // =====================================
                  // Error
                  // نفس السلوك
                  // =====================================
                  if (state is SeniorByCityIdErrorState) {
                    return Expanded(
                      child: errorFullScreen(
                        context,
                        func: () {},
                      ),
                    );
                  }

                  // =====================================
                  // Empty
                  // نفس السلوك
                  // =====================================
                  if (state is SeniorByCityIdEmptyState ||
                      seniors.isEmpty) {
                    return Expanded(
                      child: emptyFullScreen(
                        context,
                      ),
                    );
                  }

                  // =====================================
                  // Data
                  // =====================================
                  return Expanded(
                    child: AnimationLimiter(
                      child: ListView.builder(
                        padding: EdgeInsets.symmetric(
                          horizontal: listHorizontalPadding,
                          vertical: listVerticalPadding,
                        ),
                        physics: const BouncingScrollPhysics(),
                        itemCount: seniors.length,
                        itemBuilder: (context, index) {
                          return AnimationConfiguration.staggeredList(
                            position: index,
                            duration: const Duration(
                              milliseconds: 500,
                            ),
                            delay: const Duration(
                              milliseconds: 50,
                            ),
                            child: SlideAnimation(
                              verticalOffset: 30,
                              child: FadeInAnimation(
                                child: _buildRepSmartCard(
                                  context,
                                  seniors[index],
                                  cardPadding: cardPadding,
                                  cardBottomMargin: cardBottomMargin,
                                  cardRadius: cardRadius,
                                  avatarSize: avatarSize,
                                  avatarIconSize: avatarIconSize,
                                  avatarSpacing: avatarSpacing,
                                  nameFontSize: nameFontSize,
                                  subtitleFontSize: subtitleFontSize,
                                  arrowSize: arrowSize,
                                ),
                              ),
                            ),
                          );
                        },
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

  Widget _buildHeader({
    required double horizontalPadding,
    required double topPadding,
    required double bottomPadding,
    required double titleFontSize,
    required double subtitleFontSize,
  }) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        horizontalPadding,
        topPadding,
        horizontalPadding,
        bottomPadding,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "سينيور المنطقة",
                  style: TextStyle(
                    fontSize: titleFontSize,
                    fontWeight: FontWeight.bold,
                    color: ColorManager.medicalPrimary,
                  ),
                ),

                const SizedBox(
                  height: 4,
                ),

                Text(
                  "قائمة السينيور المتاحين في $cityname",
                  style: TextStyle(
                    color: Colors.grey.shade500,
                    fontSize: subtitleFontSize,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(
            width: 16,
          ),

          Container(
            height: 5,
            width: 45,
            decoration: BoxDecoration(
              color: const Color(0xFF42A5F5),
              borderRadius: BorderRadius.circular(
                10,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // =====================================================
  // Senior Card
  // =====================================================

  Widget _buildRepSmartCard(
      BuildContext context,
      SeniorCityModel senior, {
        required double cardPadding,
        required double cardBottomMargin,
        required double cardRadius,
        required double avatarSize,
        required double avatarIconSize,
        required double avatarSpacing,
        required double nameFontSize,
        required double subtitleFontSize,
        required double arrowSize,
      }) {
    return Container(
      margin: EdgeInsets.only(
        bottom: cardBottomMargin,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(
          cardRadius,
        ),
        border: Border.all(
          color: Colors.blue.withOpacity(0.05),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 15,
            offset: const Offset(
              0,
              8,
            ),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(
          cardRadius,
        ),
        child: InkWell(
          // ============================================
          // نفس السلوك الأصلي تماماً
          // ============================================
          onTap: () {
            initSeniorModule();

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return AllRepSeniorGenerlReports(
                    cityname: senior.city_name,
                    cityId: int.parse(
                      senior.city_id,
                    ),
                    repId: int.parse(
                      senior.rep_id,
                    ),
                    seniorName: senior.rep_name,
                  );
                },
              ),
            );

            print(
              "rep_id:${senior.rep_id}",
            );

            BlocProvider.of<SeniorRepsBloc>(context).add(
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

          child: Padding(
            padding: EdgeInsets.all(
              cardPadding,
            ),
            child: Row(
              children: [
                // ======================================
                // Avatar
                // ======================================
                Container(
                  width: avatarSize,
                  height: avatarSize,
                  decoration: BoxDecoration(
                    color: ColorManager.medicalPrimary
                        .withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.person_pin_rounded,
                    size: avatarIconSize,
                    color: ColorManager.medicalPrimary,
                  ),
                ),

                SizedBox(
                  width: avatarSpacing,
                ),

                // ======================================
                // Senior Info
                // ======================================
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        senior.rep_name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: nameFontSize,
                          fontWeight: FontWeight.w700,
                          color: ColorManager.secondaryColor1,
                        ),
                      ),

                      const SizedBox(
                        height: 4,
                      ),

                      Text(
                        "اضغط لاستعراض تقارير المندوبين",
                        style: TextStyle(
                          fontSize: subtitleFontSize,
                          color: Colors.grey.shade400,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(
                  width: 10,
                ),

                Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: arrowSize,
                  color: Colors.grey.shade300,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}