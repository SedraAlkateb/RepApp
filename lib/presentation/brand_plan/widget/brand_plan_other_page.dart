import 'package:domina_app/app/user_info.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/brand_plan/bloc/brand_plan_bloc.dart';
import 'package:domina_app/presentation/resources/assets_manager.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/resources/values_manager.dart';
import 'package:domina_app/presentation/uniti/stateWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BrandPlanOtherPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print(UserInfo.otherstatus);
    print(UserInfo.percentage);
    return Scaffold(
      backgroundColor: ColorManager.white,
      //     drawer: DrawerPage(),
      body: Container(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: BlocConsumer<BrandPlanBloc, BrandPlanState>(
                  listener: (context, state) {
                    if (state is AllBrandPlanErrorState) {
                      error(context, state.failure.massage, state.failure.code);
                    }
                    if (state is SumErrorState) {
                      error(context, state.failure.massage, state.failure.code);
                      BlocProvider.of<BrandPlanBloc>(context)
                          .add(UpdateEvent());
                    }
                  },
                  builder: (context, state) {
                    List<PlanBrandSqlModel> planBrandModel =
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
                    return ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) => Container(
                        margin: EdgeInsets.all(AppPadding.p8),
                        padding: EdgeInsets.all(AppPadding.p16),
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(color: ColorManager.secondaryColor),
                          ],
                          color: ColorManager.white,
                          border:
                              Border.all(color: ColorManager.secondaryColor7),
                          borderRadius: const BorderRadius.all(
                              Radius.circular(AppSize.s8)),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8),
                                    child: Icon(
                                      Icons.add_card,
                                      color: ColorManager.secondaryColor4,
                                    ),
                                  ),
                                  SizedBox(
                                      width:
                                          8), // مسافة صغيرة بين الأيقونة والنص
                                  Expanded(
                                    child: Text(
                                      "العينة : ${planBrandModel[index].brandTitle}",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineMedium,
                                      overflow: TextOverflow
                                          .ellipsis, // لمنع تجاوز النص
                                    ),
                                  ),
                                  Container(
                                    // margin: EdgeInsets.all(AppPadding.p8),
                                    padding: EdgeInsets.symmetric(
                                        vertical: AppPadding.p8,
                                        horizontal: AppPadding.p14),
                                    decoration: BoxDecoration(
                                      color: ColorManager.secondaryColor2,
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(AppSize.s8)),
                                      //        color: ColorManager.card,
                                    ),
                                    child: Text(
                                        "${planBrandModel[index].brandType == 1 ? " هدف " : " مساعد "}"),
                                  )
                                ],
                              ),
                            ),
                            Divider(color: ColorManager.secondaryColor7),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8),
                                    child: Icon(
                                      Icons.merge_type_rounded,
                                      color: ColorManager.secondaryColor4,
                                    ),
                                  ),
                                  SizedBox(width: 8), // مسافة صغيرة
                                  Expanded(
                                    child: Text(
                                      "النوع : ${planBrandModel[index].phTitle}",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineMedium,
                                      overflow: TextOverflow
                                          .ellipsis, // منع تجاوز النص
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Divider(color: ColorManager.secondaryColor7),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8),
                                    child: Icon(
                                      Icons.medical_services_outlined,
                                      color: ColorManager.secondaryColor4,
                                    ),
                                  ),
                                  SizedBox(width: 8), // مسافة صغيرة
                                  Expanded(
                                    child: Text(
                                      'الاختصاص: ${planBrandModel[index].specializationTitle}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineMedium,
                                      overflow: TextOverflow
                                          .ellipsis, // منع تجاوز النص
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Divider(color: ColorManager.secondaryColor7),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8),
                                    child: Text(
                                      'العدد ',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineMedium,
                                    ),
                                  ),
                                  SizedBox(
                                      width: 10), // مسافة بين النص وحقل الإدخال
                                  Expanded(
                                    child: TextField(
                                      decoration: InputDecoration(
                                        hintText: planBrandModel[index]
                                            .amount
                                            .toString(),
                                        enabled: UserInfo.otherstatus == 0
                                            ? true
                                            : state is SumErrorState
                                                ? false
                                                : false,
                                        border: OutlineInputBorder(),
                                        contentPadding: EdgeInsets.symmetric(
                                          vertical: 8,
                                          horizontal: 10,
                                        ),
                                      ),
                                      onChanged: (value) {
                                        if (value.isNotEmpty && value != "") {
                                          print(value);
                                          print("value");
                                          BlocProvider.of<BrandPlanBloc>(
                                                  context)
                                              .add(ChangeFieldEvent(
                                                  int.parse(value), index));
                                        }
                                      },
                                      keyboardType: TextInputType.number,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      itemCount: planBrandModel.length,
                    );
                  },
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
                                BlocProvider.of<BrandPlanBloc>(context)
                                    .add(UpdateAmountSucEvent());
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
                                BlocProvider.of<BrandPlanBloc>(context)
                                    .add(SendToS());
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
                                        "ارسال",
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
      ),
    );
  }
}
