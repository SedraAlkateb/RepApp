import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/resources/responsive/app_ui.dart';
import 'package:flutter/material.dart';

class DropDownNum extends StatelessWidget {
  const DropDownNum({
    super.key,
    required this.hintText,
    required this.items,
    required this.prefixIcon,
    required this.onChanged,
    required this.validator,
    this.width,
    this.value,
    this.onTap,
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

    return SizedBox(
      width: width ?? double.infinity,

      child: DropdownButtonFormField<dynamic>(
        elevation: 4,

        // =====================================================
        // يمنع لون القائمة البني
        // =====================================================
        dropdownColor: Colors.white,

        menuMaxHeight:
        ui.isMobile ? 260 : 300,

        borderRadius: BorderRadius.circular(
          ui.smallRadius + 2,
        ),

        isExpanded: true,

        validator: validator,

        initialValue: value,

        // =====================================================
        // السهم
        // =====================================================
        icon: Icon(
          Icons.keyboard_arrow_down_rounded,
          color: ColorManager.medicalPrimary,
          size: ui.isMobile ? 21 : 23,
        ),

        // =====================================================
        // Hint
        // =====================================================
        hint: Text(
          hintText,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize:
            ui.isMobile ? 13.5 : 14.5,
            fontWeight: FontWeight.w500,
            color: const Color(
              0xFF94A3B8,
            ),
          ),
        ),

        // =====================================================
        // Input Style
        // =====================================================
        decoration: InputDecoration(
          filled: true,

          // بدل secondaryColor3
          fillColor: Colors.white,

          prefixIcon: prefixIcon,

          isDense: true,

          contentPadding:
          EdgeInsets.symmetric(
            horizontal:
            ui.cardPadding,
            vertical:
            ui.isMobile ? 13 : 14,
          ),

          border: OutlineInputBorder(
            borderRadius:
            BorderRadius.circular(
              ui.smallRadius + 2,
            ),
            borderSide: const BorderSide(
              color: Color(
                0xFFE2E8F0,
              ),
            ),
          ),

          enabledBorder:
          OutlineInputBorder(
            borderRadius:
            BorderRadius.circular(
              ui.smallRadius + 2,
            ),
            borderSide: const BorderSide(
              color: Color(
                0xFFE2E8F0,
              ),
            ),
          ),

          focusedBorder:
          OutlineInputBorder(
            borderRadius:
            BorderRadius.circular(
              ui.smallRadius + 2,
            ),
            borderSide: BorderSide(
              color:
              ColorManager.medicalPrimary,
              width: 1.4,
            ),
          ),

          errorBorder:
          OutlineInputBorder(
            borderRadius:
            BorderRadius.circular(
              ui.smallRadius + 2,
            ),
            borderSide: const BorderSide(
              color: Color(
                0xFFEF4444,
              ),
            ),
          ),

          focusedErrorBorder:
          OutlineInputBorder(
            borderRadius:
            BorderRadius.circular(
              ui.smallRadius + 2,
            ),
            borderSide: const BorderSide(
              color: Color(
                0xFFEF4444,
              ),
              width: 1.4,
            ),
          ),

          errorStyle: TextStyle(
            fontSize:
            ui.smallTextSize,
            color: const Color(
              0xFFEF4444,
            ),
          ),
        ),

        // =====================================================
        // Items
        // =====================================================
        items: items.map(
              (dynamic val) {
            return DropdownMenuItem<dynamic>(
              value: val,

              onTap: onTap ?? () {},

              child: Align(
                alignment:
                AlignmentDirectional
                    .centerStart,

                child: Text(
                  val.toString(),

                  maxLines: 1,

                  overflow:
                  TextOverflow.ellipsis,

                  style: TextStyle(
                    // أهم تعديل:
                    // ما عاد يكبر بشكل مبالغ فيه بالتابلت
                    fontSize:
                    ui.isMobile
                        ? 13.5
                        : 14.5,

                    fontWeight:
                    FontWeight.w500,

                    color: const Color(
                      0xFF334155,
                    ),
                  ),
                ),
              ),
            );
          },
        ).toList(),

        // =====================================================
        // نفس السلوك الأصلي
        // =====================================================
        onChanged: onChanged,

        onTap: () {},
      ),
    );
  }
}