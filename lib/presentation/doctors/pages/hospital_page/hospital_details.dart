import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/doctors/widget/hospital/hospital_details_responsive_layout.dart';
import 'package:flutter/material.dart';

class HospitalDetails extends StatelessWidget {
  const HospitalDetails({
    super.key,
    required this.hospital,
  });

  final HospitalSpAllModel hospital;

  @override
  Widget build(BuildContext context) {
    return HospitalDetailsResponsiveLayout(
      hospital: hospital,
    );
  }
}