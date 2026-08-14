import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/doctors/widget/hospital/hospital_specialty_item.dart';
import 'package:domina_app/presentation/resources/responsive/app_responsive.dart';
import 'package:flutter/material.dart';

class HospitalSpecialtiesCard extends StatelessWidget {
  const HospitalSpecialtiesCard({
    super.key,
    required this.hospitalSp,
    required this.deviceType,
    required this.padding,
  });

  final List<SpecHospitalSp> hospitalSp;
  final AppDeviceType deviceType;
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
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                'معلومات إضافية',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0D47A1),
                ),
              ),
              SizedBox(width: 10),
              Icon(
                Icons.medical_services_outlined,
                color: Colors.blue,
              ),
            ],
          ),

          const SizedBox(
            height: 18,
          ),

          if (hospitalSp.isEmpty)
            const _EmptySpecialties()
          else
            _buildSpecialties(),
        ],
      ),
    );
  }

  Widget _buildSpecialties() {
    switch (deviceType) {
      case AppDeviceType.mobilePortrait:
        return _buildList();

      case AppDeviceType.tabletPortrait:
        return _buildGrid(
          crossAxisCount: 2,
          aspectRatio: 2.4,
        );

      case AppDeviceType.tabletLandscape:
        return _buildGrid(
          crossAxisCount: 2,
          aspectRatio: 2.8,
        );
    }
  }

  Widget _buildList() {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: hospitalSp.length,
      separatorBuilder: (_, __) {
        return const SizedBox(
          height: 12,
        );
      },
      itemBuilder: (context, index) {
        return HospitalSpecialtyItem(
          item: hospitalSp[index],
          deviceType: deviceType,
        );
      },
    );
  }

  Widget _buildGrid({
    required int crossAxisCount,
    required double aspectRatio,
  }) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: hospitalSp.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 14,
        mainAxisSpacing: 14,
        childAspectRatio: aspectRatio,
      ),
      itemBuilder: (context, index) {
        return HospitalSpecialtyItem(
          item: hospitalSp[index],
          deviceType: deviceType,
        );
      },
    );
  }
}

class _EmptySpecialties extends StatelessWidget {
  const _EmptySpecialties();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        vertical: 32,
        horizontal: 16,
      ),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(14),
      ),
      child: const Column(
        children: [
          Icon(
            Icons.medical_information_outlined,
            size: 36,
            color: Colors.grey,
          ),
          SizedBox(height: 10),
          Text(
            'لا توجد اختصاصات',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}