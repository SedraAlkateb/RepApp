import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/resources/values_manager.dart';
import 'package:domina_app/presentation/senior/representative/bloc/senior_prof_bloc.dart';
import 'package:domina_app/presentation/uniti/circle_number_widget.dart';
import 'package:domina_app/presentation/uniti/search_field.dart';
import 'package:domina_app/presentation/uniti/stateWidget.dart';
import 'package:domina_app/presentation/uniti/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DoctorSenior extends StatelessWidget {
  DoctorSenior({super.key});
  final TextEditingController searchDocController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        title: Text('الأطباء'),
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
                    searchController: searchDocController,
                    onPressed: (value) {
                      BlocProvider.of<SeniorProfBloc>(context)
                          .add(SenSearchDoctorEvent(value));
                    },
                  ),
                ],
              ),
            ),
            BlocBuilder<SeniorProfBloc, SeniorProfState>(
              buildWhen: (previous, current) =>
                  current is SenAllDoctorsState ||
                  current is SenAllDoctorEmptyState,
              builder: (context, state) {
                List<DoctorModel> doctorModel =
                    context.watch<SeniorProfBloc>().doctor;
                if (state is SenAllDoctorsState) {
                  doctorModel = state.doctor;
                }
                if (state is SenAllDoctorEmptyState) {
                  return SliverList(
                      delegate: SliverChildListDelegate([
                    SizedBox(
                      height: 100,
                    ),
                    emptyFullScreen(context)
                  ]));
                }
                if (state is SenAllDoctorErrorState) {
                  return SliverList(
                      delegate: SliverChildListDelegate([
                    SizedBox(
                      height: 100,
                    ),
                    errorFullScreen(context, func: () {
                      BlocProvider.of<SeniorProfBloc>(context)
                          .add(SenAllDoctorEvent(203));
                    })
                  ]));
                }
                if (state is SenAllDoctorLoadingState) {
                  return SliverList(
                      delegate: SliverChildListDelegate([
                    SizedBox(
                      height: 100,
                    ),
                    loadingFullScreen(context)
                  ]));
                }
                return SliverList(
                  delegate: SliverChildListDelegate([
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "عدد الأطباء: ",
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                          CircleNumberWidget(number: doctorModel.length),
                        ],
                      ),
                    ),
                    ...doctorModel.map((doctor) {
                      return Container(
                        margin: EdgeInsets.all(AppPaddingH.p8),
                        padding: EdgeInsets.all(AppPaddingH.p16),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              ColorManager.secondaryColor6,
                              ColorManager.secondaryColor7,
                            ],
                          ),
                          borderRadius:
                              BorderRadius.all(Radius.circular(AppSize.s8)),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [

                            Text(
                              doctor.title,
                              style: Theme.of(context).textTheme.labelLarge,
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              doctor.spTitle,
                              style: Theme.of(context).textTheme.titleMedium,
                              textAlign: TextAlign.center,
                            ),
                            TextRach(
                              s1: "التقيم : ",
                              s2: doctor.rate.toString(),
                            ),
                            Text(
                              "${doctor.address}_${doctor.placeTitle}",
                              style: Theme.of(context).textTheme.titleMedium,
                              textAlign: TextAlign.center,
                            ),

                            doctor.workHours!=null&& doctor.workHours!=""?
                            Text(
                              "أوقات العمل${doctor.workHours}",
                              style: Theme.of(context).textTheme.titleMedium,
                              textAlign: TextAlign.center,
                            ):SizedBox(),
                            doctor.note!=null&& doctor.note!=""?
                            TextRach(
                              s1: "ملاحظة : ",
                              s2: doctor.note.toString(),
                            ):SizedBox(),
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
