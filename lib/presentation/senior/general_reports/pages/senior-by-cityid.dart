// ignore_for_file: must_be_immutable, file_names
import 'package:domina_app/app/di.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/senior/general_reports/bloc/bloc/general_reports_bloc.dart';
import 'package:domina_app/presentation/senior/general_reports/pages/all-rep-general-reports.dart';
import 'package:domina_app/presentation/senior/places/bloc/senior_reps_bloc.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/uniti/stateWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class SeniorByCityId extends StatelessWidget {
  final String cityname;
  final int cityid;
  const SeniorByCityId({super.key, required this.cityid, required this.cityname});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(cityname),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. الهيدر يظهر فوراً خارج الـ BlocBuilder لضمان عدم التأخر
          _buildHeader(context),

          // 2. قائمة المناديب أو اللودينج
          BlocBuilder<GeneralReportsBloc, GeneralReportsState>(
            builder: (context, state) {
              List<SeniorCityModel> seniors =
                  context.watch<GeneralReportsBloc>().dataseniorsbycityid;

              if (state is SeniorByCityIdState) {
                seniors = state.data;
              }

              // حل مشكلة الـ Overflow أثناء التحميل بوضع الشيمر داخل Expanded
              if (state is SeniorByCityIdLoadingState) {
                return Expanded(
                  child: loadingShimmer(context, 10, 20, 20, BorderRadius.circular(20)),
                );
              }

              if (state is SeniorByCityIdErrorState) {
                return Expanded(child: errorFullScreen(context, func: () {}));
              }

              if (state is SeniorByCityIdEmptyState || seniors.isEmpty) {
                return Expanded(child: emptyFullScreen(context));
              }

              return Expanded(
                child: AnimationLimiter(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    physics: const BouncingScrollPhysics(),
                    itemCount: seniors.length,
                    itemBuilder: (context, index) {
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
                  ),
                ),
              );
            },
          ),
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
              Text("سينيور المنطقة",
                  style: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                      color: ColorManager.medicalPrimary)),
              const SizedBox(height: 4),
              Text("قائمة السينيور المتاحين في $cityname",
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
            BlocProvider.of<SeniorRepsBloc>(context).add(
                AllSeniorRepEvent(
                    int.parse(senior.city_id),
                    int.parse(senior.rep_id)
                ));
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
                  child: Icon(Icons.person_pin_rounded, color: ColorManager.secondaryColor1),
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
                        "اضغط لاستعراض تقارير المندوبين",
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
}