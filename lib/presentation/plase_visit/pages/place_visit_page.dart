import 'package:domina_app/presentation/plase_visit/bloc/visit_place_bloc.dart';
import 'package:domina_app/presentation/plase_visit/widget/doctor_visit.dart';
import 'package:domina_app/presentation/plase_visit/widget/hospital_visit.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PlaceVisitPage extends StatelessWidget {
  const PlaceVisitPage({super.key, required this.placeId});
  final int placeId;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(

        body: NestedScrollView(
          // هذا الجزء يسمح للـ Header (الـ AppBar والـ TabBar) بالتحرك مع السكرول
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(

                elevation: 0,
                pinned: false, // اجعله false ليختفي الـ AppBar عند السكرول
                floating: true, // يظهر بمجرد السحب لأسفل قليلاً
                snap: true, // يكمل الظهور تلقائياً
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Color(0xFF0D47A1)),
                  onPressed: () => Navigator.pop(context),
                ),
                title: Text(
                  "قائمة الزيارات",
                  style: TextStyle(
                    color: const Color(0xFF0D47A1),
                    fontWeight: FontWeight.bold,
                    fontSize: 18.sp,
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 12.h),
                  child: Container(
                    height: 60,
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
                      padding: const EdgeInsets.all(3),
                      dividerColor: Colors.transparent,
                      labelColor: Colors.white,
                      unselectedLabelColor: Colors.grey,
                      labelStyle: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 14.sp),
                      labelPadding: EdgeInsets.zero,
                      indicatorSize: TabBarIndicatorSize.tab,
                      indicator: BoxDecoration(
                        color: ColorManager.medicalPrimary,
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      onTap: (value) {
                        if (value == 0) {
                          BlocProvider.of<VisitPlaceBloc>(context)
                              .add(DoctorByPlace(placeId, 0));
                        } else {
                          BlocProvider.of<VisitPlaceBloc>(context)
                              .add(HospitalByPlace(placeId, 1));
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
                                ])),
                        Tab(
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(Icons.local_hospital_outlined),
                                  SizedBox(width: 8.w),
                                  const Text('المشافي'),
                                ])),
                      ],
                    ),
                  ),
                ),
              ),
            ];
          },
          // محتوى الصفحات تحت الـ TabBar
          body: TabBarView(
            physics: const NeverScrollableScrollPhysics(),            children: [
              DoctorVisit(),
              HospitalVisit(),
            ],
          ),
        ),
      ),
    );
  }
}