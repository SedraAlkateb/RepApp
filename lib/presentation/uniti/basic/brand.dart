import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/resources/responsive/app_responsive.dart';
import 'package:domina_app/presentation/uniti/stateWidget.dart';
import 'package:flutter/material.dart';

class BrandListWidget extends StatelessWidget {
  final List brands;
  final bool shrinkWrap;
  final ScrollPhysics? physics;
  final void Function(dynamic brand)? onTap;

  const BrandListWidget({
    super.key,
    required this.brands,
    this.shrinkWrap = false,
    this.physics,
    this.onTap,
    required this.isPr
  });
  final bool isPr;
  @override
  Widget build(BuildContext context) {
    final deviceType = AppResponsive.deviceType(context);

    double listVerticalPadding;

    double cardBottomSpacing;
    double cardPadding;
    double cardRadius;

    double iconBoxSize;
    double iconSize;
    double iconRadius;
    double iconSpacing;

    double titleFontSize;
    double titleSubtitleSpacing;

    double pharmaHorizontalPadding;
    double pharmaVerticalPadding;
    double pharmaRadius;
    double pharmaFontSize;

    switch (deviceType) {
    // =================================================
    // Mobile
    // =================================================
      case AppDeviceType.mobilePortrait:
        listVerticalPadding = 6;
        cardBottomSpacing = 12;
        cardPadding = 16;
        cardRadius = 14;

        iconBoxSize = 44;
        iconSize = 22;
        iconRadius = 10;
        iconSpacing = 12;

        titleFontSize = 15;
        titleSubtitleSpacing = 6;

        pharmaHorizontalPadding = 8;
        pharmaVerticalPadding = 4;
        pharmaRadius = 6;
        pharmaFontSize = 11;
        break;

    // =================================================
    // Tablet Portrait
    // =================================================
      case AppDeviceType.tabletPortrait:
        listVerticalPadding = 8;
        cardBottomSpacing = 14;
        cardPadding = 20;
        cardRadius = 16;

        iconBoxSize = 52;
        iconSize = 26;
        iconRadius = 12;
        iconSpacing = 16;

        titleFontSize = 18;
        titleSubtitleSpacing = 8;

        pharmaHorizontalPadding = 10;
        pharmaVerticalPadding = 5;
        pharmaRadius = 8;
        pharmaFontSize = 13;
        break;

    // =================================================
    // Tablet Landscape
    // =================================================
      case AppDeviceType.tabletLandscape:
        listVerticalPadding = 6;
        cardBottomSpacing = 12;
        cardPadding = 18;
        cardRadius = 16;

        iconBoxSize = 48;
        iconSize = 24;
        iconRadius = 11;
        iconSpacing = 14;

        titleFontSize = 17;
        titleSubtitleSpacing = 7;

        pharmaHorizontalPadding = 10;
        pharmaVerticalPadding = 4;
        pharmaRadius = 8;
        pharmaFontSize = 12;
        break;
    }

    if (brands.isEmpty) {
      return emptyFullScreen(context);
    }

    return ListView.builder(
      padding: EdgeInsets.symmetric(vertical: listVerticalPadding),
      shrinkWrap: shrinkWrap,
      physics: physics,
      itemCount: brands.length,
      itemBuilder: (context, index) {
        final brand = brands[index];

        final String genCoast = (brand.generalCoast == null || brand.generalCoast.toString().trim().isEmpty)
            ? 'غير محدد'
            : brand.generalCoast.toString();

        final String phCoast = (brand.phCoast == null || brand.phCoast.toString().trim().isEmpty)
            ? 'غير محدد'
            : brand.phCoast.toString();

        return Container(
          margin: EdgeInsets.only(bottom: cardBottomSpacing),
          child: Material(
            color: Colors.white, // خلفية بيضاء ناصعة كما في التصميم الأصلي
            borderRadius: BorderRadius.circular(cardRadius),
            elevation: 0,
            child: InkWell(
              borderRadius: BorderRadius.circular(cardRadius),
              onTap: (onTap != null&&isPr==true) ? () => onTap!(brand) : null,
              child: Container(
                padding: EdgeInsets.all(cardPadding),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(cardRadius),
                  border: Border.all(
                    color: ColorManager.inputBorder.withOpacity(0.18),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.03),
                      blurRadius: 10,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // =============================================
                    // الجزء العلوي: الأيقونة والعنوان والشكل الصيدلاني
                    // =============================================
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // أيقونة الصنف بالألوان الخضراء الطبية الأصلية
                        Container(
                          width: iconBoxSize,
                          height: iconBoxSize,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: const Color(0xFFE8F5E9),
                            borderRadius: BorderRadius.circular(iconRadius),
                          ),
                          child: Icon(
                            Icons.medication_outlined,
                            color: const Color(0xFF4CAF50),
                            size: iconSize,
                          ),
                        ),

                        SizedBox(width: iconSpacing),

                        // تفاصيل الاسم والشكل الصيدلاني
                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                brand.title,
                                style: TextStyle(
                                  color: ColorManager.medicalPrimary,
                                  fontWeight: FontWeight.w700,
                                  fontSize: titleFontSize,
                                  height: 1.2,
                                ),
                              ),
                              SizedBox(height: titleSubtitleSpacing),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: pharmaHorizontalPadding,
                                  vertical: pharmaVerticalPadding,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFF5F5F5),
                                  borderRadius: BorderRadius.circular(pharmaRadius),
                                ),
                                child: Text(
                                  brand.phTitle,
                                  style: TextStyle(
                                    color: Colors.grey.shade700,
                                    fontSize: pharmaFontSize,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        isPr?
                        Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: Colors.grey.shade400,
                          size: 14,
                        ):SizedBox(),
                      ],
                    ),

                    const SizedBox(height: 12),

                    // =============================================
                    // شريط الأسعار السفلي المصمم باحترافية
                    // =============================================
                    isPr?
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFAFAFA), // خلفية ناعمة جداً تبرز الأسعار
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: Colors.grey.shade200,
                          width: 0.8,
                        ),
                      ),
                      child: Row(
                        children: [
                          // سعر الصيدلي
                          Expanded(
                            child: Row(
                              children: [
                                Text(
                                  'سعر الصيدلي :',
                                  style: TextStyle(
                                    fontSize: pharmaFontSize,
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                                const SizedBox(width: 4),
                                Flexible(
                                  child: Text(
                                    phCoast,
                                    style: TextStyle(
                                      fontSize: pharmaFontSize + 1,
                                      fontWeight: FontWeight.bold,
                                      color: ColorManager.medicalPrimary,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),


                          // فاصل عمودي ناعم
                          Container(
                            height: 12,
                            width: 1,
                            color: Colors.grey.shade300,
                            margin: const EdgeInsets.symmetric(horizontal: 8),
                          ),
                          // السعر العام
                          Expanded(
                            child: Row(
                              children: [
                                Text(
                                  'سعر العموم:',
                                  style: TextStyle(
                                    fontSize: pharmaFontSize,
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                                const SizedBox(width: 4),
                                Flexible(
                                  child: Text(
                                    genCoast,
                                    style: TextStyle(
                                      fontSize: pharmaFontSize + 1,
                                      fontWeight: FontWeight.bold,
                                      color: ColorManager.medicalPrimary,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),

                        ],
                      ),
                    ):SizedBox(),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}