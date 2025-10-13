import 'package:domina_app/app/user_info.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/resources/values_manager.dart';
import 'package:domina_app/presentation/senior/report_visit_doctor/bloc/report_visit_doctor_bloc.dart';
import 'package:domina_app/presentation/senior/report_visit_doctor/widget/text_info.dart';
import 'package:domina_app/presentation/uniti/circle_number_widget.dart';
import 'package:domina_app/presentation/uniti/search_field.dart';
import 'package:domina_app/presentation/uniti/stateWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReportVisitDoctorPage extends StatelessWidget {
  ReportVisitDoctorPage({
    super.key,
    required this.userId,
    required this.repId,
    required this.repName,
    required this.indexRep,
    required this.repPlan,
  });
  final int userId;
  final int repId;
  final String repName;
  final int indexRep;
  final int repPlan;

  final TextEditingController searchNoteDoctorController =
      TextEditingController();
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ReportVisitDoctorBloc>(context).clear();
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
                BlocProvider.of<ReportVisitDoctorBloc>(context)
                    .add(DocNoIsExpandedNoteEvent());
                Navigator.pop(context);
              },
            );
          },
        ),
        title: Text(repName),
      ),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Padding(
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
                          BlocProvider.of<ReportVisitDoctorBloc>(context)
                              .add(SenSearchNoteVisitDoctorEvent(value));
                        },
                      ),
                    ],
                  ),
                ),
                BlocConsumer<ReportVisitDoctorBloc, ReportVisitDoctorState>(
                  listener: (context, state) {
                    if (state is AsReadErrorState) {
                      error(context, state.failure.massage, state.failure.code);
                    }
                  },
                  builder: (context, state) {
                    List<RepVisitsModel> doctorNoteModel =
                        context.watch<ReportVisitDoctorBloc>().repVisitsSearch;
                    if (state is AllReportVisitDoctorEmptyState) {
                      return SliverList(
                          delegate: SliverChildListDelegate([
                        SizedBox(
                          height: 100,
                        ),
                        emptyFullScreen(context)
                      ]));
                    }
                    if (state is SenVisitDoctorAsReadState) {
                      doctorNoteModel = state.doctorNoteModel;
                    }
                    if (state is AllReportVisitDoctorsState) {
                      doctorNoteModel = state.repVisitsModel;
                    }
                    if (state is AllReportVisitDoctorLoadingState) {
                      return SliverList(
                        delegate: SliverChildListDelegate(
                            [loadingFullScreen(context)]),
                      );
                    }
                    if (state is AllReadLoadingState) {
                      return SliverList(
                        delegate: SliverChildListDelegate(
                            [loadingFullScreen(context)]),
                      );
                    }
                    if (state is AllReadSucState) {
                      BlocProvider.of<ReportVisitDoctorBloc>(context).add(
                          AllReportVisitDoctorEvent(
                              VisitRepSen(repId, UserInfo.repId)));
                    }
                    if (state is AllReportVisitDoctorErrorState) {
                      return SliverList(
                        delegate: SliverChildListDelegate([
                          errorFullScreen(context, func: () {
                            BlocProvider.of<ReportVisitDoctorBloc>(context).add(
                                AllReportVisitDoctorEvent(
                                    VisitRepSen(repId, userId)));
                          })
                        ]),
                      );
                    }
                    if (state is AllReadErrorState) {
                      return SliverList(
                        delegate: SliverChildListDelegate([
                          errorFullScreen(context, func: () {
                            BlocProvider.of<ReportVisitDoctorBloc>(context).add(
                                AllReportVisitDoctorEvent(
                                    VisitRepSen(repId, userId)));
                          })
                        ]),
                      );
                    }
                    return SliverList(
                      delegate: SliverChildListDelegate([
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text("عدد الملاحظات : ",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge),
                                  CircleNumberWidget(
                                      number: doctorNoteModel.length),
                                ],
                              ),
                              Row(
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        BlocProvider.of<ReportVisitDoctorBloc>(
                                                context)
                                            .add(AllReadDocNoteEvent(
                                                readAll: ReadAll(repPlan,
                                                    UserInfo.repId, 1, 1)));
                                      },
                                      icon: Icon(Icons.bookmarks_rounded)),
                                  IconButton(
                                      onPressed: () {
                                        BlocProvider.of<ReportVisitDoctorBloc>(
                                            context)
                                            .add(AllReadDocNoteEvent(
                                            readAll: ReadAll(repPlan,
                                                UserInfo.repId, 1, 0)));
                                      },
                                      icon: Icon(Icons.bookmarks_outlined)),
                                ],
                              )
                            ],
                          ),
                        ),
                        // القائمة
                        ...doctorNoteModel.asMap().entries.map((entry) {
                          final index = entry.key;
                          final doctorNoteModel = entry.value;
                          return Container(
                            margin: EdgeInsets.all(AppPaddingH.p8),
                            padding: EdgeInsets.symmetric(
                                horizontal: AppPaddingW.p8,
                                vertical: AppPaddingH.p12),
                            decoration: doctorNoteModel.flag
                                ? BoxDecoration(
                                    border:
                                        Border.all(color: ColorManager.primary),
                                    color: ColorManager.secondaryColor8,
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(AppSize.s14)),
                                  )
                                : BoxDecoration(
                                    color: ColorManager.white,
                                    border: Border.all(
                                        color: ColorManager.hintGrey),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(AppSize.s14)),
                                  ),
                            child: Column(
                              children: [
                                InkWell(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        doctorNoteModel.docTitle,
                                        style: doctorNoteModel.flag
                                            ? Theme.of(context)
                                                .textTheme
                                                .titleSmall
                                            : Theme.of(context)
                                                .textTheme
                                                .labelLarge,
                                        textAlign: TextAlign.center,
                                      ),
                                      Text(
                                        "${doctorNoteModel.placeTitle}",
                                        style: doctorNoteModel.flag
                                            ? Theme.of(context)
                                                .textTheme
                                                .titleSmall
                                            : Theme.of(context)
                                                .textTheme
                                                .labelLarge,
                                        textAlign: TextAlign.center,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  " التاريخ :",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodySmall,
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    " ${doctorNoteModel.visitDate} ",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodySmall,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Expanded(
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "الإختصاص :",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodySmall,
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    " ${doctorNoteModel.spTitle} ",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodySmall,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  onTap: () {
                                    BlocProvider.of<ReportVisitDoctorBloc>(
                                            context)
                                        .add(DocIsExpandedNoteEvent(
                                            doctorNoteModel, index));
                                  },
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              " التقيم :",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall,
                                            ),
                                            Expanded(
                                              child: Text(
                                                " ${doctorNoteModel.rate} ",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    BlocBuilder<ReportVisitDoctorBloc,
                                        ReportVisitDoctorState>(
                                      builder: (context, state) {
                                        return Align(
                                          child: IconButton(
                                              onPressed: state
                                                      is AsReadLoadingState
                                                  ? null
                                                  : () {
                                                      print(
                                                          doctorNoteModel.flag);

                                                      BlocProvider.of<ReportVisitDoctorBloc>(
                                                              context)
                                                          .add(ChangeReadDocNoteEvent(
                                                              repVisitsModel:
                                                                  doctorNoteModel,
                                                              index: indexRep,
                                                              indexBook:
                                                                  index));
                                                    },
                                              icon: Icon(
                                                Icons.book_outlined,
                                                color: doctorNoteModel.flag
                                                    ? ColorManager.white
                                                    : ColorManager
                                                        .secondaryColor,
                                              )),
                                          alignment: Alignment.bottomLeft,
                                        );
                                      },
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
          BlocBuilder<ReportVisitDoctorBloc, ReportVisitDoctorState>(
            builder: (context, state) {
              bool num = BlocProvider.of<ReportVisitDoctorBloc>(context).num;
              bool isExpanded =
                  BlocProvider.of<ReportVisitDoctorBloc>(context).isExpanded;
              RepVisitsModel doctorNoteModel =
                  BlocProvider.of<ReportVisitDoctorBloc>(context)
                      .doctorNoteModel;
              int index = BlocProvider.of<ReportVisitDoctorBloc>(context).index;

              if (state is DocIsExpandedNoteState) {
                isExpanded = true;
                index = state.index;
                doctorNoteModel = state.doctorNoteModel;
              }
              if (state is DocNoIsExpandedNoteState) {
                isExpanded = false;
              }
              return Stack(
                children: [
                  if (isExpanded)
                    GestureDetector(
                      onTap: () {
                        BlocProvider.of<ReportVisitDoctorBloc>(context)
                            .add(DocNoIsExpandedNoteEvent());
                      },
                      child: ModalBarrier(
                        color: Colors.black.withOpacity(0.5),
                        dismissible: true,
                      ),
                    ),
                  isExpanded
                      ? DraggableScrollableSheet(
                          initialChildSize: 0.4,
                          minChildSize: 0.1,
                          maxChildSize: 1,
                          builder: (context, scrollController) {
                            return NotificationListener<
                                DraggableScrollableNotification>(
                              onNotification: (notification) {
                                if (notification.extent == 1) {
                                  BlocProvider.of<ReportVisitDoctorBloc>(
                                          context)
                                      .add(ExpandedBorder(true));
                                } else if (BlocProvider.of<
                                            ReportVisitDoctorBloc>(context)
                                        .num ==
                                    true) {
                                  BlocProvider.of<ReportVisitDoctorBloc>(
                                          context)
                                      .add(ExpandedBorder(false));
                                } else if (notification.extent <= 0.1) {
                                  BlocProvider.of<ReportVisitDoctorBloc>(
                                          context)
                                      .add(DocNoIsExpandedNoteEvent());
                                }
                                // else {
                                //   BlocProvider.of<ReportVisitDoctorBloc>(context).add(ExpandedBorder(1));
                                // }
                                return true;
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: ColorManager.secondaryColor3),
                                  color: ColorManager.white,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(
                                        ((num == true)) ? 0 : AppSize.s40),
                                    topRight: Radius.circular(
                                        ((num == true)) ? 0 : AppSize.s40),
                                  ),
                                ),
                                child: SingleChildScrollView(
                                  controller: scrollController,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      num == false
                                          ? Center(
                                              child: InkWell(
                                                onTap: () {
                                                  BlocProvider.of<
                                                              ReportVisitDoctorBloc>(
                                                          context)
                                                      .add(
                                                          DocNoIsExpandedNoteEvent());
                                                },
                                                child: Container(
                                                  margin: EdgeInsets.all(16),
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: AppPaddingH.p8),
                                                  child: Column(
                                                    children: List.generate(
                                                      2,
                                                      (index) => Container(
                                                        width: 60,
                                                        height: 3,
                                                        margin: EdgeInsets
                                                            .symmetric(
                                                                vertical: 3),
                                                        decoration:
                                                            BoxDecoration(
                                                          color: ColorManager
                                                              .secondaryColor1,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(2),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            )
                                          : SizedBox(),
                                      Padding(
                                        padding: EdgeInsets.all(AppPaddingH.p20),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            SizedBox(height: 20),
                                            TextInfo(
                                              title: "اسم الدكتور",
                                              supTitle:
                                                  doctorNoteModel.docTitle,
                                            ),
                                            TextInfo(
                                              title: "العنوان",
                                              supTitle:
                                                  doctorNoteModel.placeTitle,
                                            ),
                                            TextInfo(
                                              title: "الاختصاص",
                                              supTitle: doctorNoteModel.spTitle,
                                            ),
                                            TextInfo(
                                              title: "التقييم",
                                              supTitle: doctorNoteModel.rate,
                                            ),
                                            TextInfo(
                                              title: "التاريخ",
                                              supTitle:
                                                  doctorNoteModel.visitDate,
                                            ),
                                            TextInfo(
                                              title: "الأهداف",
                                              supTitle: doctorNoteModel.target,
                                            ),
                                            TextInfo(
                                              title: "ملاحظات المكتب العلمي",
                                              supTitle: doctorNoteModel.note,
                                            ),
                                            TextInfo(
                                              title: "ملاحظات إضافية",
                                              supTitle: doctorNoteModel.special,
                                            ),
                                            TextInfo(
                                              title: "ملاحظات مستودع قاسيون",
                                              supTitle: doctorNoteModel.issue,
                                            ),
                                            doctorNoteModel.samples.isNotEmpty
                                                ? Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        "المستحضرات: ",
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .labelLarge,
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                      SizedBox(height: 8),
                                                      ListView.builder(
                                                        shrinkWrap: true,
                                                        physics:
                                                            NeverScrollableScrollPhysics(),
                                                        itemCount:
                                                            doctorNoteModel
                                                                .samples.length,
                                                        itemBuilder:
                                                            (context, index) {
                                                          return Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                                    vertical: 5,
                                                                    horizontal:
                                                                        5),
                                                            child: Container(
                                                              alignment: Alignment
                                                                  .bottomRight,
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(10),
                                                              decoration:
                                                                  BoxDecoration(
                                                                border: Border.all(
                                                                    color: ColorManager
                                                                        .secondaryColor7),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8),
                                                              ),
                                                              child: Text(
                                                                doctorNoteModel
                                                                        .samples[
                                                                    index],
                                                                style: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .bodySmall,
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                              ),
                                                            ),
                                                          );
                                                        },
                                                      ),
                                                    ],
                                                  )
                                                : SizedBox(),
                                            Align(
                                              child: IconButton(
                                                onPressed: state
                                                        is AsReadLoadingState
                                                    ? null
                                                    : () {
                                                        BlocProvider.of<
                                                                    ReportVisitDoctorBloc>(
                                                                context)
                                                            .add(
                                                          ChangeReadDocNoteEvent(
                                                              repVisitsModel:
                                                                  doctorNoteModel,
                                                              index: indexRep,
                                                              indexBook: index),
                                                        );
                                                      },
                                                icon: Icon(
                                                  size: 30,
                                                  Icons.book_outlined,
                                                  color: doctorNoteModel.flag
                                                      ? ColorManager
                                                          .secondaryColor4
                                                      : ColorManager
                                                          .secondaryColor,
                                                ),
                                              ),
                                              alignment: Alignment.bottomLeft,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        )
                      : SizedBox(),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
