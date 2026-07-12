import 'package:domina_app/app/di.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/senior/all_city/bloc/bloc/all_city_bloc.dart';
import 'package:domina_app/presentation/senior/general_reports/bloc/bloc/general_reports_bloc.dart';
import 'package:domina_app/presentation/senior/general_reports/pages/senior-by-cityid.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/uniti/stateWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class AllCitySeniors extends StatefulWidget {
  const AllCitySeniors({super.key});

  @override
  State<AllCitySeniors> createState() => _AllCityState();
}

class _AllCityState extends State<AllCitySeniors> {

  @override
  void initState() {
    BlocProvider.of<AllCityBloc>(context).add(const GetAllCityEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC), // خلفية طبية باردة
      appBar: AppBar(
        title: const Text('المناطق والمدن'),
      ),
      body: bodyBuild(context),
    );
  }

  Widget bodyBuild(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 1. قسم العنوان والوصف (Header Section)
        _buildHeader(),
        // 3. قائمة المدن مع الأنيميشن
        Expanded(
          child: BlocBuilder<AllCityBloc, AllCityState>(
            builder: (context, state) {
              if (state is GetAllCityState) {
                final List<CityModel> cities = state.cities;
                return
                  cities.isEmpty?emptyFullScreen(context):
                  AnimationLimiter(
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 20),
                    itemCount: cities.length,
                    itemBuilder: (context, index) {
                      return AnimationConfiguration.staggeredList(
                        position: index,
                        duration: const Duration(milliseconds: 500),
                        delay: const Duration(milliseconds: 50),
                        child: SlideAnimation(
                          verticalOffset: 30.0,
                          child: FadeInAnimation(
                            child: _buildCitySmartCard(cities[index], index),
                          ),
                        ),
                      );
                    },
                  ),
                );
              }
              if (state is AllCityLoadingState) {
                return loadingShimmer(context, 20, 25, 70, BorderRadius.circular(20));
              }
              if (state is AllCityErrorState) {
                return errorFullScreen(context,
                    func: () => BlocProvider.of<AllCityBloc>(context).add(const GetAllCityEvent()));
              }
              return const SizedBox();
            },
          ),
        ),
      ],
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("دليل المناطق",
                  style: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                      color: ColorManager.medicalPrimary)),
              const SizedBox(height: 4),
              Text("اختر المنطقة لاستعراض السينيور فيها",
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 13.sp)),
            ],
          ),
          // الخط الجمالي الأزرق المميز
          Container(
            height: 5,
            width: 40,
            decoration: BoxDecoration(
              color: const Color(0xFF42A5F5),
              borderRadius: BorderRadius.circular(10),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildCitySmartCard(CityModel city, int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.blue.withOpacity(0.05), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: () {
          initGeneralReportsModule();
          Navigator.push(context, MaterialPageRoute(
            builder: (context) => SeniorByCityId(
              cityname: city.title,
              cityid: city.id,
            ),
          ));
          BlocProvider.of<GeneralReportsBloc>(context).add(GetSeniorByCityIdEvent(city.id));
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Row(
            children: [
              // أيقونة المنطقة بتصميم دائري
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: ColorManager.secondaryColor1.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.location_city, color: ColorManager.secondaryColor1),
              ),
              const SizedBox(width: 16),
              // اسم المدينة
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      city.title,
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: ColorManager.secondaryColor1,
                      ),
                    ),
                    Text(
                      "استعراض كافة البيانات",
                      style: TextStyle(fontSize: 12.sp, color: Colors.grey),
                    ),
                  ],
                ),
              ),
              // سهم الانتقال
              Icon(Icons.arrow_forward_ios_rounded,
                  size: 18, color: Colors.grey.shade400),
            ],
          ),
        ),
      ),
    );
  }
}