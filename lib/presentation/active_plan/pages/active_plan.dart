import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/active_plan/bloc/bloc/active_plan_bloc.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/resources/values_manager.dart';
import 'package:domina_app/presentation/uniti/stateWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ActivePlanPage extends StatefulWidget {
  @override
  State<ActivePlanPage> createState() => _BrandPlanActivePageState();
}

class _BrandPlanActivePageState extends State<ActivePlanPage>
    with AutomaticKeepAliveClientMixin {
  final TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
        appBar: AppBar(
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: Icon(
                  size: AppSize.s30,
                  Icons.arrow_back,
                  color: ColorManager.secondaryColor1,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              );
            },
          ),
          title: const Text('الخطة الفعالة'),
        ),
        backgroundColor: ColorManager.white,
        //  drawer: DrawerPage(),
        body: MediaQuery.removePadding(
          context: context,
          removeTop: true,
          child: SingleChildScrollView(
            child: Column(
              children: [
                // const SizedBox(
                //   height: 50,
                // ),
                //  dataPlan(UserInfo.startDate, UserInfo.endDate),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 10),
                  child: BlocConsumer<ActivePlanBloc, ActivePlanState>(
                    listener: (context, state) {
                      if (state is AllActivePlanErrorState) {
                        error(
                            context, state.failure.massage, state.failure.code);
                      }
                    },
                    builder: (context, state) {
                      List<ActivePlanBrandModel> planBrandModel =
                          context.watch<ActivePlanBloc>().activePlan;
                      if (state is AllActivePlanLoadingState) {
                        return loadingShimmer(
                            context, 20, 25, 150, BorderRadius.circular(20));
                      }
                      return Column(
                        children: [
                          ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) => Container(
                              margin: const EdgeInsets.all(AppPadding.p8),
                              //  padding: EdgeInsets.all(AppPadding.p16),
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                      color: ColorManager.secondaryColor3),
                                ],
                                color: ColorManager.white,
                                border: Border.all(
                                    color: ColorManager.secondaryColor7),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(AppSize.s8)),
                              ),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: ColorManager.secondaryColor7,
                                      border: Border.symmetric(
                                          vertical: BorderSide(
                                              color: ColorManager
                                                  .secondaryColor7)),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(AppSize.s8)),
                                    ),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 8,
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                //  '22'
                                                planBrandModel[index].title,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleMedium,
                                              ),
                                              Container(
                                                margin:
                                                    const EdgeInsets.symmetric(
                                                        horizontal:
                                                            AppPadding.p8),
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  vertical: AppPadding.p8,
                                                  horizontal: AppPadding.p14,
                                                ),
                                                decoration: BoxDecoration(
                                                  color: planBrandModel[index]
                                                              .type ==
                                                          "هدف"
                                                      ? ColorManager
                                                          .secondaryColor1
                                                      : ColorManager
                                                          .secondaryColor2,
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                    Radius.circular(AppSize.s8),
                                                  ),
                                                ),
                                                child: Text(
                                                  planBrandModel[index].type,
                                                  style: TextStyle(
                                                    color: ColorManager.white,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 8),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  "النوع : ${planBrandModel[index].title}",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleMedium,
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  // Divider(color: ColorManager.secondaryColor7),
                                  Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 8),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 8),
                                          child: Icon(
                                            Icons.medical_services_outlined,
                                            color: ColorManager.secondaryColor4,
                                          ),
                                        ),
                                        Text(
                                          'الاختصاص ',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headlineMedium,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Divider(
                                    thickness: 0.5,
                                    color: ColorManager.secondaryColor7,
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 8),
                                    child: ListView.separated(
                                      separatorBuilder: (context, index) =>
                                          Divider(
                                        thickness: 0.5,
                                        color: ColorManager.secondaryColor7,
                                      ),
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount:
                                          planBrandModel[index].spPlan.length,
                                      itemBuilder: (context, index1) {
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                '${planBrandModel[index].spPlan[index1].name} :',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headlineMedium,
                                              ),
                                              Text(
                                                ' ${planBrandModel[index].spPlan[index1].amount}',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headlineMedium,
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            itemCount: planBrandModel.length,
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  @override
  bool get wantKeepAlive => true;
}
