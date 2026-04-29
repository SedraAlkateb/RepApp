import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/specialization/bloc/specialization_bloc.dart';
import 'package:domina_app/presentation/specialization/pages/doctor_sp.dart';
import 'package:domina_app/presentation/specialization/pages/hospital_sp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SpecDH extends StatelessWidget {
  const SpecDH({super.key, required this.spId});
  final int spId;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: const Color(0xFFF8F9FB), // لون الخلفية الموحد للتطبيق
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              // الهيدر العلوي
              SliverAppBar(
                elevation: 0,
                pinned: true,
                floating: true,
                snap: true,
                backgroundColor: Colors.white,
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Color(0xFF0D47A1)),
                  onPressed: () => Navigator.pop(context),
                ),
                title: Text(
                  "قائمة الاختصاصات", // أو أي عنوان تفضله
                  style: TextStyle(
                    color: const Color(0xFF0D47A1),
                    fontWeight: FontWeight.bold,
                    fontSize: 18.sp,
                  ),
                ),
              ),
              // تصميم الـ TabBar العائم داخل الحاوية البيضاء
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 12.h),
                  child: Container(
                    height: 55.h, // ارتفاع مناسب
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
                          BlocProvider.of<SpecializationBloc>(context)
                              .add(DoctorSpEvent(spId));
                        } else {
                          BlocProvider.of<SpecializationBloc>(context)
                              .add(HospitalSpEvent(spId));
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
          // محتوى الصفحات
          body: TabBarView(
            physics: const NeverScrollableScrollPhysics(),            children: [
              DoctorSp(),
              HospitalSp(),
            ],
          ),
        ),
      ),
    );
  }
}