import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/resources/values_manager.dart';
import 'package:domina_app/presentation/senior/search_doctors/bloc/search_doctors_bloc.dart';
import 'package:domina_app/presentation/senior/search_doctors/widgets/text__serach_doctor.dart';
import 'package:domina_app/presentation/uniti/search_field.dart';
import 'package:domina_app/presentation/uniti/stateWidget.dart';
import 'package:domina_app/presentation/uniti/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HospitalDetails extends StatefulWidget {
  final SearchHospitalModel searchHospitalModel;
  const HospitalDetails({super.key, required this.searchHospitalModel});

  @override
  State<HospitalDetails> createState() => _HospitalDetailsState();
}

class _HospitalDetailsState extends State<HospitalDetails>
    with AutomaticKeepAliveClientMixin {
  final TextEditingController searchNoteHospitalController =
      TextEditingController();
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
        appBar: null,
        body: SingleChildScrollView(
            child: BlocBuilder<SearchDoctorsBloc, SearchDoctorsState>(
                buildWhen: (previous, current) =>
                    current is FutureDocHospitalsState ||
                    current is FutureDocHospitalsErrorState ||
                    current is FutureDocHospitalsLoadingState ||
                    current is FutureDocHospitalsEmptyState,
                builder: (context, state) {
                  if (state is FutureDocHospitalsErrorState) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 200),
                      child: errorFullScreen(context,
                          mes: state.failure.massage, func: () {}),
                    );
                  }
                  if (state is FutureDocHospitalsLoadingState) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 200),
                      child: loadingFullScreen(context),
                    );
                  }
                  if (state is FutureDocHospitalsEmptyState) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 200),
                      child: emptyFullScreen(context),
                    );
                  }
                  if (state is FutureDocHospitalsState) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 250,
                          decoration: BoxDecoration(
                            color: ColorManager.secondaryColor1,
                            borderRadius: const BorderRadius.vertical(
                                bottom: Radius.circular(50)),
                          ),
                          child: Padding(
                            padding:  EdgeInsets.symmetric(
                                horizontal: AppPaddingW.p20),
                            child: Column(
                              children: [
                                Align(
                                    alignment: Alignment.topRight,
                                    child: IconButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        iconSize: 30,
                                        padding: const EdgeInsets.only(
                                            right: 5, top: 30, bottom: 20),
                                        icon: Icon(Icons.arrow_back_sharp,
                                            color: ColorManager.white))),
                                Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(20),
                                        decoration: BoxDecoration(
                                          color: Colors.transparent,
                                          shape: BoxShape.rectangle,
                                          border: Border.all(
                                            color: ColorManager.secondaryColor2,
                                            width: 2.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Text(
                                          widget.searchHospitalModel.name,
                                          textAlign: TextAlign.center,
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium
                                              ?.copyWith(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                              ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      // Text(
                                      //   textAlign: TextAlign.center,
                                      //   "العنوان: ${widget.searchHospitalModel.placeTitle}",
                                      //   style: Theme.of(context).textTheme.titleMedium,
                                      // ),
                                      // const SizedBox(
                                      //   height: 10,
                                      // ),
                                      // Text(
                                      //   textAlign: TextAlign.center,
                                      //   " الإختصاص : ${(widget.searchHospitalModel.spTitle)}",
                                      //   style: Theme.of(context).textTheme.titleMedium,
                                      // ),
                                      // const SizedBox(
                                      //   height: 5,
                                      // ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        SearchField(
                          searchController: searchNoteHospitalController,
                          onPressed: (value) {
                            BlocProvider.of<SearchDoctorsBloc>(context)
                                .add(SearchNoteHosEvent(value));
                          },
                        ),
                        ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return Padding(
                                padding: const EdgeInsets.only(
                                    bottom: 20, right: 16, left: 16),
                                child: Container(
                                  margin: const EdgeInsets.all(2),
                                  padding:  EdgeInsets.symmetric(
                                      vertical: AppPaddingH.p8),
                                  decoration: BoxDecoration(
                                    color: ColorManager.white,
                                    border: Border.all(
                                        color: ColorManager.hintGrey),
                                    borderRadius:  BorderRadius.all(
                                        Radius.circular(AppSize.s8)),
                                  ),
                                  child: GestureDetector(
                                    onTap: () {
                                      showModalBottomSheet(
                                        context: context,
                                        isScrollControlled: true,
                                        backgroundColor: Colors.transparent,
                                        builder: (context) {
                                          return DraggableScrollableSheet(
                                            expand: true,
                                            initialChildSize: 0.5,
                                            maxChildSize: 1.0,
                                            minChildSize: 0.3,
                                            builder:
                                                (context, scrollController) {
                                              return Container(
                                                padding:
                                                    const EdgeInsets.all(15),
                                                decoration: const BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.vertical(
                                                    top: Radius.circular(20),
                                                  ),
                                                ),
                                                child: ListView(
                                                  controller: scrollController,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              vertical:
                                                                  AppPaddingH
                                                                      .p12),
                                                      child: Column(
                                                        children: List.generate(
                                                          2,
                                                          (index) => Container(
                                                            width: 60,
                                                            height: 3,
                                                            margin:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                                    vertical:
                                                                        3),
                                                            decoration:
                                                                BoxDecoration(
                                                              color: ColorManager
                                                                  .secondaryColor1,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          2),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    TextSerachDoctor(
                                                      s1: "ملاحظات المكتب العلمي",
                                                      s2: state
                                                          .allNote[index].note
                                                          .toString(),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            },
                                          );
                                        },
                                      );
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: AppPaddingH.p10),
                                      child: Column(
                                        children: [
                                          TextRach(
                                              s1: "اسم المندوب: ",
                                              s2: state.allNote[index].name),
                                          TextRach(
                                              s1: "التاريخ: ",
                                              s2: state
                                                  .allNote[index].visitDate),
                                        ],
                                      ),
                                    ),
                                  ),
                                ));
                          },
                          itemCount: state.allNote.length,
                        )
                      ],
                    );
                  }
                  return const SizedBox();
                })));
  }

  @override
  bool get wantKeepAlive => true;
}
