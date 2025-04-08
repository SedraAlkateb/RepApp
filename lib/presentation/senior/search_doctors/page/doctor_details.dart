import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/resources/values_manager.dart';
import 'package:domina_app/presentation/senior/search_doctors/bloc/search_doctors_bloc.dart';
import 'package:domina_app/presentation/senior/search_doctors/widgets/text__serach_doctor.dart';
import 'package:domina_app/presentation/uniti/search_field.dart';
import 'package:domina_app/presentation/uniti/stateWidget.dart';
import 'package:domina_app/presentation/uniti/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DoctorDetails extends StatefulWidget {
  final doctorsModel doctorModel;
  const DoctorDetails({super.key, required this.doctorModel});

  @override
  State<DoctorDetails> createState() => _DoctorDetailsState();
}

class _DoctorDetailsState extends State<DoctorDetails>
    with AutomaticKeepAliveClientMixin {
  final TextEditingController searchNoteDoctorController =
  TextEditingController();
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
        appBar: null,
        body: SingleChildScrollView(
            child: BlocConsumer<SearchDoctorsBloc, SearchDoctorsState>(
                listener: (context, state) {
                  if (state is FutureDocDoctorsErrorState) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      error(context, state.failure.massage, state.failure.code);
                    });
                  }
                }, builder: (context, state) {
              if (state is FutureDocDoctorsLoadingState) {
                return loadingFullScreen(context);
              }
              if (state is FutureDocDoctorsEmptyState) {
                return Padding(
                  padding: const EdgeInsets.only(top: 200),
                  child: emptyFullScreen(context),
                );
              }
              if (state is FutureDocDoctorsState) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 250,
                      decoration: BoxDecoration(
                        color: ColorManager.secondaryColor1,
                        borderRadius:
                        const BorderRadius.vertical(bottom: Radius.circular(50)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: AppPadding.p18),
                        child: Stack(
                          children: [
                            Align(
                              alignment: Alignment.center,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 22),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Align(
                                        alignment: Alignment.topRight,
                                        child: IconButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            iconSize: 30,
                                            padding: const EdgeInsets.only(right: 15),
                                            icon: Icon(Icons.arrow_back_sharp,
                                                color: ColorManager.white))),
                                  ],
                                ),
                              ),
                            ),
                            Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  InkWell(
                                    child: Container(
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        color: Colors.transparent,
                                        shape: BoxShape.rectangle,
                                        border: Border.all(
                                          color: ColorManager.secondaryColor2,
                                          width: 2.0,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Text(
                                        widget.doctorModel.name,
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
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    textAlign: TextAlign.center,
                                    "العنوان: ${widget.doctorModel.placeTitle}",
                                    style: Theme.of(context).textTheme.titleMedium,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    textAlign: TextAlign.center,
                                    " الإختصاص : ${(widget.doctorModel.spTitle)}",
                                    style: Theme.of(context).textTheme.titleMedium,
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    SearchField(
                      searchController: searchNoteDoctorController,
                      onPressed: (value) {
                        BlocProvider.of<SearchDoctorsBloc>(context)
                            .add(SearchNoteDoctorEvent(value));
                      },
                    ),
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Padding(
                            padding:
                            const EdgeInsets.symmetric( horizontal: 16),
                            child: Container(
                              margin: const EdgeInsets.all(2),
                              padding: const EdgeInsets.symmetric(vertical: AppPadding.p8),
                              decoration: BoxDecoration(
                                color: ColorManager.white,
                                border: Border.all(color: ColorManager.hintGrey),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(AppSize.s8)),
                              ),
                              child: Column(
                                children: [
                                  TextRach(
                                      s1: "اسم المندوب: ",
                                      s2: state.doctordetails[index].repName),
                                  TextRach(
                                      s1: "التاريخ: ",
                                      s2: state.doctordetails[index].visitDate),
                                  TextSerachDoctor(
                                      s1: "ملاحظات مستودع قاسيون : ",
                                      s2: state.doctordetails[index].issue),
                                  TextSerachDoctor(
                                      s1: "ملاحظات المستودع العلمي : ",
                                      s2: state.doctordetails[index].note
                                          .toString()),
                                ],
                              ),
                            ));
                      },
                      itemCount: state.doctordetails.length,
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
