import 'package:domina_app/app/user_info.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/brand_plan/bloc/brand_plan_bloc.dart';
import 'package:domina_app/presentation/brand_plan/widget/brand_plan_other_page.dart';
import 'package:domina_app/presentation/brand_plan/widget/dialog_plan.dart';
import 'package:domina_app/presentation/resources/assets_manager.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/resources/values_manager.dart';
import 'package:domina_app/presentation/uniti/stateWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SpecPlanPage extends StatelessWidget {
  SpecPlanPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Stack(
        children: [
          SingleChildScrollView(
            child:    Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      blurRadius: 0.6,
                      color: ColorManager.white,
                      spreadRadius: 0.5,
                      offset: Offset(2, 3))
                ],
                borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BlocConsumer<BrandPlanBloc, BrandPlanState>(
                      listener: (context, state) {
                        if (state is AllBrandPlanErrorState) {
                          error(context, state.failure.massage, state.failure.code);
                        }

                      },
                      builder: (context, state) {
                        List<OtherBrandSpPlanModel> planBrandModel =
                            context.watch<BrandPlanBloc>().planBrand;
                        if (state is SumState) {
                          planBrandModel = state.planBrands;
                        }
                        if (state is AllBrandPlanEmptyState) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 200),
                            child: emptyFullScreen(context),
                          );
                        }
                        return GridView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 1.0,
                            mainAxisSpacing: 2.0,
                            childAspectRatio: 1,
                          ),
                          itemCount: planBrandModel.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => BrandPlanOtherPage(
                                        otherBrandSpPlanModel:
                                        planBrandModel[index],index1: index,),
                                    ));
                              },
                              child: Container(
                                margin: EdgeInsets.all(AppPadding.p10),
                                padding: EdgeInsets.all(AppPadding.p5),
                                width: 6,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(colors: [
                                    ColorManager.secondaryColor6,
                                    ColorManager.secondaryColor7,
                                  ]),
                                  color: ColorManager.white,
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(AppSize.s25),
                                  ),
                                ),
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        ImageAssetsSpec().getImage(
                                            planBrandModel[index].specModel.id),
                                        width: 50,
                                        height: 50,
                                        color: ColorManager.white.withOpacity(0.8),
                                        colorBlendMode: BlendMode.modulate,
                                      ),
                                      SizedBox(height: 20),
                                      Text(
                                        textAlign: TextAlign.center,
                                        planBrandModel[index].specModel.title,
                                        style: TextStyle(
                                            color: ColorManager.white,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 20),
                                      ),
                                      Text(
                                        textAlign: TextAlign.center,
                                        "عدد زيارات الاطباء : ${planBrandModel[index].specModel.sumDoctor}",
                                        style: TextStyle(
                                            color: ColorManager.white,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 10),
                                      ),
                                      Text(
                                        textAlign: TextAlign.center,
                                        "عدد زيارات المشافي : ${planBrandModel[index].specModel.sumHospital}",
                                        style: TextStyle(
                                            color: ColorManager.white,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 10),
                                      ),
                                      Text(
                                        textAlign: TextAlign.center,
                                        "عدد العينات المتاحة: ${planBrandModel[index].brandk.toString()}",
                                        style: TextStyle(
                                            color: ColorManager.white,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 10),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          context.watch<BrandPlanBloc>().planBrand.isNotEmpty
              ? BlocListener<BrandPlanBloc, BrandPlanState>(
            listener: (context, state) {
              if (state is UpdateAmountErrorState) {
                error(
                    context, state.failure.massage, state.failure.code);
              }
              if (state is UpdateAmountState) {
                successWithMessage(context, "تم حفظ التغيرات");
              }
            },
            child: Positioned(
                bottom: 20,
                left: 10,
                child: Column(
                  children: [
                    InkWell(
                      onTap: () {
                        showDialog(context: context, builder: (context) {
                          return dialogPlan(context,
                      fun:()=> BlocProvider.of<BrandPlanBloc>(context).add(UpdateAmountSucEvent())
                              ,"هل انت متاكد من حفظ التغيرات");
                        },);
                      },
                      child: SizedBox(
                        height: 80,
                        width: 100,
                        child: Stack(
                          //    alignment: Alignment.bottomCenter,
                          children: [
                            Image.asset(
                              ImageAssets.top,
                            ),
                            Positioned(
                              bottom: 20,
                              left: 35,
                              child: Text(
                                "حفظ",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        UserInfo.otherstatus==0?
                        showDialog(context: context, builder: (context) {
                          return dialogPlan(context,
                           fun: ()=>  BlocProvider.of<BrandPlanBloc>(context).add(SendToS())
                              ,"هل انت متاكد من ارسال التغيرات");
                        },):null;
                      },
                      child: SizedBox(
                        height: 80,
                        width: 100,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Image.asset(
                              ImageAssets.bottom,
                            ),
                            Positioned(
                              bottom: 50,
                              left: 35,
                              child: Text(
                                "إرسال",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )),
          )
              : SizedBox(),
        ],
      ),
    );
  }
}
