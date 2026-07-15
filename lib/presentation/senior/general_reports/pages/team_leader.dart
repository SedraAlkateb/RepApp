// ignore_for_file: must_be_immutable
import 'package:domina_app/app/di.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/senior/general_reports/bloc/bloc/general_reports_bloc.dart';
import 'package:domina_app/presentation/senior/general_reports/pages/all-rep-general-reports.dart';
import 'package:domina_app/presentation/senior/places/bloc/senior_reps_bloc.dart';
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
          // 1. الهيدر
          SliverToBoxAdapter(
            child: _buildHeader(context),
          ),

          // 2. المحتوى المعالج برمجياً بطريقة ذكية تمنع الـ Render Exception
          BlocBuilder<GeneralReportsBloc, GeneralReportsState>(
            builder: (context, state) {
              // ⚠️ تم تغيير watch إلى read هنا لأننا داخل الـ builder الخاص بالـ BlocBuilder لتجنب التكرار 불필요
              List<SeniorCityModel> seniors =
                  context.read<GeneralReportsBloc>().dataseniors;

              final double availableHeight = MediaQuery.of(context).size.height * 0.6;

              // 🟢 حالة التحميل: استخدام SliverToBoxAdapter بدلاً من SliverFillRemaining
              if (state is TeamLeaderAndCityLoadingState) {
                return SliverToBoxAdapter(
                  child: SizedBox(
                    height: availableHeight,
                    child: Center(
                      child: loadingShimmer(context, 8, 25, 25, BorderRadius.circular(20)),
                    ),
                  ),
                );
              }

              // 🟢 حالة الخطأ
              if (state is TeamLeaderAndCityErrorState) {
                return SliverToBoxAdapter(
                  child: SizedBox(
                    height: availableHeight,
                    child: errorFullScreen(context, func: () {}),
                  ),
                );
              }

              // 🟢 حالة القائمة الفارغة
              if (seniors.isEmpty) {
                return SliverToBoxAdapter(
                  child: SizedBox(
                    height: availableHeight,
                    child: emptyFullScreen(context),
                  ),
                );
              }

              // حالة عرض البيانات الطبيعية
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
            initSeniorModule();
            Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return AllRepSeniorGenerlReports(
                  cityname: senior.city_name,
                  cityId: int.parse(senior.city_id),
                  repId: int.parse(senior.rep_id),
                );
              },
            ));
            print("rep_id:${senior.rep_id}");
            BlocProvider.of<SeniorRepsBloc>(context).add(
                AllSeniorRepEvent(
                    int.parse(senior.city_id),
                    int.parse(senior.rep_id)
                ));
            // ملاحظة: تفعيل الـ Module مسبقاً قبل التوجيه لمنع مشاكل الـ GetIt
            // initGeneralReportsModule();
            // Navigator.push(context, MaterialPageRoute(
            //   builder: (context) => SeniorByCityId(
            //     cityname: senior.city_name,
            //     cityid: int.parse(senior.city_id),
            //   ),
            // ));
            // BlocProvider.of<GeneralReportsBloc>(context)
            //     .add(GetSeniorByCityIdEvent(int.parse(senior.city_id)));
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