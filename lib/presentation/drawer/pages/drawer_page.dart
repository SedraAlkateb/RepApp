import 'dart:ui';

import 'package:domina_app/app/di.dart';
import 'package:domina_app/app/user_info.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/resources/routes_manager.dart';
import 'package:domina_app/presentation/visits/bloc/visit_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ويدجت لبناء بطاقات الإحصائيات
Widget _buildStatCard(
    String title, String count, Color dotColor, bool showDot) {
  return Expanded(
    child: Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.r),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2)),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (showDot)
                Container(
                    width: 6,
                    height: 6,
                    decoration:
                        BoxDecoration(color: dotColor, shape: BoxShape.circle)),
              if (showDot) SizedBox(width: 4),
              Text(title,
                  style:
                      TextStyle(fontSize: 12.sp, color: Colors.grey.shade700)),
            ],
          ),
          SizedBox(height: 5.h),
          Text(count,
              style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0D47A1))),
        ],
      ),
    ),
  );
}

// ويدجت موحدة لعناصر القائمة لتقليل تكرار الكود
Widget _buildDrawerItem(
    BuildContext context, IconData icon, String title, Function fun) {
  return ListTile(
    leading: Icon(icon, color: ColorManager.secondaryColor4, size: 24.sp),
    title: Text(
      title,
      style: TextStyle(color: ColorManager.secondaryColor1, fontSize: 15.sp),
    ),
    trailing:
        Icon(Icons.arrow_forward_ios, size: 14.sp, color: Colors.grey.shade400),
    onTap: () => fun,
  );
}

class DrawerPage extends StatelessWidget {
  DrawerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      // تغميق خلفية الدراور الكلية قليلاً ليعطي تباين مع الهيدر الأبيض
      // backgroundColor: Colors.grey[50],
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
      ),
      child: Stack(
        children: [
          ClipRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10), // قوة التغبيش
              child: Container(
                // وضع لون أبيض شفاف جداً فوق التغبيش لإعطاء مظهر زجاجي
                color: Colors.white.withOpacity(0.1),
              ),
            ),
          ),
          Column(
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.only(top: 50.h, bottom: 25.h),
                decoration: BoxDecoration(
                  color: ColorManager.medicalBg, // الهيدر يبقى أبيض ليبرز
                  //  borderRadius: BorderRadius.vertical(bottom: Radius.circular(25.r)),
                  border: Border(bottom: BorderSide(color: Colors.black12)),
                ),
                child: Column(
                  children: [
                    Container(
                      width: 80.w,
                      height: 80.w,
                      decoration: BoxDecoration(
                        color: ColorManager.medicalPrimary,
                        borderRadius: BorderRadius.circular(15.r),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        UserInfo.name?[0] ?? "أ",
                        style: TextStyle(
                          fontSize: 35.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 12.h),
                    Text(
                      UserInfo.name ?? "آلاء البني",
                      style: TextStyle(
                        fontSize: 22.sp,
                        fontWeight: FontWeight.bold,
                        color: ColorManager.secondaryColor1,
                      ),
                    ),
                    Text(
                      "مشرف - دمشق", //todo
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.grey[700], // رمادي أغمق للنص
                      ),
                    ),
                    SizedBox(height: 20.h),
                    // البطاقات الإحصائية
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Row(
                        children: [
                          _buildStatCard(
                              "المشافي",
                              UserInfo.numOfHospitalVisit.toString(),
                              Colors.red,
                              true),
                          SizedBox(width: 15.w),
                          _buildStatCard(
                              "الأطباء",
                              UserInfo.numOfDoctorVisit.toString(),
                              Colors.transparent,
                              false),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // --- الجزء المتحرك (Scrollable List) ---
              Expanded(
                child: ListView(
                  padding: EdgeInsets.only(
                      top: 10.h), // مسافة بسيطة بعد الهيدر الثابت
                  children: [
                    // --- العناصر مع الأيقونات المحدثة ---

                    _buildDrawerItem(
                        context,
                        Icons.location_city_outlined, // إجراء زيارة
                        "إجراء زيارة",
                        () => WidgetsBinding.instance.addPostFrameCallback((_) {
                              Navigator.pushNamedAndRemoveUntil(
                                context,
                                Routes.places,
                                (route) => false,
                              );
                            })),

                    _buildDrawerItem(
                      context,
                      Icons.history_outlined, // سجل الزيارات
                      "سجل الزيارات",
                      () {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          Navigator.pushNamed(
                            context,
                            Routes.visits,

                          );
                          BlocProvider.of<VisitBloc>(context)
                              .add(VisitDoctorEvent());
                        });
                      },
                    ),
                    (UserInfo.repType != "7")
                        ? ListTile(
                            focusColor: ColorManager.secondaryColor,
                            minTileHeight: 10,
                            leading: Icon(Icons.list_alt_outlined,
                                color: ColorManager.secondaryColor4),
                            title: Text(
                              'تقارير المندوبين',
                              style: TextStyle(
                                  color: ColorManager.secondaryColor1),
                            ),
                            onTap: () {
                              WidgetsBinding.instance.addPostFrameCallback((_) {
                                Navigator.pushNamedAndRemoveUntil(
                                  context,
                                  Routes.cities,
                                  (route) => false,
                                );
                              });
                            },
                          )
                        : SizedBox(),
                    (UserInfo.repType != "7")
                        ? _buildDrawerItem(
                            context,
                            Icons.person_search_outlined, // البحث عن طبيب
                            "البحث عن طبيب",
                            () => WidgetsBinding.instance
                                    .addPostFrameCallback((_) {
                                  Navigator.pushNamed(
                                    context,
                                    Routes.searchdoctors,
                                  );
                                }))
                        : const SizedBox(),
                    _buildDrawerItem(
                        context,
                        Icons.assignment_outlined, // وصفة طبيب
                        "وصفة طبيب",
                        () => Navigator.pushNamed(
                              context,
                              Routes.doctors,

                            )),

                    _buildDrawerItem(
                        context,
                        Icons.local_hospital_outlined, // وصفة مشفى
                        "وصفة مشفى",
                        () => Navigator.pushNamed(
                              context,
                              Routes.hospital,

                            )),

                    _buildDrawerItem(
                      context,
                      Icons.inventory_2_outlined, // إنشاء طلبية
                      "إنشاء طلبية",
                      () {

                        Navigator.pushNamed(
                          context,
                          Routes.createOrder,

                        );
                      }
                      // أضف المسار هنا لاحقاً
                    ),

                    _buildDrawerItem(
                        context,
                        Icons.grid_view_outlined, // الإختصاصات
                        "الإختصاصات",
                        () => WidgetsBinding.instance.addPostFrameCallback((_) {
                              Navigator.pushNamed(
                                context,
                                Routes.spec,
                              );
                            })),

                    _buildDrawerItem(
                        context,
                        Icons.medication_outlined, // الأصناف الدوائية
                        "الأصناف الدوائية",
                        () => WidgetsBinding.instance.addPostFrameCallback((_) {
                              Navigator.pushNamed(
                                context,
                                Routes.brand,

                              );
                            })),
                    _buildDrawerItem(
                      context,
                      Icons.list_alt_outlined,
                      'الخطط',
                      () {
                        Navigator.pushNamed(
                          context,
                          Routes.brandPlan,
                        );
                      },
                    ),

                    Divider(
                      color: Colors.black12,
                      thickness: 0.5,
                    ),
                    _buildDrawerItem(
                        context,
                        Icons.sync_outlined, // المزامنة
                        "مزامنة البيانات", () {
                      initAsyncInModule();
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        Navigator.pushNamed(
                          context,
                          Routes.asyncIn,
                        );
                      });
                    }),

                    _buildDrawerItem(
                        color: ColorManager.error,
                        context,
                        Icons.logout_outlined, // تسجيل خروج
                        "تسجيل خروج", () {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        Navigator.pushNamed(context, Routes.logout);
                      });
                    }),

                    SizedBox(height: 35.h),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Version 4',
                        style: TextStyle(
                          color: ColorManager.secondaryColor7,
                          fontSize: 12.sp,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // دالة بناء العناصر (ListTile) مع تحسين الألوان
  Widget _buildDrawerItem(
      BuildContext context, IconData icon, String title, VoidCallback onTap,
      {Color? color}) {
    return ListTile(
      leading: Icon(icon,
          color: color ?? Color(0xFF546E7A),
          size: 22.sp), // لون رمادي أغمق للأيقونات
      title: Text(
        title,
        style: TextStyle(
          color: color ?? Color(0xFF37474F), // لون نص أغمق وأوضح
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
      onTap: onTap,
    );
  }

  // دالة بطاقات الإحصائيات (Stat Card) كما هي مع لمسة تظليل بسيطة
  Widget _buildStatCard(
      String title, String count, Color dotColor, bool showDot) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15.r),
          border: Border.all(color: Colors.grey[200]!),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (showDot)
                  Container(
                      width: 6,
                      height: 6,
                      decoration: BoxDecoration(
                          color: dotColor, shape: BoxShape.circle)),
                if (showDot) const SizedBox(width: 4),
                Text(title,
                    style: TextStyle(fontSize: 11.sp, color: Colors.grey[600])),
              ],
            ),
            SizedBox(height: 4.h),
            Text(count,
                style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: ColorManager.secondaryColor1)),
          ],
        ),
      ),
    );
  }
}
