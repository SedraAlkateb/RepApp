import 'package:domina_app/presentation/doctors/widget/bottom.dart';
import 'package:domina_app/presentation/doctors/widget/html_info.dart';
import 'package:domina_app/presentation/doctors/widget/row_info.dart';
import 'package:domina_app/presentation/hospitals/widget/card.dart';
import 'package:domina_app/presentation/hospitals/widget/header.dart';
import 'package:domina_app/presentation/hospitals/widget/note.dart';
import 'package:domina_app/presentation/hospitals/widget/start_card.dart';
import 'package:domina_app/presentation/resources/assets_manager.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/senior/search_doctors/bloc/search_doctors_bloc.dart';
import 'package:domina_app/presentation/uniti/stateWidget.dart';
import 'package:flutter/material.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DoctorInfo  extends StatelessWidget {
  DoctorInfo();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("معلومات الطبيب"),
        centerTitle: true,
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon:Icon( Icons.arrow_back_ios_new)),
      ),
      body: Stack(
        children: [

          SingleChildScrollView(
            child: BlocBuilder<SearchDoctorsBloc, SearchDoctorsState>(
              builder: (context, state) {
                if(state is DoctorInfoLoadingState){
                  return loadingFullScreen(context);
                }
                else if(state is DoctorInfoErrorState){
                  return errorFullScreen(context);
                }
                else if(state is DoctorInfoState){
                  DoctorModel doctor=state.doctor;
                  return SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // 1. الهيدر الذي يحتوي على الاسم
                        buildHeader(doctor.title),

                        SizedBox(height: 10.h),

                        // 2. بطاقات الإحصائيات (الزيارات، التصنيف، المزارة)
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              buildStatCard(
                                  "الزيارات",
                                  doctor.visits.toString(),
                                  Icons.visibility_outlined,
                                  Colors.blue
                              ),
                              buildStatCard(
                                  "التصنيف",
                                  doctor.rate ?? "0.0",
                                  Icons.star_border,
                                  Colors.orange
                              ),
                              buildStatCard(
                                  "المزارة",
                                  doctor.visited == null ? "0" : doctor.visited.toString(),
                                  Icons.group_outlined,
                                  Colors.green
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: 20.h),

                        // 3. بطاقة المعلومات التفصيلية
                        _buildDetailsCard(doctor),

                        SizedBox(height: 15.h),

                        // 4. بطاقة الملاحظات (تظهر فقط إذا وجدت)
                        if (doctor.note != null && doctor.note!.isNotEmpty)
                          buildNotesCard(doctor.note),

                        // مساحة إضافية في الأسفل لكي لا يغطي الزر المحتوى
                        SizedBox(height: 50.h),
                      ],
                    ),
                  );
                }
                return SizedBox();
              },
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildDetailsCard(  DoctorModel doctor) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(25.r)),
      child: Column(
        children: [
          buildInfoRow(Icons.location_on_outlined, "المنطقة", doctor.placeTitle),
          const Divider(height: 30,thickness: 0.1,),
          buildInfoRow(Icons.business_outlined, "العنوان", doctor.address),
          const Divider(height: 30,thickness: 0.1,),
          buildInfoRow(Icons.medical_services_outlined, "الإختصاص", doctor.spTitle),
          const Divider(height: 30,thickness: 0.1,),
          buildInfoRow(Icons.work, "أوقات العمل", doctor.workHours??""),

        ],
      ),
    );
  }
}
