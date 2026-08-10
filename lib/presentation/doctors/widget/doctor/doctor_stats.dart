import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/doctors/widget/start_card.dart';
import 'package:flutter/material.dart';

class DoctorStats extends StatelessWidget {
  const DoctorStats({
    super.key,
    required this.doctor,
    required this.spacing,
  });

  final DoctorModel doctor;
  final double spacing;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: buildStatCard(
            'الزيارات',
            doctor.visits.toString(),
            Icons.visibility_outlined,
            Colors.blue,
          ),
        ),

        SizedBox(width: spacing),

        Expanded(
          child: buildStatCard(
            'التصنيف',
            doctor.rate ?? '',
            Icons.star_border,
            Colors.orange,
          ),
        ),

        SizedBox(width: spacing),

        Expanded(
          child: buildStatCard(
            'المزارة',
            doctor.visited?.toString() ?? '0',
            Icons.group_outlined,
            Colors.green,
          ),
        ),
      ],
    );
  }
}