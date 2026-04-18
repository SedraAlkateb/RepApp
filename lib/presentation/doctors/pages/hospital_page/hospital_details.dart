
import 'package:domina_app/presentation/doctors/widget/bottom.dart';
import 'package:domina_app/presentation/doctors/widget/card.dart';
import 'package:domina_app/presentation/doctors/widget/header.dart';
import 'package:domina_app/presentation/doctors/widget/note.dart';
import 'package:domina_app/presentation/doctors/widget/start_card.dart';
import 'package:flutter/material.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HospitalDetails extends StatelessWidget {
  final HospitalSpAllModel hospital;

  HospitalDetails({required this.hospital});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("معلومات المشفى"),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                buildHeader(hospital.title),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      buildStatCard("الزيارات", hospital.visit.toString(), Icons.visibility_outlined,
                          Colors.blue),
                      buildStatCard(
                          "التصنيف", hospital.rate??"", Icons.star_border, Colors.orange),
                      buildStatCard(
                          "الأطباء", hospital.totalDocs.toString(), Icons.group_outlined, Colors.green),
                    ],
                  ),
                ),

                SizedBox(height: 20.h),
                _buildDetailsCard(),

                SizedBox(height: 15.h),
                buildNotesCard(hospital.note),
                SizedBox(
                  height: 150,
                ),

              ],
            ),
          ),
          buildBottomButtons(hospital.hospitalId),
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
          buildInfoRow(Icons.location_on_outlined, "المنطقة", hospital.placeTitle??""),
          const Divider(height: 30,thickness: 0.1,),
          buildInfoRow(Icons.business_outlined, "العنوان", hospital.address??""),
          const Divider(height: 30,thickness: 0.1,),
          buildInfoRow(Icons.medical_services_outlined, "الإختصاص", hospital.titleSp??""),
        ],
      ),
    );
  }







}
