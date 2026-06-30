import 'package:domina_app/app/user_info.dart';
import 'package:domina_app/presentation/brand_plan/pages/spec_plan_page.dart';
import 'package:domina_app/presentation/brand_plan/pages/brand_plan_active_page.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:flutter/material.dart';
// تم إضافة flutter_screenutil لتوحيد المقاييس مع التصميم الجديد
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BrandPlanPage extends StatelessWidget {
  const BrandPlanPage({super.key});

  @override
  Widget build(BuildContext context) {
    // الاحتفاظ بعمليات الطباعة للتأكد من القيم
    print(UserInfo.otherstatus);
    print(UserInfo.flag);

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        // استخدام لون الخلفية الموحد الفاتح
        backgroundColor: const Color(0xFFF8F9FB),
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              // 1. الهيدر العلوي (SliverAppBar)
              SliverAppBar(
                elevation: 0,
                pinned: true, // يبقى مثبت عند التمرير
                floating: true, // يظهر بمجرد السحب للأسفل
                snap: true,
                backgroundColor: Colors.white, // خلفية بيضاء للهيدر
                // يمكنك إلغاء تعليق leading إذا أردت زر رجوع مخصص
                // leading: IconButton(
                //   icon: const Icon(Icons.arrow_back, color: Color(0xFF0D47A1)),
                //   onPressed: () => Navigator.pop(context),
                // ),
                title: Text(
                  "خطة المندوب", // عنوان الصفحة
                  style: TextStyle(
                    color: const Color(0xFF0D47A1), // اللون الأزرق الداكن للعنوان
                    fontWeight: FontWeight.bold,
                    fontSize: 18.sp,
                  ),
                ),
                centerTitle: true,
              ),

              // 2. تصميم الـ TabBar العائم داخل حاوية بيضاء (Contained Style)
              SliverToBoxAdapter(
                child: Padding(
                  // نفس المسافات من التصميم المثال
                  padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 12.h),
                  child: Container(
                    height: 55.h, // الارتفاع الموحد للـ TabBar
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15.r),
                      border: Border.all(color: Colors.grey.shade200),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.02),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: TabBar(
                      padding: const EdgeInsets.all(4), // مسافة داخلية للمؤشر
                      dividerColor: Colors.transparent, // إخفاء الخط الفاصل الافتراضي
                      labelColor: Colors.white, // لون نص التبويب المحدد
                      unselectedLabelColor: Colors.grey.shade400, // لون نص التبويب غير المحدد
                      labelStyle: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 14.sp),
                      indicatorSize: TabBarIndicatorSize.tab,
                      // تصميم المؤشر الخلفي الأزرق
                      indicator: BoxDecoration(
                        color: ColorManager.medicalPrimary, // افترضت أن هذا هو اللون الأزرق الرئيسي في تطبيفك
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      tabs: [
                        // التبويب الأول
                        Tab(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.list_alt_outlined),
                              SizedBox(width: 8.w),
                              const Text("الخطة الحالية"),
                            ],
                          ),
                        ),
                        // التبويب الثاني
                        Tab(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.featured_play_list_outlined),
                              SizedBox(width: 8.w),
                              const Text('قيد المعالجة'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ];
          },
          // 3. محتوى الصفحات
          body: TabBarView(
            physics: const NeverScrollableScrollPhysics(),            // تغيير الفيزكس لتصبح ارتدادية وسلسة
        //    physics: const BouncingScrollPhysics(),
            children: [
              BrandPlanActivePage(),
              SpecPlanPage(),
            ],
          ),
        ),
      ),
    );
  }
}