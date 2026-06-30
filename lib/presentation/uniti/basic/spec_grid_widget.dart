import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/resources/assets_manager.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SpecGridWidget extends StatelessWidget {
  final List<SpecDModel> items;
  final int crossAxisCount;
  final Function(SpecDModel model)? onTap;

  const SpecGridWidget({
    super.key,
    required this.items,
    required this.crossAxisCount,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bool isTablet = MediaQuery.of(context).size.shortestSide >= 600;

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 12.w,
        mainAxisSpacing: 12.h,
        childAspectRatio: 0.6, // زيادة الارتفاع قليلاً لاستيعاب النصوص
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return InkWell(
          onTap: onTap != null ? () => onTap!(item) : null,
          borderRadius: BorderRadius.circular(AppSize.s25),
          child: Container(
            padding: EdgeInsets.all(AppPaddingH.p10),
            decoration: BoxDecoration(
              color: ColorManager.white,
              borderRadius: BorderRadius.circular(AppSize.s25),
              border: Border.all(color: ColorManager.inputBorder.withOpacity(0.5)),
              boxShadow: [
                BoxShadow(
                  color: ColorManager.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Icon Container
                Container(
                  padding: EdgeInsets.all(10.w),
                  decoration: BoxDecoration(
                    color: ColorManager.medicalSecondary.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset(
                    ImageAssetsSpec().getImage(item.id),
                    width: isTablet ? 50.w : 35.w,
                    height: isTablet ? 50.h : 35.h,
                    color: ColorManager.medicalSecondary.withOpacity(0.8),
                    colorBlendMode: BlendMode.modulate,
                    errorBuilder: (context, error, stackTrace) =>
                        Icon(Icons.medical_services, color: ColorManager.medicalSecondary),
                  ),
                ),
                SizedBox(height: 12.h),
                // Title
                Text(
                  item.title,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: ColorManager.medicalText,
                    fontWeight: FontWeight.w600,
                    fontSize: isTablet ? 18.sp : 15.sp,
                  ),
                ),
                SizedBox(height: 4.h),
                // Statistics
                if (item.sumDoctor != 0)
                  _buildStatText("زيارات الأطباء: ${item.sumDoctor}", isTablet),
                if (item.sumHospital != 0)
                  _buildStatText("زيارات المشافي: ${item.sumHospital}", isTablet),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildStatText(String text, bool isTablet) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: ColorManager.black.withOpacity(0.5),
        fontWeight: FontWeight.w400,
        fontSize: isTablet ? 13.sp : 10.sp,
      ),
    );
  }
}