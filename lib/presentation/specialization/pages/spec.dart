import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/resources/assets_manager.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/resources/values_manager.dart';
import 'package:domina_app/presentation/specialization/bloc/specialization_bloc.dart';
import 'package:domina_app/presentation/specialization/pages/spec_d_h.dart';
import 'package:domina_app/presentation/uniti/search_field.dart';
import 'package:domina_app/presentation/uniti/stateWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SpecializationsPage extends StatelessWidget {
  SpecializationsPage({super.key});
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final bool isTablet = MediaQuery.of(context).size.shortestSide >= 600;

    return Scaffold(
      backgroundColor: ColorManager.background,
      appBar: AppBar(

        title: Text(
          'الإختصاصات',
          style: TextStyle(fontSize: isTablet ? 28.sp : 20.sp),
        ),
      ),
      body: OrientationBuilder(

        builder: (context, orientation) {
          // 🔹 إذا كانت الشاشة أفقية (landscape) على التابلت → 4 أعمدة
          // 🔹 إذا كانت عمودية (portrait) → 2 أو 3 حسب نوع الجهاز
          int crossAxisCount;
          if (isTablet) {
            crossAxisCount = orientation == Orientation.landscape ? 4 : 3;
          } else {
            crossAxisCount = orientation == Orientation.landscape ? 3 : 2;
          }

          return SingleChildScrollView(
            child: Padding(
              padding:
              EdgeInsets.symmetric(horizontal: isTablet ? 30.w : 8.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 12.h,),
                  SearchField(
                    searchController: searchController,
                    onPressed: (value) {
                      BlocProvider.of<SpecializationBloc>(context)
                          .add(SearchSpecEvent(value));
                    },
                  ),
                  BlocConsumer<SpecializationBloc, SpecializationState>(
                    listener: (context, state) {
                      if (state is AllSpecErrorState) {
                        error(context, state.failure.massage,
                            state.failure.code);
                      }
                    },
                    builder: (context, state) {
                      List<SpecDModel> placeModel =
                          context.watch<SpecializationBloc>().specialization;
                      if (state is AllSpecState) {
                        placeModel = state.Specs;
                      }

                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12,horizontal: 8),
                        child: GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                          SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: crossAxisCount,
                            crossAxisSpacing:  8.w,
                            mainAxisSpacing: 8.h,
                            childAspectRatio:  1,
                          ),
                          itemCount: placeModel.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        SpecDH(spId: placeModel[index].id),
                                  ),
                                );
                                BlocProvider.of<SpecializationBloc>(context)
                                    .add(
                                    DoctorSpEvent(placeModel[index].id));
                              },
                              child: Container(
                                margin: EdgeInsets.all(0),
                                padding: EdgeInsets.all(AppPaddingH.p5),
                                decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color:  ColorManager.inputBorder,
                                        blurRadius: 10,
                                        offset: const Offset(0, 5),
                                      ),
                                    ],

                                  color: ColorManager.white,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(AppSize.s25),
                                  ),
                                  border: BoxBorder.all(color:
                                  ColorManager.inputBorder)
                                ),
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        padding: EdgeInsets.all(12.w),
                                        decoration: BoxDecoration(
                                          color: ColorManager.medicalSecondary.withOpacity(0.1), // أزرق فاتح جداً
                                          shape: BoxShape.circle,
                                        ),
                                        child:
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Image.asset(
                                            ImageAssetsSpec()
                                                .getImage(placeModel[index].id),
                                            width: isTablet ? 60.w : 35.w,
                                            height: isTablet ? 60.h : 35.h,
                                            color: ColorManager.medicalSecondary
                                                .withOpacity(0.8),
                                            colorBlendMode: BlendMode.modulate,
                                          ),
                                        ),
                                      ),

                                      SizedBox(
                                          height: isTablet ? 15.h : 10.h),
                                      Text(
                                        placeModel[index].title,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: ColorManager.medicalText,
                                          fontWeight: FontWeight.w600,
                                          fontSize:
                                          isTablet ? 22.sp : 18.sp,
                                        ),
                                      ),
                                      if (placeModel[index].sumDoctor != 0)
                                        Text(
                                          " زيارات الاطباء : ${placeModel[index].sumDoctor}",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: ColorManager.black.withOpacity(0.5),
                                            fontWeight: FontWeight.w300,
                                            fontSize:
                                            isTablet ? 16.sp : 12.sp,
                                          ),
                                        ),
                                      if (placeModel[index].sumHospital != 0)
                                        Text(
                                          " زيارات المشافي : ${placeModel[index].sumHospital}",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: ColorManager.black.withOpacity(0.5),
                                            fontWeight: FontWeight.w300,
                                            fontSize:
                                            isTablet ? 16.sp : 12.sp,
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
