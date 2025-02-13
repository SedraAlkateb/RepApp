import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/resources/values_manager.dart';
import 'package:domina_app/presentation/senior/representative/bloc/senior_prof_bloc.dart';
import 'package:domina_app/presentation/uniti/circle_number_widget.dart';
import 'package:domina_app/presentation/uniti/search_field.dart';
import 'package:domina_app/presentation/uniti/stateWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SenVisitDoctor extends StatelessWidget {
  SenVisitDoctor({super.key});
  final TextEditingController searchteDoctorController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(  title: Text("الأطباء الذين تمت زيارتهم"),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Icon(
                size: AppSize.s30,
                Icons.arrow_back_sharp,
                color: ColorManager.secondaryColor1,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            );
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SearchField(
                    searchController: searchteDoctorController,
                    onPressed: (value) {
                      BlocProvider.of<SeniorProfBloc>(context)
                          .add(SenSearchVisitDoctorEvent(value));
                    },
                  ),
                ],
              ),
            ),
            BlocBuilder<SeniorProfBloc, SeniorProfState>(
              builder: (context, state) {
                List<NoVisitDocModel> visitDoc =
                    context.watch<SeniorProfBloc>().visitDoc;
                if (state is SenVisitDocEmptyState) {
                  return SliverList(
                      delegate: SliverChildListDelegate([
                    SizedBox(
                      height: 100,
                    ),
                    emptyFullScreen(context)
                  ]));
                }
                if (state is SenVisitDocsState) {
                  visitDoc = state.visitDoc;
                }
                if (state is SenVisitDocLoadingState) {
                  return SliverList(
                    delegate:
                        SliverChildListDelegate([loadingFullScreen(context)]),
                  );
                }
                if (state is SenVisitDocErrorState) {
                  return SliverList(
                    delegate: SliverChildListDelegate([
                      errorFullScreen(context, func: () {
                        BlocProvider.of<SeniorProfBloc>(context)
                            .add(VisitDocEvent(156));
                      })
                    ]),
                  );
                }
                return SliverList(
                  delegate: SliverChildListDelegate([
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("عدد الملاحظات: ",
                              style: Theme.of(context).textTheme.labelLarge),
                          CircleNumberWidget(number: visitDoc.length),
                        ],
                      ),
                    ),
                    ...visitDoc.map((visitDoc) {
                      return Container(
                        margin: EdgeInsets.all(AppPadding.p8),
                        padding: EdgeInsets.all(AppPadding.p16),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              ColorManager.secondaryColor6,
                              ColorManager.secondaryColor7,
                            ],
                          ),
                          borderRadius:
                              BorderRadius.all(Radius.circular(AppSize.s4)),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              " ${visitDoc.docTitle} ",
                              style: Theme.of(context).textTheme.titleSmall,
                              textAlign: TextAlign.center,
                            ),
                            Row(mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                " الإختصاص :",
                                style:
                                Theme.of(context).textTheme.bodySmall,
                              ),
                                Text(
                                  " ${visitDoc.spTitle} ",
                                  style: Theme.of(context).textTheme.titleSmall,
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),  Row(mainAxisAlignment: MainAxisAlignment.center,
                              children: [Text(
                                " تاريخ الزيارة :",
                                style:
                                Theme.of(context).textTheme.bodySmall,
                              ),
                                Text(
                                  " 2-20-2025 ",
                                  style:
                                  Theme.of(context).textTheme.titleSmall,
                                ),
                              ],
                            ),
                            Text(
                              " ${visitDoc.address} ",
                              style: Theme.of(context).textTheme.titleSmall,
                              textAlign: TextAlign.center,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      " التقيم :",
                                      style:
                                          Theme.of(context).textTheme.bodySmall,
                                    ),
                                    Text(
                                      " ${visitDoc.rate} ",
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelSmall,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "عدد الزيارات :",
                                      style:
                                          Theme.of(context).textTheme.bodySmall,
                                    ),
                                    Text(
                                      " ${visitDoc.visits} ",
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelSmall,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ]),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
