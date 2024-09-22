import 'package:domina_app/presentation/plase_visit/bloc/visit_place_bloc.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/resources/values_manager.dart';
import 'package:domina_app/presentation/uniti/stateWidget.dart';
import 'package:domina_app/presentation/uniti/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HospitalVisit extends StatelessWidget {
  const HospitalVisit({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal:8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
        
            Expanded(
              child: BlocListener<VisitPlaceBloc, VisitPlaceState>(
                listener: (context, state) {
                  if(state is AllHospitalByPlaceErrorState){
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      error(context, state.failure.massage, state.failure.code);
                    });
                  }

                  /*
                  if(state is AllHospitalByPlaceLoadingState){
                    loading(context);
                  }
                  if(state is AllHospitalByPlaceState){
    success(context);}
                 */
                },child: ListView.builder
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
                          Text(  context.watch<VisitPlaceBloc>().hospitals[index].title,style: Theme.of(context).textTheme.labelLarge,),
                          TextRach(s1: "العنوان : ", s2: context.watch<VisitPlaceBloc>().hospitals[index].address)
                        ],
                      ),
                    );
                  }, itemCount: context.watch<VisitPlaceBloc>().hospitals.length),

              ),
            ),
          ],
        ),
      ),

    );
  }
}
