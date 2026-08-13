import 'package:domina_app/app/user_info.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/resources/responsive/app_responsive.dart';
import 'package:domina_app/presentation/resources/routes_manager.dart';
import 'package:domina_app/presentation/senior/representative/bloc/senior_prof_bloc.dart';
import 'package:domina_app/presentation/uniti/stateWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PlaceSenior extends StatelessWidget {
  const PlaceSenior({
    super.key,
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

    double cardHorizontalPadding;
    double cardVerticalPadding;
    double cardBottomSpacing;
    double cardRadius;

    double iconBoxSize;
    double iconSize;
    double iconSpacing;

    double labelFontSize;
    double titleFontSize;

    switch (deviceType) {
      // =================================================
      // Mobile
      // =================================================
      case AppDeviceType.mobilePortrait:
        pageMaxWidth = 600;

        headerHorizontalPadding = 20;
        headerTopPadding = 22;
        headerBottomPadding = 10;

        listHorizontalPadding = 16;
        listVerticalPadding = 10;

        headerTitleFontSize = 23;
        headerSubtitleFontSize = 13;

        cardHorizontalPadding = 16;
        cardVerticalPadding = 16;
        cardBottomSpacing = 12;
        cardRadius = 16;

        iconBoxSize = 46;
        iconSize = 23;
        iconSpacing = 14;

        labelFontSize = 11;
        titleFontSize = 17;
        break;

      // =================================================
      // Tablet Portrait
      // =================================================
      case AppDeviceType.tabletPortrait:
        pageMaxWidth = 760;

        headerHorizontalPadding = 28;
        headerTopPadding = 26;
        headerBottomPadding = 14;

        listHorizontalPadding = 28;
        listVerticalPadding = 12;

        headerTitleFontSize = 26;
        headerSubtitleFontSize = 14;

        cardHorizontalPadding = 20;
        cardVerticalPadding = 18;
        cardBottomSpacing = 14;
        cardRadius = 18;

        iconBoxSize = 52;
        iconSize = 26;
        iconSpacing = 16;

        labelFontSize = 12;
        titleFontSize = 19;
        break;

      // =================================================
      // Tablet Landscape
      // =================================================
      case AppDeviceType.tabletLandscape:
        pageMaxWidth = 900;

        headerHorizontalPadding = 32;
        headerTopPadding = 20;
        headerBottomPadding = 12;

        listHorizontalPadding = 32;
        listVerticalPadding = 10;

        headerTitleFontSize = 26;
        headerSubtitleFontSize = 14;

        cardHorizontalPadding = 20;
        cardVerticalPadding = 14;
        cardBottomSpacing = 12;
        cardRadius = 18;

        iconBoxSize = 50;
        iconSize = 24;
        iconSpacing = 16;

        labelFontSize = 12;
        titleFontSize = 18;
        break;
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: const Text(
          'المناطق المتاحة',
        ),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: pageMaxWidth,
          ),
          child: bodyBuild(
            context,
            headerHorizontalPadding: headerHorizontalPadding,
            headerTopPadding: headerTopPadding,
            headerBottomPadding: headerBottomPadding,
            listHorizontalPadding: listHorizontalPadding,
            listVerticalPadding: listVerticalPadding,
            headerTitleFontSize: headerTitleFontSize,
            headerSubtitleFontSize: headerSubtitleFontSize,
            cardHorizontalPadding: cardHorizontalPadding,
            cardVerticalPadding: cardVerticalPadding,
            cardBottomSpacing: cardBottomSpacing,
            cardRadius: cardRadius,
            iconBoxSize: iconBoxSize,
            iconSize: iconSize,
            iconSpacing: iconSpacing,
            labelFontSize: labelFontSize,
            titleFontSize: titleFontSize,
          ),
        ),
      ),
    );
  }

  Widget bodyBuild(
    BuildContext context, {
    required double headerHorizontalPadding,
    required double headerTopPadding,
    required double headerBottomPadding,
    required double listHorizontalPadding,
    required double listVerticalPadding,
    required double headerTitleFontSize,
    required double headerSubtitleFontSize,
    required double cardHorizontalPadding,
    required double cardVerticalPadding,
    required double cardBottomSpacing,
    required double cardRadius,
    required double iconBoxSize,
    required double iconSize,
    required double iconSpacing,
    required double labelFontSize,
    required double titleFontSize,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // =================================================
        // Header
        // =================================================
        _buildHeader(
          horizontalPadding: headerHorizontalPadding,
          topPadding: headerTopPadding,
          bottomPadding: headerBottomPadding,
          titleFontSize: headerTitleFontSize,
          subtitleFontSize: headerSubtitleFontSize,
        ),

        // =================================================
        // Places
        // =================================================
        Expanded(
          child: BlocBuilder<SeniorProfBloc, SeniorProfState>(
            buildWhen: (previous, current) => current is SenAllPlaceState||

            current is SenAllPlaceLoadingState||current is SenAllPlaceErrorState
            ,
            builder: (context, state) {
              if (state is SenAllPlaceState) {
                final List<PlaceModel> placeModel = state.places;

                return placeModel.isEmpty
                    ? emptyFullScreen(context)
                    : ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        padding: EdgeInsets.symmetric(
                          horizontal: listHorizontalPadding,
                          vertical: listVerticalPadding,
                        ),
                        itemCount: placeModel.length,
                        itemBuilder: (context, index) {
                          return _buildPlaceCard(
                            context,
                            placeModel[index],
                            horizontalPadding: cardHorizontalPadding,
                            verticalPadding: cardVerticalPadding,
                            bottomSpacing: cardBottomSpacing,
                            radius: cardRadius,
                            iconBoxSize: iconBoxSize,
                            iconSize: iconSize,
                            iconSpacing: iconSpacing,
                            labelFontSize: labelFontSize,
                            titleFontSize: titleFontSize,
                          );
                        },
                      );
              }

              // =================================================
              // Loading
              // نفس السلوك
              // =================================================
              if (state is SenAllPlaceLoadingState) {
                return loadingFullScreen(
                  context,
                );
              }

              // =================================================
              // Error
              // نفس السلوك تماماً
              // =================================================
              if (state is SenAllPlaceErrorState) {
                return errorFullScreen(
                  context,
                  func: () {
                    BlocProvider.of<SeniorProfBloc>(
                      context,
                    ).add(
                      SenAllPlaceEvent(
                        203,
                      ),
                    );
                  },
                );
              }

              return const SizedBox.shrink();
            },
          ),
        ),
      ],
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
                  'دليل المناطق',
                  style: TextStyle(
                    fontSize: titleFontSize,
                    fontWeight: FontWeight.bold,
                    color: const Color(
                      0xFF1F4E79,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  'المناطق المتاحة لهذا المندوب',
                  style: TextStyle(
                    fontSize: subtitleFontSize,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(
            width: 16,
          ),

          // نفس العنصر البصري المستخدم ببقية الصفحات
          Container(
            width: 40,
            height: 5,
            decoration: BoxDecoration(
              color: const Color(
                0xFF42A5F5,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ],
      ),
    );
  }

  // =====================================================
  // Place Card
  // =====================================================

  Widget _buildPlaceCard(
    BuildContext context,
    PlaceModel place, {
    required double horizontalPadding,
    required double verticalPadding,
    required double bottomSpacing,
    required double radius,
    required double iconBoxSize,
    required double iconSize,
    required double iconSpacing,
    required double labelFontSize,
    required double titleFontSize,
  }) {
    return Container(
      margin: EdgeInsets.only(
        bottom: bottomSpacing,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(
          color: Colors.black.withOpacity(
            0.035,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(
              0.03,
            ),
            blurRadius: 12,
            offset: const Offset(
              0,
              5,
            ),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(radius),

          // =================================================
          // نفس السلوك الأصلي
          // =================================================
          onTap: () {
            Navigator.pushNamed(
              context,
              Routes.docHos,
            );
            BlocProvider.of<SeniorProfBloc>(context)
                .add(DocHosEvent(UserInfo.repId, placeId: place.placeId));
          },

          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: horizontalPadding,
              vertical: verticalPadding,
            ),
            child: Row(
              children: [
                // =============================================
                // Location Icon
                // =============================================
                Container(
                  width: iconBoxSize,
                  height: iconBoxSize,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: const Color(
                      0xFFE3F2FD,
                    ),
                    borderRadius: BorderRadius.circular(
                      14,
                    ),
                  ),
                  child: Icon(
                    Icons.location_on_rounded,
                    color: const Color(
                      0xFF1E88E5,
                    ),
                    size: iconSize,
                  ),
                ),

                SizedBox(
                  width: iconSpacing,
                ),

                // =============================================
                // Place Info
                // =============================================
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "اسم المنطقة",
                        style: TextStyle(
                          fontSize: labelFontSize,
                          color: Colors.grey.shade500,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(
                        height: 3,
                      ),
                      Text(
                        place.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: titleFontSize,
                          fontWeight: FontWeight.w700,
                          color: const Color(
                            0xFF263238,
                          ),
                        ),
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
}
