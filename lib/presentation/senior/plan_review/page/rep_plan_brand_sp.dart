import 'package:domina_app/app/user_info.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/resources/language_manager.dart';
import 'package:domina_app/presentation/resources/values_manager.dart';
import 'package:domina_app/presentation/senior/plan_review/bloc/future_rep_bloc.dart';
import 'package:domina_app/presentation/uniti/stateWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RepPlanBrandSpPage extends StatefulWidget {

  final String title;
  final int? flag;
  @override
  const RepPlanBrandSpPage({super.key, required this.title,this.flag});

  State<RepPlanBrandSpPage> createState() => _RepPlanBrandSpPageState();
}

class _RepPlanBrandSpPageState extends State<RepPlanBrandSpPage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {

    super.build(context);
    List<PlanBrandSp> planBrandsp = context.watch<FutureRepBloc>().planBrandSp.planBrandSps;
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text(widget.title)),
      backgroundColor: ColorManager.white,
      body: Container(
        child: Stack(
          children: [
            SingleChildScrollView(
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
                      if (state is FutureRepPlanBrandSpState) {
                        planBrandsp = state.planBrandSp;
                      }
                    },
                    builder: (context, state) {
                      if (state is FutureRepPlanBrandSpLoadingState) {
                        return loadingFullScreen(context);
                      }
                      if (state is FutureRepPlanBrandSpEmptyState) {
                        return emptyFullScreen(context);
                      }
                      return ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) =>
                            BlocBuilder<FutureRepBloc, FutureRepState>(
                          builder: (context, state) {
                            return Container(
                              margin: EdgeInsets.all(AppPaddingH.p8),
                              padding: EdgeInsets.all(AppPaddingH.p16),
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
                                        SizedBox(width: 8),
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
                                          padding: EdgeInsets.symmetric(
                                            vertical: AppPaddingH.p8,
                                            horizontal: AppPaddingW.p14,
                                          ),
                                          decoration: BoxDecoration(
                                            color: planBrandsp[index].brandType ==
                                                    1
                                                ? ColorManager.secondaryColor1
                                                : ColorManager.secondaryColor2,
                                            borderRadius:
                                                 BorderRadius.all(
                                              Radius.circular(AppSize.s8),
                                            ),
                                          ),
                                          child: Text(
                                            planBrandsp[index]
                                                .brandType ==
                                                    1
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
                                        SizedBox(width: 8), // مسافة صغيرة
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
                                        SizedBox(
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
                                              border: OutlineInputBorder(),
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                vertical: 8,
                                                horizontal: 10,
                                              ),
                                            ),
                                            enabled: widget.flag==1?true:false,
                                            onChanged: (value) {
                                              if (value.isNotEmpty && value != "") {
                                                BlocProvider.of<FutureRepBloc>(
                                                        context)
                                                    .add(ChangeFieldEvent(
                                                    int.parse(convertArabicNumberToEnglish(value)),
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
                      );
                    },
                  )),
            ),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
