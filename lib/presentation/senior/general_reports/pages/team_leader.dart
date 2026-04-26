// ignore_for_file: must_be_immutable
import 'package:domina_app/app/di.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/senior/general_reports/bloc/bloc/general_reports_bloc.dart';
import 'package:domina_app/presentation/senior/general_reports/pages/senior-by-cityid.dart';
import 'package:domina_app/presentation/uniti/stateWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class TeamLeader extends StatefulWidget {
  const TeamLeader({super.key});

  @override
  State<TeamLeader> createState() => _TeamLeaderState();
}

class _TeamLeaderState extends State<TeamLeader>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("إدارة التقارير العامة"),
      ),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // 1. الهيدر: يظهر فوراً ولا يسبب Overflow لأنه داخل SliverToBoxAdapter
          SliverToBoxAdapter(
            child: _buildHeader(context),
          ),

          // 2. المحتوى: يتم التحكم به عبر BlocBuilder ولكن داخل نظام الـ Slivers
          BlocBuilder<GeneralReportsBloc, GeneralReportsState>(
            builder: (context, state) {
              List<SeniorCityModel> seniors =
                  context.watch<GeneralReportsBloc>().dataseniors;

              // حالة التحميل: نستخدم SliverFillRemaining لمنع الخطأ
              if (state is TeamLeaderAndCityLoadingState) {
                return SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(
                    child: loadingShimmer(context, 8, 25, 25, BorderRadius.circular(20)),
                  ),
                );
              }

              // حالة الخطأ
              if (state is TeamLeaderAndCityErrorState) {
                return SliverFillRemaining(
                  hasScrollBody: false,
                  child: errorFullScreen(context, func: () {}),
                );
              }

              // حالة القائمة الفارغة
              if (seniors.isEmpty) {
                return SliverFillRemaining(
                  hasScrollBody: false,
                  child: emptyFullScreen(context),
                );
              }

              // حالة عرض البيانات: نستخدم SliverList بدلاً من ListView العادي
              return SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                sliver: AnimationLimiter(
                  child: SliverList(
                    delegate: SliverChildBuilderDelegate(
                          (context, index) {
                        return AnimationConfiguration.staggeredList(
                          position: index,
                          duration: const Duration(milliseconds: 500),
                          delay: const Duration(milliseconds: 50),
                          child: SlideAnimation(
                            verticalOffset: 30.0,
                            child: FadeInAnimation(
                              child: _buildRepSmartCard(context, seniors[index]),
                            ),
                          ),
                        );
                      },
                      childCount: seniors.length,
                    ),
                  ),
                ),
              );
            },
          ),

          // مسافة أمان سفلية
          const SliverToBoxAdapter(child: SizedBox(height: 30)),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 25, 20, 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("تيم ليدر دومنا",
                  style: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                      color: ColorManager.medicalPrimary)),
              const SizedBox(height: 4),
              Text("قائمة التيم ليدر المتاحين في دومنا ",
                  style: TextStyle(color: Colors.grey.shade500, fontSize: 13.sp)),
            ],
          ),
          Container(
            height: 5, width: 45,
            decoration: BoxDecoration(
              color: const Color(0xFF42A5F5),
              borderRadius: BorderRadius.circular(10),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildRepSmartCard(BuildContext context, SeniorCityModel senior) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.blue.withOpacity(0.05), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: InkWell(
          onTap: () {
            initGeneralReportsModule();
            Navigator.push(context, MaterialPageRoute(
              builder: (context) => SeniorByCityId(
                cityname: senior.city_name,
                cityid: int.parse(senior.city_id),
              ),
            ));
            BlocProvider.of<GeneralReportsBloc>(context)
                .add(GetSeniorByCityIdEvent(int.parse(senior.city_id)));
          },
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: ColorManager.secondaryColor1.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.person_pin_rounded,
                      color: ColorManager.secondaryColor1),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        senior.rep_name,
                        style: TextStyle(
                          fontSize: 17.sp,
                          fontWeight: FontWeight.w700,
                          color: ColorManager.secondaryColor1,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "اضغط لاستعراض السينيور في ${senior.city_name}",
                        style: TextStyle(fontSize: 11.sp, color: Colors.grey.shade400),
                      ),
                    ],
                  ),
                ),
                Icon(Icons.arrow_forward_ios_rounded,
                    size: 18, color: Colors.grey.shade300),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}