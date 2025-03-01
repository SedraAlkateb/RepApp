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

class ReportVisitHospital extends StatelessWidget {
  ReportVisitHospital(
      {super.key,
      required this.userId,
      required this.repId,
      required this.repName});
  final int userId;
  final int repId;
  final String repName;
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
                              .add(SenSearchNoteVisitHospitalEvent(value));
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
                        context.watch<ReportVisitDoctorBloc>().repVisitHospital;
                    if (state is AllReportVisitHospitalEmptyState) {
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
                    if (state is AllReportVisitHospitalsState) {
                      doctorNoteModel = state.repVisitsModel;
                    }
                    if (state is AllReportVisitHospitalLoadingState) {
                      return SliverList(
                        delegate: SliverChildListDelegate(
                            [loadingFullScreen(context)]),
                      );
                    }

                    if (state is AllReportVisitHospitalErrorState) {
                      return SliverList(
                        delegate: SliverChildListDelegate([
                          errorFullScreen(context, func: () {
                            BlocProvider.of<ReportVisitDoctorBloc>(context).add(
                                AllReportVisitHospitalEvent(
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
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text("عدد الملاحظات : ",
                                  style:
                                      Theme.of(context).textTheme.titleLarge),
                              CircleNumberWidget(
                                  number: doctorNoteModel.length),
                            ],
                          ),
                        ),
                        // القائمة
                        ...doctorNoteModel.asMap().entries.map((entry) {
                          final index = entry.key;
                          final doctorNoteModel = entry.value;
                          return Container(
                            margin: EdgeInsets.all(AppPadding.p8),
                            padding: EdgeInsets.symmetric(
                                horizontal: AppPadding.p8,
                                vertical: AppPadding.p12),
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
                                              onPressed:
                                                  state is AsReadLoadingState
                                                      ? null
                                                      : () {
                                                          BlocProvider.of<
                                                                      ReportVisitDoctorBloc>(
                                                                  context)
                                                              .add(ChangeReadHosNoteEvent(
                                                                  index,
                                                                  !doctorNoteModel
                                                                      .flag));
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
              bool isExpanded = state is DocIsExpandedNoteState;
              return Stack(
                children: [
                  if (isExpanded)
                    ModalBarrier(
                      color: Colors.black.withOpacity(0.5),
                      dismissible: false,
                    ),
                  isExpanded
                      ? DraggableScrollableSheet(
                          initialChildSize: 0.4,
                          minChildSize: 0.2,
                          maxChildSize: 0.97,
                          builder: (context, scrollController) {
                            return Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: ColorManager.secondaryColor3),
                                color: ColorManager.white,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(AppSize.s40),
                                  topRight: Radius.circular(AppSize.s40),
                                ),
                              ),
                              child: SingleChildScrollView(
                                controller: scrollController,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Center(
                                      child: InkWell(
                                        onTap: () {
                                          BlocProvider.of<
                                                      ReportVisitDoctorBloc>(
                                                  context)
                                              .add(DocNoIsExpandedNoteEvent());
                                        },
                                        child: Container(
                                          margin: EdgeInsets.all(16),
                                          padding: EdgeInsets.symmetric(
                                              vertical: AppPadding.p8),
                                          child: Column(
                                            children: List.generate(
                                                2,
                                                (index) => Container(
                                                      width: 60,
                                                      height: 3,
                                                      margin:
                                                          EdgeInsets.symmetric(
                                                              vertical: 3),
                                                      decoration: BoxDecoration(
                                                        color: ColorManager
                                                            .secondaryColor1,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(2),
                                                      ),
                                                    )),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(AppPadding.p20),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            height: 20,
                                          ),
                                          TextInfo(
                                            title: "اسم الدكتور",
                                            supTitle:
                                                state.doctorNoteModel.docTitle,
                                          ),
                                          TextInfo(
                                            title: "العنوان",
                                            supTitle: state
                                                .doctorNoteModel.placeTitle,
                                          ),
                                          TextInfo(
                                            title: "الاختصاص",
                                            supTitle:
                                                state.doctorNoteModel.spTitle,
                                          ),
                                          TextInfo(
                                            title: "التقيم",
                                            supTitle:
                                                state.doctorNoteModel.rate,
                                          ),
                                          TextInfo(
                                            title: "التاريخ",
                                            supTitle:
                                                state.doctorNoteModel.visitDate,
                                          ),
                                          TextInfo(
                                            title: "ملاحظات المكتب العلمي",
                                            supTitle:
                                                state.doctorNoteModel.note,
                                          ),
                                          TextInfo(
                                            title: "ملاحظات إضافية",
                                            supTitle:
                                                state.doctorNoteModel.special,
                                          ),
                                          TextInfo(
                                            title: "ملاحظات مستودع قاسيون",
                                            supTitle:
                                                state.doctorNoteModel.issue,
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                bottom: AppPadding.p8),
                                            child: Column(
                                              children: [
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Expanded(
                                                      child: Text.rich(
                                                        textAlign:
                                                            TextAlign.start,
                                                        softWrap: false,
                                                        maxLines: 3,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        TextSpan(
                                                          text:
                                                              "الهدف من الزيارة : ",
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .labelLarge,
                                                          children: <TextSpan>[
                                                            TextSpan(
                                                              text: state
                                                                  .doctorNoteModel
                                                                  .target,
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .bodySmall,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 20,
                                                ),
                                              ],
                                            ),
                                          ),
                                          state.doctorNoteModel.samples
                                                      .length !=
                                                  0
                                              ? Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
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
                                                      itemCount: state
                                                          .doctorNoteModel
                                                          .samples
                                                          .length,
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
                                                                EdgeInsets.all(
                                                                    10),
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
                                                              state.doctorNoteModel
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
                                                onPressed:
                                                    state is AsReadLoadingState
                                                        ? null
                                                        : () {
                                                            BlocProvider.of<
                                                                        ReportVisitDoctorBloc>(
                                                                    context)
                                                                .add(ChangeReadHosNoteEvent(
                                                                    state.index,
                                                                    !state
                                                                        .doctorNoteModel
                                                                        .flag));
                                                          },
                                                icon: Icon(
                                                  size: 30,
                                                  Icons.book_outlined,
                                                  color:
                                                      state.doctorNoteModel.flag
                                                          ? ColorManager
                                                              .secondaryColor4
                                                          : ColorManager
                                                              .secondaryColor,
                                                )),
                                            alignment: Alignment.bottomLeft,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
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
