import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/senior/finished_plan/bloc/finished_plan_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PlanRepsPage extends StatelessWidget {
  const PlanRepsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // لون خلفية خفيف لإبراز البطاقات البيضاء
      backgroundColor: const Color(0xFFF8FAFD),
      appBar: AppBar(
        title: const Text("سجل المندوبين"),
        elevation: 0,
      ),
      body: CustomScrollView(
        slivers: [
          // 1. هيدر الصفحة
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.fromLTRB(25.w, 20.h, 25.w, 10.h),
              child: _buildHeader(),
            ),
          ),

          // 2. قائمة المندوبين المستمدة من الـ Bloc
          BlocBuilder<FinishedPlanBloc, FinishedPlanState>(
            buildWhen: (previous, current) =>
                current is PlanRepsLoading ||
                current is PlanRepsLoaded ||
                current is PlanRepsError,
            builder: (context, state) {
              if (state is PlanRepsLoading) {
                return const SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(child: CircularProgressIndicator()),
                );
              } else if (state is PlanRepsLoaded) {
                return SliverPadding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        // تمرير كائن المندوب للبطاقة الجديدة المصممة أدناه
                        return RepCard(repName: state.reps[index].name);
                      },
                      childCount: state.reps.length,
                    ),
                  ),
                );
              } else if (state is PlanRepsError) {
                return SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(child: Text(state.message)),
                );
              }
              return const SliverToBoxAdapter(child: SizedBox());
            },
          ),

          // مساحة تباعد سفلية
          SliverToBoxAdapter(child: SizedBox(height: 20.h)),
        ],
      ),
    );
  }

  // ويدجت الهيدر الموثق
  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'سجل المندوبين',
              style: TextStyle(
                fontSize: 22.sp,
                fontWeight: FontWeight.bold,
                color: ColorManager.medicalPrimary,
              ),
            ),
            // شكل جمالي صغير (خط أزرق)
            Container(
              height: 4.h,
              width: 30.w,
              decoration: BoxDecoration(
                color: const Color(0xFF42A5F5),
                borderRadius: BorderRadius.circular(10.r),
              ),
            )
          ],
        ),
        SizedBox(height: 5.h),
        Text(
          'عرض أسماء المندوبين المشاركين في هذه الخطة',
          style: TextStyle(fontSize: 13.sp, color: Colors.grey[600]),
        ),
      ],
    );
  }
}

/// بطاقة عرض المندوب (تصميم بسيط ومركّز على الاسم)
class RepCard extends StatelessWidget {
  final String repName;

  const RepCard({Key? key, required this.repName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.r),
        // ظل خفيف جداً لإعطاء عمق
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 5.h),
        // أيقونة المستخدم الجانبية
        leading: CircleAvatar(
          backgroundColor: ColorManager.medicalPrimary.withOpacity(0.1),
          child: Icon(Icons.person,
              color: ColorManager.medicalPrimary, size: 20.sp),
        ),
        // عرض اسم المندوب بخط واضح
        title: Text(
          repName,
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        // سهم صغير للاشارة إلى قابلية النقر
        trailing: Icon(
          Icons.arrow_forward_ios,
          size: 14.sp,
          color: Colors.grey[400],
        ),
        onTap: () {
          // هنا يمكن إضافة الانتقال لصفحة تقرير المندوب لاحقاً
        },
      ),
    );
  }
}
