import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/resources/routes_manager.dart';
import 'package:domina_app/presentation/senior/finished_plan/bloc/finished_plan_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; // إضافة مكتبة البلوك

class FinishedPlanPage extends StatelessWidget {
  const FinishedPlanPage({Key? key, required this.cityId}) : super(key: key);
  final int cityId;

  @override
  Widget build(BuildContext context) {
    // إرسال الحدث لجلب البيانات بناءً على معرف المدينة
    context.read<FinishedPlanBloc>().add(GetFinishedPlansEvent(cityId: cityId));

    return Scaffold(
      appBar: AppBar(
        title: const Text("سجل الخطط"),
      ),
      // استخدام CustomScrollView هو المفتاح لتفعيل تأثيرات الـ Sliver
      body: CustomScrollView(
        slivers: [
          // 1. الجزء العلوي (الهيدر) الذي سيرتفع عند التمرير
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.fromLTRB(25.w, 20.h, 25.w, 10.h),
              child: _buildHeader(),
            ),
          ),

          // 2. التعامل مع حالات الـ Bloc داخل نظام الـ Slivers
          BlocBuilder<FinishedPlanBloc, FinishedPlanState>(
            buildWhen: (previous, current) =>
            current is FinishedPlanLoading ||
                current is FinishedPlanLoaded ||
                current is FinishedPlanError,
            builder: (context, state) {
              if (state is FinishedPlanLoading) {
                // نستخدم SliverFillRemaining لوضع مؤشر التحميل في وسط المساحة المتبقية
                return const SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(child: CircularProgressIndicator()),
                );
              } else if (state is FinishedPlanLoaded) {
                // عرض قائمة الخطط باستخدام SliverList
                return SliverPadding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                          (context, index) {
                        return PlanCard(plan: state.plans[index]);
                      },
                      childCount: state.plans.length,
                    ),
                  ),
                );
              } else if (state is FinishedPlanError) {
                return SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(child: Text(state.message)),
                );
              }
              return const SliverToBoxAdapter(child: SizedBox());
            },
          ),

          // مساحة إضافية في الأسفل لراحة التمرير
          SliverToBoxAdapter(child: SizedBox(height: 20.h)),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'سجل الخطط السابقة',
              style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.bold,
                color: ColorManager.medicalPrimary,
              ),
            ),
            Container(
              height: 4, width: 35,
              decoration: BoxDecoration(
                color: const Color(0xFF42A5F5),
                borderRadius: BorderRadius.circular(10),
              ),
            )
          ],
        ),
        SizedBox(height: 4.h),
        Text(
          'تصفح تقارير ونتائج الدورات المنتهية',
          style: TextStyle(fontSize: 14.sp, color: Colors.grey),
        ),
      ],
    );
  }
}
class PlanCard extends StatelessWidget {
  final FinishedPlanModel plan;
  const PlanCard({required this.plan});

  @override
  Widget build(BuildContext context) {
    // منطق الألوان والحالات بناءً على active
    Color mainColor;
    String statusText;
    if (plan.active == "-1") {
      mainColor = Colors.blueGrey;
      statusText = "مؤرشفة";
    } else if (plan.active == "0") {
      mainColor = Colors.redAccent;
      statusText = "منتهية";
    } else {
      mainColor = Colors.teal;
      statusText = "مراجعة نهائية";
    }

    return InkWell(
      onTap: () {
        BlocProvider.of<FinishedPlanBloc>(context).add(GetPlanRepsEvent(planId: int.parse(plan.id)));
        Navigator.pushNamed(context, Routes.planReps,arguments:int.parse(plan.id) );
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 5.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(35.r),
          border: Border(
            // الخط الجانبي يتغير لونه بناءً على الـ flag (مقروء أو غير مقروء)
            right: BorderSide(
              color: mainColor,
              width: 8.w,
            ),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.02),
              blurRadius: 10,
              offset: const Offset(0, 5),
            )
          ],
        ),
        padding: EdgeInsets.all(20.w),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _generatePlanTitle(plan.startDate),
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF0D47A1),
                      ),
                    ),
                    SizedBox(height: 10.h),
                    _buildStatusBadge(statusText, mainColor),
                    SizedBox(height: 10.h),
                    _buildDateContainer(plan.startDate, plan.endDate),
                  ],
                ),
              ),
              // زر الانتقال المستدير
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFFF0F4F8),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.arrow_forward_ios, size: 14.sp, color: Colors.blueGrey),
              ),
            ],
          ),
      
      ),
    );
  }

  // وسم الحالة (Badge)
  Widget _buildStatusBadge(String text, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Text(
        text,
        style: TextStyle(color: color, fontSize: 10.sp, fontWeight: FontWeight.bold),
      ),
    );
  }

  // حاوية التواريخ الرمادية
  Widget _buildDateContainer(String start, String end) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 5.h),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFD),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(start, style: TextStyle(fontSize: 11.sp, color: Colors.blueGrey)),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: Icon(Icons.arrow_back, size: 12.sp, color: Colors.grey[300]),
          ),
          Text(end, style: TextStyle(fontSize: 11.sp, color: Colors.blueGrey)),
        ],
      ),
    );
  }

  /// دالة لتوليد عنوان الخطة مع التحقق من صحة التاريخ
  String _generatePlanTitle(String dateString) {
    // 1. محاولة تحويل النص إلى تاريخ بشكل آمن
    // استخدمنا tryParse لتجنب الأخطاء في حال كان التاريخ القادم من السيرفر غير صحيح
    DateTime? date = DateTime.tryParse(dateString);

    // 2. التحقق: إذا كان التاريخ غير صحيح (null)، أظهر "خطة الشتاء"
    if (date == null) {
      return "خطة الشتاء";
    }

    // 3. قائمة أسماء الأشهر العربية (تستخدم في حال كان التاريخ صحيحاً)
    List<String> months = [
      "يناير", "فبراير", "مارس", "أبريل", "مايو", "يونيو",
      "يوليو", "أغسطس", "سبتمبر", "أكتوبر", "نوفمبر", "ديسمبر"
    ];

    // 4. استخراج اسم الشهر والسنة
    String monthName = months[date.month - 1];
    String year = date.year.toString();

    // 5. إرجاع النتيجة النهائية
    return "خطة $monthName $year";
  }
}