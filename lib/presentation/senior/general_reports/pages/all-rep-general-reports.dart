import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/senior/general_reports/pages/doctors-hospitals-reports.dart';
import 'package:domina_app/presentation/senior/places/bloc/senior_reps_bloc.dart';
import 'package:domina_app/presentation/uniti/search_field.dart';
import 'package:domina_app/presentation/uniti/stateWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class AllRepSeniorGenerlReports extends StatefulWidget {
  final int cityId;
  final String cityname;
  final int repId;

  const AllRepSeniorGenerlReports({
    super.key,
    required this.cityId,
    required this.cityname,
    required this.repId,
  });

  @override
  State<AllRepSeniorGenerlReports> createState() => _AllRepSeniorGenerlReportsState();
}

class _AllRepSeniorGenerlReportsState extends State<AllRepSeniorGenerlReports> {
  final TextEditingController _searchController = TextEditingController();
  final RefreshController _refreshController = RefreshController(initialRefresh: false);

  @override
  void dispose() {
    _searchController.dispose();
    _refreshController.dispose();
    super.dispose();
  }

  // --- منطق التحديث ---
  void _onRefresh() {
    BlocProvider.of<SeniorRepsBloc>(context).add(
      AllSeniorRepEvent(widget.cityId, widget.repId),
    );
    _refreshController.refreshCompleted();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('تقارير المندوبين (${widget.cityname})'),
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: SmartRefresher(
          controller: _refreshController,
          onRefresh: _onRefresh,
          enablePullDown: true,
          header: const WaterDropHeader(),
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              // 1. قسم العنوان الفرعي (Header)
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(25.w, 20.h, 25.w, 0),
                  child: _buildHeader(),
                ),
              ),

              // 2. حقل البحث
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
                  child: SearchField(
                    searchController: _searchController,
                    onPressed: (value) {
                      context.read<SeniorRepsBloc>().add(SenSearchRepEvent(value));
                    },
                  ),
                ),
              ),

              // 3. قائمة المناديب
              SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                sliver: _buildRepsList(),
              ),

              // مسافة أمان سفلية
              SliverToBoxAdapter(child: SizedBox(height: 50.h)),
            ],
          ),
        ),
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
              'إدارة التقارير',
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
          'استعراض تقارير المندوبين ومراقبة السينيور',
          style: TextStyle(fontSize: 14.sp, color: Colors.grey),
        ),
      ],
    );
  }

  Widget _buildRepsList() {
    return BlocBuilder<SeniorRepsBloc, SeniorRepsState>(
      builder: (context, state) {
        List<AllRepresentative> list = context.watch<SeniorRepsBloc>().allRepresentative;

        if (state is AllSeniorRepLoadingState) {
          return SliverToBoxAdapter(
            child: Center(child: loadingShimmer(context, 5, 100, 20, BorderRadius.circular(20))),
          );
        }

        if (state is AllSeniorRepErrorState) {
          return SliverToBoxAdapter(
            child: errorFullScreen(context, func: _onRefresh),
          );
        }

        if (state is AllSeniorRepState) {
          list = state.representatives;
        }

        if (list.isEmpty) {
          return SliverFillRemaining(
            hasScrollBody: false,
            child: emptyFullScreen(context),
          );
        }

        return AnimationLimiter(
          child: SliverList(
            delegate: SliverChildBuilderDelegate(
                  (context, index) {
                final rep = list[index];
                return AnimationConfiguration.staggeredList(
                  position: index,
                  duration: const Duration(milliseconds: 500),
                  child: SlideAnimation(
                    verticalOffset: 50.0,
                    child: FadeInAnimation(
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 15.h),
                        child: _buildRepReportCard(rep, index),
                      ),
                    ),
                  ),
                );
              },
              childCount: list.length,
            ),
          ),
        );
      },
    );
  }

  Widget _buildRepReportCard(AllRepresentative rep, int index) {
    return Container(
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
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(15.r),
          onTap: () {
            // الحفاظ على نفس الـ onTap الأصلي
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) {
                return DoctorsHospitalsReports(
                  repName: rep.name,
                  indexRep: index,
                  senId: widget.repId,
                  repId: rep.id,
                  phone: rep.number.toString(),
                );
              },
            ));
          },
          child: Padding(
            padding: EdgeInsets.all(16.w),
            child: Row(
              children: [
                // أيقونة دائرية باسم المندوب أو رمز
                Container(
                  width: 50.w,
                  height: 50.w,
                  decoration: BoxDecoration(
                    color: ColorManager.medicalPrimary.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.assessment_outlined, color: ColorManager.medicalPrimary),
                ),
                SizedBox(width: 15.w),
                // بيانات المندوب
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        rep.name,
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          color: ColorManager.secondaryColor1,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        "عدد الزيارات غير المقروءة: ${rep.number}",
                        style: TextStyle(fontSize: 12.sp, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
                // أيقونة السهم
                Icon(Icons.arrow_forward_ios_rounded, size: 18.sp, color: Colors.grey.shade400),
              ],
            ),
          ),
        ),
      ),
    );
  }
}