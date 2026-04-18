import 'package:domina_app/app/di.dart';
import 'package:domina_app/app/user_info.dart';
import 'package:domina_app/domain/models/models.dart';

import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/senior/report_visit_doctor/bloc/report_visit_doctor_bloc.dart';
import 'package:domina_app/presentation/senior/report_visit_doctor/page/report_visit_doctor.dart';
import 'package:domina_app/presentation/senior/report_visit_doctor/page/report_visit_hospital.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DoctorsHospitalsReports extends StatefulWidget {
  const DoctorsHospitalsReports(
      {super.key,
      required this.repId,
      required this.senId,
      required this.indexRep,
      required this.repName});
  final int repId;
  final int senId;
  final int indexRep;
  final String repName;

  @override
  State<DoctorsHospitalsReports> createState() =>
      _DoctorsHospitalsReportsState();
}

class _DoctorsHospitalsReportsState extends State<DoctorsHospitalsReports> {
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    initReportVisitDoctorModule();
    BlocProvider.of<ReportVisitDoctorBloc>(context)
        .add(AllReportVisitDoctorEvent(VisitRepSen(widget.repId, widget.senId,

            //  UserInfo.repId
            ),true));

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          // flexibleSpace: CustomWaveAppBar(
          //   text: widget.repName,
          //   onPressed: () {},
          // ),
          title: Text(widget.repName),
          backgroundColor: Colors.white,
          bottom: TabBar(
            dividerColor: ColorManager.secondaryColor1,
            labelColor: ColorManager.secondaryColor1,
            labelPadding: const EdgeInsets.all(0.9),
            onTap: (value) {
              if (value == 0) {
                BlocProvider.of<ReportVisitDoctorBloc>(context).add(
                    AllReportVisitDoctorEvent(
                        VisitRepSen(widget.repId, widget.senId
                            //   UserInfo.repId
                            ),true));
              } else {
                BlocProvider.of<ReportVisitDoctorBloc>(context).add(
                    AllReportVisitHospitalEvent(
                        VisitRepSen(widget.repId, widget.senId
                            //  UserInfo.repId
                            ),true));
              }
            },
            tabs: const [
              Tab(
                // icon: context.watch<EditBrandPlanBloc>().current == 0
                //     ? Icon(Icons.groups, color: ColorManager.secondaryColor1)
                //     : const Icon(Icons.groups),
                text: 'الأطباء',
              ),
              Tab(
                // icon: context.watch<EditBrandPlanBloc>().current == 1
                //     ? Icon(Icons.local_hospital,
                //         color: ColorManager.secondaryColor1)
                //     : const Icon(Icons.local_hospital),
                text: 'المشافي',
              ),
            ],
          ),
        ),
        body: Stack(
          children: [
            TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              children: [
                ReportVisitDoctorPage(
                  userId: UserInfo.repId,
                  repId: widget.repId,
                  repName: widget.repName,
                  indexRep: widget.indexRep,
                  repPlan: 0,
                  iscanedite: false,
                ),

                ReportVisitHospital(
                  userId: UserInfo.repId,
                  repId: widget.repId,
                  indexRep: widget.indexRep,
                  repName: widget.repName,
                  repPlan: 0,
                  iscanedite: false,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
