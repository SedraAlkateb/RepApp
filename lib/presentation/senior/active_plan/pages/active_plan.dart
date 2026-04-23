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
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
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

// ويدجيت الـ Card المطور ليطابق التصميم المرفق تماماً
class BrandPlanCard extends StatelessWidget {
  final ActivePlanBrandModel model;

  const BrandPlanCard({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20.h),
      decoration: BoxDecoration(
        color: Colors.white,
        border: BoxBorder.all(color:  ColorManager.black.withValues(alpha: 0.1,blue: 0.1,green: 0.1)),//اطار خفيف جدا,
        borderRadius: BorderRadius.circular(25.r), // حواف دائرية كبيرة للكارد
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03), // ظل ناعم جداً فاتح
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // الجزء العلوي (Header) - بخلفية رمادية فاتحة جداً
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            decoration: BoxDecoration(
              color: const Color(0xFFE9ECF0), // لون خلفية الهيدر الرمادي الفاتح
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25.r),
                topRight: Radius.circular(25.r),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // اسم الدواء والنوع (تحت بعض)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      model.title,
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF1E3A8A), // أزرق داكن للنص الأساسي
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      model.pharmaceuticalFormTitle,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF64748B), // رمادي للنص الفرعي
                      ),
                    ),
                  ],
                ),
                // شارة "هدف" البيضاء
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.r), // حواف دائرية صغيرة للشارة
                    border: Border.all(color: const Color(0xFFE2E8F0)), // إطار رمادي خفيف جداً
                  ),
                  child: Text(
                    model.type,
                    style: TextStyle(
                      color: const Color(0xFF3B82F6), // أزرق فاتح لنص الشارة
                      fontWeight: FontWeight.bold,
                      fontSize: 13.sp,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // قسم "توزيع الأهداف حسب الاختصاص" - الخلفية بيضاء تلقائياً
          Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.info_outline, size: 16.sp, color: const Color(0xFF94A3B8)),
                    SizedBox(width: 8.w),
                    Text(
                      "توزيع الأهداف حسب الاختصاص",
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: const Color(0xFF64748B), // رمادي للنص الوصفي
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),

                // قائمة الاختصاصات داخل مربعات بيضاء بإطار رمادي
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: model.spPlan.length,
                  itemBuilder: (context, i) {
                    return Container(
                      margin: EdgeInsets.only(bottom: 12.h),
                      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                      decoration: BoxDecoration(
                        color: Colors.white, // مربعات الاختصاصات بيضاء
                        borderRadius: BorderRadius.circular(15.r),
                        border: Border.all(color: const Color(0xFFE2E8F0)), // إطار رمادي خفيف
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween, // توزيع على الأطراف
                        children: [
                          Text(
                            model.spPlan[i].name,
                            style: TextStyle(
                              fontSize: 15.sp,
                              color: const Color(0xFF1E293B), // أسود/أزرق داكن لاسم الاختصاص
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            model.spPlan[i].amount,
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF1E3A8A), // أزرق داكن للرقم
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