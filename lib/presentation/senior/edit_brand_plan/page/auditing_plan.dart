
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/resources/values_manager.dart';
import 'package:domina_app/presentation/senior/edit_brand_plan/bloc/edit_brand_plan_bloc.dart';
import 'package:domina_app/presentation/uniti/custom_dropdown.dart';
import 'package:domina_app/presentation/uniti/search_field.dart';
import 'package:domina_app/presentation/uniti/stateWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class AuditingPlan extends StatefulWidget {
  AuditingPlan({
    super.key,
    required this.repPlan
  });
final int repPlan;
  @override
  State<AuditingPlan> createState() => _AuditingPlanState();
}

class _AuditingPlanState extends State<AuditingPlan> {
  final TextEditingController searchController = TextEditingController();
  int? loadingItemId;
@override
  void initState() {
  BlocProvider.of<EditBrandPlanBloc>(context)
      .add(FutureGetPlanBrandEvent(Rep(widget.repPlan)));
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    List<PlanBrandModel> planBrand = context.watch<EditBrandPlanBloc>().planBrands;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        onPressed: () {
          // initAsyncInModule();
          // WidgetsBinding.instance.addPostFrameCallback((_) {
          //   Navigator.pushNamed(context, Routes.asyncIn);
          // });
        },
        backgroundColor: ColorManager.secondaryColor1,
        child: Icon(
          Icons.edit_note_outlined,
          color: ColorManager.white,
        ),
      ),
      appBar: AppBar(
        title: Text("تعديل أصناف الخطة"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SearchField(
            searchController: searchController,
            onPressed: (value) {
              BlocProvider.of<EditBrandPlanBloc>(context)
                  .add(FutureSearchSpecEvent(value));
            },
          ),
          BlocBuilder<EditBrandPlanBloc, EditBrandPlanState>(
            builder: (context, state) {
              // List<PlanBrandModel> planBrand =
              //     context.watch<EditBrandPlanBloc>().planBrands;
              if (state is FuturePlanBrandState) {
                planBrand = state.planbrand;
              }

              if (state is FutureSpRepLoadingState) {
                return loadingFullScreen(context);
              }

              if (state is FutureSpRepErrorState) {
              return  errorFullScreen(context, func: () {});
              }

              return Expanded(
                  child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      int brandTypeId = int.parse(planBrand[index].brandType);

                      String brandTypeHintText = "لاشيء";
                      for (var type in brandType) {
                        if (type.i == brandTypeId) {
                          brandTypeHintText = type.name;
                          break;
                        }
                      }

                      return Container(
                        margin: EdgeInsets.all(AppPadding.p8),
                        padding: EdgeInsets.all(AppPadding.p16),
                        decoration: BoxDecoration(
                          color: ColorManager.white,
                          border: Border.all(color: ColorManager.hintGrey),
                          borderRadius: const BorderRadius.all(
                              Radius.circular(AppSize.s8)),
                        ),
                        child: Column(
                          children: [
                            Text(
                              planBrand[index].title,
                              style: Theme.of(context).textTheme.labelLarge,
                            ),
                            SizedBox(
                              height: AppSize.s8,
                            ),
                            BlocConsumer<EditBrandPlanBloc, EditBrandPlanState>(
                              builder: (context, state) {
                                if (state is FutureChangePlanBrandTypeState) {
                                  loadingItemId = -1;
                                }

                                return loadingItemId == index
                                    ? SpinKitThreeInOut(
                                        color: ColorManager.secondaryColor1,
                                        size: 30.0)
                                    : CustomDropDown(
                                        hintText: brandTypeHintText,
                                        items: brandType,
                                        prefixIcon: null,
                                        onChanged: (value) {
                                          setState(() {
                                            loadingItemId = index;
                                          });

                                          BlocProvider.of<EditBrandPlanBloc>(
                                                  context)
                                              .add(
                                            FutureChangePlanBrandTypeEvent(
                                                planBrand[index].id, value.i),
                                          );
                                          planBrand[index].brandType =
                                              value.i.toString();
                                        },
                                        validator: (value) {
                                          return null;
                                        },
                                        errorText: '',
                                      );
                              },
                              listener:
                                  (BuildContext context, EditBrandPlanState state) {
                                if (state is FutureChangePlanBrandTypeErrorState) {
                                  loadingItemId = -1;
                                  error(context, state.failure.massage,
                                      state.failure.code);
                                }
                              },
                            ),
                          ],
                        ),
                      );
                    },
                    itemCount: planBrand.length),
              ));
            },
          ),
        ],
      ),
    );
  }
}
