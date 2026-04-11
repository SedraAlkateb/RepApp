import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/plase_visit/bloc/visit_place_bloc.dart';
import 'package:domina_app/presentation/plase_visit/widget/build_card_buttom.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/resources/routes_manager.dart';
import 'package:domina_app/presentation/uniti/search_field.dart';
import 'package:domina_app/presentation/uniti/stateWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DoctorVisit extends StatefulWidget {
  @override
  _DoctorVisitState createState() => _DoctorVisitState();
}

class _DoctorVisitState extends State<DoctorVisit>
    with AutomaticKeepAliveClientMixin {
  final TextEditingController searchController = TextEditingController();

  @override
  bool get wantKeepAlive => true;
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
                    .add(SearchDoctorVisitEvent(value: value));
              },
            ),
            BlocConsumer<VisitPlaceBloc, VisitPlaceState>(
              listener: (context, state) {
                if (state is AllDoctorByPlaceErrorState) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    error(context, state.failure.massage, state.failure.code);
                  });
                }
              },
              builder: (context, state) {
                List<DoctorModel> doctors =
                    context.watch<VisitPlaceBloc>().doctors;
                if (state is SearchVisitDoctorState) {
                  doctors = state.doctorVisit;
                }
                if (state is AllDoctorByPlaceState) {
                  doctors = state.data;
                }
                if (state is EmptyState) {
                  return emptyFullScreen(context);
                }
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: ListView.builder(

                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.only(bottom: 16.h,right: 8.w,left: 8.w),
                        padding: EdgeInsets.all(16.w),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15.r),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.08), // درجة غمق الظل
                              blurRadius: 15, // مدى نعومة الظل
                              spreadRadius: 0, // مدى انتشار الظل
                              offset: const Offset(0, 6), // إزاحة الظل للأسفل ليعطي عمقاً (Shadow Offset)
                            ),
                          ],                          ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
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
                                  child: Text(doctors[index].spTitle, style
                                      : TextStyle(color: Colors.blue, fontSize: 12.sp)),
                                ),
                                Text(
                                  doctors[index].title,
                                    style: TextStyle(
                                fontSize: 18.sp, fontWeight: FontWeight.bold, color: ColorManager.medicalPrimary)),

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
                                  child: Text(doctors[index].address,
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
                                buildCardActionText("إنشاء وصفة", Icons.assignment_outlined),
                                const Spacer(),
                                InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(
                                      context,
                                      Routes.visitDoctor,
                                      arguments:doctors[index], // نرسل الـ ID هنا
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
                    itemCount: doctors.length,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

}
