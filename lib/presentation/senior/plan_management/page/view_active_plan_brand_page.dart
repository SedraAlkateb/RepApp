import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/senior/plan_management/bloc/plan_management_bloc.dart';
import 'package:domina_app/presentation/uniti/search_field.dart';
import 'package:domina_app/presentation/uniti/stateWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ViewActivePlanBrandPage extends StatefulWidget {
  const ViewActivePlanBrandPage({super.key});

  @override
  State<ViewActivePlanBrandPage> createState() => _ViewActivePlanBrandPageState();
}

class _ViewActivePlanBrandPageState extends State<ViewActivePlanBrandPage> {
  final TextEditingController searchController = TextEditingController();

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 💡 استخدام الـ BlocBuilder للاستماع للحالات المعزولة الخاصة بالخطة الفعالة فقط
    return BlocBuilder<PlanManagementBloc, PlanManagementState>(
      buildWhen: (previous, current) =>
      previous.activeStatus != current.activeStatus ||
          previous.searchActiveBrands != current.searchActiveBrands,
      builder: (context, state) {

        // 1️⃣ حالة التحميل المخصصة للخطة الفعالة (Active Loading)
        if (state.activeStatus == PlanStatus.loading) {
          return loadingShimmer(context, 20, 25, 150, BorderRadius.circular(20.r));
        }

        // 2️⃣ حالة الخطأ المخصصة للخطة الفعالة (Active Error)
        if (state.activeStatus == PlanStatus.error) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.error_outline, size: 48.sp, color: Colors.red[300]),
                SizedBox(height: 12.h),
                Text(
                  state.activeFailure?.massage ?? "حدث خطأ غير متوقع",
                  style: TextStyle(color: Colors.black54, fontSize: 15.sp),
                ),
              ],
            ),
          );
        }

        // 3️⃣ جلب القائمة المفلترة المستقلة من الـ State المطور
        final List<ActivePlanBrandModel> planBrandModel = state.searchActiveBrands;

        // استبدال الـ Scaffold بـ غلاف مرن ليناسب الـ TabBarView
        return Container(
          color: const Color(0xFFF8FAFC), // رمادي فاتح جداً هادئ نفس التصميم الجديد
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [

              // --- قسم العنوان وحقل البحث ---
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20.h),
                      _buildFluidAnimation(
                        index: 0,
                        child: Text(
                          'منتجات الخطة الفعالة',
                          style: TextStyle(
                            fontSize: 22.sp,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF0F172A),
                          ),
                        ),
                      ),
                      _buildFluidAnimation(
                        index: 1,
                        child: Text(
                          'عرض جميع المنتجات المدرجة في الخطة الحالية مع امكانية البحث عن منتج معين',
                          style: TextStyle(fontSize: 14.sp, color: const Color(0xFF64748B)),
                        ),
                      ),
                      SizedBox(height: 20.h),

                      // حقل البحث المرتبط بحدث البحث للـ Active Plan
                      _buildFluidAnimation(
                        index: 2,
                        child: SearchField(
                          searchController: searchController,
                          onPressed: (value) {
                            // إطلاق حدث البحث المخصص للخطة الفعالة
                            BlocProvider.of<PlanManagementBloc>(context)
                                .add(SearchActivePlanBrandEvent(value));
                          },
                        ),
                      ),
                      SizedBox(height: 15.h),
                    ],
                  ),
                ),
              ),

              // --- قائمة الكروت المطورة الفخمة مع حماية الـ Empty ---
              planBrandModel.isEmpty
                  ? SliverFillRemaining(
                hasScrollBody: false,
                child: Center(
                  child: emptyFullScreen(
                    context,
                    message: 'لا توجد نتائج مطابقة للبحث في الخطة الفعالة',
                  ),
                ),
              )
                  : SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                        (context, index) {
                      return _buildFluidAnimation(
                        index: index + 3,
                        child: BrandPlanCard(model: planBrandModel[index]),
                      );
                    },
                    childCount: planBrandModel.length,
                  ),
                ),
              ),

              // مساحة أمان سفلية لمنع تداخل الكروت مع الأطراف
              SliverToBoxAdapter(child: SizedBox(height: 40.h)),
            ],
          ),
        );
      },
    );
  }

  // ويدجيت الأنيميشن الانسيابي المنفذ بذكاء لحساب الارتفاعات
  Widget _buildFluidAnimation({required Widget child, required int index}) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 150),
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(0, 30 * (1 - value)),
          child: Transform.scale(
            scale: 0.95 + (0.05 * value),
            child: child,
          ),
        );
      },
      child: child,
    );
  }
}

// ================= 💳 ويدجيت الـ Card المطور والفخم المعتمد على الموديل الجديد =================
class BrandPlanCard extends StatelessWidget {
  final ActivePlanBrandModel model;

  const BrandPlanCard({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25.r),
        border: Border.all(color: ColorManager.black.withValues(alpha: 0.05)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // الهيدر الفاتح للكارد
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            decoration: BoxDecoration(
              color: const Color(0xFFF1F5F9),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25.r),
                topRight: Radius.circular(25.r),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        model.title,
                        style: TextStyle(
                          fontSize: 17.sp,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF1E3A8A),
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        model.pharmaceuticalFormTitle,
                        style: TextStyle(
                          fontSize: 13.sp,
                          color: const Color(0xFF64748B),
                        ),
                      ),
                    ],
                  ),
                ),
                // بناء البادج الخاص بنوع المنتج
                Type.buildBadge(model.type),
              ],
            ),
          ),

          // محتوى الكارد السفلي وعرض قائمة التخصصات والأهداف الموزعة
          Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.bar_chart_rounded, size: 16.sp, color: const Color(0xFF94A3B8)),
                    SizedBox(width: 8.w),
                    Text(
                      "توزيع الأهداف حسب الاختصاص",
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: const Color(0xFF64748B),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12.h),

                // بناء التخصصات الفرعية بداخل الكارد بشكل ديناميكي ومستقر
                ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: model.spPlan.length,
                  itemBuilder: (context, i) {
                    return Container(
                      margin: EdgeInsets.only(bottom: 8.h),
                      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(color: const Color(0xFFF1F5F9)),
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
                              color: const Color(0xFF1E3A8A),
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