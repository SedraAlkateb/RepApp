import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/doctors/widget/start_card.dart';
import 'package:flutter/material.dart';

class HospitalStats extends StatelessWidget {
  const HospitalStats({
    super.key,
    required this.hospital,
    required this.spacing,
  });

  final HospitalSpAllModel hospital;
  final double spacing;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: buildStatCard(
            'الزيارات',
            hospital.visit.toString(),
            Icons.visibility_outlined,
            Colors.blue,
          ),
        ),

        SizedBox(
          width: spacing,
        ),

        Expanded(
          child: buildStatCard(
            'التصنيف',
            hospital.rate ?? '',
            Icons.star_border,
            Colors.orange,
          ),
        ),

        SizedBox(
          width: spacing,
        ),

        Expanded(
          child: buildStatCard(
            'الأطباء',
            hospital.totalDocs.toString(),
            Icons.group_outlined,
            Colors.green,
          ),
        ),
      ],
    );
  }
}