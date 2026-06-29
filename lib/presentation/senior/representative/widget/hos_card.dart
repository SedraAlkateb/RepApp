import 'package:domina_app/domain/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HospitalCardWidget extends StatelessWidget {
  final HospitalSpModel hospital;

  const HospitalCardWidget({super.key, required this.hospital});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24.r), // زوايا أنعم وأكثر عصرية
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24.r),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // السطر العلوي: الأيقونة، الاسم، التخصص، والـ Badges
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.all(10.w),
                        decoration: BoxDecoration(
                          color: const Color(
                              0xFFE0F2F1), // أخضر مائي للمشافي والمراكز
                          borderRadius: BorderRadius.circular(14.r),
                        ),
                        child: Icon(
                          Icons.local_hospital_rounded,
                          color: const Color(0xFF00897B),
                          size: 24.sp,
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    hospital.title ?? "",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.bold,
                                      color: const Color(0xFF1E293B),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 6.w),
                                // شارة التصنيف (Rate) مثل: B
                                if (hospital.rate != null &&
                                    hospital.rate!.isNotEmpty)
                                  _buildBadge(
                                    text: hospital.SpName ?? "عام",
                                    bgColor: const Color(0xFFFEF3C7),
                                    textColor: const Color(0xFFD97706),
                                  ),
                              ],
                            ),
                            SizedBox(height: 4.h),
                            // اختصاص المركز أو المشفى (مثال: غدد)
                            Text(
                              "تصنيف ${hospital.rate}",
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: const Color(
                                    0xFF7C3AED), // لون بنفسجي مميز للاختصاص
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 14.h),

                  // صناديق معلومات المكان، العنوان، والزيارات
                  Row(
                    children: [
                      _buildInfoTile(Icons.location_on_outlined,
                          hospital.placeTitle ?? hospital.placeTitle ?? ""),
                      SizedBox(width: 8.w),
                      // خانة الزيارات التفاعلية المضافة حديثاً
                      _buildInfoTile(
                        Icons.directions_run_rounded,
                        hospital.address ?? "",
                      ),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  // سطر العنوان التفصيلي الكامل (شارع القوتلي مقابل شعبة التجنيد)
                  _buildFullAddressTile(
                      Icons.map_outlined,
                      bgColor: const Color(0xFFF0FDF4),
                      textColor: const Color(0xFF16A34A),
                      iconColor: const Color(0xFF16A34A),
                      "الزيارات: ${hospital.visit ?? '0'}" ?? ""),

                  // قسم الملاحظات الذكي
                  if (hospital.note != null && hospital.note!.isNotEmpty) ...[
                    SizedBox(height: 12.h),
                    Container(
                      padding: EdgeInsets.all(12.w),
                      decoration: BoxDecoration(
                        color: const Color(
                            0xFFFFFBEB), // خلفية صفراء دافئة للتنبيهات والملاحظات
                        borderRadius: BorderRadius.circular(14.r),
                        border: Border.all(color: const Color(0xFFFEF3C7)),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(Icons.info_outline_rounded,
                              size: 18, color: Color(0xFFD97706)),
                          SizedBox(width: 8.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "توجيهات وملاحظات",
                                  style: TextStyle(
                                    fontSize: 11.sp,
                                    fontWeight: FontWeight.bold,
                                    color: const Color(0xFFB45309),
                                  ),
                                ),
                                SizedBox(height: 2.h),
                                Text(
                                  hospital.note!,
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    color: const Color(0xFF451A03),
                                    height: 1.3,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ودجيت لبناء الشارات الصغيرة بجانب الاسم
  Widget _buildBadge(
      {required String text,
      required Color bgColor,
      required Color textColor}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 10.sp,
          fontWeight: FontWeight.bold,
          color: textColor,
        ),
      ),
    );
  }

  // ودجيت مرنة ومحسنة لعرض البيانات السريعة
  Widget _buildInfoTile(
    IconData icon,
    String text, {
    Color bgColor = const Color(0xFFF8FAFC),
    Color textColor = const Color(0xFF475569),
    Color iconColor = const Color(0xFF94A3B8),
  }) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 10.w),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: const Color(0xFFE2E8F0).withOpacity(0.5)),
        ),
        child: Row(
          children: [
            Icon(icon, size: 15, color: iconColor),
            SizedBox(width: 6.w),
            Expanded(
              child: Text(
                text,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: 11.sp,
                    color: textColor,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
      ),
    );
  }

// ودجيت مخصصة للعنوان الطويل لكي لا يختفي بالـ Triple Dots ويعرض النص كاملاً بأمان
  Widget _buildFullAddressTile(
    IconData icon,
    String text, {
    Color bgColor = const Color(0xFFF8FAFC),
    Color textColor = const Color(0xFF475569),
    Color iconColor = const Color(0xFF94A3B8),
  }) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 10.w),
      decoration: BoxDecoration(
        color:
            bgColor, // 👈 تم استخدام المتغير الممرر هنا بدلاً من اللون الثابت
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            size: 15,
            color: iconColor, // 👈 تم استخدام المتغير الممرر هنا للـ Icon
          ),
          SizedBox(width: 6.w),
          Expanded(
            child: Text(
              text.isEmpty ? "لم يحدد العنوان بالتفصيل" : text,
              style: TextStyle(
                fontSize: 11.sp,
                color:
                    textColor, // 👈 تم استخدام المتغير الممرر هنا لنص العنوان
                height: 1.3,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
