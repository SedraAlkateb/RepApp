import 'package:domina_app/presentation/Recipes/widget/hospital_recipe.dart';
import 'package:domina_app/presentation/plase_visit/widget/build_card_buttom.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/resources/routes_manager.dart';
import 'package:domina_app/presentation/specialization/bloc/specialization_bloc.dart';
import 'package:domina_app/presentation/uniti/stateWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HospitalSp extends StatefulWidget {
  @override
  _HospitalSpState createState() => _HospitalSpState();
}

class _HospitalSpState extends State<HospitalSp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BlocConsumer<SpecializationBloc, SpecializationState>(
              listener: (context, state) {
                if (state is AllSpecDoctorErrorState) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    error(context, state.failure.massage, state.failure.code);
                  });
                }
              },
              builder: (context, state) {
                if (state is AllHospitalSpState) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
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
                                  " ${state.hospitals.length} مشفى",
                                  style: TextStyle(
                                      color: ColorManager.medicalPrimary,
                                      fontSize: 11.sp),
                                ),
                              ),
                            ],
                          ),
                        ),
                        state.hospitals.length == 0
                            ? Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(
                              horizontal: 20.w, vertical: 90.h),
                          margin: EdgeInsets.all(20)
                          ,
                          decoration: BoxDecoration(
                            color: ColorManager.white,
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Column(

                            children: [
                              Icon(
                                color: ColorManager.medicalMuted,
                                Icons.person_outline,size: 60,fontWeight: FontWeight.w100,),
                              SizedBox(height: 20.h,),
                              Text(
                                textAlign: TextAlign.center,
                                "لا يوجد مشافي مسجلين في هذا الاختصاص",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: ColorManager.medicalPrimary,
                                    fontSize: 20.sp),
                              ),
                            ],
                          ),
                        )
                            : ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return
                              Container(
                                margin: EdgeInsets.only(
                                    bottom: 16.h, right: 8.w, left: 8.w),
                                padding: EdgeInsets.all(16.w),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15.r),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black
                                          .withOpacity(0.08), // درجة غمق الظل
                                      blurRadius: 15, // مدى نعومة الظل
                                      spreadRadius: 0, // مدى انتشار الظل
                                      offset: const Offset(0,
                                          6), // إزاحة الظل للأسفل ليعطي عمقاً (Shadow Offset)
                                    ),
                                  ],
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [

                                    Text(
                                        state.hospitals[index].title,
                                        style: TextStyle(
                                            fontSize: 18.sp, fontWeight: FontWeight.bold, color: ColorManager.medicalPrimary)),
                                    SizedBox(height: 10.h),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Icon(Icons.location_on_outlined,size: 22.sp,color: Colors.grey),
                                        SizedBox(width: 8.w,),
                                        Expanded(
                                          child: Text(state.hospitals[index].placeTitle,
                                              style: TextStyle
                                                (color: Colors.grey,
                                                  fontSize: 15.sp)),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10.h),
                                    state.hospitals[index].note!=null?
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Icon(Icons.note_alt_sharp,size: 22.sp,color: Colors.grey),
                                        SizedBox(width: 8.w,),
                                        Expanded(
                                          child: Text(state.hospitals[index].note??"",
                                              style: TextStyle
                                                (color: Colors.grey,
                                                  fontSize: 15.sp)),
                                        ),
                                      ],
                                    ):SizedBox(),
                                    SizedBox(height: 16.h),
                                    Divider(color:  Colors.grey,thickness: 0.1,),
                                    SizedBox(height: 8.h),
                                    // أزرار الأكشن
                                    Row(
                                      children: [
                                        PrescriptionHospitalMenuWidget(hospitalId: state.hospitals[index].id),
                                        const Spacer(),
                                        // InkWell(
                                        //   onTap: () => Navigator.pushNamed(
                                        //       context, Routes.hospitalDetails,
                                        //       arguments:  state.hospitals[index]),
                                        //   child: buildCardButton(
                                        //       "عرض التفاصيل",
                                        //       ColorManager.medicalPrimary,
                                        //       Colors.white,
                                        //       Icons.directions_run),
                                        // ),

                                      ],
                                    ),
                                  ],
                                ),
                              );
                          },
                          itemCount: state.hospitals.length,
                        ),
                      ],
                    ),
                  );
                }

                return SizedBox();
              },
            ),
          ],
        ),
      ),
    );
  }
}
