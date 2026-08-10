import 'package:domina_app/app/di/di.dart';
import 'package:domina_app/presentation/places/widget/place/places_content.dart';
import 'package:domina_app/presentation/resources/responsive/app_responsive.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/resources/routes_manager.dart';
import 'package:flutter/material.dart';

class PlacesResponsiveLayout extends StatelessWidget {
  final TextEditingController searchController;

  const PlacesResponsiveLayout({
    super.key,
    required this.searchController,
  });

  @override
  Widget build(BuildContext context) {
    final deviceType = AppResponsive.deviceType(context);

    double pageMaxWidth;
    double listMaxWidth;
    double searchMaxWidth;
    double horizontalPadding;

    switch (deviceType) {
      case AppDeviceType.mobilePortrait:
        pageMaxWidth = 600;
        listMaxWidth = 600;
        searchMaxWidth = 600;
        horizontalPadding = 16;
        break;

      case AppDeviceType.tabletPortrait:
        pageMaxWidth = 900;
        listMaxWidth = 720;
        searchMaxWidth = 720;
        horizontalPadding = 28;
        break;

      case AppDeviceType.tabletLandscape:
        pageMaxWidth = 1200;
        listMaxWidth = 780;
        searchMaxWidth = 780;
        horizontalPadding = 32;
        break;
    }

    return Stack(
      children: [
        Positioned.fill(
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: pageMaxWidth,
              ),
              child: PlacesContent(
                searchController: searchController,
                horizontalPadding: horizontalPadding,
                searchMaxWidth: searchMaxWidth,
                listMaxWidth: listMaxWidth,
              ),
            ),
          ),
        ),

        Positioned(
          left: deviceType == AppDeviceType.mobilePortrait ? 18 : 30,
          bottom: deviceType == AppDeviceType.mobilePortrait ? 18 : 30,
          child: SafeArea(
            child: FloatingActionButton(
              heroTag: 'places_sync_fab',
              backgroundColor: ColorManager.secondaryColor1,
              onPressed: () {
                initAsyncInModule();

                Navigator.pushNamed(
                  context,
                  Routes.asyncIn,
                );
              },
              child: Icon(
                Icons.wifi_protected_setup_outlined,
                color: ColorManager.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}