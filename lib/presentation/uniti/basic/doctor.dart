// presentation/doctors/widget/doctor_card_item.dart
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/Recipes/widget/doctor_recipe.dart';
import 'package:domina_app/presentation/plase_visit/widget/build_card_buttom.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/resources/routes_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DoctorCardItem extends StatelessWidget {
  final DoctorModel doctor;

  const DoctorCardItem({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h, right: 8.w, left: 8.w),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            spreadRadius: 0,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  doctor.spTitle,
                  style: TextStyle(color: Colors.blue, fontSize: 12.sp),
                ),
              ),
              Expanded(
                child: Text(
                  doctor.title,
                  textAlign: TextAlign.end,
                  style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: ColorManager.medicalPrimary),
                ),
              ),
            ],
          ),
          SizedBox(height: 10.h),
          _buildInfoRow(Icons.location_on_outlined, doctor.placeTitle),
          _buildInfoRow(Icons.map_outlined, doctor.address),
          _buildInfoRow(Icons.star_rate_outlined, doctor.rate ?? "", iconColor: ColorManager.medicalSecondary),
          SizedBox(height: 12.h),
          const Divider(color: Colors.grey, thickness: 0.2),
          SizedBox(height: 8.h),
          Row(
            children: [
              PrescriptionMenuWidget(doctorId: doctor.id),
              const Spacer(),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    Routes.doctorDetails,
                    arguments: doctor,
                  );
                },
                child: buildCardButton(
                  "عرض التفاصيل",
                  ColorManager.medicalPrimary,
                  Colors.white,
                  Icons.directions_run,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text, {Color iconColor = Colors.grey}) {
    if (text.isEmpty) return const SizedBox.shrink();
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Row(
        children: [
          Icon(icon, size: 20.sp, color: iconColor),
          SizedBox(width: 8.w),
          Expanded(
            child: Text(
              text,
              style: TextStyle(color: Colors.grey.shade700, fontSize: 14.sp),
            ),
          ),
        ],
      ),
    );
  }
}