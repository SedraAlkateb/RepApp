import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/doctors/bloc/doctors_bloc.dart';
import 'package:domina_app/presentation/plase_visit/widget/build_card_buttom.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/resources/routes_manager.dart';
import 'package:domina_app/presentation/uniti/search_field.dart';
import 'package:domina_app/presentation/uniti/stateWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Doctors extends StatelessWidget {
  Doctors({super.key});
  final TextEditingController searchDocController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('الأطباء'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 12.h,
                  ),
                  SearchField(
                    searchController: searchDocController,
                    onPressed: (value) {
                      BlocProvider.of<DoctorsBloc>(context)
                          .add(SearchDocEvent(value));
                    },
                  ),
                ],
              ),
            ),
            BlocBuilder<DoctorsBloc, DoctorsState>(
              buildWhen: (previous, current) => current is AllDoctorState||current is AllDoctorEmptyState,

              builder: (context, state) {
                List<DoctorModel> doctorModel=context.watch<DoctorsBloc>().doctor;
                if (state is AllDoctorState) {
                  doctorModel = state.doctor;
                }
                if (state is AllDoctorErrorState) {
                 return errorFullScreen(context,mes:  state.failure.massage, func: (){});
                }
                if (state is AllDoctorEmptyState) {
                  return SliverList(
                      delegate: SliverChildListDelegate([
                        SizedBox(
                          height: 100,
                        ),
                        emptyFullScreen(context)
                      ]));
                }
                  return SliverList(
                    delegate: SliverChildListDelegate([
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w,vertical: 20.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "قائمة الاطباء المسجين",
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
                                " ${doctorModel.length} طبيب",
                                style: TextStyle(
                                    color: ColorManager.medicalPrimary,
                                    fontSize: 11.sp),
                              ),
                            ),
                          ],
                        ),
                      ),
                      ...doctorModel.map((doctor) {
                        return Container(
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
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
                                    decoration: BoxDecoration(
                                      color: Colors.blue.shade50,
                                      borderRadius: BorderRadius.circular(8.r),
                                    ),
                                    child: Text(doctor.spTitle , style
                                        : TextStyle(color: Colors.blue, fontSize: 12.sp)),
                                  ),
                                  Expanded(
                                    child: Text(
                                        textAlign: TextAlign.end,
                                        doctor.title,
                                        style: TextStyle(
                                            fontSize: 18.sp, fontWeight: FontWeight.bold, color: ColorManager.medicalPrimary)),
                                  ),

                                ],
                              ),
                              SizedBox(height: 10.h),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(Icons.location_on_outlined,size: 22.sp,color: Colors.grey),
                                  SizedBox(width: 8.w,),
                                  Expanded(
                                    child: Text(doctor.placeTitle,
                                        style: TextStyle
                                          (color: Colors.grey,
                                            fontSize: 15.sp)),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(Icons.location_on_outlined,size: 22.sp,color: Colors.grey),
                                  SizedBox(width: 8.w,),
                                  Expanded(
                                    child: Text(doctor.address,
                                        style: TextStyle
                                          (color: Colors.grey,
                                            fontSize: 15.sp)),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(Icons.star_rate_outlined,size: 22.sp,color:ColorManager.medicalSecondary),
                                  SizedBox(width: 8.w,),
                                  Expanded(
                                    child: Text(doctor.rate??"",
                                        style: TextStyle
                                          (color: ColorManager.medicalSecondary,
                                            fontSize: 15.sp)),
                                  ),
                                ],
                              ),
                              SizedBox(height: 16.h),
                              Divider(color:  Colors.grey,thickness: 0.1,),
                              SizedBox(height: 8.h),
                              // أزرار الأكشن
                              Row(
                                children: [

                                  buildCardActionText("إنشاء وصفة", Icons.assignment_outlined),
                                  const Spacer(),
                                  InkWell(
                                    onTap: () {
                                      Navigator.pushNamed(
                                        context,
                                        Routes.doctorDetails,
                                        arguments: doctor,
                                      );

                                    },
                                    child: buildCardButton("عرض التفاصيل",
                                        ColorManager.medicalPrimary,
                                        Colors.white, Icons.directions_run),
                                  ),

                                ],
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ]),
                  );


              },
            ),
          ],
        ),
      ),
    );
  }
}
