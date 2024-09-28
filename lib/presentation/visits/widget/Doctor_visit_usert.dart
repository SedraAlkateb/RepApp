import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/resources/values_manager.dart';
import 'package:domina_app/presentation/uniti/stateWidget.dart';
import 'package:domina_app/presentation/uniti/text.dart';
import 'package:domina_app/presentation/visits/bloc/visit_bloc.dart';
import 'package:domina_app/presentation/visits/pages/info_visit_doctor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DoctorVisitUser extends StatelessWidget {
  const DoctorVisitUser({super.key});
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: BlocConsumer<VisitBloc, VisitState>(
                listener: (context, state) {
                  if (state is VisitDoctorErrorState) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      error(context, state.failure.massage, state.failure.code);
                    });
                  }
                  /*
                  if(state is AllPharmacyByPlaceLoadingState){
                    loading(context);
                  }
                  if(state is AllPharmacyByPlaceState){
    success(context);}
                 */
                },
                builder: (context, state) => ListView.builder(
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return InfoVisitDoctor(
                              doctorModel: context
                                  .watch<VisitBloc>()
                                  .doctors[index],
                            );
                          }));
                        },
                        child: Container(
                          margin: EdgeInsets.all(AppPadding.p8),
                          padding: EdgeInsets.all(AppPadding.p8),
                          //    height: AppSize.s150,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(color: ColorManager.secondaryColor4)
                            ],
                            color: ColorManager.white,
                            border: Border.all(color: ColorManager.hintGrey),
                            borderRadius: const BorderRadius.all(
                                Radius.circular(AppSize.s8)),
                            //        color: ColorManager.card,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                textAlign: TextAlign.center,
                                context
                                    .watch<VisitBloc>()
                                    .doctors[index]
                                    .doctorModel
                                    .title,
                                style: Theme.of(context).textTheme.labelLarge,
                              ),
                              TextRach(
                                  s1: "العنوان : ",
                                  s2: context
                                      .watch<VisitBloc>()
                                      .doctors[index]
                                      .doctorModel
                                      .address)
                            ],
                          ),
                        ),
                      );
                    },
                    itemCount:
                        context.watch<VisitBloc>().doctors.length),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
