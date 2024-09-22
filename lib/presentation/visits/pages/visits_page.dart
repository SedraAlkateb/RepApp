
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/visits/bloc/visit_bloc.dart';
import 'package:domina_app/presentation/visits/widget/doctor_visit_user.dart';
import 'package:domina_app/presentation/visits/widget/hospital_visit_user.dart';
import 'package:domina_app/presentation/visits/widget/pharmacy_visit_usert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class VisitsPage extends StatelessWidget {
  const VisitsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor:ColorManager.secondaryColor7,
            bottom:
            TabBar(labelPadding:EdgeInsets.all(0.9) ,
                onTap: (value) {
                },
                tabs: [
                  Tab(icon:
                  context.watch<VisitBloc>().current==0?
                  Icon(
                      Icons.local_pharmacy_sharp,color: ColorManager.secondaryColor1):
                  Icon(
                      Icons.local_pharmacy_sharp)

                    ,text: 'الصيدليات',),
                  Tab(icon:
                  context.watch<VisitBloc>().current==1?
                  Icon(Icons.groups,color: ColorManager.secondaryColor1,):
                  Icon(Icons.groups)
                    ,text: 'الأطباء',),
                  Tab(icon:                  context.watch<VisitBloc>().current==1?
                  Icon(Icons.local_hospital,color: ColorManager.secondaryColor1,):
                  Icon(Icons.local_hospital)
                    ,text: 'المشافي',)
                ]
            ),
          ),
          body: TabBarView(
              children: [
                PharmacyVisitUser(),
                DoctorVisitUser(),
                HospitalVisitUser(),
              ]
          ),
        )
    );
  }
}
