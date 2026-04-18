
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/senior/edit_brand_plan/bloc/edit_brand_plan_bloc.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/resources/values_manager.dart';
import 'package:domina_app/presentation/uniti/custom_dropdown.dart';
import 'package:domina_app/presentation/uniti/search_field.dart';
import 'package:domina_app/presentation/uniti/stateWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class EditingPlanTarget extends StatefulWidget {
  EditingPlanTarget({super.key, required this.repPlan, required this.planBrand});
  final int repPlan;
 List<PlanBrandModel> planBrand;

  @override
  State<EditingPlanTarget> createState() => _EditingPlanTargetState();
}

class _EditingPlanTargetState extends State<EditingPlanTarget>  with AutomaticKeepAliveClientMixin{
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    // List<PlanBrandModel> planBrand =
    //     context.watch<EditBrandPlanBloc>().planBrands;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        onPressed: () {},
        backgroundColor: ColorManager.secondaryColor1,
        child: Icon(
          Icons.edit_note_outlined,
          color: ColorManager.white,
        ),
      ),
      // appBar: AppBar(
      //   title: Text("تعديل أصناف الخطة"),
      // )
   //   ,
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
                widget.planBrand = state.planbrand;
              }

              if (state is FutureSpRepLoadingState) {
                return loadingFullScreen(context);
              }

              if (state is FutureSpRepErrorState) {
                return errorFullScreen(context, func: () {});
              }

              return Expanded(
                  child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      int brandTypeId = int.parse(widget.planBrand[index].brandType);

                      String brandTypeHintText = "لاشيء";
                      for (var type in brandType) {
                        if (type.i == brandTypeId) {
                          brandTypeHintText = type.name;
                          break;
                        }
                      }

                      return Container(
                        margin: EdgeInsets.all(AppPaddingH.p8),
                        padding: EdgeInsets.all(AppPaddingH.p16),
                        decoration: BoxDecoration(
                          color: ColorManager.white,
                          border: Border.all(color: ColorManager.hintGrey),
                          borderRadius:  BorderRadius.all(
                              Radius.circular(AppSize.s8)),
                        ),
                        child: Column(
                          children: [
                            Text(
                              widget.planBrand[index].title,
                              style: Theme.of(context).textTheme.labelLarge,
                            ),
                            SizedBox(
                              height: AppSize.s8,
                            ),
                            BlocConsumer<EditBrandPlanBloc, EditBrandPlanState>(
                              builder: (context, state) {
                                if (state
                                    is FutureChangeLoadingItemValueState) {
                                  if (state.index == index) {
                                    return SpinKitThreeInOut(
                                      color: ColorManager.secondaryColor1,
                                      size: 30.0,
                                    );
                                  }
                                }

                                return CustomDropDown(
                                  hintText: brandTypeHintText,
                                  items: brandType,
                                  prefixIcon: null,
                                  onChanged: (value) {
                                    BlocProvider.of<EditBrandPlanBloc>(context)
                                        .add(
                                      FutureChangePlanBrandTypeEvent(
                                        widget.planBrand[index].id,
                                        value.i,
                                      ),
                                    );
                                    widget.planBrand[index].brandType =
                                        value.i.toString();
                                    BlocProvider.of<EditBrandPlanBloc>(context)
                                        .add(
                                      FutureChangeLoadingItemValueEvent(index),
                                    );
                                  },
                                  validator: (value) {
                                    return null;
                                  },
                                  errorText: '',
                                );
                              },
                              listener: (BuildContext context,
                                  EditBrandPlanState state) {
                                if (state
                                    is FutureChangePlanBrandTypeErrorState) {
                                  error(
                                    context,
                                    state.failure.massage,
                                    state.failure.code,
                                  );
                                }
                              },
                            )
                          ],
                        ),
                      );
                    },
                    itemCount: widget.planBrand.length),
              ));
            },
          ),
        ],
      ),
    );
  }
    @override
  bool get wantKeepAlive => true;
}
