import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/plase_visit/bloc/visit_place_bloc.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/resources/values_manager.dart';
import 'package:domina_app/presentation/uniti/stateWidget.dart';
import 'package:domina_app/presentation/uniti/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DoctorVisit extends StatelessWidget {
  const DoctorVisit({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal:8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Text("كل الدكاترة",),
            Expanded(
              child: BlocConsumer<VisitPlaceBloc, VisitPlaceState>(
                listener: (context, state) {
                  if(state is AllDoctorByPlaceErrorState){
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      error(context, state.failure.massage, state.failure.code);
                    });
                  }
                  /*
                  if(state is AllDoctorByPlaceLoadingState){
                    loading(context);
                  }
                  if(state is AllDoctorByPlaceState){
    success(context);}
                 */
                },
                builder: (context, state) {
                  if(state is AllDoctorByPlaceState){
                    List<DoctorModel> doctorModel=state.data;
                    return ListView.builder
                      (
                        itemBuilder: (context, index) {
                          return Container(
                            margin: EdgeInsets.all(AppPadding.p8),
                            padding: EdgeInsets.all(AppPadding.p16),
                            //    height: AppSize.s150,
                            decoration: BoxDecoration(
                              color: ColorManager.white,
                              border:
                              Border.all(color: ColorManager.hintGrey),
                              borderRadius: const BorderRadius.all(
                                  Radius.circular(AppSize.s8)),
                              //        color: ColorManager.card,
                            ),
                            child:
                            Column(
                              children: [
                                TextRach(s1: "title : ", s2: doctorModel[index].title),
                                TextRach(s1: "address : ", s2: doctorModel[index].address)
                              ],
                            ),
                          );
                        }, itemCount: doctorModel.length);
                  }
                  return SizedBox(
                  );
                },
              ),
            ),
          ],
        ),
      ),
    
    );
  }
}
