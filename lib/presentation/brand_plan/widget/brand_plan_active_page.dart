import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/brand_plan/bloc/brand_plan_bloc.dart';
import 'package:domina_app/presentation/drawer/pages/drawer_page.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/resources/values_manager.dart';
import 'package:domina_app/presentation/uniti/stateWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BrandPlanActivePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
              List<PlanBrandSqlModel> planBrandModel =
                  context.watch<BrandPlanBloc>().planBrandActive;
              return  ListView.builder(
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
                    borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8)),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8,),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 8),
                              child: Icon(Icons.add_card,color: ColorManager.secondaryColor4,),
                            ),
                            Expanded(
                              child: Text(
                                "العينة : ${planBrandModel[index].brandTitle}",
                                style: Theme.of(context).textTheme.headlineMedium,
                              ),
                            ),
                                     Container(
                                      // margin: EdgeInsets.all(AppPadding.p8),
                                       padding: EdgeInsets.symmetric(vertical: AppPadding.p8,horizontal: AppPadding.p14),
                                       decoration: BoxDecoration(
                                         color: ColorManager.secondaryColor2,
                                         borderRadius: const BorderRadius.all(
                       Radius.circular(AppSize.s8)),
                                         //        color: ColorManager.card,
                                       ),
                                       child: Text("${planBrandModel[index].brandType == 1 ? " رئيسي " : " ثانوي "}"),)
                          ],
                        ),
                      ),
                      Divider(color:ColorManager.secondaryColor7),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 8),
                              child: Icon(Icons.merge_type_rounded,color: ColorManager.secondaryColor4,),
                            ),
                            Expanded(
                              child: Text(
                                "النوع : ${planBrandModel[index].phTitle}",
                                style: Theme.of(context).textTheme.headlineMedium,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(color:ColorManager.secondaryColor7),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 8),
                              child: Icon(Icons.medical_services_outlined,color: ColorManager.secondaryColor4,),
                            ),
                            Expanded(
                              child: Text(
                                'الاختصاص: ${planBrandModel[index].specializationTitle}',
                                style: Theme.of(context).textTheme.headlineMedium,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(color:ColorManager.secondaryColor7),
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
                                style: Theme.of(context).textTheme.headlineMedium,
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: TextField(
                                decoration: InputDecoration(
                                  hintText: planBrandModel[index].amount.toString(),
                                  enabled: false,
                                  border: OutlineInputBorder(),
                                  contentPadding: EdgeInsets.symmetric(
                                    vertical: 8,
                                    horizontal: 10,
                                  ),
                                ),
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
    );
  }
}
