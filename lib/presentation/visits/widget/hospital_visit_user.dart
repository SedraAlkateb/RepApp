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

class HospitalVisitUser extends StatefulWidget {
  const HospitalVisitUser({super.key});

  @override
  State<HospitalVisitUser> createState() => _HospitalVisitUserState();
}

class _HospitalVisitUserState extends State<HospitalVisitUser>
    with AutomaticKeepAliveClientMixin {
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 12.h,),
          SearchField(
            searchController: searchController,
            onPressed: (value) {
              BlocProvider.of<VisitBloc>(context)
                  .add(SearchHospitalVisitEvent(value: value));
            },
          ),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: BlocConsumer<VisitBloc, VisitState>(
                  listener: (context, state) {
                if (state is VisitHospitalErrorState) {
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
              }, builder: (context, state) {
                List<VisitHospitalAndHospital> hospitals =
                    context.watch<VisitBloc>().hospitals;
                if (state is VisitHospitalState) {
                  hospitals = state.hospitals;
                }
                if (state is SearchVisitHospitalState) {
                  hospitals = state.hospitals;
                }
                if (state is EmptyVisitHospitalState) {
                  return emptyFullScreen(context);
                }
                return ListView.builder(
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
                          crossAxisAlignment: CrossAxisAlignment.end,
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
                                  child: Text(hospitals[index].specModel.title , style
                                      : TextStyle(color: Colors.blue, fontSize: 12.sp)),
                                ),
                                Expanded(
                                  child: Text(
                                      textAlign: TextAlign.end,
                                      hospitals[index].hospitalModel.title ,
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

                                      "${hospitals[index].hospitalModel.placeTitle} - ${hospitals[index].hospitalModel.address}",
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
                                Text(hospitals[index].visitHospitalModel.data,
                                    style: TextStyle
                                      (color: Colors.grey,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14.sp)),

                                const Spacer(),
                                InkWell
                                  (
                                  onTap: () {
                                    Navigator.pushNamed(context,Routes.infoVisitHospital,
                                      arguments: hospitals[index],
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
                    itemCount: hospitals.length);
              }),
            ),
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
