import 'package:custom_dropdown_search/custom_dropdown_search.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/resources/responsive/app_ui.dart';
import 'package:flutter/material.dart';

class DropDownRecipesSearch extends StatelessWidget {
  const DropDownRecipesSearch({
    super.key,
    required this.validator,
    required this.onChanged,
    required this.items,
    required this.hintText,
    this.icon,
    this.brandRes,
  });

  final FormFieldValidator<dynamic> validator;
  final ValueSetter<dynamic> onChanged;
  final List<dynamic> items;
  final String hintText;
  final Icon? icon;
  final dynamic brandRes;

  @override
  Widget build(BuildContext context) {
    final ui = AppUi.of(context);

    return SizedBox(
      width: double.infinity,
      child: DropdownSearch<dynamic>(
        // =====================================================
        // نفس طريقة عرض العنصر الأصلية
        // =====================================================
        itemAsString: (dynamic item) {
          return item.title_en;
        },

        validator: validator,
        selectedItem: brandRes,

        // =====================================================
        // Popup
        // =====================================================
        popupProps: PopupProps.menu(
          showSearchBox: true,

          itemBuilder: (
              context,
              item,
              isSelected,
              ) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  dense: ui.isMobile,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: ui.cardPadding,
                    vertical: ui.smallSpacing / 2,
                  ),
                  title: Text(
                    item.title_en,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: ui.isMobile ? 14 : 16,
                      fontWeight: isSelected
                          ? FontWeight.w700
                          : FontWeight.w500,
                      color: isSelected
                          ? ColorManager.medicalPrimary
                          : const Color(0xFF334155),
                    ),
                  ),
                  onTap: () {
                    // =============================================
                    // نفس onChanged الأصلي
                    // =============================================
                    onChanged(item);
                  },
                ),

                const Divider(
                  height: 1,
                  thickness: 1,
                  color: Color(
                    0xFFE9EEF3,
                  ),
                ),
              ],
            );
          },

          // =====================================================
          // Search Field
          // =====================================================
          searchFieldProps: TextFieldProps(
            decoration: InputDecoration(
              isDense: true,

              hintText: 'ابحث هنا',

              hintStyle: TextStyle(
                fontSize: ui.isMobile ? 14 : 16,
                color: const Color(
                  0xFF94A3B8,
                ),
                fontWeight: FontWeight.w500,
              ),

              prefixIcon: Icon(
                Icons.search_rounded,
                size: ui.iconSize,
                color: const Color(
                  0xFF94A3B8,
                ),
              ),

              filled: true,
              fillColor: const Color(
                0xFFF8FAFC,
              ),

              contentPadding: EdgeInsets.symmetric(
                horizontal: ui.cardPadding,
                vertical: ui.mediumSpacing + 2,
              ),

              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  ui.smallRadius + 2,
                ),
                borderSide: const BorderSide(
                  color: Color(
                    0xFFE2E8F0,
                  ),
                ),
              ),

              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  ui.smallRadius + 2,
                ),
                borderSide: const BorderSide(
                  color: Color(
                    0xFFE2E8F0,
                  ),
                ),
              ),

              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  ui.smallRadius + 2,
                ),
                borderSide: BorderSide(
                  color: ColorManager.medicalPrimary,
                  width: 1.5,
                ),
              ),
            ),
          ),
        ),

        items: items,

        // =====================================================
        // Closed Dropdown
        // =====================================================
        dropdownDecoratorProps: DropDownDecoratorProps(
          baseStyle: TextStyle(
            fontSize: ui.isMobile ? 14 : 16,
            color: const Color(
              0xFF334155,
            ),
            fontWeight: FontWeight.w500,
            overflow: TextOverflow.ellipsis,
          ),

          dropdownSearchDecoration: InputDecoration(
            icon: icon,

            hintText: hintText,

            hintStyle: TextStyle(
              fontSize: ui.isMobile ? 14 : 16,
              color: const Color(
                0xFF94A3B8,
              ),
              fontWeight: FontWeight.w500,
              overflow: TextOverflow.ellipsis,
            ),

            labelStyle: TextStyle(
              fontSize: ui.isMobile ? 14 : 16,
              color: const Color(
                0xFF334155,
              ),
              fontWeight: FontWeight.w500,
              overflow: TextOverflow.ellipsis,
            ),

            filled: true,
            fillColor: Colors.white,

            contentPadding: EdgeInsets.symmetric(
              horizontal: ui.cardPadding,
              vertical: ui.mediumSpacing + 3,
            ),

            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                ui.smallRadius + 2,
              ),
              borderSide: const BorderSide(
                color: Color(
                  0xFFE2E8F0,
                ),
              ),
            ),

            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                ui.smallRadius + 2,
              ),
              borderSide: const BorderSide(
                color: Color(
                  0xFFE2E8F0,
                ),
              ),
            ),

            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                ui.smallRadius + 2,
              ),
              borderSide: BorderSide(
                color: ColorManager.medicalPrimary,
                width: 1.5,
              ),
            ),

            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                ui.smallRadius + 2,
              ),
              borderSide: const BorderSide(
                color: Color(
                  0xFFEF4444,
                ),
              ),
            ),

            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                ui.smallRadius + 2,
              ),
              borderSide: const BorderSide(
                color: Color(
                  0xFFEF4444,
                ),
                width: 1.5,
              ),
            ),
          ),
        ),

        // =====================================================
        // نفس callback الأصلي
        // =====================================================
        onChanged: onChanged,
      ),
    );
  }
}