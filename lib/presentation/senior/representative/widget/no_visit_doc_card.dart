import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RemainingVisitCard extends StatelessWidget {
  final NoVisitDocModel data;

  const RemainingVisitCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    // المنطق البرمجي: visits هو الإجمالي و remainingVisits هو المنجز
    final int totalVisits = int.tryParse(data.visits ?? '0') ?? 0;
    final int doneVisits = data.remainingVisits ?? 0;

    // حساب نسبة التعبئة
    double progressPercent = totalVisits == 0 ? 0.0 : doneVisits / totalVisits;
    progressPercent = progressPercent.clamp(0.0, 1.0);

    // نص العرض (الإجمالي / المنجز) ليقرأ بالعربي بشكل صحيح
    final String progressLabel = "$totalVisits / $doneVisits";

    return Directionality(
      textDirection: TextDirection.rtl, // لضمان اتجاه الواجهة العربي
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10.h, horizontal: 16.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 15,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(25.r),
          child: IntrinsicHeight(
            child: Row(
              children: [
                // 1. الشريط الجانبي الملون (أصبح على اليمين تماماً)
                Container(
                  width: 5.w,
                  color: ColorManager.medicalSecondary,
                ),

                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(16.w),
                    child: Column(
                      children: [
                        // 2. الهيدر (تم عكسه: الاسم يمين، العداد يسار)
                        _buildHeaderRow(doneVisits),

                     //   SizedBox(height: 12.h),

                        // 3. العنوان (أيقونة الموقع يمين النص)
                     //   _buildAddressRow(),

                        SizedBox(height: 20.h),

                        // 4. شريط الإنجاز
                        _buildProgressBarRow(progressPercent, progressLabel),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // الهيدر المحدث: الاسم يمين والمنجز يسار
  Widget _buildHeaderRow(int done) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // أيقونة المستخدم (يمين)
        _buildProfileIcon(),
        SizedBox(width: 10.w),

        // بيانات الطبيب (يمين الوسط)
        Expanded(
          flex: 5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                data.docTitle,
                style: TextStyle(
                  fontSize: 17.sp,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF0D47A1),
                ),
              ),
              Row(
                children: [
                  Text(
                    data.spTitle,
                    style: TextStyle(fontSize: 13.sp, color: Colors.grey[600]),
                  ),
                  SizedBox(width: 8.w),
                  _buildRateBadge(data.rate),
                ],
              ),
            ],
          ),
        ),

        // العداد الرقمي للمنجز (يسار)
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              "المنجز",
              style: TextStyle(fontSize: 10.sp, color: Colors.grey),
            ),
            Text(
              "$done",
              style: TextStyle(
                fontSize: 26.sp,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF2979FF),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildProgressBarRow(double percent, String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "حالة الإنجاز من الهدف",
              style: TextStyle(fontSize: 11.sp, color: Colors.grey[600]),
            ),
            Text(
              label,
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF0D47A1),
              ),
            ),
          ],
        ),
        SizedBox(height: 8.h),
        ClipRRect(
          borderRadius: BorderRadius.circular(10.r),
          child: LinearProgressIndicator(
            value: percent,
            backgroundColor: const Color(0xFFF1F4F8),
            valueColor: AlwaysStoppedAnimation<Color>(ColorManager.medicalSecondary),
            minHeight: 10.h,
          ),
        ),
      ],
    );
  }

  Widget _buildRateBadge(String rate) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF3E0),
        borderRadius: BorderRadius.circular(5.r),
      ),
      child: Text(
        rate,
        style: TextStyle(
          fontSize: 11.sp,
          color: const Color(0xFFFB8C00),
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildProfileIcon() {
    return Container(
      padding: EdgeInsets.all(8.w),
      decoration: BoxDecoration(
        color: const Color(0xFFF0F4F8),
        shape: BoxShape.circle,
      ),
      child: Icon(
        Icons.person_outline,
        color: const Color(0xFF90A4AE),
        size: 24.sp,
      ),
    );
  }

  Widget _buildAddressRow() {
    return Row(
      children: [
        Icon(Icons.location_on_outlined, size: 16.sp, color: Colors.blue[300]),
        SizedBox(width: 6.w),
        Text(
          data.address,
          style: TextStyle(fontSize: 12.sp, color: Colors.black),
        ),
      ],
    );
  }
}