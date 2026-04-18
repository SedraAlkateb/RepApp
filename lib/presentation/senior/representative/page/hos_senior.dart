import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/senior/representative/bloc/senior_prof_bloc.dart';
import 'package:domina_app/presentation/senior/representative/widget/hos_card.dart';
import 'package:domina_app/presentation/uniti/search_field.dart';
import 'package:domina_app/presentation/uniti/stateWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HospitalSenior extends StatelessWidget {
  HospitalSenior({super.key});
  final TextEditingController searchHosController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC), // خلفية هادئة تبرز البطاقات
      appBar: AppBar(
        title: const Text('أرشيف المشافي'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(12.w, 16.h, 12.w, 0),
              child: SearchField(
                searchController: searchHosController,
                onPressed: (value) {
                  BlocProvider.of<SeniorProfBloc>(context).add(SenSearchHospEvent(value));
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.w,vertical: 20.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "قائمة المشافي المسجين",
                    style: TextStyle(
                        color: ColorManager.medicalText
                            .withOpacity(0.8),
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: 12.w, vertical: 4.h),
                    decoration: BoxDecoration(
                      color: ColorManager.medicalPrimary
                          .withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Text(
                      " ${context.watch<SeniorProfBloc>().hospital.length} مشفى",
                      style: TextStyle(
                          color: ColorManager.medicalPrimary,
                          fontSize: 11.sp),
                    ),
                  ),
                ],
              ),
            ),
            // 2. القائمة باستخدام BlocBuilder
            BlocBuilder<SeniorProfBloc, SeniorProfState>(
              builder: (context, state) {
                // جلب البيانات من الـ Bloc
                List<HospitalModel> hospitalModel = context.watch<SeniorProfBloc>().hospital;

                if (state is SenAllHospitalsState) {
                  hospitalModel = state.hospital;
                }
                if (state is SenAllHospitalLoadingState) return loadingFullScreen(context);
                if (state is SenAllHospitalEmptyState) return emptyFullScreen(context);
                if (state is SenAllHospitalErrorState) return errorFullScreen(context);
                return ListView.builder(
                  padding: EdgeInsets.all(16.w),
                   physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: hospitalModel.length ,
                  itemBuilder: (context, index) {
                    return HospitalCardWidget(hospital: hospitalModel[index]);
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}