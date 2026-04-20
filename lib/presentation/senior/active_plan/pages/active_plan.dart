import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/senior/active_plan/bloc/bloc/active_plan_bloc.dart';
import 'package:domina_app/presentation/uniti/stateWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ActivePlanPage extends StatefulWidget {
  @override
  State<ActivePlanPage> createState() => _BrandPlanActivePageState();
}

class _BrandPlanActivePageState extends State<ActivePlanPage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('الخطة الفعالة'),
      ),
      body: BlocConsumer<ActivePlanBloc, ActivePlanState>(
        listener: (context, state) {
          if (state is AllActivePlanErrorState) {
            error(context, state.failure.massage, state.failure.code);
          }
        },
        builder: (context, state) {
          List<ActivePlanBrandModel> planBrandModel =
              context.watch<ActivePlanBloc>().activePlan;

          if (state is AllActivePlanLoadingState) {
            return loadingShimmer(context, 20, 25, 150, BorderRadius.circular(20));
          }

          return ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
            itemCount: planBrandModel.length,
            itemBuilder: (context, index) => BrandPlanCard(model: planBrandModel[index]),
          );
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

// ويدجيت الـ Card المطور بناءً على التصميم
class BrandPlanCard extends StatelessWidget {
  final ActivePlanBrandModel model;

  const BrandPlanCard({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // الجزء العلوي الملون (Header)
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              // تلوين الخلفية بلون أزرق فاتح جداً أو شفافية من اللون الأساسي
              color: ColorManager.secondaryColor3,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25.r),
                topRight: Radius.circular(25.r),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      model.title,
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF0D47A1),
                      ),
                    ),
                    Text(
                      model.pharmaceuticalFormTitle,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                // شارة "هدف"
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 6.h),
                  decoration: BoxDecoration(
                    color: Colors.white, // جعل الشارة بيضاء لتبرز فوق الخلفية الملونة
                    borderRadius: BorderRadius.circular(10.r),
                    border: Border.all(color: const Color(0xFFE3F2FD)),
                  ),
                  child: Text(
                    model.type,
                    style: TextStyle(
                      color: const Color(0xFF2196F3),
                      fontWeight: FontWeight.bold,
                      fontSize: 12.sp,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // إزالة الـ Divider لأنه تم تمييز الجزء العلوي باللون
          // const Divider(height: 1),

          // قسم "توزيع الأهداف حسب الاختصاص"
          Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.info_outline, size: 16.sp, color: Colors.grey),
                    SizedBox(width: 8.w),
                    Text(
                      "توزيع الأهداف حسب الاختصاص",
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: Colors.blueGrey[700],
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12.h),

                // قائمة الاختصاصات داخل مربعات
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: model.spPlan.length,
                  itemBuilder: (context, i) {
                    return Container(
                      margin: EdgeInsets.only(bottom: 10.h),
                      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF8FAFC),
                        borderRadius: BorderRadius.circular(15.r),
                        border: Border.all(color: const Color(0xFFE2E8F0)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            model.spPlan[i].name,
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: const Color(0xFF334155),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            model.spPlan[i].amount,
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF0D47A1),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}