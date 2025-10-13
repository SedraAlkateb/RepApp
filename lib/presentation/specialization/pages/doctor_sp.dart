import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/resources/values_manager.dart';
import 'package:domina_app/presentation/specialization/bloc/specialization_bloc.dart';
import 'package:domina_app/presentation/uniti/stateWidget.dart';
import 'package:domina_app/presentation/uniti/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DoctorSp extends StatefulWidget {
  @override
  _DoctorSpState createState() => _DoctorSpState();
}

class _DoctorSpState extends State<DoctorSp> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BlocConsumer<SpecializationBloc, SpecializationState>(
              listener: (context, state) {
                if (state is AllSpecDoctorErrorState) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    error(context, state.failure.massage, state.failure.code);
                  });
                }
              },
              builder: (context, state) {
                if (state is AllDoctorSpState) {
                  return Column(
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 20),
                            child: Text("عدد الاطباء  :  ${state.doctors.length} "
                                ,style: Theme.of(context).textTheme.displayLarge),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: EdgeInsets.all(AppPaddingH.p8),
                              padding: EdgeInsets.all(AppPaddingH.p16),
                              decoration: BoxDecoration(
                                color: ColorManager.white,
                                border: Border.all(color: ColorManager.hintGrey),
                                borderRadius:  BorderRadius.all(
                                    Radius.circular(AppSize.s8)),
                              ),
                              child: Column(
                                children: [
                                  Text(
                                    state.doctors[index].title,
                                    style: Theme.of(context).textTheme.labelLarge,
                                  ),
                                  TextRach(
                                      s1: "العنوان: ", s2: state.doctors[index].placeTitle),
                                  TextRach(
                                      s1: "الزيارات: ", s2: state.doctors[index].visits.toString()),
                                ],
                              ),
                            );
                          },
                          itemCount: state.doctors.length,
                        ),
                      ),
                    ],
                  );
                }

               return SizedBox();
              },
            ),
          ],
        ),
      ),
    );
  }
}
