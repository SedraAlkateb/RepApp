import 'dart:ui';
import 'package:domina_app/app/user_info.dart';
import 'package:domina_app/domain/models/drawer_model.dart';
import 'package:domina_app/presentation/drawer/pages/drawer_launcher.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// قم باستيراد الـ ColorManager و UserInfo حسب مساراتهم لديك

class CustomAppDrawer extends StatelessWidget {
  final String roleTitle;
  final List<DrawerMenuItem> menuItems;
  final bool showStats;

  const CustomAppDrawer({
    super.key,
    required this.roleTitle,
    required this.menuItems,
    this.showStats = false,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // الخلفية الزجاجية
        ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
            child: Container(color: Colors.white.withOpacity(0.1)),
          ),
        ),
        Drawer(
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
          child: Column(
            children: [
              _buildHeader(),
              Expanded(
                child: ListView(
                  padding: EdgeInsets.only(top: 10.h),
                  children: [

                    ...menuItems.map((item) => _buildListTile(context, item)),
                    const Divider(color: Colors.black12, thickness: 0.5),

                    ...getLogoutItem(context).map((item) => _buildListTile(context, item)),

                    _buildVersionInfo(), // إضافة معلومات الإصدار هنا
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(top: 50.h, bottom: 10.h),
      decoration: BoxDecoration(
        color: ColorManager.medicalBg,
        border: const Border(bottom: BorderSide(color: Colors.black12)),
      ),
      child: Column(
        children: [
          _buildAvatar(),
          SizedBox(height: 12.h),
          Text(UserInfo.name ?? "",
              style: TextStyle(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.bold,
                  color: ColorManager.secondaryColor1)),
          Text("$roleTitle _ ${UserInfo.cityTitle}",
              style: TextStyle(fontSize: 14.sp, color: Colors.grey[700])),
          if (showStats) _buildStatsSection(),
        ],
      ),
    );
  }

  Widget _buildAvatar() {
    return Container(
      width: 80.w,
      height: 80.w,
      decoration: BoxDecoration(
        color: ColorManager.medicalPrimary,
        borderRadius: BorderRadius.circular(15.r),
      ),
      alignment: Alignment.center,
      child: Text(
        UserInfo.name?[0] ?? "أ",
        style: TextStyle(
          fontSize: 35.sp,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildListTile(BuildContext context, DrawerMenuItem item) {
    return Column(
      children: [
        ListTile(
          leading: Icon(item.icon,
              color: item.color ?? const Color(0xFF546E7A), size: 22.sp),
          title: Text(item.title,
              style: TextStyle(
                  color: item.color ?? const Color(0xFF37474F),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500)),
          onTap: item.onTap,
        ),
      ],
    );
  }

  Widget _buildVersionInfo() {
    return Padding(
      padding: EdgeInsets.all(20.w),
      child: Text(
        'Version 4',
        style: TextStyle(color: ColorManager.secondaryColor7, fontSize: 12.sp),
      ),
    );
  }

  // قسم الإحصائيات (Stats) كما في الكود الأصلي
  Widget _buildStatsSection() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      child: Row(
        children: [
          _buildStatCard(
              "المشافي", UserInfo.numOfHospitalVisit.toString(), true),
          SizedBox(width: 15.w),
          _buildStatCard(
              "الأطباء", UserInfo.numOfDoctorVisit.toString(), false),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String count, bool showDot) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15.r),
          border: Border.all(color: Colors.grey[200]!),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (showDot && UserInfo.numOfHospitalVisit != 0)
                  Container(
                      width: 6,
                      height: 6,
                      decoration: const BoxDecoration(
                          color: Colors.red, shape: BoxShape.circle)),
                if (showDot) const SizedBox(width: 4),
                Text(title,
                    style: TextStyle(fontSize: 11.sp, color: Colors.grey[600])),
              ],
            ),
            Text(count,
                style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: ColorManager.secondaryColor1)),
          ],
        ),
      ),
    );
  }
}
