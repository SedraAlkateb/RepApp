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
      drawer: DrawerPage(),
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
                    border: Border.all(color: ColorManager.secondaryColor),
                    borderRadius:
                        const BorderRadius.all(Radius.circular(AppSize.s8)),
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
                            Icon(Icons.add_card),
                            Text(
                              "العينة : ${planBrandModel[index].brandTitle} ( ${planBrandModel[index].brandType == 1 ? " رئيسي " : " ثانوي "} )",
                              style:
                                  Theme.of(context).textTheme.headlineMedium,
                            ),
                          ],
                        ),
                      ),
                      Divider(),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(Icons.merge_type_rounded),
                            Expanded(
                              child: Text(
                                "النوع : ${planBrandModel[index].phTitle}",
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineMedium,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(Icons.medical_services_outlined),
                            Text(
                              'الاختصاص: ${planBrandModel[index].specializationTitle}',
                              style:
                                  Theme.of(context).textTheme.headlineMedium,
                            ),
                          ],
                        ),
                      ),
                      Divider(),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'العدد ',
                              style:
                                  Theme.of(context).textTheme.headlineMedium,
                            ),
                            SizedBox(
                                width: 10), // مسافة بين النص وحقل الإدخال
                            Expanded(
                              child: TextField(
                                decoration: InputDecoration(
                                  hintText:
                                      planBrandModel[index].amount.toString(),
                                  enabled: false,
                                  border: OutlineInputBorder(),
                                  contentPadding: EdgeInsets.symmetric(
                                    vertical: 8,
                                    horizontal: 10,
                                  ), // تحسين المساحة الداخلية للحقل
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
