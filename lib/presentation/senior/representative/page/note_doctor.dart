import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/resources/values_manager.dart';
import 'package:domina_app/presentation/senior/representative/bloc/senior_prof_bloc.dart';
import 'package:domina_app/presentation/uniti/circle_number_widget.dart';
import 'package:domina_app/presentation/uniti/search_field.dart';
import 'package:domina_app/presentation/uniti/stateWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NoteDoctor extends StatelessWidget {
  NoteDoctor({super.key});
  final TextEditingController searchNoteDoctorController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
        title: Text('ملاحظات الأطباء'),
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
                    searchController: searchNoteDoctorController,
                    onPressed: (value) {
                      BlocProvider.of<SeniorProfBloc>(context)
                          .add(SenSearchNoteDoctorEvent(value));
                    },
                  ),
                ],
              ),
            ),
            BlocBuilder<SeniorProfBloc, SeniorProfState>(
              builder: (context, state) {
                List<DoctorNoteModel> doctorNoteModel =
                    context.watch<SeniorProfBloc>().doctorNoteModel;
                if (state is SenAllNoteDoctorEmptyState) {
                  return SliverList(
                      delegate: SliverChildListDelegate([
                    SizedBox(
                      height: 100,
                    ),
                    emptyFullScreen(context)
                  ]));
                }
                if (state is SenAllNoteDoctorsState) {
                  doctorNoteModel = state.doctorNoteModel;
                }
                if (state is SenAllNoteDoctorLoadingState) {
                  return SliverList(
                    delegate:
                        SliverChildListDelegate([loadingFullScreen(context)]),
                  );
                }
                if (state is SenAllNoteDoctorErrorState) {
                  return SliverList(
                    delegate: SliverChildListDelegate([
                      errorFullScreen(context, func: () {
                        BlocProvider.of<SeniorProfBloc>(context)
                            .add(SenAllNoteDoctorEvent(156));
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
                              style: Theme.of(context).textTheme.titleLarge),
                          CircleNumberWidget(number: doctorNoteModel.length),
                        ],
                      ),
                    ),
                    // القائمة
                    ...doctorNoteModel.map((doctorNoteModel) {
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
                              BorderRadius.all(Radius.circular(AppSize.s8)),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              doctorNoteModel.docTitle,
                              style: Theme.of(context).textTheme.labelLarge,
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              "${doctorNoteModel.address}",
                              style: Theme.of(context).textTheme.labelLarge,
                              textAlign: TextAlign.center,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      " التاريخ :",
                                      style:
                                          Theme.of(context).textTheme.bodySmall,
                                    ),
                                    Text(
                                      " ${doctorNoteModel.visitDate} ",
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
                                      "الاختصاص :",
                                      style:
                                          Theme.of(context).textTheme.bodySmall,
                                    ),
                                    Text(
                                      " ${doctorNoteModel.spTitle} ",
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelSmall,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            doctorNoteModel.note != null
                                ? Divider(
                                    color: Colors.white,
                                  )
                                : SizedBox(),
                            doctorNoteModel.note != null
                                ? Text.rich(
                                  textAlign: TextAlign.start,
                                  softWrap: false,
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  TextSpan(
                                    text: "ملاحظات المكتب العلمي :  ",
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelLarge,
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: doctorNoteModel.note,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium,
                                      ),
                                    ],
                                  ),
                                )
                                : SizedBox(),
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
