import 'package:domina_app/presentation/places/widget/place_visit_archive/place_visit_archive_responsive_layout.dart';
import 'package:flutter/material.dart';

class PlaceVisitArchivePage extends StatelessWidget {
  const PlaceVisitArchivePage({
    super.key,
    required this.placeId,
  });

  final int placeId;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: const Color(0xFFF8FAFC),
        body: PlaceVisitArchiveResponsiveLayout(
          placeId: placeId,
        ),
      ),
    );
  }
}