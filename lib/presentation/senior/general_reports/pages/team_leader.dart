// ignore_for_file: must_be_immutable
import 'package:domina_app/app/di.dart';
import 'package:domina_app/domain/models/models.dart';

import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/resources/values_manager.dart';
import 'package:domina_app/presentation/senior/general_reports/bloc/bloc/general_reports_bloc.dart';
import 'package:domina_app/presentation/senior/general_reports/pages/all-rep-general-reports.dart';
import 'package:domina_app/presentation/senior/general_reports/pages/general_reports.dart';
import 'package:domina_app/presentation/senior/places/bloc/senior_reps_bloc.dart';
import 'package:domina_app/presentation/uniti/stateWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
        title: Text("إدارة التقارير العامة"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(context),
          BlocBuilder<GeneralReportsBloc, GeneralReportsState>(
            builder: (context, state) {
              List<SeniorCityModel> seniors =
                  context.watch<GeneralReportsBloc>().dataseniors;
              if (state is SeniorByCityIdState) {
                seniors = state.data;
              }
              if (state is SeniorByCityIdLoadingState) {
                return loadingShimmer(
                    context, 8, 25, 25, BorderRadius.circular(20));
              }
              if (state is SeniorByCityIdErrorState) {
                return errorFullScreen(context, func: () {});
              }
              return Expanded(
                  child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return _buildRepSmartCard(context, seniors[index]);
                    },
                    itemCount: seniors.length),
              ));
            },
          ),
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
                return GeneralReports(
                  //            cityname:  seniors[index].city_name,
                  // cityId:int.parse(seniors[index].city_id)  ,
                  //            repId:int.parse(seniors[index].rep_id)  ,
                );
              },
            ));
            BlocProvider.of<SeniorRepsBloc>(context).add(
                AllSeniorRepEvent(
                    int.parse(senior.city_id
                    ),
                    int.parse(senior.rep_id)
                ));
          },
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Row(
              children: [
                // أيقونة المندوب الشخصية بتصميم دائري ناعم
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: ColorManager.secondaryColor1.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.person_pin_rounded, color: ColorManager.secondaryColor1),
                ),
                const SizedBox(width: 16),

                // اسم المندوب
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20,),
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
                ),

                // سهم الانتقال
                Icon(Icons.arrow_forward_ios_rounded,
                    size: 18, color: Colors.grey.shade300),
              ],
            ),
          ),
        ),
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
          // الخط الجمالي الأزرق لضمان تناسق التصميم
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

  @override
  bool get wantKeepAlive => true;
}
