import 'package:domina_app/app/di.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/senior/finished_plan/bloc/finished_plan_bloc.dart';
import 'package:domina_app/presentation/senior/finished_plan/page/report_finished_plan_user_page.dart';
import 'package:domina_app/presentation/uniti/search_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// 🌟 تم تحويل الكلاس إلى StatefulWidget لإنشاء وإدارة الـ TextEditingController الخاص بالبحث
class PlanRepsPage extends StatefulWidget {
  const PlanRepsPage({Key? key}) : super(key: key);

  @override
  State<PlanRepsPage> createState() => _PlanRepsPageState();
}

class _PlanRepsPageState extends State<PlanRepsPage> {
  // 🔍 متحكم حقل إدخال البحث لمراقبة النص ومسحه عند الحاجة
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    // 🛡️ تنظيف الـ Controller من الذاكرة فور إغلاق الصفحة لمنع تسريب الذاكرة (Memory Leak)
    _searchController.dispose();
    super.dispose();
  }

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
          // 1. هيدر الصفحة الرئيسي
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.fromLTRB(25.w, 20.h, 25.w, 10.h),
              child: _buildHeader(),
            ),
          ),

          // 🌟 2. شريط البحث الجديد (تم إضافته كـ Sliver مخصص)
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
              child:
              SearchField(
                  searchController: _searchController,
                  onPressed: (value) {
                    context.read<FinishedPlanBloc>().add(SearchPlanRepsEvent(value));
                  }),
            ),
          ),

          // 3. قائمة المندوبين المستمدة من الـ Bloc
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
                // 💡 التحقق في حال كانت القائمة المفلترة الممررة من الـ State فارغة (لا توجد نتائج بحث)
                if (state.reps.isEmpty) {
                  return SliverFillRemaining(
                    hasScrollBody: false,
                    child: Center(
                      child: Text(
                        'لا يوجد نتائج تطابق البحث',
                        style: TextStyle(color: Colors.grey, fontSize: 14.sp),
                      ),
                    ),
                  );
                }

                // عرض القائمة الحالية (المفلترة تلقائياً عبر الـ State)
                return SliverPadding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                          (context, index) {
                        return RepCard(
                          repName: state.reps[index],
                          repPlanId: int.parse(state.reps[index].repPlan),
                        );
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
  final PlanRepsModel repName;
  final int repPlanId;
  const RepCard({Key? key, required this.repName, required this.repPlanId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.r),
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
        leading: CircleAvatar(
          backgroundColor: ColorManager.medicalPrimary.withOpacity(0.1),
          child: Icon(Icons.person, color: ColorManager.medicalPrimary, size: 20.sp),
        ),
        title: Text(
          repName.name,
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          size: 14.sp,
          color: Colors.grey[400],
        ),
        onTap: () {
          initSeniorProfModule();
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ReportFinishedPlanUserPage(
                    id: int.parse(repName.id), repPlanId: repPlanId, name: repName.name),
              ));
        },
      ),
    );
  }
}