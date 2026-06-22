// ignore_for_file: deprecated_member_use

import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/brand_plan/bloc/brand_plan_bloc.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../app/user_info.dart';
import 'package:domina_app/presentation/uniti/search_field.dart';
import 'package:domina_app/presentation/uniti/stateWidget.dart';

class BrandPlanActivePage extends StatefulWidget {
  const BrandPlanActivePage({super.key});

  @override
  State<BrandPlanActivePage> createState() => _BrandPlanActivePageState();
}

class _BrandPlanActivePageState extends State<BrandPlanActivePage>
    with AutomaticKeepAliveClientMixin {
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: BlocConsumer<BrandPlanBloc, BrandPlanState>(
        listener: (context, state) {
          if (state is AllBrandPlanErrorState) {
            error(context, state.failure.massage, state.failure.code);
          }
        },
        builder: (context, state) {
          List<BrandSpPlanModel> planBrandModel =
              context.read<BrandPlanBloc>().planBrandActive;

          if (state is SearchBrandState) {
            planBrandModel = state.brand;
          }

          return CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 14.h),
                      _buildFluidAnimation(
                        index: 0,
                        child: Center(
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 12.h),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15.r),
                                border: Border.all(color: Colors.grey.shade100),
                                boxShadow: [
                                  BoxShadow(color: Colors.black.withOpacity(0.01), blurRadius: 10, offset: const Offset(0, 2))
                                ]
                            ),
                            child: Text(
                              "تاريخ الخطة: ${UserInfo.startDate} - ${UserInfo.endDate}",
                              style: TextStyle(
                                  fontSize: 14.sp,
                                  color: ColorManager.medicalPrimary,
                                  fontWeight: FontWeight.w900
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 25.h),
                      _buildFluidAnimation(
                        index: 1,
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
                        index: 2,
                        child: Text(
                          'عرض جميع المنتجات المدرجة في الخطة الحالية مع امكانية البحث عن منتج معين',
                          style: TextStyle(
                              fontSize: 14.sp, color: const Color(0xFF64748B)),
                        ),
                      ),
                      SizedBox(height: 20.h),
                      _buildFluidAnimation(
                        index: 3,
                        child: SearchField(
                          searchController: searchController,
                          onPressed: (value) {
                            BlocProvider.of<BrandPlanBloc>(context).add(
                                SearchBrandEvent(
                                    value: value, brand: planBrandModel));
                          },
                        ),
                      ),
                      SizedBox(height: 15.h),
                    ],
                  ),
                ),
              ),
              planBrandModel.isEmpty
                  ? SliverFillRemaining(
                hasScrollBody: false,
                child: Center(child: emptyFullScreen(context)),
              )
                  : SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                        (context, index) {
                      return _buildFluidAnimation(
                        index: index + 4,
                        child: ActiveBrandPlanCard(model: planBrandModel[index]),
                      );
                    },
                    childCount: planBrandModel.length,
                  ),
                ),
              ),
              SliverToBoxAdapter(child: SizedBox(height: 100.h)),
            ],
          );
        },
      ),
    );
  }

  // ميثود الأنيميشن المعدلة (تم حذف Opacity نهائياً)
  Widget _buildFluidAnimation({required Widget child, required int index}) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 600), // تقليل الوقت لسرعة الحركة
      curve: Interval(
        (index * 0.05).clamp(0.0, 0.5), // تقليل الفارق الزمني بين العناصر
        1.0,
        curve: Curves.easeOutCubic, // حركة انزلاق أكثر سلاسة
      ),
      builder: (context, value, child) {
        // تم حذف الـ Opacity هنا
        return Transform.translate(
          offset: Offset(0, 40 * (1 - value)), // انزلاق للأعلى
          child: Transform.scale(
            scale: 0.95 + (0.05 * value), // تأثير تكبير بسيط
            child: child,
          ),
        );
      },
      child: child,
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class ActiveBrandPlanCard extends StatelessWidget {
  final BrandSpPlanModel model;

  const ActiveBrandPlanCard({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    final bool isGoal = int.parse(model.spPlan[0].brandType) == 1;
    final Color typeColor = isGoal ? const Color(0xFF10B981) : const Color(0xFFF59E0B);

    return Container(
      margin: EdgeInsets.only(bottom: 20.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25.r),
        border: Border.all(color: Colors.grey.shade100),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            decoration: BoxDecoration(
              color: const Color(0xFFE2E8F0),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25.r),
                topRight: Radius.circular(25.r),
              ),
              border: const Border(
                bottom: BorderSide(color: Color(0xFFCBD5E1), width: 1),
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
                        model.brandModel.title,
                        style: TextStyle(
                          fontSize: 17.sp,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF1E3A8A),
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        model.brandModel.phTitle,
                        style: TextStyle(
                          fontSize: 13.sp,
                          color: const Color(0xFF64748B),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding:
                  EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                  decoration: BoxDecoration(
                    color:   isGoal ? ColorManager.secondaryColor1
                        : ColorManager.secondaryColor2,
                    borderRadius:
                    BorderRadius.all(
                      Radius.circular(AppSize.s8),
                    ),
                    ),
                  child: Text(
                    isGoal ? "هدف" : "مساعد",
                    style: TextStyle(
                      color: typeColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 12.sp,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.bar_chart_rounded,
                        size: 16.sp, color: const Color(0xFF94A3B8)),
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
                ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: model.spPlan.length,
                  itemBuilder: (context, i) {

                    return Container(
                      margin: EdgeInsets.only(bottom: 8.h),
                      padding: EdgeInsets.symmetric(
                          horizontal: 14.w, vertical: 12.h),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(color: const Color(0xFFF1F5F9)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            model.spPlan[i].title,
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: const Color(0xFF334155),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            "${model.spPlan[i].amount}",
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