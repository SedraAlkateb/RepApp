
import 'package:domina_app/presentation/doctors/widget/bottom.dart';
import 'package:domina_app/presentation/doctors/widget/card.dart';
import 'package:domina_app/presentation/doctors/widget/header.dart';
import 'package:domina_app/presentation/doctors/widget/note.dart';
import 'package:domina_app/presentation/doctors/widget/start_card.dart';
import 'package:flutter/material.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DoctorDetails extends StatelessWidget {
  final DoctorModel doctor;
  DoctorDetails({required this.doctor});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("معلومات الطبيب"),
        centerTitle: true,
      ),
      body:        Stack(
        children: [

          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildHeader(doctor.title),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      buildStatCard("الزيارات", doctor.visits.toString(), Icons.visibility_outlined,
                          Colors.blue),
                      buildStatCard(
                          "التصنيف", doctor.rate??"", Icons.star_border, Colors.orange),
                      buildStatCard(
                          "المزارة", doctor.visited==null?"0": doctor.visited.toString(), Icons.group_outlined, Colors.green),
                    ],
                  ),
                ),
                _buildDetailsCard(),

                SizedBox(height: 15.h),
                buildNotesCard(doctor.note),
                SizedBox(
                  height: 150,
                ),

              ],
            ),
          ),
          buildBottomButtonsDoctor(doctor.id),
        ],
      ),
    );
  }
  Widget _buildDetailsCard() {
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
