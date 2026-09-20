import 'package:domina_app/presentation/places/widget/place_archive/places_archive_content.dart';
import 'package:domina_app/presentation/resources/responsive/app_ui.dart';
import 'package:flutter/material.dart';

class PlacesArchiveResponsiveLayout extends StatelessWidget {
  const PlacesArchiveResponsiveLayout({
    super.key,
    required this.searchController,
  });

  final TextEditingController searchController;

  @override
  Widget build(BuildContext context) {
    final ui = AppUi.of(context);

    final double contentMaxWidth =
    ui.isTabletLandscape ? 760 : ui.pageMaxWidth;

    final double contentInnerMaxWidth =
    ui.isMobile
        ? contentMaxWidth
        : ui.isTabletPortrait
        ? 720
        : 760;

    return ColoredBox(
      color: const Color(0xFFF8FAFC),
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: contentMaxWidth,
          ),
          child: PlacesArchiveContent(
            searchController: searchController,
            horizontalPadding: ui.pagePadding,
            searchMaxWidth: contentInnerMaxWidth,
            listMaxWidth: contentInnerMaxWidth,
          ),
        ),
      ),
    );
  }
}