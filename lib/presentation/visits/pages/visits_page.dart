import 'package:domina_app/app/di.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/resources/routes_manager.dart';
import 'package:domina_app/presentation/visits/bloc/visit_bloc.dart';
import 'package:domina_app/presentation/visits/widget/Doctor_visit_usert.dart';
import 'package:domina_app/presentation/visits/widget/hospital_visit_user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VisitsPage extends StatelessWidget {
  const VisitsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: const Color(0xFFF8F9FB), // الخلفية الفاتحة للتطبيق
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              // الهيدر العلوي (AppBar)
              SliverAppBar(
                elevation: 0,
                pinned: true,
                floating: true,
                snap: true,
                backgroundColor: Colors.white,
                centerTitle: true,
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Color(0xFF0D47A1)),
                  onPressed: () => Navigator.pop(context),
                ),
                title: Text(
                  "سجل الزيارات", // العنوان المناسب للصفحة
                  style: TextStyle(
                    color: const Color(0xFF0D47A1), // الأزرق الداكن المعتمد
                    fontWeight: FontWeight.bold,
                    fontSize: 18.sp,
                  ),
                ),
              ),

              // تصميم الـ TabBar العائم (Capsule Style)
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 12.h),
                  child: Container(
                    height: 55.h,
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
                      padding: const EdgeInsets.all(4),
                      dividerColor: Colors.transparent,
                      labelColor: Colors.white,
                      unselectedLabelColor: Colors.grey.shade400,
                      labelStyle: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 14.sp),
                      indicatorSize: TabBarIndicatorSize.tab,
                      indicator: BoxDecoration(
                        color: ColorManager.medicalPrimary, // اللون الأزرق الرئيسي
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      onTap: (value) {
                        if (value == 0) {
                          BlocProvider.of<VisitBloc>(context).add(VisitDoctorEvent());
                        } else {
                          BlocProvider.of<VisitBloc>(context).add(VisitHospitalEvent());
                        }
                      },
                      tabs: [
                        Tab(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.groups_outlined),
                              SizedBox(width: 8.w),
                              const Text('الأطباء'),
                            ],
                          ),
                        ),
                        Tab(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.local_hospital_outlined),
                              SizedBox(width: 8.w),
                              const Text('المشافي'),
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

          // محتوى التبويبات
          body: TabBarView(
            physics: const NeverScrollableScrollPhysics(),            children: [
              DoctorVisitUser(),
              HospitalVisitUser(),
            ],
          ),
        ),

        // الزر العائم (FAB) بنفس موقع وتصميم التطبيق
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            initAsyncInModule();
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.pushNamed(context, Routes.asyncIn);
            });
          },
          backgroundColor: ColorManager.medicalPrimary, // توحيد اللون
          child: Icon(
            Icons.wifi_protected_setup_outlined,
            color: Colors.white,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.startFloat, // لليسار كما في التصميم
      ),
    );
  }
}