import 'package:domina_app/app/di.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/resources/assets_manager.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/resources/routes_manager.dart';
import 'package:domina_app/presentation/resources/values_manager.dart';
import 'package:domina_app/presentation/senior/plan_review/bloc/future_rep_bloc.dart';
import 'package:domina_app/presentation/uniti/search_field.dart';
import 'package:domina_app/presentation/uniti/stateWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FutureSpecializationsPage extends StatelessWidget {
  FutureSpecializationsPage({super.key, required this.id,
    required this.repPlanId,
  required this.flag
  });
 final int id;
  final int repPlanId;
  final FlagModel flag;
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Future<bool> _onWillPop() async {
    //   BlocProvider.of<FutureRepBloc>(context)
    //       .add(FutureSpEvent(id));
    //   return true;
    // }
    return Center(
      child: Scaffold(
        appBar: AppBar(
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: Icon(
                  size: AppSize.s30,
                  Icons.arrow_forward,
                  color: ColorManager.secondaryColor1,
                ),
                onPressed: () {
               Navigator.pop(context);
                },
              );
            },
          ),
          title: Text('الإختصاصات'),
        ),
        body: SingleChildScrollView(
          child: Container(
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
                  SearchField(
                    searchController: searchController,
                    onPressed: (value) {
                      BlocProvider.of<FutureRepBloc>(context)
                          .add(FutureSearchSpecEvent(value));
                    },
                  ),
                  BlocBuilder<FutureRepBloc, FutureRepState>(
                    builder: (context, state) {
                      List<SpecDModel> spModel =
                          context.watch<FutureRepBloc>().specialization;
                      if (state is FutureSpRepState) {
                        spModel = state.Specs;
                      }
                      if(state is FutureSpRepLoadingState){
                      return  loadingFullScreen(context);
                      }
                      if (state is FutureSpRepErrorState) {
                     return   errorFullScreen(context,mes: state.failure.massage,func: ()=>
                         BlocProvider.of<FutureRepBloc>(context)
                         .add(FutureSpEvent(id)));
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
                        itemCount: spModel.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: ()  {
                                    iniFutureModule();
                                    BlocProvider.of<FutureRepBloc>(context)
                                        .add(FutureRepPlanBrandSpEvent(RepSp(repPlanId,spModel[index].id , id)));

                                    Navigator.pushNamed(
                                      context,
                                      Routes.RepPlanBrandSp,
                                      arguments: {'title': spModel[index].title,'flag':flag.flag},
                                    );
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
                                      ImageAssetsSpec()
                                          .getImage(spModel[index].id),
                                      width: 45,
                                      height: 45,
                                      color: ColorManager.white.withOpacity(0.8),
                                      colorBlendMode: BlendMode.modulate,
                                      errorBuilder: (context, error, stackTrace) {
                                        return SizedBox();
                                      },
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      textAlign: TextAlign.center,
                                      spModel[index].title,
                                      style: TextStyle(
                                          color: ColorManager.white,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 20),
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
      ),
    );
  }
}
