import 'package:domina_app/app/di.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/resources/routes_manager.dart';
import 'package:domina_app/presentation/visits/bloc/visit_bloc.dart';
import 'package:domina_app/presentation/visits/widget/Doctor_visit_usert.dart';
import 'package:domina_app/presentation/visits/widget/hospital_visit_user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VisitsPage extends StatelessWidget {
  const VisitsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: ColorManager.secondaryColor7,
          bottom: TabBar(
            labelPadding: EdgeInsets.all(0.9),
            onTap: (value) {
              if (value == 0) {
                BlocProvider.of<VisitBloc>(context).add(VisitDoctorEvent());
              } else {
                BlocProvider.of<VisitBloc>(context).add(VisitHospitalEvent());
              }
            },
            tabs: [
              Tab(
                icon: context.watch<VisitBloc>().current == 0
                    ? Icon(Icons.groups, color: ColorManager.secondaryColor1)
                    : Icon(Icons.groups),
                text: 'الأطباء',
              ),
              Tab(
                icon: context.watch<VisitBloc>().current == 1
                    ? Icon(Icons.local_hospital, color: ColorManager.secondaryColor1)
                    : Icon(Icons.local_hospital),
                text: 'المشافي',
              ),
            ],
          ),
        ),
        body: Stack(
          children: [
            TabBarView(
              physics: NeverScrollableScrollPhysics(),
              children: [
                DoctorVisitUser(),
                HospitalVisitUser(),
              ],
            ),
            Positioned(
              bottom: 30,
              left: 30,
              child: FloatingActionButton(
                onPressed: () {
                  initAsyncInModule();
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    Navigator.pushNamed(
                        context,
                        Routes .asyncIn
                    );
                  });
                },
                backgroundColor: ColorManager.secondaryColor1,
                child: Icon(
                  Icons.sync_outlined,
                  color: ColorManager.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
