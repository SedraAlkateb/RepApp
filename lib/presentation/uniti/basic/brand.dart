import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/resources/responsive/app_responsive.dart';
import 'package:domina_app/presentation/uniti/stateWidget.dart';
import 'package:flutter/material.dart';

class BrandListWidget extends StatelessWidget {
  final List brands;
  final bool shrinkWrap;
  final ScrollPhysics? physics;

  const BrandListWidget({
    super.key,
    required this.brands,
    this.shrinkWrap = false,
    this.physics,
  });

  @override
  Widget build(BuildContext context) {
    final deviceType =
    AppResponsive.deviceType(context);

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
        cardPadding = 15;
        cardRadius = 16;

        iconBoxSize = 46;
        iconSize = 23;
        iconRadius = 12;
        iconSpacing = 12;

        titleFontSize = 16;
        titleSubtitleSpacing = 6;

        pharmaHorizontalPadding = 8;
        pharmaVerticalPadding = 4;
        pharmaRadius = 7;
        pharmaFontSize = 11;
        break;

    // =================================================
    // Tablet Portrait
    // =================================================
      case AppDeviceType.tabletPortrait:
        listVerticalPadding = 8;

        cardBottomSpacing = 14;
        cardPadding = 20;
        cardRadius = 18;

        iconBoxSize = 54;
        iconSize = 27;
        iconRadius = 14;
        iconSpacing = 16;

        titleFontSize = 19;
        titleSubtitleSpacing = 8;

        pharmaHorizontalPadding = 10;
        pharmaVerticalPadding = 5;
        pharmaRadius = 9;
        pharmaFontSize = 13;
        break;

    // =================================================
    // Tablet Landscape
    // =================================================
      case AppDeviceType.tabletLandscape:
        listVerticalPadding = 6;

        cardBottomSpacing = 12;
        cardPadding = 18;
        cardRadius = 18;

        iconBoxSize = 50;
        iconSize = 25;
        iconRadius = 13;
        iconSpacing = 14;

        titleFontSize = 18;
        titleSubtitleSpacing = 7;

        pharmaHorizontalPadding = 10;
        pharmaVerticalPadding = 4;
        pharmaRadius = 8;
        pharmaFontSize = 12;
        break;
    }

    // =====================================================
    // Empty
    // =====================================================
    if (brands.isEmpty) {
      return emptyFullScreen(
        context,
      );
    }

    // =====================================================
    // Brands List
    // =====================================================
    return ListView.builder(
      padding: EdgeInsets.symmetric(
        vertical: listVerticalPadding,
      ),

      // نفس الخصائص الموجودة بالـ widget
      shrinkWrap: shrinkWrap,
      physics: physics,

      itemCount: brands.length,

      itemBuilder: (context, index) {
        final brand = brands[index];

        return Container(
          margin: EdgeInsets.only(
            bottom: cardBottomSpacing,
          ),

          padding: EdgeInsets.all(
            cardPadding,
          ),

          decoration: BoxDecoration(
            color: Colors.white,

            borderRadius:
            BorderRadius.circular(
              cardRadius,
            ),

            border: Border.all(
              color: ColorManager.inputBorder
                  .withOpacity(0.18),
            ),

            boxShadow: [
              BoxShadow(
                color:
                Colors.black.withOpacity(
                  0.03,
                ),
                blurRadius: 12,
                offset: const Offset(
                  0,
                  4,
                ),
              ),
            ],
          ),

          child: Row(
            crossAxisAlignment:
            CrossAxisAlignment.center,
            children: [
              // =============================================
              // Brand Icon
              // =============================================
              Container(
                width: iconBoxSize,
                height: iconBoxSize,

                alignment: Alignment.center,

                decoration: BoxDecoration(
                  color: const Color(
                    0xFFE8F5E9,
                  ),

                  borderRadius:
                  BorderRadius.circular(
                    iconRadius,
                  ),
                ),

                child: Icon(
                  Icons.medication_outlined,
                  color: const Color(
                    0xFF4CAF50,
                  ),
                  size: iconSize,
                ),
              ),

              SizedBox(
                width: iconSpacing,
              ),

              // =============================================
              // Brand Data
              // =============================================
              Expanded(
                child: Column(
                  mainAxisSize:
                  MainAxisSize.min,
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    // =========================================
                    // Brand name
                    // =========================================
                    Text(
                      brand.title,

                      // خليته ياخد راحته مثل كودك الأصلي
                      // بدون ellipsis
                      style: TextStyle(
                        color: ColorManager
                            .medicalPrimary,
                        fontWeight:
                        FontWeight.w700,
                        fontSize:
                        titleFontSize,
                        height: 1.3,
                      ),
                    ),

                    SizedBox(
                      height:
                      titleSubtitleSpacing,
                    ),

                    // =========================================
                    // Pharmaceutical Form
                    // =========================================
                    Container(
                      padding:
                      EdgeInsets.symmetric(
                        horizontal:
                        pharmaHorizontalPadding,
                        vertical:
                        pharmaVerticalPadding,
                      ),

                      decoration:
                      BoxDecoration(
                        color: const Color(
                          0xFFF5F5F5,
                        ),

                        borderRadius:
                        BorderRadius.circular(
                          pharmaRadius,
                        ),
                      ),

                      child: Text(
                        brand.phTitle,
                        style: TextStyle(
                          color: Colors
                              .grey.shade700,
                          fontSize:
                          pharmaFontSize,
                          fontWeight:
                          FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}