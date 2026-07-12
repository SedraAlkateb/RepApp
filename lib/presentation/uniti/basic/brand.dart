import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/uniti/stateWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BrandListWidget extends StatelessWidget {
  final List<BrandModel> brands;
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
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w,vertical: 12.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "قائمة الاصناف",
                style: TextStyle(
                    color: ColorManager.medicalText
                        .withOpacity(0.8),
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: 12.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: ColorManager.medicalPrimary
                      .withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  " ${brands.length} صنف",
                  style: TextStyle(
                      color: ColorManager.medicalPrimary,
                      fontSize: 11.sp),
                ),
              ),
            ],
          ),
        ),
       brands.isEmpty?emptyFullScreen(context):
        ListView.builder(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: brands.length,
          itemBuilder: (context, index) {
            final brand = brands[index];
            return Container(
              margin: EdgeInsets.only(bottom: 12.h),
              padding: EdgeInsets.all(15.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
                border: Border.all(color: ColorManager.inputBorder.withOpacity(0.2)),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center, // توسيط الأيقونة مع المحتوى الجانبي
                children: [
                  // 1. أيقونة الدواء
                  Container(
                    padding: EdgeInsets.all(10.w),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE8F5E9),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Icon(
                      Icons.medication_outlined,
                      color: const Color(0xFF4CAF50),
                      size: 24.sp,
                    ),
                  ),
                  SizedBox(width: 12.w),

                  // 2. المحتوى النصي (الاسم وتحته التصنيف)
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          brand.title,
                          // أزلنا maxLines و ellipsis لكي يأخذ راحته في النزول لسطر جديد
                          style: TextStyle(
                            color: ColorManager.medicalPrimary,
                            fontWeight: FontWeight.bold,
                            fontSize: 16.sp,
                          ),
                        ),
                        SizedBox(height: 6.h), // مسافة بسيطة بين الاسم والتصنيف

                        // 3. الشكل الصيدلاني (ينزل تحت تلقائياً لأنه داخل Column)
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF5F5F5),
                            borderRadius: BorderRadius.circular(6.r),
                          ),
                          child: Text(
                            brand.phTitle,
                            style: TextStyle(
                              color: Colors.grey[700],
                              fontSize: 11.sp,
                              fontWeight: FontWeight.w500,
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
        ),
      ],
    );
  }
}