// الأزرار السفلية
import 'package:domina_app/app/di.dart';
import 'package:domina_app/presentation/Recipes/pages/recipes_hospital.dart';
import 'package:domina_app/presentation/hospitals/bloc/hospitals_bloc.dart';
import 'package:domina_app/presentation/uniti/stateWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget buildBottomButtons(int hospitalId) {
  return Align(
    alignment: Alignment.bottomCenter,
    child: Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
      ),
      child:  BlocConsumer<HospitalsBloc, HospitalsState>(
        listener: (context, state) {
          if (state is CheckRecipesState) {
       
            if (state.isCheck == true) {
              initBrandRecModule();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RecipesHospital(
                    HospitalId:
                    hospitalId ?? 0,
                    //  docId: doctor.id,
                    st: state.st,
                  ),
                ),
              );
            } else {
              ScaffoldMessenger.of(context)
                  .showSnackBar(
                SnackBar(
                    content: Text(
                        'لقد تجاوزت الحد المسموح لعدد الوصفات')),
              );
            }
          }
          if (state is CheckRecipesErrorState) {
            error(context, state.failure.massage,
                state.failure.code);
          }
        },
        builder: (context, state) {
          return Row(
            children: [
              // زر تكرار
              Expanded(
                child: OutlinedButton.icon(
                  onPressed:
                  state is CheckRecipesLoadingState
                      ? null
                      : () {
                    WidgetsBinding.instance
                        .addPostFrameCallback(
                            (_) {
                          BlocProvider.of<
                              HospitalsBloc>(
                              context)
                              .add(CheckReciEvent(
                              hospitalId
                                  ,
                              1));
                        });
                  },
                  icon: const Icon(Icons.refresh),
                  label: const Text("تكرار وصفة"),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFF0D47A1),
                    side: const BorderSide(color: Color(0xFF0D47A1)),
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.r)),
                  ),
                ),
              ),
              SizedBox(width: 15.w),
              // زر إنشاء
              Expanded(
                child: ElevatedButton.icon(
                  onPressed:
                  state is CheckRecipesLoadingState
                      ? null
                      : () {
                    WidgetsBinding.instance
                        .addPostFrameCallback(
                            (_) {
                          BlocProvider.of<
                              HospitalsBloc>(
                              context)
                              .add(CheckReciEvent(
                              hospitalId ,
                              0));
                        });
                  },
                  icon: const Icon(Icons.add_box_outlined, color: Colors.white),
                  label: const Text("إنشاء وصفة",
                      style: TextStyle(color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0D47A1),
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.r)),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    ),
  );
}
