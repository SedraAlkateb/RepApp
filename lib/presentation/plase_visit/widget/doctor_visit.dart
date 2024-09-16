import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/plase_visit/bloc/visit_place_bloc.dart';
import 'package:domina_app/presentation/plase_visit/pages/visit_doctor.dart';
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
            Expanded(
              child: BlocListener<VisitPlaceBloc, VisitPlaceState>(
                listener: (context, state) {
                  if(state is AllDoctorByPlaceErrorState){
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      error(context, state.failure.massage, state.failure.code);
                    });
                  }
                },
                child: ListView.builder
                  (
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          BlocProvider.of<VisitPlaceBloc>(context).add(BrandFlagEvent());
                          Navigator.push(context, MaterialPageRoute(builder: (context) {
                            return  VisitDoctor(doctorModel: context.watch<VisitPlaceBloc>().doctors[index],);
                          },));
                        },
                        child: Container(
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
                              TextRach(s1: "title : ", s2: context.watch<VisitPlaceBloc>().doctors[index].title),
                              TextRach(s1: "address : ", s2: context.watch<VisitPlaceBloc>().doctors[index].address)
                            ],
                          ),
                        ),
                      );
                    }, itemCount: context.watch<VisitPlaceBloc>().doctors.length),

              ),
            ),
          ],
        ),
      ),
    
    );
  }
}
