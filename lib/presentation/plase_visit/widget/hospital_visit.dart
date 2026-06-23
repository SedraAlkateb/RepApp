import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/Recipes/widget/hospital_recipe.dart';
import 'package:domina_app/presentation/plase_visit/bloc/visit_place_bloc.dart';
import 'package:domina_app/presentation/plase_visit/widget/build_card_buttom.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/resources/routes_manager.dart';
import 'package:domina_app/presentation/uniti/search_field.dart';
import 'package:domina_app/presentation/uniti/stateWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HospitalVisit extends StatefulWidget {
  HospitalVisit({super.key});

  @override
  State<HospitalVisit> createState() => _HospitalVisitState();
}

class _HospitalVisitState extends State<HospitalVisit>
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
            SearchField(
              searchController: searchController,
              onPressed: (value) {
                BlocProvider.of<VisitPlaceBloc>(context)
                    .add(SearchHospitalVisitEvent(value: value));
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: BlocConsumer<VisitPlaceBloc, VisitPlaceState>(
                  listener: (context, state) {
                if (state is AllHospitalByPlaceErrorState) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    error(context, state.failure.massage, state.failure.code);
                  });
                }
              }, builder: (context, state) {
                List<HospitalSpAllModel> hospitals =
                    context.watch<VisitPlaceBloc>().hospitals;
                if (state is SearchVisitHospitalState) {
                  hospitals = state.hospitalVisit;
                }
                if (state is AllHospitalByPlaceState) {
                  hospitals = state.data;
                }
                if (state is EmptyState) {
                  return emptyFullScreen(context);
                }
                return ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
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
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [

                            Text(
                                hospitals[index].title??"",
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
                                  child: Text(hospitals[index].address??"",
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
                                PrescriptionHospitalMenuWidget(hospitalId: hospitals[index].hospitalId),
                                const Spacer(),
                                InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(
                                      context,
                                      Routes.visitHospital,
                                      arguments:hospitals[index], // نرسل الـ ID هنا
                                    );

                                  },
                                  child: buildCardButton("بدء زيارة",
                                      ColorManager.medicalPrimary,
                                      Colors.white, Icons.directions_run),
                                ),

                              ],
                            ),
                          ],
                        ),
                      );
                    },
                    itemCount: hospitals.length);
              }),
            ),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
