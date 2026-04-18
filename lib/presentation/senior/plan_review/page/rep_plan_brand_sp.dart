import 'package:domina_app/app/user_info.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/resources/values_manager.dart';
import 'package:domina_app/presentation/senior/plan_review/bloc/future_rep_bloc.dart';
import 'package:domina_app/presentation/uniti/circle_number_widget.dart';
import 'package:domina_app/presentation/uniti/search_field.dart';
import 'package:domina_app/presentation/uniti/stateWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RepPlanBrandSpPage extends StatefulWidget {
  final String title;
  final int? flag;
  @override
  const RepPlanBrandSpPage({super.key, required this.title, this.flag});

  @override
  State<RepPlanBrandSpPage> createState() => _RepPlanBrandSpPageState();
}

class _RepPlanBrandSpPageState extends State<RepPlanBrandSpPage>
    with AutomaticKeepAliveClientMixin {
  List<PlanBrandSp> planBrandsp = [];
  @override
  Widget build(BuildContext context) {
    super.build(context);
    final TextEditingController searchController = TextEditingController();

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        onPressed: () {
          BlocProvider.of<FutureRepBloc>(context).add(UpdateAmountEvent());
        },
        backgroundColor: ColorManager.secondaryColor1,
        child: Icon(
          Icons.edit_note_outlined,
          color: ColorManager.white,
        ),
      ),
      appBar: AppBar(centerTitle: true, title: Text(widget.title)),
      backgroundColor: ColorManager.white,
      body: Column(
        children: [
          SearchField(
            searchController: searchController,
            onPressed: (value) {
              BlocProvider.of<FutureRepBloc>(context)
                  .add(SearchPlanBrandsEvent(value));
            },
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: BlocConsumer<FutureRepBloc, FutureRepState>(
                    listener: (context, state) {
                      if (state is FutureRepPlanBrandSpErrorState) {
                        return error(
                            context, state.failure.massage, state.failure.code);
                        // BlocProvider.of<BrandPlanBloc>(context)
                        //     .add(UpdateEvent());
                      }
                      if (state is SumErrorState) {
                        return error(
                            context, state.failure.massage, state.failure.code);
                        // BlocProvider.of<BrandPlanBloc>(context)
                        //     .add(UpdateEvent());
                      }
                      if (state is FutureSpRepErrorState) {
                        return error(
                            context, state.failure.massage, state.failure.code);
                      }
                      if (state is UpdateAmountLoadingState) {
                        return loading(context);
                      }
                      if (state is UpdateAmountState) {
                        success(context);
                        return Navigator.pop(context);
                      }
                    },
                    builder: (context, state) {
                      if (state is FutureRepPlanBrandSpState) {
                        planBrandsp = state.planBrandSp;
                      }
                      if (state is FutureRepPlanBrandSpLoadingState) {
                        return loadingFullScreen(context);
                      }
                      if (state is FutureRepPlanBrandSpEmptyState) {
                        return emptyFullScreen(context);
                      }
                      return Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "عدد العينات الموزعة: ",
                                style: Theme.of(context).textTheme.labelLarge,
                              ),
                              CircleNumberWidget(number:
                              BlocProvider.of<FutureRepBloc>(context).number),
                            ],
                          ),
                          ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) =>
                                BlocBuilder<FutureRepBloc, FutureRepState>(
                              builder: (context, state) {
                                return Container(
                                  margin:  EdgeInsets.all(AppPaddingH.p8),
                                  padding:  EdgeInsets.all(AppPaddingH.p16),
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(color: ColorManager.secondaryColor),
                                    ],
                                    color: ColorManager.white,
                                    border: Border.all(
                                        color: ColorManager.secondaryColor7),
                                    borderRadius:  BorderRadius.all(
                                        Radius.circular(AppSize.s8)),
                                  ),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.symmetric(vertical: 8),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.only(left: 8),
                                              child: Icon(
                                                Icons.medication_outlined,
                                                color: ColorManager.secondaryColor4,
                                              ),
                                            ),
                                            const SizedBox(width: 8),
                                            Expanded(
                                              child: Text(
                                                "العينة : ${planBrandsp[index].titleAr}",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headlineMedium,
                                                overflow: TextOverflow.visible,
                                              ),
                                            ),
                                            Container(
                                              padding:  EdgeInsets.symmetric(
                                                vertical: AppPaddingH.p8,
                                                horizontal: AppPaddingW.p14,
                                              ),
                                              decoration: BoxDecoration(
                                                color: planBrandsp[index]
                                                            .brandType ==
                                                        1
                                                    ? ColorManager.secondaryColor1
                                                    : ColorManager.secondaryColor2,
                                                borderRadius:
                                                     BorderRadius.all(
                                                  Radius.circular(AppSize.s8),
                                                ),
                                              ),
                                              child: Text(
                                                planBrandsp[index].brandType == 1
                                                    ? "هدف"
                                                    : "مساعد",
                                                style: TextStyle(
                                                  color: ColorManager.white,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Divider(color: ColorManager.secondaryColor7),
                                      Padding(
                                        padding:
                                            const EdgeInsets.symmetric(vertical: 8),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.only(left: 8),
                                              child: Icon(
                                                Icons.medical_information_outlined,
                                                color: ColorManager.secondaryColor4,
                                              ),
                                            ),
                                            const SizedBox(width: 8), // مسافة صغيرة
                                            Expanded(
                                              child: Text(
                                                "النوع : ${planBrandsp[index].phTitle}",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headlineMedium,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Divider(color: ColorManager.secondaryColor7),
                                      Padding(
                                        padding:
                                            const EdgeInsets.symmetric(vertical: 8),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.only(left: 8),
                                              child: Text(
                                                'العدد ',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headlineMedium,
                                              ),
                                            ),
                                            const SizedBox(
                                                width:
                                                    10), // مسافة بين النص وحقل الإدخال
                                            Expanded(
                                              child: TextField(
                                                decoration: InputDecoration(
                                                  hintText: planBrandsp[index]
                                                      .totalAmount
                                                      .toString(),
                                                  enabled: UserInfo.otherstatus == 0
                                                      ? true
                                                      : state is SumErrorState
                                                          ? false
                                                          : false,
                                                  border:
                                                      const OutlineInputBorder(),
                                                  contentPadding:
                                                      const EdgeInsets.symmetric(
                                                    vertical: 8,
                                                    horizontal: 10,
                                                  ),
                                                ),
                                                enabled:
                                                    widget.flag == 5? true : false,
                                                onChanged: (value) {
                                                  if (value.isNotEmpty &&
                                                      value != "") {
                                                    BlocProvider.of<FutureRepBloc>(
                                                            context)
                                                        .add(ChangeFieldEvent(
                                                      int.parse(value),
                                                      index,
                                                    ));
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
                                );
                              },
                            ),
                            itemCount: planBrandsp.length,
                          ),
                        ],
                      );
                    },
                  )),
            ),
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
