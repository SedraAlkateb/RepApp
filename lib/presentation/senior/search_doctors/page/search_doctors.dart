import 'package:domina_app/presentation/plase_visit/widget/build_card_buttom.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/resources/values_manager.dart';
import 'package:domina_app/presentation/senior/search_doctors/bloc/search_doctors_bloc.dart';
import 'package:domina_app/presentation/senior/search_doctors/page/doctor_details.dart';
import 'package:domina_app/presentation/uniti/search_field.dart';
import 'package:domina_app/presentation/uniti/stateWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchDoctors extends StatelessWidget {
  SearchDoctors({
    super.key,
  });

  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('البحث عن طبيب'),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Icon(
                size: AppSize.s30,
                Icons.arrow_back_sharp,
                color: ColorManager.secondaryColor1,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            );
          },
        ),
      ),

      // الحل البديل والأجمل: زر ثابت في الأسفل لا يغطي المحتوى
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: SizedBox(
          width: double.infinity,
          height: 55.h,
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorManager.secondaryColor1,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.r),
              ),
              elevation: 0,
            ),
            onPressed: () {
              BlocProvider.of<SearchDoctorsBloc>(context)
                  .add(FutureSearchDocEvent(searchController.text));
            },
            icon: const Icon(Icons.search, color: Colors.white),
            label: Text(
              'ابحث الآن',
              style: TextStyle(
                fontSize: 18.sp,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),

      body: SingleChildScrollView(
        // أضفت padding أسفل القائمة لضمان عدم تداخل آخر عنصر مع الزر الثابت
        padding: EdgeInsets.only(bottom: 20.h),
        child: Column(
          children: [
            SizedBox(height: 12.h),
            SearchField(
              searchController: searchController,
            ),
            BlocBuilder<SearchDoctorsBloc, SearchDoctorsState>(
              buildWhen: (previous, current) =>
              current is FutureFutureSearchDoctorsErrorState ||
                  current is FutureSearchDoctorsLoadingState ||
                  current is FutureSearchDoctorsState ||
                  current is FutureSearchDoctorsEmptyState,
              builder: (context, state) {
                if (state is FutureFutureSearchDoctorsErrorState) {
                  return errorFullScreen(context,
                      mes: state.failure.massage,
                      func: () => BlocProvider.of<SearchDoctorsBloc>(context)
                          .add(FutureSearchDocEvent(searchController.text)));
                }
                if (state is FutureSearchDoctorsLoadingState) {
                  return loadingFullScreen(context);
                }
                if (state is FutureSearchDoctorsEmptyState) {
                  return emptyFullScreen(context);
                }
                if (state is FutureSearchDoctorsState) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 12.h),
                    child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: state.Representative.length,
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
                                color: Colors.black.withOpacity(0.08),
                                blurRadius: 15,
                                offset: const Offset(0, 6),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                                    child: Text(
                                        state.Representative[index].spTitle,
                                        style: TextStyle(
                                            color: Colors.blue,
                                            fontSize: 12.sp)),
                                  ),
                                  Text(
                                    state.Representative[index].name,
                                    style: TextStyle(
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.bold,
                                        color: ColorManager.medicalPrimary),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10.h),
                              Row(
                                children: [
                                  Icon(Icons.location_on_outlined,
                                      size: 22.sp, color: Colors.grey),
                                  SizedBox(width: 8.w),
                                  Expanded(
                                    child: Text(
                                        state.Representative[index].placeTitle,
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 15.sp)),
                                  ),
                                ],
                              ),
                              SizedBox(height: 16.h),
                              const Divider(color: Colors.grey, thickness: 0.1),
                              SizedBox(height: 8.h),
                              Row(
                                children: [
                                  buildCardActionText("إنشاء وصفة",
                                      Icons.assignment_outlined),
                                  const Spacer(),
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(context, MaterialPageRoute(
                                        builder: (context) => DoctorDetails(
                                          doctorModel: state.Representative[index],
                                        ),
                                      ));
                                      BlocProvider.of<SearchDoctorsBloc>(context).add(
                                          FutureDocDoctorsEvent(
                                              state.Representative[index].id));
                                    },
                                    child: buildCardButton(
                                        "عرض التقارير",
                                        ColorManager.medicalPrimary,
                                        Colors.white,
                                        Icons.directions_run),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  );
                }
                return emptyFullScreen(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}