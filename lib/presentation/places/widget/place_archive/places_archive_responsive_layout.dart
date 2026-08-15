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

    // =========================================================
    // عرض الصفحة
    // نفس النمط المعتمد لباقي صفحات الـ List
    // =========================================================
    final double contentMaxWidth =
    ui.isTabletLandscape
        ? 760
        : ui.pageMaxWidth;

    // =========================================================
    // عرض البحث والقائمة
    // قيم خاصة بهالصفحة فقط، لذلك ما منضيفها لـ AppUi
    // =========================================================
    final double contentInnerMaxWidth =
    ui.isMobile
        ? contentMaxWidth
        : ui.isTabletPortrait
        ? 720
        : 760;

    return ColoredBox(
      color: const Color(
        0xFFF8FAFC,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: contentMaxWidth,
          ),
          child: PlacesArchiveContent(
            searchController: searchController,

            // =================================================
            // Responsive values من AppUi
            // =================================================
            horizontalPadding:
            ui.pagePadding,

            searchMaxWidth:
            contentInnerMaxWidth,

            listMaxWidth:
            contentInnerMaxWidth,
          ),
        ),
      ),
    );
  }
}