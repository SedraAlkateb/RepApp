import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/resources/assets_manager.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/resources/responsive/app_responsive.dart';
import 'package:flutter/material.dart';

class HospitalSpecialtyItem extends StatelessWidget {
  const HospitalSpecialtyItem({
    super.key,
    required this.item,
    required this.deviceType,
  });

  final SpecHospitalSp item;
  final AppDeviceType deviceType;

  @override
  Widget build(BuildContext context) {
    double padding;
    double imageWidth;
    double imageHeight;
    double titleSize;
    double valueSize;

    switch (deviceType) {
      case AppDeviceType.mobilePortrait:
        padding = 14;
        imageWidth = 38;
        imageHeight = 55;
        titleSize = 12;
        valueSize = 14;
        break;

      case AppDeviceType.tabletPortrait:
        padding = 16;
        imageWidth = 42;
        imageHeight = 60;
        titleSize = 13;
        valueSize = 15;
        break;

      case AppDeviceType.tabletLandscape:
        padding = 16;
        imageWidth = 44;
        imageHeight = 62;
        titleSize = 13;
        valueSize = 15;
        break;
    }

    return Container(
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        color: ColorManager.secondaryColor8.withOpacity(0.06),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: ColorManager.secondaryColor7,
        ),
      ),
      child: Row(
        children: [
          // ==========================================
          // Information
          // ==========================================
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _InfoLine(
                  label: 'الاختصاص',
                  value: item.specModel.title.toString(),
                  titleSize: titleSize,
                  valueSize: valueSize,
                ),

                const SizedBox(
                  height: 10,
                ),

                Row(
                  children: [
                    Expanded(
                      child: _InfoLine(
                        label: 'الزيارات',
                        value: item.hospitalSpModel.visit.toString(),
                        titleSize: titleSize,
                        valueSize: valueSize,
                      ),
                    ),

                    const SizedBox(
                      width: 10,
                    ),

                    Expanded(
                      child: _InfoLine(
                        label: 'التصنيف',
                        value: item.hospitalSpModel.rate?.toString() ?? '',
                        titleSize: titleSize,
                        valueSize: valueSize,
                      ),
                    ),
                  ],
                ),

                const SizedBox(
                  height: 8,
                ),

                _InfoLine(
                  label: 'عدد الأطباء',
                  value: item.hospitalSpModel.totalDocs.toString(),
                  titleSize: titleSize,
                  valueSize: valueSize,
                ),
              ],
            ),
          ),

          const SizedBox(
            width: 14,
          ),

          // ==========================================
          // Specialty image
          // ==========================================
          Image.asset(
            ImageAssetsSpec().getImage(
              item.specModel.id,
            ),
            width: imageWidth,
            height: imageHeight,
            fit: BoxFit.contain,
            color: ColorManager.secondaryColor4,
            colorBlendMode: BlendMode.modulate,
            errorBuilder: (
                context,
                error,
                stackTrace,
                ) {
              return SizedBox(
                width: imageWidth,
                height: imageHeight,
                child: const Icon(
                  Icons.medical_services_outlined,
                  color: Colors.grey,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _InfoLine extends StatelessWidget {
  const _InfoLine({
    required this.label,
    required this.value,
    required this.titleSize,
    required this.valueSize,
  });

  final String label;
  final String value;

  final double titleSize;
  final double valueSize;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          label,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.right,
          style: TextStyle(
            fontSize: titleSize,
            color: Colors.grey.shade600,
          ),
        ),

        const SizedBox(
          height: 2,
        ),

        Text(
          value,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.right,
          style: TextStyle(
            fontSize: valueSize,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF0D47A1),
          ),
        ),
      ],
    );
  }
}