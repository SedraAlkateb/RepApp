import 'package:domina_app/app/di.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/senior/places/bloc/senior_reps_bloc.dart';
import 'package:domina_app/presentation/senior/places/widget/rep_card_widget.dart';
import 'package:domina_app/presentation/senior/representative/bloc/senior_prof_bloc.dart';
import 'package:domina_app/presentation/senior/representative/page/rep_profile.dart';
import 'package:domina_app/presentation/uniti/search_field.dart';
import 'package:domina_app/presentation/uniti/stateWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class AllRepSenior extends StatefulWidget {
  final int cityId;
  final String cityname;
  final int repId;

  const AllRepSenior({
    super.key,
    required this.cityId,
    required this.cityname,
    required this.repId,
  });

  @override
  State<AllRepSenior> createState() => _AllRepSeniorState();
}

class _AllRepSeniorState extends State<AllRepSenior> {
  final TextEditingController _searchController = TextEditingController();
  final RefreshController _refreshController = RefreshController(initialRefresh: false);

  @override
  void dispose() {
    _searchController.dispose();
    _refreshController.dispose();
    super.dispose();
  }

  // --- Logic Functions ---

  void _onRefresh() {
    context.read<SeniorRepsBloc>().add(AllSeniorRepEvent(
      widget.cityId,
      widget.repId
    ));
    _refreshController.refreshCompleted();
  }

  void _navigateToProfile(BuildContext context, AllRepresentative rep, int index) {
    initSeniorProfModule();
    context.read<SeniorProfBloc>().add(getInfoRepEvent(rep.id));

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => RepProfile(
          index: index,
          repPlanId: rep.activePlan,
          id: rep.id,
        ),
      ),
    );
  }

  // --- UI Components ---

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
              // 1. Header Section (Title & Search)
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(25.w, 20.h, 25.w, 0),
                  child: _buildHeader(),
                ),
              ),

              // 2. Search Field Section
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
              // 3. Representatives List Section
              SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                sliver: _buildRepsList(),
              ),

              // Bottom Spacer
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
        Text(
          'إدارة المندوبين',
          style: TextStyle(
            fontSize: 24.sp,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF1F4E79),
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          'اختر مندوباً لمراجعة الأداء والتقارير',
          style: TextStyle(fontSize: 14.sp, color: Colors.grey),
        ),
      ],
    );
  }

  Widget _buildRepsList() {
    return BlocBuilder<SeniorRepsBloc, SeniorRepsState>(
      builder: (context, state) {
        // هنا نقوم بجلب القائمة الحالية من الـ Bloc
        // تأكد أن الـ Bloc الخاص بك يقوم بتحديث قائمة allRepresentative عند البحث
        List<AllRepresentative> list = context.read<SeniorRepsBloc>().allRepresentative;

        if (state is AllSeniorRepLoadingState) {
          return SliverToBoxAdapter(
       //     hasScrollBody: false,
            child: Center(child:
            loadingShimmer(context, 5, 100, 20, BorderRadius.circular(20))),
          );
        }

        if (state is AllSeniorRepErrorState) {
          return SliverToBoxAdapter(
            child: errorFullScreen(context, func: _onRefresh),
          );
        }

        // تحديث القائمة إذا كانت الحالة هي حالة نجاح البحث أو جلب البيانات
        if (state is AllSeniorRepState) {
          list = state.representatives;
        }

        if (list.isEmpty) {
          return SliverFillRemaining(
            hasScrollBody: false,
            child: emptyFullScreen(context),
          );
        }

        return SliverList(
          delegate: SliverChildBuilderDelegate(
                (context, index) {
              final rep = list[index];
              return Padding(
                padding: EdgeInsets.only(bottom: 15.h),
                child: RepresentativeCard(allRepresentative: rep,
                  onTap: () {
                    // 1. تهيئة موديل البروفايل
                    initSeniorProfModule();

                    // 2. إرسال حدث جلب بيانات المندوب المحدد
                    context.read<SeniorProfBloc>().add(
                      getInfoRepEvent(rep.id),
                    );

                    // 3. الانتقال لصفحة البروفايل مع تمرير البيانات المطلوبة
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => RepProfile(
                          index: index,
                          repPlanId: rep.activePlan,
                          id: rep.id,
                        ),
                      ),
                    );
                  },
                ),
              );
            },
            childCount: list.length,
          ),
        );
      },
    );
  }
}