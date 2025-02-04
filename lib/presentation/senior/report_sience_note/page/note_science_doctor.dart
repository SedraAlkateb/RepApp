import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/resources/values_manager.dart';
import 'package:domina_app/presentation/senior/report_sience_note/bloc/report_science_bloc.dart';
import 'package:domina_app/presentation/uniti/circle_number_widget.dart';
import 'package:domina_app/presentation/uniti/search_field.dart';
import 'package:domina_app/presentation/uniti/stateWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NoteScienceDoctor extends StatelessWidget {
  NoteScienceDoctor({super.key, required this.id});
  final int id;
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
        title: Text('ملاحظات المكتب العلمي'),
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
                          BlocProvider.of<ReportScienceBloc>(context)
                              .add(SenSearchNoteDoctorEvent(value));
                        },
                      ),
                    ],
                  ),
                ),
                BlocBuilder<ReportScienceBloc, ReportScienceState>(
                  builder: (context, state) {
                    List<DoctorNoteModel> doctorNoteModel =
                        context.watch<ReportScienceBloc>().doctorNoteModel;
                    if (state is SenAllNoteDoctorEmptyState) {
                      return SliverList(
                          delegate: SliverChildListDelegate([
                        SizedBox(
                          height: 100,
                        ),
                        emptyFullScreen(context)
                      ]));
                    }
                    if (state is SenAsReadState) {
                      doctorNoteModel = state.doctorNoteModel;
                    }
                    if (state is SenAllNoteDoctorsState) {
                      doctorNoteModel = state.doctorNoteModel;
                    }
                    if (state is SenAllNoteDoctorLoadingState) {
                      return SliverList(
                        delegate: SliverChildListDelegate(
                            [loadingFullScreen(context)]),
                      );
                    }
                    if (state is SenAllNoteDoctorErrorState) {
                      return SliverList(
                        delegate: SliverChildListDelegate([
                          errorFullScreen(context, func: () {
                            BlocProvider.of<ReportScienceBloc>(context)
                                .add(SenAllNoteDoctorEvent(id));
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
                            decoration: doctorNoteModel.isRead
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
                                        style: doctorNoteModel.isRead
                                            ? Theme.of(context)
                                                .textTheme
                                                .titleSmall
                                            : Theme.of(context)
                                                .textTheme
                                                .labelLarge,
                                        textAlign: TextAlign.center,
                                      ),
                                      Text(
                                        "${doctorNoteModel.address}",
                                        style: doctorNoteModel.isRead
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
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                " التاريخ :",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall,
                                              ),
                                              Text(
                                                " ${doctorNoteModel.visitDate} ",
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
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall,
                                              ),
                                              Text(
                                                " ${doctorNoteModel.spTitle} ",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  onTap: () {
                                    BlocProvider.of<ReportScienceBloc>(context)
                                        .add(IsExpandedNoteEvent(
                                            doctorNoteModel));
                                  },
                                ),
                                Align(
                                  child: IconButton(
                                      onPressed: () {
                                        BlocProvider.of<ReportScienceBloc>(
                                                context)
                                            .add(ChangeReadScienceNoteEvent(
                                                index,
                                                !doctorNoteModel.isRead));
                                      },
                                      icon: Icon(
                                        Icons.book_outlined,
                                        color: doctorNoteModel.isRead
                                            ? ColorManager.white
                                            : ColorManager.secondaryColor,
                                      )),
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
          BlocBuilder<ReportScienceBloc, ReportScienceState>(
            builder: (context, state) {
              bool isExpanded = state is IsExpandedNoteState;

              return Stack(
                children: [
                  // الطبقة المظللة عندما يكون الـ DraggableScrollableSheet مفتوحًا
                  if (isExpanded)
                    ModalBarrier(
                      color: Colors.black.withOpacity(0.5),
                      dismissible: false,
                    ),
                  isExpanded
                      ? DraggableScrollableSheet(
                          initialChildSize: 0.4,
                          minChildSize: 0.2,
                          maxChildSize: 0.8,
                          builder: (context, scrollController) {
                            return Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: ColorManager.secondaryColor3),
                                color: ColorManager.white,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(AppSize.s50),
                                  topRight: Radius.circular(AppSize.s50),
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
                                          BlocProvider.of<ReportScienceBloc>(
                                                  context)
                                              .add(NoIsExpandedNoteEvent());
                                        },
                                        child: Container(
                                          margin: EdgeInsets.all(16),
                                          padding: EdgeInsets.symmetric(
                                              vertical: AppPadding.p8),
                                          child: Column(
                                            children: List.generate(
                                                3,
                                                (index) => Container(
                                                      width: 70,
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
                                      padding: EdgeInsets.all(AppPadding.p16),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                           "اسم الدكتور",
                                            style:  Theme.of(context)
                                                .textTheme
                                                .labelLarge,
                                            textAlign: TextAlign.center,
                                          ),
                                          SizedBox(height: 2,),
                                          Text(
                                            state.doctorNoteModel.docTitle,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall,
                                          ),
                                          Text(
                                            "اسم الدكتور",
                                            style:  Theme.of(context)
                                                .textTheme
                                                .labelLarge,
                                            textAlign: TextAlign.center,
                                          ),
                                          SizedBox(height: 2,),
                                          Text(
                                            state.doctorNoteModel.docTitle,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall,
                                          ),
                                          Text(
                                            "الاختصاص",
                                            style:  Theme.of(context)
                                                .textTheme
                                                .labelLarge,
                                            textAlign: TextAlign.center,
                                          ),
                                          SizedBox(height: 2,),
                                          Text(
                                            state.doctorNoteModel.spTitle,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall,
                                          ),
                                          Text(
                                            "note",
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelLarge,
                                          ),
                                          SizedBox(height: AppSize.s8),
                                          Text(
                                            state.doctorNoteModel.note ??
                                                "لا توجد معلومات إضافية",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium,
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
