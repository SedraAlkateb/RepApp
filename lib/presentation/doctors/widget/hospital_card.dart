// presentation/doctors/widget/hospital_card_item.dart
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/Recipes/widget/hospital_recipe.dart';
import 'package:domina_app/presentation/plase_visit/widget/build_card_buttom.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/resources/routes_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HospitalCardItem extends StatelessWidget {
  final HospitalSpAllModel hospital;

  const HospitalCardItem({super.key, required this.hospital});

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
            color: Colors.black.withOpacity(0.04),
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
              if (hospital.titleSp != null && hospital.titleSp!.isNotEmpty)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Text(
                    hospital.titleSp!,
                    style: TextStyle(color: Colors.blue, fontSize: 12.sp),
                  ),
                ),
              Expanded(
                child: Text(
                  hospital.title ?? "",
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
          _buildInfoRow(Icons.location_on_outlined, hospital.placeTitle),
          _buildInfoRow(Icons.map_outlined, hospital.address),
          _buildInfoRow(Icons.star_rate_outlined, hospital.rate, iconColor: ColorManager.medicalSecondary),
          SizedBox(height: 12.h),
          const Divider(color: Colors.grey, thickness: 0.2),
          SizedBox(height: 8.h),
          Row(
            children: [
              PrescriptionHospitalMenuWidget(hospitalId: hospital.hospitalId),
              const Spacer(),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    Routes.hospitalDetails,
                    arguments: hospital,
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

  Widget _buildInfoRow(IconData icon, String? text, {Color iconColor = Colors.grey}) {
    if (text == null || text.isEmpty) return const SizedBox.shrink();
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