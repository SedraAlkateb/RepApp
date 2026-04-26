import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/places/bloc/place_bloc.dart';
import 'package:domina_app/presentation/plase_visit/bloc/visit_place_bloc.dart';
import 'package:domina_app/presentation/plase_visit/widget/build_card_buttom.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/resources/routes_manager.dart';
import 'package:domina_app/presentation/uniti/search_field.dart';
import 'package:domina_app/presentation/uniti/stateWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HospitalArchive extends StatelessWidget {
  HospitalArchive({super.key});
  final TextEditingController searchhosController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: CustomScrollView(
          slivers: [

            BlocBuilder<PlaceBloc, PlaceState>(
              buildWhen: (previous, current) =>
              current is AllHospitalArchiveByPlaceErrorState ||
                  current is EmptyArchiveState||current is AllHospitalArchiveByPlaceState,
              builder: (context, state) {
                if (state is AllHospitalArchiveByPlaceState) {
                  List<HospitalModel> hospitals  = state.data;
                  return SliverList(
                    delegate: SliverChildListDelegate([
                      // عرض عدد المستشفيات في Row
                      SliverToBoxAdapter(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 12.h,
                            ),
                            SearchField(
                              searchController: searchhosController,
                              onPressed: (value) {
                                BlocProvider.of<PlaceBloc>(context)
                                    .add(SearchHospitalArchive(value, hospitals));
                              },
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 20.w, vertical: 20.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "قائمة المشافي المسجين",
                              style: TextStyle(
                                  color:
                                  ColorManager.medicalText.withOpacity(0.8),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 12.w, vertical: 4.h),
                              decoration: BoxDecoration(
                                color:
                                ColorManager.medicalPrimary.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              child: Text(
                                " ${hospitals.length} مشفى",
                                style: TextStyle(
                                    color: ColorManager.medicalPrimary,
                                    fontSize: 11.sp),
                              ),
                            ),
                          ],
                        ),
                      ),
                      ...hospitals.map((HospitalArchive) {
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
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 12.w, vertical: 4.h),
                                    decoration: BoxDecoration(
                                      color: Colors.blue.shade50,
                                      borderRadius: BorderRadius.circular(8.r),
                                    ),
                                    child: Text(HospitalArchive.title ?? "",
                                        style: TextStyle(
                                            color: Colors.blue, fontSize: 12.sp)),
                                  ),
                                  Expanded(
                                    child: Text(
                                        textAlign: TextAlign.end,
                                        HospitalArchive.title ?? "",
                                        style: TextStyle(
                                            fontSize: 18.sp,
                                            fontWeight: FontWeight.bold,
                                            color: ColorManager.medicalPrimary)),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10.h),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(Icons.location_on_outlined,
                                      size: 22.sp, color: Colors.grey),
                                  SizedBox(
                                    width: 8.w,
                                  ),
                                  Expanded(
                                    child: Text(HospitalArchive.placeTitle ?? "",
                                        style: TextStyle(
                                            color: Colors.grey, fontSize: 15.sp)),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(Icons.location_on_outlined,
                                      size: 22.sp, color: Colors.grey),
                                  SizedBox(
                                    width: 8.w,
                                  ),
                                  Expanded(
                                    child: Text(HospitalArchive.address ?? "",
                                        style: TextStyle(
                                            color: Colors.grey, fontSize: 15.sp)),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(Icons.star_rate_outlined,
                                      size: 22.sp,
                                      color: ColorManager.medicalSecondary),
                                  SizedBox(
                                    width: 8.w,
                                  ),
                                  Expanded(
                                    child: Text(HospitalArchive.address ?? "",
                                        style: TextStyle(
                                            color: ColorManager.medicalSecondary,
                                            fontSize: 15.sp)),
                                  ),
                                ],
                              ),
                              SizedBox(height: 16.h),
                              Divider(
                                color: Colors.grey,
                                thickness: 0.1,
                              ),
                              SizedBox(height: 8.h),
                              // أزرار الأكشن
                              Row(
                                children: [

                                  const Spacer(),
                                  InkWell(
                                    onTap: () {
                                      Navigator.pushNamed(
                                        context,
                                        Routes.hospitalDetails,
                                        arguments: HospitalArchive,
                                      );
                                    },
                                    child: buildCardButton(
                                        "عرض التفاصيل",
                                        ColorManager.medicalPrimary,
                                        Colors.white,
                                        Icons.directions_run),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ]),
                  );
                }
                if (state is EmptyArchiveState) {
                  return SliverList(
                      delegate: SliverChildListDelegate([
                        SizedBox(
                          height: 100,
                        ),
                        emptyFullScreen(context)
                      ]));
                }
                if (state is AllHospitalArchiveByPlaceErrorState) {
                  return SliverList(
                      delegate: SliverChildListDelegate([
                        SizedBox(
                          height: 100,
                        ),
                        errorFullScreen(context)
                      ]));
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
