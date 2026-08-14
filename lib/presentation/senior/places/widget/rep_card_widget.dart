import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/uniti/unread_visit_widget.dart';
import 'package:flutter/material.dart';

class RepresentativeCard extends StatelessWidget {
  const RepresentativeCard({
    super.key,
    required this.allRepresentative,
    required this.onTap,
  });

  final AllRepresentative allRepresentative;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return PersonProgressCard(
      name:
      allRepresentative.name,

      // number عندك = غير المقروء / المتبقي
      unreadCount:
      allRepresentative.number,

      totalCount:
      allRepresentative.totalVisit ?? 0,

      progressTitle:
      "زيارات الخطة",

      remainingTitle:
      "المتبقية",

      onTap:
      onTap,
    );
  }
}