// ignore_for_file: deprecated_member_use

import 'package:domina_app/app/user_info.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/brand_plan/bloc/brand_plan_bloc.dart';
import 'package:domina_app/presentation/brand_plan/pages/brand_plan_other_page.dart';
import 'package:domina_app/presentation/brand_plan/widget/save_send_bottom.dart';
import 'package:domina_app/presentation/resources/assets_manager.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/uniti/stateWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SpecPlanPage extends StatelessWidget {
  SpecPlanPage({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isTablet = MediaQuery.of(context).size.shortestSide >= 600;

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC), // خلفية الصفحة الموحدة
      body: Stack(
        children: [
          BlocConsumer<BrandPlanBloc, BrandPlanState>(
            listener: (context, state) {
              if (state is AllBrandPlanErrorState) {
                error(context, state.failure.massage, state.failure.code);
              }
            },
            builder: (context, state) {
              List<OtherBrandSpPlanModel> planBrandModel =
                  context.watch<BrandPlanBloc>().planBrand;

              if (state is SumState) {
                planBrandModel = state.planBrands;
              }

              if (state is AllBrandPlanEmptyState || planBrandModel.isEmpty) {
                return Center(child: emptyFullScreen(context));
              }

              return OrientationBuilder(
                builder: (context, orientation) {
                  // تحديد عدد الأعمدة بناءً على نوع الجهاز والوضعية
                  int crossAxisCount;
                  if (isTablet) {
                    crossAxisCount = orientation == Orientation.landscape ? 4 : 3;
                  } else {
                    crossAxisCount = orientation == Orientation.landscape ? 3 : 2;
                  }

                  return CustomScrollView(
                    physics: const BouncingScrollPhysics(),
                    slivers: [
                      // 1. قسم الهيدر (التاريخ + العنوان + الوصف) الموحد مع الواجهة الأخرى
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 14.h),
                              // حاوية التاريخ البيضاء
                              Center(
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 12.h),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(15.r),
                                      border: Border.all(color: Colors.grey.shade100),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.black.withOpacity(0.01),
                                            blurRadius: 10,
                                            offset: const Offset(0, 2))
                                      ]),
                                  child: Text(
                                    "تاريخ الخطة: ${UserInfo.otherStartDate} - ${UserInfo.otherEndDate}",
                                    style: TextStyle(
                                        fontSize: 14.sp,
                                        color: ColorManager.medicalPrimary,
                                        fontWeight: FontWeight.w900),
                                  ),
                                ),
                              ),
                              SizedBox(height: 25.h),
                              // عنوان الصفحة
                              Text(
                                'توزيع العينات حسب الاختصاص',
                                style: TextStyle(
                                  fontSize: 22.sp,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFF0F172A),
                                ),
                              ),
                              // وصف الصفحة
                              Text(
                                'يمكنك استعراض عدد العينات المتاحة لكل اختصاص وتعديلها أو إرسالها للمراجعة',
                                style: TextStyle(
                                    fontSize: 14.sp,
                                    color: const Color(0xFF64748B),
                                    height: 1.4),
                              ),
                              SizedBox(height: 20.h),
                            ],
                          ),
                        ),
                      ),

                      // 2. شبكة الإختصاصات (Grid)
                      SliverPadding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.w, vertical: 10.h),
                        sliver: SliverGrid(
                          gridDelegate:
                          SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: crossAxisCount,
                            crossAxisSpacing: 12.w,
                            mainAxisSpacing: 12.h,
                            childAspectRatio:
                            0.65, // لتكبير الارتفاع قليلاً ليناسب النصوص
                          ),
                          delegate: SliverChildBuilderDelegate(
                                (context, index) {
                              final item = planBrandModel[index];

                              // الحفاظ على شرط الفلترة الأصلي
                              if (item.brandk == 0)
                                return const SizedBox.shrink();

                              return _buildSpecItem(context, item, index);
                            },
                            childCount: planBrandModel.length,
                          ),
                        ),
                      ),

                      // مساحة إضافية في الأسفل لكي لا يغطي الزر على المحتوى
                      SliverToBoxAdapter(child: SizedBox(height: 120.h)),
                    ],
                  );
                },
              );
            },
          ),

          // 3. زر الحفظ والإرسال
          context.watch<BrandPlanBloc>().planBrand.isNotEmpty
              ? BlocListener<BrandPlanBloc, BrandPlanState>(
            listener: (context, state) {
              if (state is UpdateAmountErrorState) {
                error(context, state.failure.massage, state.failure.code);
              }
              if (state is UpdateAmountState) {
                BlocProvider.of<BrandPlanBloc>(context).add(UpdateSaveEvent());
                dismissDialog(context);
                successWithMessage(context, "تم حفظ التغيرات");
              }
              if (state is UpdateAmountSendState) {
                dismissDialog(context);
                successWithMessage(context, "تم الارسال يرجى المزامنة ");
              }
            },
            child: SaveSendBottom(),
          )
              : const SizedBox(),
        ],
      ),
    );
  }
  // بناء العنصر الواحد بتصميم عصري (يشبه المثال الجديد)
  Widget _buildSpecItem(
      BuildContext context, OtherBrandSpPlanModel model, int index) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                BrandPlanOtherPage(
                  otherBrandSpPlanModel:
                  model,
                  index1: index,
                ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(color: const Color(0xFFE2E8F0)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // الأيقونة بخلفية ملونة خفيفة
            Container(
              padding: EdgeInsets.all(10.w),
              margin:  EdgeInsets.all(10.w),
              decoration: BoxDecoration(
                color: ColorManager.medicalSecondary.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Image.asset(
                ImageAssetsSpec().getImage(model.specModel.id),
                width: 35.w,
                height: 35.h,
                color: ColorManager.medicalSecondary.withOpacity(0.8),
                colorBlendMode: BlendMode.modulate,
                errorBuilder: (context, error, stackTrace) =>
                    Icon(Icons.medical_services, color: ColorManager.medicalSecondary),
              ),
            ),
            SizedBox(height: 10.h),
            Text(
              model.specModel.title,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: const Color(0xFF1E293B),
                fontWeight: FontWeight.bold,
                fontSize: 14.sp,
              ),
            ),
            SizedBox(height: 5.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              child: Column(
                children: [
                  _buildStatItem("زيارات أطباء", "${model.specModel.sumDoctor}"),
                  Divider(
                      height: 12.h,
                      color: Colors.grey.withOpacity(0.1),
                      thickness: 1),
                  _buildStatItem("زيارات المشافي", "${model.specModel.sumHospital}"),
                  Divider(
                      height: 12.h,
                      color: Colors.grey.withOpacity(0.1),
                      thickness: 1),
                  _buildStatItem("عينات",
                      "${(model.brandk / UserInfo.samplesCount)}"),
                ],
              ),
            ),
            // // بيانات إحصائية مصغرة
            // _buildMiniInfo("زيارات: ${model.specModel.sumDoctor + model.specModel.sumHospital}"),
            // _buildMiniInfo("العينات: ${(model.brandk / UserInfo.samplesCount).toStringAsFixed(0)}"),
          ],
        ),
      ),
    );
  }

  // ويدجت الكرت (تصميم عصري + خط فاصل + توزيع أفقي + Hero)
  // Widget _buildSpecCard(BuildContext context, OtherBrandSpPlanModel model, int index) {
  //   return Hero(
  //     tag: "spec_plan_${model.specModel.id}",
  //     child: Material(
  //       color: Colors.transparent,
  //       child: InkWell(
  //         borderRadius: BorderRadius.circular(20.r),
  //         onTap: () {
  //           Navigator.push(
  //             context,
  //             MaterialPageRoute(
  //               builder: (context) => BrandPlanOtherPage(
  //                 otherBrandSpPlanModel: model,
  //                 index1: index,
  //               ),
  //             ),
  //           );
  //         },
  //         child: Container(
  //           decoration: BoxDecoration(
  //             color: Colors.white,
  //             borderRadius: BorderRadius.circular(20.r),
  //             boxShadow: [
  //               BoxShadow(
  //                 color: Colors.black.withOpacity(0.04),
  //                 blurRadius: 10,
  //                 offset: const Offset(0, 4),
  //               ),
  //             ],
  //             border: Border.all(color: const Color(0xFFF1F5F9)),
  //           ),
  //           child: Column(
  //             children: [
  //               // الأيقونة
  //               Expanded(
  //                 flex: 5,
  //                 child: Container(
  //                   margin: EdgeInsets.only(top: 10.h),
  //                   padding: EdgeInsets.all(12.w),
  //                   decoration: BoxDecoration(
  //                     color: ColorManager.medicalSecondary.withOpacity(0.1),
  //                     shape: BoxShape.circle,
  //                   ),
  //                   child: Image.asset(
  //                     ImageAssetsSpec().getImage(model.specModel.id),
  //                     color: ColorManager.medicalSecondary,
  //                     errorBuilder: (context, error, stackTrace) =>
  //                         Icon(Icons.medical_services_outlined, color: ColorManager.medicalSecondary, size: 24.sp),
  //                   ),
  //                 ),
  //               ),
  //
  //               // اسم الاختصاص
  //               Padding(
  //                 padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 4.w),
  //                 child: Text(
  //                   model.specModel.title,
  //                   textAlign: TextAlign.center,
  //                   maxLines: 1,
  //                   overflow: TextOverflow.ellipsis,
  //                   style: TextStyle(
  //                     fontSize: 14.sp,
  //                     fontWeight: FontWeight.bold,
  //                     color: const Color(0xFF1E293B),
  //                   ),
  //                 ),
  //               ),
  //
  //               // البيانات مع الخطوط الفاصلة
  //               Padding(
  //                 padding: EdgeInsets.symmetric(horizontal: 12.w),
  //                 child: Column(
  //                   children: [
  //                     _buildStatItem("زيارات أطباء", "${model.specModel.sumDoctor}"),
  //                     Divider(height: 10.h, color: Colors.grey.withOpacity(0.1), thickness: 1),
  //                     _buildStatItem("زيارات مشافي", "${model.specModel.sumHospital}"),
  //                     Divider(height: 10.h, color: Colors.grey.withOpacity(0.1), thickness: 1),
  //                     _buildStatItem("عينات", "${(model.brandk / UserInfo.samplesCount).toStringAsFixed(0)}"),
  //                   ],
  //                 ),
  //               ),
  //               SizedBox(height: 12.h),
  //             ],
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }

  // سطر المعلومات (Label - Value)
  Widget _buildStatItem(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 10.sp,
            color: const Color(0xFF94A3B8),
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 11.sp,
            color: const Color(0xFF0F172A),
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}