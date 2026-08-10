import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/doctors/widget/card.dart';
import 'package:flutter/material.dart';

class HospitalDetailsCard extends StatelessWidget {
  const HospitalDetailsCard({
    super.key,
    required this.hospital,
    required this.padding,
  });

  final HospitalSpAllModel hospital;
  final double padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(
        padding,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        border: Border.all(
          color: Colors.grey.shade200,
        ),
      ),
      child: Column(
        children: [
          buildInfoRow(
            Icons.location_on_outlined,
            'المنطقة',
            hospital.placeTitle ?? '',
          ),

          const Divider(
            height: 30,
            thickness: 0.1,
          ),

          buildInfoRow(
            Icons.business_outlined,
            'العنوان',
            hospital.address ?? '',
          ),

          const Divider(
            height: 30,
            thickness: 0.1,
          ),

          buildInfoRow(
            Icons.medical_services_outlined,
            'الإختصاص',
            hospital.titleSp ?? '',
          ),
        ],
      ),
    );
  }
}