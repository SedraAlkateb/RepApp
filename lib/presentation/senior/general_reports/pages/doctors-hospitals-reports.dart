import 'package:domina_app/app/di/di.dart';
import 'package:domina_app/app/user_info.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/senior/report_visit_doctor/bloc/report_visit_doctor_bloc.dart';
import 'package:domina_app/presentation/senior/report_visit_doctor/page/report_visit_doctor.dart';
import 'package:domina_app/presentation/senior/report_visit_doctor/page/report_visit_hospital.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DoctorsHospitalsReports extends StatefulWidget {
  const DoctorsHospitalsReports({
    super.key,
    required this.repId,
    required this.senId,
    required this.indexRep,
    required this.repName,
    required this.phone,
  });

  final int repId;
  final int senId;
  final int indexRep;
  final String repName;
  final String phone;

  @override
  State<DoctorsHospitalsReports> createState() =>
      _DoctorsHospitalsReportsState();
}

class _DoctorsHospitalsReportsState extends State<DoctorsHospitalsReports> {
  @override
  void initState() {
    super.initState();
    initReportVisitDoctorModule();
    context.read<ReportVisitDoctorBloc>().add(
      AllReportVisitDoctorEvent(
          VisitRepSen(widget.repId, widget.senId), true),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: const Color(0xFFF8F9FB),
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
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
                  widget.repName,
                  style: TextStyle(
                    color: const Color(0xFF0D47A1),
                    fontWeight: FontWeight.bold,
                    fontSize: 18.sp,
                  ),
                ),
              ),
              // الـ TabBar العائم بكامل العرض
              SliverToBoxAdapter(
                child: Container(
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                  padding: EdgeInsets.all(4.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15.r),
                    border: Border.all(color: Colors.grey.shade200),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.03),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: TabBar(
                    labelPadding: EdgeInsets.zero,
                    dividerColor: Colors.transparent,
                    labelColor: Colors.white,
                    unselectedLabelColor: Colors.grey.shade500,
                    labelStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14.sp,
                      fontFamily: 'Cairo', // أو الخط المعتمد لديك
                    ),
                    unselectedLabelStyle: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14.sp,
                      fontFamily: 'Cairo',
                    ),
                    indicatorSize: TabBarIndicatorSize.tab,
                    indicator: BoxDecoration(
                      color: ColorManager.medicalPrimary,
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    onTap: (value) {
                      if (value == 0) {
                        context.read<ReportVisitDoctorBloc>().add(
                          AllReportVisitDoctorEvent(
                              VisitRepSen(widget.repId, widget.senId),
                              true),
                        );
                      } else {
                        context.read<ReportVisitDoctorBloc>().add(
                          AllReportVisitHospitalEvent(
                              VisitRepSen(widget.repId, widget.senId),
                              true),
                        );
                      }
                    },
                    tabs: [
                      Tab(
                        height: 48.h,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(Icons.groups_outlined, size: 20.sp),
                            SizedBox(width: 8.w),
                            Text(
                              'الأطباء',
                              style: TextStyle(fontSize: 14.sp),
                            ),
                          ],
                        ),
                      ),
                      Tab(
                        height: 48.h,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(Icons.local_hospital_outlined, size: 20.sp),
                            SizedBox(width: 8.w),
                            Text(
                              'المشافي',
                              style: TextStyle(fontSize: 14.sp),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ];
          },
          body: TabBarView(
            physics: const NeverScrollableScrollPhysics(),
            children: [
              ReportVisitDoctorPage(
                userId: UserInfo.repId,
                repId: widget.repId,
                repName: widget.repName,
                indexRep: widget.indexRep,
                repPlan: 0,
                phone: widget.phone,
                iscanedite: false,
              ),
              ReportVisitHospital(
                userId: UserInfo.repId,
                repId: widget.repId,
                indexRep: widget.indexRep,
                repName: widget.repName,
                repPlan: 0,
                iscanedite: false,
                phone: widget.phone,
              ),
            ],
          ),
        ),
      ),
    );
  }
}