import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/resources/values_manager.dart';
import 'package:domina_app/presentation/senior/search_doctors/bloc/search_doctors_bloc.dart';
import 'package:domina_app/presentation/uniti/search_field.dart';
import 'package:domina_app/presentation/uniti/stateWidget.dart';
import 'package:domina_app/presentation/uniti/text2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/models/models.dart';

class DoctorDetailes extends StatefulWidget {
  final doctorsModel doctorModel;
  DoctorDetailes({super.key, required this.doctorModel});

  @override
  State<DoctorDetailes> createState() => _DoctorDetailesState();
}

class _DoctorDetailesState extends State<DoctorDetailes>
    with AutomaticKeepAliveClientMixin {
  final TextEditingController searchController = TextEditingController();
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
                        BorderRadius.vertical(bottom: Radius.circular(50)),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: AppPadding.p18),
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Padding(
                            padding: EdgeInsets.only(top: 22),
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
                                        padding: EdgeInsets.only(right: 15),
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
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    shape: BoxShape.rectangle,
                                    border: Border.all(
                                      color: ColorManager.secondaryColor2,
                                      width: 2.0,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [],
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
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                textAlign: TextAlign.center,
                                "العنوان: ${widget.doctorModel.placeTitle}",
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                textAlign: TextAlign.center,
                                " الإختصاص : ${(widget.doctorModel.spTitle)}",
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                SearchField(
                  searchController: searchController,
                  onPressed: (value) {
                    BlocProvider.of<SearchDoctorsBloc>(context)
                        .add(FutureSearchEvent(value));
                  },
                ),
                ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 1, horizontal: 16),
                        child: Container(
                          margin: EdgeInsets.all(AppPadding.p8),
                          padding: EdgeInsets.all(AppPadding.p16),
                          decoration: BoxDecoration(
                            color: ColorManager.white,
                            border: Border.all(color: ColorManager.hintGrey),
                            borderRadius: const BorderRadius.all(
                                Radius.circular(AppSize.s8)),
                          ),
                          child: Column(
                            children: [
                              TextRach2(
                                s1: "اسم المندوب: ",
                                s2: state.doctordetails[index].repName,
                              ),
                              TextRach2(
                                  s1: "التاريخ: ",
                                  s2: state.doctordetails[index].visitDate),
                              TextRach2(
                                  s1: "ملاحظات مستودع قاسيون : ",
                                  s2: state.doctordetails[index].issue),
                              TextRach2(
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
          return SizedBox();
        })));
  }

  @override
  bool get wantKeepAlive => true;
}
