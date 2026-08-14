import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/doctors/widget/doctor/doctor_details_responsive_layout.dart';
import 'package:flutter/material.dart';

class DoctorDetails extends StatelessWidget {
  const DoctorDetails({
    super.key,
    required this.doctor,
  });

  final DoctorModel doctor;

  @override
  Widget build(BuildContext context) {
    return DoctorDetailsResponsiveLayout(
      doctor: doctor,
    );
  }
}