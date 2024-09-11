import 'package:domina_app/presentation/plase_visit/bloc/place_visit_bloc.dart';
import 'package:domina_app/presentation/plase_visit/widget/doctor_visit.dart';
import 'package:domina_app/presentation/plase_visit/widget/hospital_visit.dart';
import 'package:domina_app/presentation/plase_visit/widget/pharmacy_visit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class PlaceVisitPage extends StatelessWidget {
  const PlaceVisitPage({super.key,required this.placeId});
 final int placeId;
  @override
  Widget build(BuildContext context) {

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
        bottom:
        TabBar(
            onTap: (value) {
              print(value);
              if(value==0){
                BlocProvider.of<PlaceVisitBloc>(context).add(PharmacyByPlace(placeId));
              }else if(value==1){
                BlocProvider.of<PlaceVisitBloc>(context).add(DoctorByPlace(placeId));
              }else{
                BlocProvider.of<PlaceVisitBloc>(context).add(HospitalByPlace(placeId));
              }
            },
            tabs: [
              Tab(icon: Icon(Icons.local_pharmacy_sharp),text: 'Pharmacy',),
              Tab(icon: Icon(Icons.groups),text: 'Doctors',),
              Tab(icon: Icon(Icons.local_hospital),text: 'Hospitals',),
            ]
        ),
      ),
        body: TabBarView(
            children: [
          PharmacyVisit(),
          DoctorVisit(),
          HospitalVisit(),
        ]
        ),
    )
    );
  }
}
