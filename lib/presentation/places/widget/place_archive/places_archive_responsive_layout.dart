import 'package:domina_app/presentation/places/widget/place_archive/places_archive_content.dart';
import 'package:domina_app/presentation/resources/responsive/app_responsive.dart';
import 'package:flutter/material.dart';

class PlacesArchiveResponsiveLayout extends StatelessWidget {
  final TextEditingController searchController;

  const PlacesArchiveResponsiveLayout({
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

    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: pageMaxWidth,
        ),
        child: PlacesArchiveContent(
          searchController: searchController,
          horizontalPadding: horizontalPadding,
          searchMaxWidth: searchMaxWidth,
          listMaxWidth: listMaxWidth,
        ),
      ),
    );
  }
}