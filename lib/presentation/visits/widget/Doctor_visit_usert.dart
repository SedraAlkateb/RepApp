import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/plase_visit/widget/build_card_buttom.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/resources/routes_manager.dart';
import 'package:domina_app/presentation/uniti/search_field.dart';
import 'package:domina_app/presentation/uniti/stateWidget.dart';
import 'package:domina_app/presentation/visits/bloc/visit_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DoctorVisitUser extends StatefulWidget {
  DoctorVisitUser({super.key});

  @override
  State<DoctorVisitUser> createState() => _DoctorVisitUserState();
}

class _DoctorVisitUserState extends State<DoctorVisitUser>
    with AutomaticKeepAliveClientMixin {
  final TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SearchField(searchController: searchController,onPressed: (value) {
              BlocProvider.of<VisitBloc>(context).add(SearchDoctorVisitEvent(value: value));},),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: BlocConsumer<VisitBloc, VisitState>(
                listener: (context, state) {
                  if (state is VisitDoctorErrorState) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      error(context, state.failure.massage, state.failure.code);
                    });
                  }

                  /*
                  if(state is AllPharmacyByPlaceLoadingState){
                    loading(context);
                  }
                  if(state is AllPharmacyByPlaceState){
                            success(context);}
                 */
                },
                builder: (context, state) {
                  List<VisitDoctorAndDoctor> doctors=context.watch<VisitBloc>().doctors;
                  if(state is VisitDoctorState){doctors=state.doctors;}
                  if (state is SearchVisitDoctorState) {
                    doctors = state.doctors;
                  }
                  if(state is EmptyVisitHospitalState){
                    return emptyFullScreen(context);
                  }

                  return ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
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
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
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
                                    child: Text(doctors[index]
                                        .doctorModel
                                        .spTitle , style
                                        : TextStyle(color: Colors.blue, fontSize: 12.sp)),
                                  ),
                                  Expanded(
                                    child: Text(
                                        textAlign: TextAlign.end,
                                        doctors[index]
                                            .doctorModel
                                            .title,
                                        style: TextStyle(
                                            fontSize: 18.sp, fontWeight: FontWeight.bold, color: ColorManager.medicalPrimary)),
                                  ),

                                ],
                              ),
                              SizedBox(height: 16.h),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(Icons.location_on_outlined,size: 22.sp,color: Colors.grey),
                                  SizedBox(width: 8.w,),
                                  Expanded(
                                    child: Text(

                                        "${doctors[index]
                                            .doctorModel.placeTitle} - ${doctors[index]
                                            .doctorModel.address}",
                                        style: TextStyle
                                          (color: Colors.grey,
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
                                  Icon(Icons.access_time,size: 18.sp,color: Colors.grey,  fontWeight: FontWeight.bold),
                                  SizedBox(width: 4.w,),
                                  Text(doctors[index]
                                      .visitDoctorModel.data,
                                      style: TextStyle
                                        (color: Colors.grey,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14.sp)),

                                  const Spacer(),
                                  InkWell
                                    (
                                    onTap: () {
                                      Navigator.pushNamed(context,Routes.infoVisitDoctor,
                                        arguments: doctors[index],
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
                      },
                      itemCount:
                      doctors.length);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
