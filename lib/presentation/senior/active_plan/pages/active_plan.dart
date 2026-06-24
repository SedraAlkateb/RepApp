import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/senior/active_plan/bloc/bloc/active_plan_bloc.dart';
import 'package:domina_app/presentation/uniti/search_field.dart';
import 'package:domina_app/presentation/uniti/stateWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ActivePlanPage extends StatefulWidget {
  const ActivePlanPage({super.key});

  @override
  State<ActivePlanPage> createState() => _BrandPlanActivePageState();
}

class _BrandPlanActivePageState extends State<ActivePlanPage>
    with AutomaticKeepAliveClientMixin {

  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC), // خلفية الصفحة رمادي فاتح جداً هادئ
      appBar: AppBar(
        title: const Text('الخطة الفعالة'),
        elevation: 0,
      ),
      body: BlocConsumer<ActivePlanBloc, ActivePlanState>(
        listener: (context, state) {
          if (state is AllActivePlanErrorState) {
            error(context, state.failure.massage, state.failure.code);
          }
        },
        builder: (context, state) {
          // جلب القائمة المفلترة من الـ Bloc
          List<ActivePlanBrandModel> planBrandModel =
              context.watch<ActivePlanBloc>().activePlanSearch;

          if (state is AllActivePlanLoadingState) {
            return loadingShimmer(context, 20, 25, 150, BorderRadius.circular(20));
          }

          return CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              // --- قسم العنوان والبحث ---
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

                      // حقل البحث
                      _buildFluidAnimation(
                        index: 2,
                        child: SearchField(
                          searchController: searchController,
                          onPressed: (value) {
                            BlocProvider.of<ActivePlanBloc>(context)
                                .add(SearchActivePlanEvent(value));
                          },
                        ),
                      ),
                      SizedBox(height: 15.h),
                    ],
                  ),
                ),
              ),

              // --- قائمة الكروت ---
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
                        index: index + 3,
                        child: BrandPlanCard(model: planBrandModel[index]),
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

  // ويدجيت الأنيميشن الانسيابي مع إصلاح مشكلة الـ Opacity
  Widget _buildFluidAnimation({required Widget child, required int index}) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 100),
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(0, 50 * (1 - value)),
          child: Transform.scale(
            scale: 0.9 + (0.1 * value),
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

// ويدجيت الـ Card المطور
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
          // Header
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            decoration: BoxDecoration(
              color: const Color(0xFFF1F5F9), // خلفية فاتحة جداً للهيدر
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
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                  decoration: BoxDecoration(
                    color: model.type.color.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(10.r),
                    border: Border.all(color: const Color(0xFFE2E8F0)),
                  ),
                  child: Text(
                    model.type.name,
                    style: TextStyle(
                      color:  model.type.color,
                      fontWeight: FontWeight.bold,
                      fontSize: 12.sp,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Content
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

                // Specialty List
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