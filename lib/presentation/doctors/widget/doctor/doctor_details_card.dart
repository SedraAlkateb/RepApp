
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/doctors/widget/card.dart';
// ignore: unused_import
import 'package:domina_app/presentation/resources/responsive/app_responsive.dart';
import 'package:flutter/material.dart';

class DoctorDetailsCard extends StatelessWidget {
  const DoctorDetailsCard({
    super.key,
    required this.doctor,
    required this.padding,
  });

  final DoctorModel doctor;
  final double padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.grey.shade200,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.035),
            blurRadius: 14,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          buildInfoRow(
            Icons.location_on_outlined,
            'المنطقة',
            doctor.placeTitle,

          ),

          _divider(),

          buildInfoRow(
            Icons.business_outlined,
            'العنوان',
            doctor.address,

          ),

          _divider(),

          buildInfoRow(
            Icons.medical_services_outlined,
            'الإختصاص',
            doctor.spTitle,

          ),

          _divider(),

          buildInfoRow(
            Icons.work_outline,
            'أوقات العمل',
            doctor.workHours ?? '',

          ),
        ],
      ),
    );
  }

  Widget _divider() {
    return Divider(
      height: 32,
      thickness: 0.6,
      color: Colors.grey.shade200,
    );
  }
}
