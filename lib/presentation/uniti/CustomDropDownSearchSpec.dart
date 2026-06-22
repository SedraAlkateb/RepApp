import 'package:custom_dropdown_search/custom_dropdown_search.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Customdropdownsearchspec extends StatelessWidget {
  const Customdropdownsearchspec({
    Key? key,
    required this.validator,
    required this.onChanged,
    required this.items,
    this.icon,
    required this.hintText,
    required this.errorText,
  }) : super(key: key);

  final FormFieldValidator<dynamic> validator;
  final ValueSetter<dynamic> onChanged;
  final List<dynamic> items;
  final String hintText;
  final String? errorText;
  final Icon? icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.r),
      ),
      width: MediaQuery.of(context).size.width,
      child: DropdownSearch<dynamic>(
        itemAsString: (dynamic value) => value.specModel.title,
        validator: validator,
        popupProps: PopupProps.menu(
          // 1. تحديد حد أقصى لارتفاع القائمة لكي لا تظهر طويلة جداً ومزعجة 📐
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.4, // أقصى ارتفاع 40% من حجم الشاشة
          ),

          // 2. تعديل الـ itemBuilder ليعيد الـ Widget فقط بدون onTap يدوي 🛑
          itemBuilder: (context, item, isSelected) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // تقييم التخصص/المشفى على اليسار
                      Row(
                        children: [
                          Icon(Icons.star, color: Colors.amber, size: 16.sp),
                          SizedBox(width: 4.w),
                          Text(
                            '${item.hospitalSpModel.rate}',
                            style: TextStyle(fontSize: 13.sp, color: Colors.grey[700]),
                          ),
                        ],
                      ),
                      // اسم التخصص على اليمين متناسق مع لغة التطبيق العربي
                      Expanded(
                        child: Text(
                          '${item.specModel.title}',
                          textAlign: TextAlign.end,
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                            color: isSelected ? ColorManager.medicalPrimary : Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(color: Colors.grey[200], height: 1.h, thickness: 1),
              ],
            );
          },
          showSearchBox: true,
          searchFieldProps: TextFieldProps(
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey[50],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
                borderSide: BorderSide(color: Colors.grey.shade200),
              ),
              isDense: true,
              hintText: 'ابحث هنا...',
              hintStyle: TextStyle(fontSize: 13.sp, color: Colors.grey),
              prefixIcon: Icon(Icons.search, size: 20.sp, color: ColorManager.black),
            ),
          ),
        ),
        items: items,
        dropdownDecoratorProps: DropDownDecoratorProps(
          baseStyle: TextStyle(fontSize: 14.sp, overflow: TextOverflow.fade),
          dropdownSearchDecoration: InputDecoration(
            icon: icon,
            labelStyle: TextStyle(fontSize: 14.sp, overflow: TextOverflow.fade),
            hintText: hintText,
            hintStyle: TextStyle(fontSize: 12.sp, overflow: TextOverflow.fade),
            contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
          ),
        ),
        // 3. هنا يتم معالجة الاختيار بشكل تلقائي وسليم ومستقر عبر المكتبة نفسها 🚀
        onChanged: onChanged,
      ),
    );
  }
}