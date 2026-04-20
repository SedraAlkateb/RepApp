import 'package:domina_app/presentation/senior/general_reports/pages/doctors-hospitals-reports.dart';
import 'package:domina_app/presentation/uniti/search_field.dart';
import 'package:domina_app/presentation/uniti/stateWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/resources/font_manager.dart';
import 'package:domina_app/presentation/resources/values_manager.dart';
import 'package:domina_app/presentation/senior/places/bloc/senior_reps_bloc.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class AllRepSeniorGenerlReports extends StatefulWidget {
  final int cityId;
  final String cityname;
  final int repId;
  const AllRepSeniorGenerlReports(
      {super.key,
        required this.cityId,
        required this.cityname,
        required this.repId});

  @override
  // ignore: library_private_types_in_public_api
  _AllRepSeniorState createState() => _AllRepSeniorState();
}

class _AllRepSeniorState extends State<AllRepSeniorGenerlReports> {
  final TextEditingController searchController = TextEditingController();
  double screenHeight = 0;
  double screenWidth = 0;
  final RefreshController _refreshController =
  RefreshController(initialRefresh: false);
  bool startAnimation = false;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        startAnimation = true;
      });
    });
  }

  void onRefresh() {
    BlocProvider.of<SeniorRepsBloc>(context)
        .add(AllSeniorRepEvent(widget.cityId, widget.repId));
    _refreshController.refreshCompleted();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 250, 254, 255),
      appBar:
      //    CustomWaveAppBar()
      AppBar(
        title: Text(
          'تقارير المندوبين (${widget.cityname})',
          textDirection: TextDirection.rtl,
        ),
      ),
      body: bodyBuild(context),
    );
  }

  Widget bodyBuild(BuildContext context) {
    ScrollController? controller;
    return SmartRefresher(
      controller: _refreshController,
      onRefresh: onRefresh,
      enablePullDown: true,
      child: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        controller: controller,
        child: Column(
          children: [
            SearchField(
              searchController: searchController,
              onPressed: (value) {
                BlocProvider.of<SeniorRepsBloc>(context)
                    .add(SenSearchRepEvent(value));
              },
            ),
            BlocBuilder<SeniorRepsBloc, SeniorRepsState>(
              builder: (context, state) {
                List<AllRepresentative> allRepresentative =
                    context.watch<SeniorRepsBloc>().allRepresentative;
                if (state is AllSeniorRepLoadingState) {
                  return loadingShimmer(
                      context, 20, 100, 20, BorderRadius.circular(50));
                } else if (state is AllSeniorRepErrorState) {
                  return errorFullScreen(context,
                      func: () => BlocProvider.of<SeniorRepsBloc>(context)
                          .add(AllSeniorRepEvent(widget.cityId, widget.repId)));
                } else if (state is AllSeniorRepState) {
                  allRepresentative = state.representatives;
                }
                if (state is AllSeniorRepEmptyState) {
                  return emptyFullScreen(context);
                }
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: allRepresentative.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) {
                              return DoctorsHospitalsReports(
                                repName: allRepresentative[index].name,
                                indexRep: index,
                                senId: widget.repId,
                                //    repPlanId: allRepresentative[index].activePlan,
                                repId: allRepresentative[index].id,
                              );
                            },
                          ));
                        },
                        child: AnimatedContainer(
                          height: 60,
                          curve: Curves.easeInOut,
                          duration: Duration(milliseconds: 300 + (index * 200)),
                          transform: Matrix4.translationValues(
                              startAnimation ? 0 : screenWidth, 0, 0),
                          margin:  EdgeInsets.all(AppPaddingH.p8),
                          padding:  EdgeInsets.symmetric(
                              horizontal: AppPaddingW.p16),
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: ColorManager.secondaryColor1, width: 2),
                            borderRadius:  BorderRadius.all(
                                Radius.circular(AppSize.s8)),
                            color: ColorManager.white,
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                allRepresentative[index].name,
                                style: TextStyle(
                                  color: ColorManager.secondaryColor1,
                                  fontSize: FontSize.s20,
                                ),
                              ),
                              Text(
                                "${allRepresentative[index].number}",
                                style: TextStyle(
                                  color: ColorManager.secondaryColor1,
                                  fontSize: FontSize.s20,
                                ),
                              ),
                            ],
                          ),
                        ),
                        //     );
                        //   },
                        // ),
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
