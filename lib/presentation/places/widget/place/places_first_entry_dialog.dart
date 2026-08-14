import 'package:domina_app/presentation/resources/responsive/app_responsive.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:flutter/material.dart';

class PlacesFirstEntryDialog extends StatelessWidget {
  const PlacesFirstEntryDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final deviceType = AppResponsive.deviceType(context);

    final maxWidth = switch (deviceType) {
      AppDeviceType.mobilePortrait => 420.0,
      AppDeviceType.tabletPortrait => 520.0,
      AppDeviceType.tabletLandscape => 560.0,
    };

    final horizontalMargin = switch (deviceType) {
      AppDeviceType.mobilePortrait => 20.0,
      AppDeviceType.tabletPortrait => 40.0,
      AppDeviceType.tabletLandscape => 48.0,
    };

    final titleSize = switch (deviceType) {
      AppDeviceType.mobilePortrait => 19.0,
      AppDeviceType.tabletPortrait => 22.0,
      AppDeviceType.tabletLandscape => 22.0,
    };

    return Dialog(
      insetPadding: EdgeInsets.symmetric(
        horizontal: horizontalMargin,
        vertical: 24,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      backgroundColor: ColorManager.white,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: maxWidth,
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            24,
            28,
            24,
            22,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: ColorManager.secondaryColor1.withOpacity(0.08),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.location_on_outlined,
                  size: 34,
                  color: ColorManager.secondaryColor1,
                ),
              ),

              const SizedBox(height: 22),

              Text(
                'اختيار المنطقة',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: titleSize,
                  fontWeight: FontWeight.bold,
                  color: ColorManager.secondaryColor1,
                ),
              ),

              const SizedBox(height: 12),

              Text(
                'اختر إحدى المناطق لإظهار (الأطباء، المشافي) في المنطقة المختارة',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: titleSize - 2,
                  height: 1.6,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),

              const SizedBox(height: 26),

              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorManager.secondaryColor1,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'موافق',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}