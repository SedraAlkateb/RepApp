import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/resources/values_manager.dart';
import 'package:domina_app/presentation/senior/report_issue_note/bloc/report_issue_bloc.dart';
import 'package:domina_app/presentation/uniti/circle_number_widget.dart';
import 'package:domina_app/presentation/uniti/search_field.dart';
import 'package:domina_app/presentation/uniti/stateWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NoteIssueDoctor extends StatelessWidget {
  NoteIssueDoctor({super.key,required this.id});
  final int id;
  final TextEditingController searchIssueDoctorController = TextEditingController();
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
        title: Text('ملاحظات مستودع قاسيون'),
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
                    searchController: searchIssueDoctorController,
                    onPressed: (value) {
                      BlocProvider.of<ReportIssueBloc>(context)
                          .add(SenSearchIssueDoctorEvent(value));
                    },
                  ),
                ],
              ),
            ),
            BlocBuilder<ReportIssueBloc, ReportIssueState>(
              builder: (context, state) {
                List<DoctorIssueModel> doctorIssueModel =
                    context.watch<ReportIssueBloc>().doctorIssueModel;
                if (state is SenAllNoteDoctorEmptyState) {
                  return SliverList(
                      delegate: SliverChildListDelegate([
                        SizedBox(
                          height: 100,
                        ),
                        emptyFullScreen(context)
                      ]));
                }
                if(state is SenAsReadState){

                  doctorIssueModel = state.doctorIssueModel;
                }
                if (state is SenAllNoteDoctorsState) {
                  doctorIssueModel = state.doctorIssueModel;
                }
                if(state is SenAllNoteDoctorLoadingState){
                  return
                    SliverList(
                      delegate: SliverChildListDelegate([
                        loadingFullScreen(context)
                      ]),
                    );
                }
                if(state is SenAllNoteDoctorErrorState){
                  return
                    SliverList(
                      delegate: SliverChildListDelegate([
                        errorFullScreen(context,
                            func: (){
                              BlocProvider.of<ReportIssueBloc>(context).add(SenAllIssueDoctorEvent(id));
                            }
                        )
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
                          CircleNumberWidget(number: doctorIssueModel.length),
                        ],
                      ),
                    ),
                    // القائمة
                    ...doctorIssueModel.asMap().entries.map((entry) {
                      final index = entry.key;
                      final doctorNoteModel = entry.value;
                      return  Container(
                        margin: EdgeInsets.all(AppPadding.p8),
                        padding: EdgeInsets.symmetric(horizontal:  AppPadding.p8),
                        decoration:
                        doctorNoteModel.isRead?
                        BoxDecoration(
                          border: Border.all(color: ColorManager.secondaryColor18),

                          color: ColorManager.secondaryColor7,
                          borderRadius:
                          BorderRadius.all(Radius.circular(AppSize.s14)),
                        ):
                        BoxDecoration(
                          color: ColorManager.white,
                          border: Border.all(color: ColorManager.hintGrey),
                          borderRadius:
                          BorderRadius.all(Radius.circular(AppSize.s14)),
                        ),
                        child: Column(
                          children: [
                            InkWell(

                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    doctorNoteModel.docTitle,
                                    style:  doctorNoteModel.isRead? Theme.of(context).textTheme.titleSmall: Theme.of(context).textTheme.labelLarge,
                                    textAlign: TextAlign.center,
                                  ),
                                  Text(
                                    "${doctorNoteModel.address}",
                                    style: doctorNoteModel.isRead? Theme.of(context).textTheme.titleSmall: Theme.of(context).textTheme.labelLarge,
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
                                            "${doctorNoteModel.visitDate}",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall,
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "الإختصاص :",
                                            style:
                                            Theme.of(context).textTheme.bodySmall,
                                          ),
                                          Text(
                                            "${doctorNoteModel.spTitle}",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall,
                                          ),
                                        ],
                                      ),

                                    ],
                                  ),
                                  SizedBox(height:20,),
                                  Row(mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                      "الملاحظات :",
                                      style:
                                      Theme.of(context).textTheme.bodySmall,
                                    ),
                                      Expanded(
                                        child: Text(
                                          "${doctorNoteModel.issue}",
                                          style: doctorNoteModel.isRead? Theme.of(context).textTheme.titleSmall: Theme.of(context).textTheme.labelLarge,
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),

                            ),
                            Align(
                              child: IconButton(onPressed: (){
                                BlocProvider.of<ReportIssueBloc>(context).
                                add(ChangeReadIssueNoteEvent(index, !doctorNoteModel.isRead));
                              }, icon: Icon(Icons.book_outlined)),
                              alignment: Alignment.bottomLeft,

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