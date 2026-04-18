// ignore_for_file: must_be_immutable, file_names
import 'package:domina_app/app/di.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/resources/values_manager.dart';
import 'package:domina_app/presentation/senior/general_reports/bloc/bloc/general_reports_bloc.dart';
import 'package:domina_app/presentation/senior/general_reports/pages/all-rep-general-reports.dart';
import 'package:domina_app/presentation/senior/places/bloc/senior_reps_bloc.dart';
import 'package:domina_app/presentation/uniti/stateWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SeniorByCityId extends StatefulWidget {
  final String cityname;
  final int cityid;
  const SeniorByCityId(
      {super.key, required this.cityid, required this.cityname});

  @override
  State<SeniorByCityId> createState() => _SeniorByCityIdState();
}

class _SeniorByCityIdState extends State<SeniorByCityId>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.cityname),
      ),
      body:  BlocBuilder<GeneralReportsBloc, GeneralReportsState>(
        builder: (context, state) {
          List<SeniorCityModel> seniors =
              context.watch<GeneralReportsBloc>().dataseniorsbycityid;
          if (state is SeniorByCityIdState) {
            seniors = state.data;
          }
          if (state is SeniorByCityIdLoadingState) {
            return loadingShimmer(
                context, 10, 20, 20, BorderRadius.circular(20));
          }
          if (state is SeniorByCityIdErrorState) {
            return errorFullScreen(context, func: () {});
          }
          if (state is SeniorByCityIdEmptyState) {
            return emptyFullScreen(context);
          }
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
            child: ListView.builder(
              //  physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      initSeniorModule();
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return AllRepSeniorGenerlReports(
                            cityname: seniors[index].city_name,
                            cityId: int.parse(seniors[index].city_id,
                            ), repId: int.parse(seniors[index].rep_id),
                          );
                        },
                      ));
                      BlocProvider.of<SeniorRepsBloc>(context).add(
                          AllSeniorRepEvent(
                              // int.parse(seniors[index].city_id),
                              // int.parse(seniors[index].rep_id)
                          ));
                    },
                    child: Container(
                      padding:  EdgeInsets.symmetric(
                          horizontal: AppPaddingW.p16, vertical: 8),

                      height: 60,
                      margin: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        border: Border.all(width: 2, color: ColorManager.secondaryColor1),
                        borderRadius: const BorderRadius.all(Radius.circular(8)),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                seniors[index].rep_name,
                                style:
                                Theme.of(context).textTheme.labelLarge,
                              ),
                              // const SizedBox(
                              //   width: 20,
                              // ),
                              // Text(
                              //   '(${seniors[index].city_name})',
                              //   style: Theme.of(context).textTheme.labelLarge,
                              // ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
                itemCount: seniors.length),
          );
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
