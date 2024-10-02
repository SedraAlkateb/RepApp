import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/specialization/bloc/specialization_bloc.dart';
import 'package:domina_app/presentation/specialization/pages/doctor_sp.dart';
import 'package:domina_app/presentation/specialization/pages/hospital_sp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SpecDH extends StatelessWidget {
  const SpecDH({super.key, required this.spId});
  final int spId;
  @override
  Widget build(BuildContext context) {

    return DefaultTabController(

        length:2, //3,
        child: Scaffold(
          appBar: AppBar(

            backgroundColor: ColorManager.secondaryColor7,
            bottom: TabBar(
                labelPadding: EdgeInsets.all(0.9),
                onTap: (value) {
                  // if (value == 0) {
                  //   BlocProvider.of<SpecializationBloc>(context)
                  //       .add(PharmacyByPlace(placeId, value));
                  //   BlocProvider.of<SpecializationBloc>(context)
                  //       .add(BrandAnyFlagEvent());
                  // } else
                  if (value == 0) {
                    BlocProvider.of<SpecializationBloc>(context)
                        .add(DoctorSpEvent(spId));
          //          BlocProvider.of<SpecializationBloc>(context)
             //           .add(BrandFlagEvent());
                  } else {
                    BlocProvider.of<SpecializationBloc>(context)
                        .add(HospitalSpEvent(spId));
            //        BlocProvider.of<SpecializationBloc>(context)
              //          .add(BrandFlagEvent());
                  }
                },
                tabs: [
                  // Tab(
                  //   icon: context.watch<SpecializationBloc>().current == 0
                  //       ? Icon(Icons.local_pharmacy_sharp,
                  //           color: ColorManager.secondaryColor1)
                  //       : Icon(Icons.local_pharmacy_sharp),
                  //   text: 'الصيدليات',
                  // ),
                  Tab(
                    icon: context.watch<SpecializationBloc>().current == 0
                        ? Icon(
                            Icons.groups,
                            color: ColorManager.secondaryColor1,
                          )
                        : Icon(Icons.groups),
                    text: 'الأطباء',
                  ),
                  Tab(
                    icon: context.watch<SpecializationBloc>().current == 1
                        ? Icon(
                            Icons.local_hospital,
                            color: ColorManager.secondaryColor1,
                          )
                        : Icon(Icons.local_hospital),
                    text: 'المشافي',
                  ),
                ]),
          ),
          body: TabBarView(
              physics: NeverScrollableScrollPhysics(),
              children: [
          //  PharmacyVisit(),
            DoctorSp(),
                HospitalSp(),
          ]),
        ));
  }
}
