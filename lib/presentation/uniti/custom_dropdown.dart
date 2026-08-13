import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/resources/responsive/app_ui.dart';
import 'package:flutter/material.dart';

class CustomDropDown extends StatelessWidget {
  const CustomDropDown({
    super.key,
    required this.hintText,
    required this.items,
    required this.prefixIcon,
    required this.onChanged,
    required this.validator,
    this.width,
    this.value,
    this.onTap,
    required String errorText,
  });

  final String hintText;
  final List<dynamic> items;
  final Icon? prefixIcon;

  final double? width;

  final ValueSetter<dynamic> onChanged;
  final VoidCallback? onTap;

  final FormFieldValidator<dynamic> validator;

  final String? value;

  @override
  Widget build(BuildContext context) {
    final ui = AppUi.of(context);

    // =====================================================
    // Dropdown-specific values
    //
    // القيم العامة من AppUi،
    // فقط ارتفاع الحقل خاص بهذا الـWidget.
    // =====================================================

    final double fieldHeight =
    ui.isMobile
        ? 48
        : ui.isTabletPortrait
        ? 54
        : 50;

    return SizedBox(
      width: width ?? double.infinity,

      child: DropdownButtonFormField<dynamic>(
        elevation: 3,

        // =================================================
        // نفس القيمة الأصلية
        // =================================================
        initialValue: value,

        // =================================================
        // Validator
        // نفس السلوك الأصلي
        // =================================================
        validator: validator,

        // =================================================
        // Dropdown Behavior
        // =================================================
        isExpanded: true,

        menuMaxHeight:
        MediaQuery.sizeOf(context).height * 0.4,

        borderRadius:
        BorderRadius.circular(
          ui.cardRadius,
        ),

        // =================================================
        // Hint
        // =================================================
        hint: Text(
          hintText,

          maxLines: 1,

          overflow:
          TextOverflow.ellipsis,

          style: TextStyle(
            fontSize: ui.bodyTextSize,
            color: const Color(
              0xFF64748B,
            ),
            fontWeight: FontWeight.w500,
          ),
        ),

        // =================================================
        // Input Decoration
        // =================================================
        decoration: InputDecoration(
          filled: true,

          fillColor:
          ColorManager.inputBorder,

          prefixIcon:
          prefixIcon,

          constraints:
          BoxConstraints(
            minHeight:
            fieldHeight,
          ),

          contentPadding:
          EdgeInsets.symmetric(
            horizontal:
            ui.mediumSpacing + 2,

            vertical:
            ui.mediumSpacing,
          ),

          isDense: true,

          // ===============================================
          // Normal Border
          // ===============================================
          enabledBorder:
          OutlineInputBorder(
            borderRadius:
            BorderRadius.circular(
              ui.smallRadius + 2,
            ),

            borderSide:
            const BorderSide(
              color:
              Color(
                0xFFE2E8F0,
              ),
            ),
          ),

          // ===============================================
          // Focused Border
          // ===============================================
          focusedBorder:
          OutlineInputBorder(
            borderRadius:
            BorderRadius.circular(
              ui.smallRadius + 2,
            ),

            borderSide:
            BorderSide(
              color:
              ColorManager
                  .secondaryColor1,

              width:
              1.4,
            ),
          ),

          // ===============================================
          // Error Border
          // ===============================================
          errorBorder:
          OutlineInputBorder(
            borderRadius:
            BorderRadius.circular(
              ui.smallRadius + 2,
            ),

            borderSide:
            const BorderSide(
              color:
              Color(
                0xFFEF4444,
              ),
            ),
          ),

          // ===============================================
          // Focused Error Border
          // ===============================================
          focusedErrorBorder:
          OutlineInputBorder(
            borderRadius:
            BorderRadius.circular(
              ui.smallRadius + 2,
            ),

            borderSide:
            const BorderSide(
              color:
              Color(
                0xFFEF4444,
              ),
              width:
              1.4,
            ),
          ),
        ),

        // =================================================
        // Items
        // =================================================
        items: items.map(
              (dynamic val) {
            return DropdownMenuItem<dynamic>(
              value: val,

              // =============================================
              // نفس onTap الأصلي
              // =============================================
              onTap:
              onTap ?? () {},

              child: Text(
                "${val.name}",

                maxLines: 1,

                softWrap: false,

                overflow:
                TextOverflow.ellipsis,

                style: TextStyle(
                  fontSize:
                  ui.bodyTextSize,

                  color:
                  const Color(
                    0xFF1E293B,
                  ),

                  fontWeight:
                  FontWeight.w500,
                ),
              ),
            );
          },
        ).toList(),

        // =================================================
        // Same Change Behavior
        // =================================================
        onChanged:
        onChanged,

        // =================================================
        // نفس onTap الخارجي الأصلي
        // كان لا ينفذ شيء
        // =================================================
        onTap: () {},
      ),
    );
  }
}