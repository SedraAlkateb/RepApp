// ignore_for_file: must_be_immutable

import 'package:domina_app/app/di/di.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/resources/responsive/app_ui.dart';
import 'package:domina_app/presentation/resources/routes_manager.dart';
import 'package:domina_app/presentation/senior/all_city/bloc/bloc/all_city_bloc.dart';
import 'package:domina_app/presentation/senior/manage_future/bloc/manage_future_bloc.dart';
import 'package:domina_app/presentation/senior/plan_review/bloc/future_rep_bloc.dart';
import 'package:domina_app/presentation/uniti/basic/spec_grid_widget.dart';
import 'package:domina_app/presentation/uniti/search_field.dart';
import 'package:domina_app/presentation/uniti/stateWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FutureSpecializationsPage extends StatefulWidget {
  const FutureSpecializationsPage({
    super.key,
    required this.id,
    required this.repPlanId,
    required this.flag,
    required this.sampleCount,
    required this.repType,
  });

  final int id;
  final int repPlanId;
  final FlagModel flag;
  final int sampleCount;
  final RepType repType;

  @override
  State<FutureSpecializationsPage> createState() =>
      _FutureSpecializationsPageState();
}


class _FutureSpecializationsPageState
    extends State<FutureSpecializationsPage>
    with AutomaticKeepAliveClientMixin {

  final TextEditingController searchController =
  TextEditingController();


  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {

      BlocProvider.of<FutureRepBloc>(
        context,
        listen: false,
      ).add(
        FutureSpEvent(
          widget.id,
          widget.repPlanId,
        ),
      );

    });
  }


  @override
  void dispose() {
    searchController.dispose();

    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

    super.build(context);

    final ui = AppUi.of(context);


    final bool isLandscape =
        MediaQuery.orientationOf(context) ==
            Orientation.landscape;


    final int crossAxisCount;


    if (ui.isTabletLandscape) {
      crossAxisCount = 4;

    } else if (ui.isTabletPortrait) {
      crossAxisCount = 3;

    } else {
      crossAxisCount = isLandscape ? 3 : 2;
    }



    return WillPopScope(

      onWillPop: () async {

        BlocProvider.of<ManageFutureBloc>(
          context,
        ).add(
          AllSeniorRepFutureEvent(
            cityId:
            context.read<AllCityBloc>()
                .selectedCityId,
          ),
        );


        return true;
      },


      child: Scaffold(

        backgroundColor:
        const Color(0xFFF8FAFC),



        body: SafeArea(

          top: false,


          child: Center(

            child: ConstrainedBox(

              constraints: BoxConstraints(

                maxWidth:
                ui.isTabletLandscape
                    ? ui.widePageMaxWidth
                    : ui.pageMaxWidth,

              ),



              child: SingleChildScrollView(

                physics:
                const BouncingScrollPhysics(),


                keyboardDismissBehavior:
                ScrollViewKeyboardDismissBehavior
                    .onDrag,


                padding:

                EdgeInsets.only(

                  bottom:
                  ui.pageBottomPadding + 70,

                ),



                child: Column(

                  crossAxisAlignment:
                  CrossAxisAlignment.stretch,



                  children: [



                    Padding(

                      padding:

                      EdgeInsets.fromLTRB(

                        ui.pagePadding,

                        ui.searchTopPadding,

                        ui.pagePadding,

                        ui.searchBottomPadding,

                      ),



                      child: SearchField(

                        searchController:
                        searchController,



                        onPressed: (value) {


                          BlocProvider.of<FutureRepBloc>(
                            context,
                          ).add(

                            FutureSearchSpecEvent(
                              value,
                            ),

                          );


                        },

                      ),

                    ),





                    BlocBuilder<
                        FutureRepBloc,
                        FutureRepState>(


                      builder:
                          (context, state) {



                        List<SpecDModel> spModel =

                            context
                                .watch<FutureRepBloc>()
                                .specialization;



                        if (state
                        is FutureSpRepState) {

                          spModel =
                              state.Specs;

                        }





                        if (state
                        is FutureSpRepLoadingState) {

                          return _buildLoadingState(
                            context,
                          );

                        }






                        if (state
                        is FutureSpRepErrorState) {


                          return Padding(

                            padding:

                            EdgeInsets.symmetric(

                              horizontal:
                              ui.pagePadding,

                              vertical:
                              ui.sectionSpacing,

                            ),



                            child:
                            errorFullScreen(

                              context,

                              mes:
                              state.failure.massage,


                              func: () {


                                BlocProvider.of<
                                    FutureRepBloc>(
                                  context,
                                ).add(

                                  FutureSpEvent(

                                    widget.id,

                                    widget.repPlanId,

                                  ),

                                );


                              },

                            ),

                          );


                        }





                        final filteredItems =

                        spModel
                            .where(
                                (item) =>
                            item.flag == 1)
                            .toList();





                        return Padding(

                          padding:

                          EdgeInsets.fromLTRB(

                            ui.pagePadding,

                            ui.listTopPadding,

                            ui.pagePadding,

                            ui.listBottomPadding,

                          ),




                          child:

                          SpecGridWidget(

                            items:
                            filteredItems,


                            isPr:
                            true,


                            crossAxisCount:
                            crossAxisCount,



                            onTap:
                                (model) {



                              iniFutureModule();



                              BlocProvider.of<
                                  FutureRepBloc>(
                                context,
                              ).add(


                                FutureRepPlanBrandSpEvent(

                                  RepSp(

                                    widget.repPlanId,

                                    model.id,

                                    widget.id,

                                  ),


                                  widget.sampleCount,

                                ),


                              );





                              Navigator.pushNamed(

                                context,

                                Routes.RepPlanBrandSp,


                                arguments: {

                                  'title':
                                  model.title,


                                  'flag':
                                  widget.flag.flag,

                                },

                              );



                            },

                          ),


                        );


                      },

                    ),



                  ],

                ),

              ),

            ),

          ),

        ),

      ),

    );


  }



  Widget _buildLoadingState(
      BuildContext context,
      ) {

    final ui = AppUi.of(context);


    return Padding(

      padding:

      EdgeInsets.fromLTRB(

        ui.pagePadding,

        70,

        ui.pagePadding,

        ui.pageBottomPadding,

      ),



      child:
      loadingFullScreen(

        context,

      ),

    );


  }




  @override
  bool get wantKeepAlive => true;

}
