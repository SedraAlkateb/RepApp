import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/brand_plan/bloc/brand_plan_bloc.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/resources/values_manager.dart';
import 'package:domina_app/presentation/uniti/stateWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BrandPlanActivePage extends StatefulWidget {
  @override
  State<BrandPlanActivePage> createState() => _BrandPlanActivePageState();
}

class _BrandPlanActivePageState extends State<BrandPlanActivePage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: ColorManager.white,
      //  drawer: DrawerPage(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BlocConsumer<BrandPlanBloc, BrandPlanState>(
            listener: (context, state) {
              if (state is AllBrandPlanErrorState) {
                error(context, state.failure.massage, state.failure.code);
              }
            },
            builder: (context, state) {
              List<BrandSpPlanModel> planBrandModel =
                  context.watch<BrandPlanBloc>().planBrandActive;
              return ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) => Container(
                  margin: EdgeInsets.all(AppPadding.p8),
                  padding: EdgeInsets.all(AppPadding.p16),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(color: ColorManager.secondaryColor3),
                    ],
                    color: ColorManager.white,
                    border: Border.all(color: ColorManager.secondaryColor7),
                    borderRadius:
                        const BorderRadius.all(Radius.circular(AppSize.s8)),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 8,
                        ),
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
                            Expanded(
                              child: Text(
                                "العينة : ${planBrandModel[index].brandModel.title}",
                                style:
                                    Theme.of(context).textTheme.headlineMedium,
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
                              child: int.parse(planBrandModel[index]
                                          .spPlan[0]
                                          .brandType) ==
                                      1
                                  ? Text("هدف")
                                  : Text("مساعد"),
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
                            Expanded(
                              child: Text(
                                "النوع : ${planBrandModel[index].brandModel.phTitle}",
                                style:
                                    Theme.of(context).textTheme.headlineMedium,
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
                            Text(
                              'الاختصاص: ',
                              style: Theme.of(context).textTheme.headlineMedium,
                            ),
                          ],
                        ),
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: planBrandModel[index].spPlan.length,
                        itemBuilder: (context, index1) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${planBrandModel[index].spPlan[index1].title} : ${planBrandModel[index].spPlan[index1].amount}',
                                style:
                                    Theme.of(context).textTheme.headlineMedium,
                              ),
                            ],
                          );
                        },
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
    );
  }

  @override
  bool get wantKeepAlive => true;
}
