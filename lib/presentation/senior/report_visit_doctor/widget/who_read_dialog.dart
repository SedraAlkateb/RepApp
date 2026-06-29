import 'package:domina_app/presentation/senior/report_visit_doctor/bloc/report_visit_doctor_bloc.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/resources/values_manager.dart';
import 'package:domina_app/presentation/uniti/stateWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// 1. Pass the existing bloc instance to the function
void whoReadDialog(BuildContext context, ReportVisitDoctorBloc bloc) {
  showDialog(
      context: context,
      builder: (dialogContext) { // Renamed context to avoid confusion
        return Center(
            child: Padding(
              padding:
              const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
              child: Container(
                  decoration: BoxDecoration(
                      color: ColorManager.white,
                      borderRadius: BorderRadius.circular(15)),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                    child: Container(
                      decoration: BoxDecoration(
                          color: ColorManager.white,
                          borderRadius: BorderRadius.circular(15)),
                      child: SingleChildScrollView(
                        // 2. Wrap the BlocBuilder with BlocProvider.value
                        child: BlocProvider.value(
                          value: bloc,
                          child: BlocBuilder<ReportVisitDoctorBloc,
                              ReportVisitDoctorState>(
                            builder: (context, state) {
                              if (state is AllWhoAllReadLoadingState) {
                                return loadingFullScreen(context);
                              }
                              if (state is AllWhoAllReadErrorState) {
                                return Padding(
                                  padding:  EdgeInsets.only(
                                      bottom: AppPaddingH.p20, top: AppPaddingH.p12),
                                  child: errorFullScreen(context,
                                      mes: state.failure.massage),
                                );
                              }
                              if (state is AllWhoAllReadEmptyState) {
                                return Padding(
                                  padding:  EdgeInsets.symmetric(
                                      vertical: AppPaddingH.p20),
                                  child: emptyFullScreen(context,
                                      message: "لم يقرأ احد الملاحظة "),
                                );
                              }
                              if (state is AllWhoAllReadsState) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 20),
                                      child: Text(
                                        textAlign: TextAlign.right,
                                        "تمت القراءة من قبل :",
                                        style: TextStyle(
                                            fontSize: 22,
                                            color: ColorManager.secondaryColor1,
                                            fontWeight: FontWeight.bold,
                                            decoration: TextDecoration.none),
                                      ),
                                    ),
                                    Padding(
                                        padding: const EdgeInsets.only(bottom: 20),
                                        child: ListView.separated(
                                          separatorBuilder: (context, index) =>
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          itemBuilder: (context, index) => Row(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.circle,
                                                color: ColorManager.secondaryColor1,
                                                size: AppSize.s12,
                                              ),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                textAlign: TextAlign.center,
                                                state.whoReadModel[index].name,
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    color:
                                                    ColorManager.secondaryColor1,
                                                    fontWeight: FontWeight.w100,
                                                    decoration: TextDecoration.none),
                                              ),
                                              Text(
                                                textAlign: TextAlign.center,
                                                "( ${state.whoReadModel[index].role} )  ",
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    color:
                                                    ColorManager.secondaryColor1,
                                                    fontWeight: FontWeight.w100,
                                                    decoration: TextDecoration.none),
                                              ),
                                            ],
                                          ),
                                          itemCount: state.whoReadModel.length,
                                          shrinkWrap: true,
                                        )),
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 12),
                                      child: Center(
                                        child: ElevatedButton(
                                            child: const Text("موافق"),
                                            onPressed: () {
                                              Navigator.pop(dialogContext);
                                            }),
                                      ),
                                    )
                                  ],
                                );
                              }
                              return const SizedBox();
                            },
                          ),
                        ),
                      ),
                    ),
                  )),
            ));
      });
}