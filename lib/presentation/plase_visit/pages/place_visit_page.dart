import 'package:domina_app/presentation/plase_visit/bloc/visit_place_bloc.dart';
import 'package:domina_app/presentation/plase_visit/widget/doctor_visit.dart';
import 'package:domina_app/presentation/plase_visit/widget/hospital_visit.dart';
import 'package:domina_app/presentation/plase_visit/widget/pharmacy_visit.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PlaceVisitPage extends StatelessWidget {
  const PlaceVisitPage({super.key, required this.placeId});
  final int placeId;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: ColorManager.secondaryColor7,
            bottom: TabBar(
                labelPadding: EdgeInsets.all(0.9),
                onTap: (value) {
                  if (value == 0) {
                    BlocProvider.of<VisitPlaceBloc>(context)
                        .add(PharmacyByPlace(placeId, value));
                    BlocProvider.of<VisitPlaceBloc>(context)
                        .add(BrandAnyFlagEvent());
                  } else if (value == 1) {
                    BlocProvider.of<VisitPlaceBloc>(context)
                        .add(DoctorByPlace(placeId, value));
                    BlocProvider.of<VisitPlaceBloc>(context)
                        .add(BrandFlagEvent());
                  } else {
                    BlocProvider.of<VisitPlaceBloc>(context)
                        .add(HospitalByPlace(placeId, value));
                    BlocProvider.of<VisitPlaceBloc>(context)
                        .add(BrandFlagEvent());
                  }
                },
                tabs: [
                  Tab(
                    icon: context.watch<VisitPlaceBloc>().current == 0
                        ? Icon(Icons.local_pharmacy_sharp,
                            color: ColorManager.secondaryColor1)
                        : Icon(Icons.local_pharmacy_sharp),
                    text: 'الصيدليات',
                  ),
                  Tab(
                    icon: context.watch<VisitPlaceBloc>().current == 1
                        ? Icon(
                            Icons.groups,
                            color: ColorManager.secondaryColor1,
                          )
                        : Icon(Icons.groups),
                    text: 'الأطباء',
                  ),
                  Tab(
                    icon: context.watch<VisitPlaceBloc>().current == 2
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
            PharmacyVisit(),
            DoctorVisit(),
            HospitalVisit(),
          ]),
        ));
  }
}
