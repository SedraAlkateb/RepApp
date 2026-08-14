import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/resources/responsive/app_responsive.dart';
import 'package:domina_app/presentation/resources/routes_manager.dart';
import 'package:domina_app/presentation/senior/all_city/bloc/bloc/all_city_bloc.dart';
import 'package:domina_app/presentation/uniti/stateWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class AllCityForRepSuper extends StatefulWidget {
  const AllCityForRepSuper({
    super.key,
  });

  @override
  State<AllCityForRepSuper> createState() =>
      _AllCityForRepSuperState();
}

class _AllCityForRepSuperState
    extends State<AllCityForRepSuper> {
  @override
  void initState() {
    BlocProvider.of<AllCityBloc>(context).add(
      const GetAllCityEvent(),
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final deviceType =
    AppResponsive.deviceType(context);

    double pageMaxWidth;

    double headerHorizontalPadding;
    double headerTopPadding;
    double headerBottomPadding;

    double listHorizontalPadding;
    double listTopPadding;
    double listBottomPadding;

    double headerTitleFontSize;
    double headerSubtitleFontSize;

    double cardHorizontalPadding;
    double cardVerticalPadding;
    double cardBottomMargin;
    double cardRadius;

    double cityTitleFontSize;
    double citySubtitleFontSize;

    double iconContainerPadding;
    double iconSize;
    double iconSpacing;
    double arrowSize;

    switch (deviceType) {
    // ===========================================
    // Mobile
    // ===========================================
      case AppDeviceType.mobilePortrait:
        pageMaxWidth = 600;

        headerHorizontalPadding = 20;
        headerTopPadding = 24;
        headerBottomPadding = 10;

        listHorizontalPadding = 16;
        listTopPadding = 8;
        listBottomPadding = 20;

        headerTitleFontSize = 24;
        headerSubtitleFontSize = 13;

        cardHorizontalPadding = 16;
        cardVerticalPadding = 20;
        cardBottomMargin = 16;
        cardRadius = 18;

        cityTitleFontSize = 18;
        citySubtitleFontSize = 12;

        iconContainerPadding = 10;
        iconSize = 24;
        iconSpacing = 16;
        arrowSize = 18;
        break;

    // ===========================================
    // Tablet Portrait
    // ===========================================
      case AppDeviceType.tabletPortrait:
        pageMaxWidth = 760;

        headerHorizontalPadding = 28;
        headerTopPadding = 28;
        headerBottomPadding = 14;

        listHorizontalPadding = 24;
        listTopPadding = 10;
        listBottomPadding = 24;

        headerTitleFontSize = 28;
        headerSubtitleFontSize = 15;

        cardHorizontalPadding = 20;
        cardVerticalPadding = 22;
        cardBottomMargin = 18;
        cardRadius = 20;

        cityTitleFontSize = 20;
        citySubtitleFontSize = 14;

        iconContainerPadding = 12;
        iconSize = 27;
        iconSpacing = 18;
        arrowSize = 20;
        break;

    // ===========================================
    // Tablet Landscape
    // ===========================================
      case AppDeviceType.tabletLandscape:
        pageMaxWidth = 900;

        headerHorizontalPadding = 32;
        headerTopPadding = 22;
        headerBottomPadding = 14;

        listHorizontalPadding = 28;
        listTopPadding = 10;
        listBottomPadding = 24;

        headerTitleFontSize = 28;
        headerSubtitleFontSize = 15;

        cardHorizontalPadding = 22;
        cardVerticalPadding = 20;
        cardBottomMargin = 18;
        cardRadius = 20;

        cityTitleFontSize = 20;
        citySubtitleFontSize = 14;

        iconContainerPadding = 12;
        iconSize = 28;
        iconSpacing = 18;
        arrowSize = 20;
        break;
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: const Text(
          'المناطق والمدن',
        ),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: pageMaxWidth,
          ),
          child: bodyBuild(
            context,
            headerHorizontalPadding:
            headerHorizontalPadding,
            headerTopPadding: headerTopPadding,
            headerBottomPadding:
            headerBottomPadding,
            listHorizontalPadding:
            listHorizontalPadding,
            listTopPadding: listTopPadding,
            listBottomPadding: listBottomPadding,
            headerTitleFontSize:
            headerTitleFontSize,
            headerSubtitleFontSize:
            headerSubtitleFontSize,
            cardHorizontalPadding:
            cardHorizontalPadding,
            cardVerticalPadding:
            cardVerticalPadding,
            cardBottomMargin: cardBottomMargin,
            cardRadius: cardRadius,
            cityTitleFontSize: cityTitleFontSize,
            citySubtitleFontSize:
            citySubtitleFontSize,
            iconContainerPadding:
            iconContainerPadding,
            iconSize: iconSize,
            iconSpacing: iconSpacing,
            arrowSize: arrowSize,
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
        required double listTopPadding,
        required double listBottomPadding,
        required double headerTitleFontSize,
        required double headerSubtitleFontSize,
        required double cardHorizontalPadding,
        required double cardVerticalPadding,
        required double cardBottomMargin,
        required double cardRadius,
        required double cityTitleFontSize,
        required double citySubtitleFontSize,
        required double iconContainerPadding,
        required double iconSize,
        required double iconSpacing,
        required double arrowSize,
      }) {
    return Column(
      crossAxisAlignment:
      CrossAxisAlignment.start,
      children: [
        // =========================================
        // Header
        // =========================================
        _buildHeader(
          horizontalPadding:
          headerHorizontalPadding,
          topPadding: headerTopPadding,
          bottomPadding: headerBottomPadding,
          titleFontSize: headerTitleFontSize,
          subtitleFontSize:
          headerSubtitleFontSize,
        ),

        // =========================================
        // Cities List
        // =========================================
        Expanded(
          child:
          BlocBuilder<AllCityBloc, AllCityState>(
            builder: (context, state) {
              if (state is GetAllCityState) {
                final List<CityModel> cities =
                    state.cities;

                return cities.isEmpty
                    ? emptyFullScreen(context)
                    : AnimationLimiter(
                  child: ListView.builder(
                    physics:
                    const BouncingScrollPhysics(),
                    padding:
                    EdgeInsets.fromLTRB(
                      listHorizontalPadding,
                      listTopPadding,
                      listHorizontalPadding,
                      listBottomPadding,
                    ),
                    itemCount: cities.length,
                    itemBuilder:
                        (context, index) {
                      return AnimationConfiguration
                          .staggeredList(
                        position: index,
                        duration:
                        const Duration(
                          milliseconds: 500,
                        ),
                        delay:
                        const Duration(
                          milliseconds: 50,
                        ),
                        child:
                        SlideAnimation(
                          verticalOffset: 30,
                          child:
                          FadeInAnimation(
                            child:
                            _buildCitySmartCard(
                              cities[index],
                              index,
                              horizontalPadding:
                              cardHorizontalPadding,
                              verticalPadding:
                              cardVerticalPadding,
                              bottomMargin:
                              cardBottomMargin,
                              radius:
                              cardRadius,
                              titleFontSize:
                              cityTitleFontSize,
                              subtitleFontSize:
                              citySubtitleFontSize,
                              iconContainerPadding:
                              iconContainerPadding,
                              iconSize:
                              iconSize,
                              iconSpacing:
                              iconSpacing,
                              arrowSize:
                              arrowSize,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              }

              if (state is AllCityLoadingState) {
                return loadingShimmer(
                  context,
                  20,
                  25,
                  70,
                  BorderRadius.circular(20),
                );
              }

              if (state is AllCityErrorState) {
                return errorFullScreen(
                  context,
                  func: () {
                    BlocProvider.of<AllCityBloc>(
                      context,
                    ).add(
                      const GetAllCityEvent(),
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
        mainAxisAlignment:
        MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                Text(
                  "دليل المناطق",
                  style: TextStyle(
                    fontSize: titleFontSize,
                    fontWeight: FontWeight.bold,
                    color:
                    ColorManager.medicalPrimary,
                  ),
                ),

                const SizedBox(
                  height: 4,
                ),

                Text(
                  "اختر المنطقة لاستعراض المندوبين فيها",
                  style: TextStyle(
                    color: Colors.grey.shade600,
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
            width: 40,
            decoration: BoxDecoration(
              color: const Color(0xFF42A5F5),
              borderRadius:
              BorderRadius.circular(10),
            ),
          ),
        ],
      ),
    );
  }

  // =====================================================
  // City Card
  // =====================================================

  Widget _buildCitySmartCard(
      CityModel city,
      int index, {
        required double horizontalPadding,
        required double verticalPadding,
        required double bottomMargin,
        required double radius,
        required double titleFontSize,
        required double subtitleFontSize,
        required double iconContainerPadding,
        required double iconSize,
        required double iconSpacing,
        required double arrowSize,
      }) {
    return Container(
      margin: EdgeInsets.only(
        bottom: bottomMargin,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
        BorderRadius.circular(radius),
        border: Border.all(
          color: Colors.blue.withOpacity(0.05),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color:
            Colors.black.withOpacity(0.04),
            blurRadius: 15,
            offset: const Offset(
              0,
              8,
            ),
          ),
        ],
      ),
      child: InkWell(
        borderRadius:
        BorderRadius.circular(radius),

        // =========================================
        // نفس السلوك الأصلي
        // =========================================
        onTap: () {
          Navigator.pushNamed(
            context,
            Routes.AllRepSenior,
            arguments: city.id,
          );
        },

        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: horizontalPadding,
            vertical: verticalPadding,
          ),
          child: Row(
            children: [
              // ==================================
              // City Icon
              // ==================================
              Container(
                padding: EdgeInsets.all(
                  iconContainerPadding,
                ),
                decoration: BoxDecoration(
                  color: ColorManager
                      .secondaryColor1
                      .withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.location_city,
                  size: iconSize,
                  color:
                  ColorManager.secondaryColor1,
                ),
              ),

              SizedBox(
                width: iconSpacing,
              ),

              // ==================================
              // City Information
              // ==================================
              Expanded(
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    Text(
                      city.title,
                      maxLines: 1,
                      overflow:
                      TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: titleFontSize,
                        fontWeight:
                        FontWeight.bold,
                        color: ColorManager
                            .secondaryColor1,
                      ),
                    ),

                    const SizedBox(
                      height: 3,
                    ),

                    Text(
                      "استعراض كافة البيانات",
                      style: TextStyle(
                        fontSize:
                        subtitleFontSize,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(
                width: 10,
              ),

              // ==================================
              // Arrow
              // ==================================
              Icon(
                Icons.arrow_forward_ios_rounded,
                size: arrowSize,
                color: Colors.grey.shade400,
              ),
            ],
          ),
        ),
      ),
    );
  }
}