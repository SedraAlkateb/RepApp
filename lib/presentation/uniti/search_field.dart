import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/resources/responsive/app_responsive.dart';
import 'package:flutter/material.dart';

class SearchField extends StatelessWidget {
  const SearchField({
    super.key,
    required this.searchController,
    this.onPressed,
    this.isIcon,
    this.hintText = 'ابحث هنا',
  });

  final TextEditingController searchController;
  final Function(String)? onPressed;
  final bool? isIcon;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    final deviceType = AppResponsive.deviceType(context);

    double fontSize;
    double iconSize;
    double horizontalPadding;
    double verticalPadding;
    double borderRadius;

    switch (deviceType) {
      case AppDeviceType.mobilePortrait:
        fontSize = 15;
        iconSize = 23;
        horizontalPadding = 16;
        verticalPadding = 14;
        borderRadius = 12;
        break;

      case AppDeviceType.tabletPortrait:
        fontSize = 17;
        iconSize = 26;
        horizontalPadding = 20;
        verticalPadding = 17;
        borderRadius = 14;
        break;

      case AppDeviceType.tabletLandscape:
        fontSize = 16;
        iconSize = 25;
        horizontalPadding = 20;
        verticalPadding = 15;
        borderRadius = 14;
        break;
    }

    return SizedBox(
      width: double.infinity,
      child: Material(
        color: Colors.transparent,
        child: TextFormField(
          controller: searchController,

          textInputAction: TextInputAction.search,

          onChanged: onPressed,

          onFieldSubmitted: onPressed,

          style: TextStyle(
            fontFamily: 'Tajawal',
            fontSize: fontSize,
            color: ColorManager.medicalText,
            fontWeight: FontWeight.w500,
          ),

          decoration: InputDecoration(
            hintText: hintText,

            hintStyle: TextStyle(
              fontFamily: 'Tajawal',
              fontSize: fontSize,
              color: ColorManager.medicalMuted,
              fontWeight: FontWeight.w400,
            ),

            filled: true,
            fillColor: ColorManager.white,

            isDense: true,

            contentPadding: EdgeInsets.symmetric(
              horizontal: horizontalPadding,
              vertical: verticalPadding,
            ),

            suffixIcon: isIcon == true
                ? Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
              ),
              child: Icon(
                Icons.search_rounded,
                color: ColorManager.medicalMuted,
                size: iconSize,
              ),
            )
                : null,

            suffixIconConstraints: BoxConstraints(
              minWidth: iconSize + 30,
              minHeight: iconSize + 20,
            ),

            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                borderRadius,
              ),
              borderSide: BorderSide(
                color: ColorManager.medicalBorder,
                width: 1,
              ),
            ),

            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                borderRadius,
              ),
              borderSide: BorderSide(
                color: ColorManager.medicalBorder,
                width: 1,
              ),
            ),

            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                borderRadius,
              ),
              borderSide: BorderSide(
                color: ColorManager.medicalPrimary,
                width: 1.5,
              ),
            ),

            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                borderRadius,
              ),
              borderSide: const BorderSide(
                color: Colors.red,
                width: 1,
              ),
            ),

            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                borderRadius,
              ),
              borderSide: const BorderSide(
                color: Colors.red,
                width: 1.5,
              ),
            ),
          ),
        ),
      ),
    );
  }
}