import 'package:domina_app/app/di.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/resources/routes_manager.dart';
import 'package:domina_app/presentation/resources/values_manager.dart';
import 'package:domina_app/presentation/senior/report_Inventory/bloc/report_inventory_bloc.dart';
import 'package:domina_app/presentation/senior/report_Inventory/page/report_inventory.dart';
import 'package:domina_app/presentation/senior/report_issue_note/bloc/report_issue_bloc.dart';
import 'package:domina_app/presentation/senior/report_issue_note/page/note_issue_doctor.dart';
import 'package:domina_app/presentation/senior/report_sience_note/bloc/report_science_bloc.dart';
import 'package:domina_app/presentation/senior/report_sience_note/page/note_science_doctor.dart';
import 'package:domina_app/presentation/senior/representative/bloc/senior_prof_bloc.dart';
import 'package:domina_app/presentation/senior/representative/widget/row_list.dart';
import 'package:domina_app/presentation/senior/representative/widget/row_list_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RepProfile extends StatelessWidget {
  final int id;
  const RepProfile({super.key, required this.id});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.secondaryColor9,
      appBar: AppBar(
        shadowColor: null,
        title: Text("معلومات شخصية"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
                decoration: BoxDecoration(
                  color: ColorManager.white,
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(40),
                  ),
                ),
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(40),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        ColorManager.secondaryColor4,
                        ColorManager.secondaryColor6,
                      ],
                    ),
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(20),
                      top: Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "الإسم : سيدرا",
                        style: Theme.of(context).textTheme.labelMedium,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "العنوان : شارع الحمرة",
                        style: Theme.of(context).textTheme.labelMedium,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "الجوال : 09635827",
                        style: Theme.of(context).textTheme.labelMedium,
                        textAlign: TextAlign.center,
                      ),
                      RowListInfo(text1: "عدد الوصفات  :", text2: "66"),
                      RowListInfo(
                          text1: "الاختصاصات المرتبط بها :", text2: "588"),
                      RowListInfo(
                          text1: "عدد الزيارات المتبقية لتحقيق الهدف :",
                          text2: "3566"),
                    ],
                  ),
                )),
            SizedBox(
              height: 20,
            ),
            Container(
              margin: EdgeInsets.all(15),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: ColorManager.white,
                borderRadius: BorderRadius.vertical(
                    top: Radius.circular(20), bottom: Radius.circular(20)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        InkWell(
                          onTap: () {
                            BlocProvider.of<SeniorProfBloc>(context)
                                .add(SenAllSpecEvent(id));
                            Navigator.pushNamed(context, Routes.seniorSpec);
                          },
                          child: CircleAvatar(
                            maxRadius: 25,
                            backgroundColor: ColorManager.secondaryColor11,
                            child: Icon(
                              FontAwesomeIcons.tag,
                              color: ColorManager.secondaryColor2,
                            ),
                          ),
                        ),
                        Text("الإختصاص")
                      ],
                    ),
                    Column(
                      children: [
                        InkWell(
                          onTap: () {
                            BlocProvider.of<SeniorProfBloc>(context)
                                .add(SenAllPlaceEvent(id));

                            Navigator.pushNamed(context, Routes.seniorPlaces);
                          },
                          child: CircleAvatar(
                            maxRadius: 25,
                            backgroundColor: ColorManager.secondaryColor13,
                            child: Icon(
                              FontAwesomeIcons.locationDot,
                              color: ColorManager.secondaryColor4,
                            ),
                          ),
                        ),
                        Text("المناطق")
                      ],
                    ),
                    Column(
                      children: [
                        InkWell(
                          child: CircleAvatar(
                            maxRadius: 25,
                            backgroundColor: ColorManager.secondaryColor16,
                            child: Icon(FontAwesomeIcons.userDoctor,
                                color: ColorManager.secondaryColor14),
                          ),
                          onTap: () {
                            BlocProvider.of<SeniorProfBloc>(context)
                                .add(SenAllDoctorEvent(id));
                            Navigator.pushNamed(context, Routes.seniorDoc);
                          },
                        ),
                        Text("الأطباء"),
                      ],
                    ),
                    Column(
                      children: [
                        InkWell(
                          onTap: () {
                            BlocProvider.of<SeniorProfBloc>(context)
                                .add(SenAllHospitalEvent(id));
                            Navigator.pushNamed(context, Routes.seniorHos);
                          },
                          child: CircleAvatar(
                            maxRadius: 25,
                            backgroundColor: ColorManager.secondaryColor17,
                            child: Icon(FontAwesomeIcons.hospital,
                                color: ColorManager.secondaryColor15),
                          ),
                        ),
                        Text("المشافي")
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              padding: EdgeInsets.all(20),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: ColorManager.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(40),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 40,
                  ),
                  Row(
                    children: [
                      Align(
                          alignment: Alignment.center,
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              "تفاصيل الخط الفعالة",
                              style: Theme.of(context).textTheme.labelLarge,
                            ),
                          )),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Container(
                          height: 0.5,
                          color: ColorManager.secondaryColor1,
                        ),
                      ),
                    ],
                  ),
                  RowList(
                    icon1: FontAwesomeIcons.userDoctor,
                    text: "الأطباء الذين تمت زيارتهم",
                    function: () {
                      BlocProvider.of<SeniorProfBloc>(context)
                          .add(VisitDocEvent(id));
                      Navigator.pushNamed(context, Routes.senVisitDoctor);
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: AppPadding.p14),
                    child: Divider(
                      color: ColorManager.secondaryColor6,
                      thickness: 0.8,
                    ),
                  ),
                  RowList(
                    icon1: FontAwesomeIcons.userDoctor,
                    text: "الأطباء الذين لم تمت زيارتهم",
                    function: () {
                      BlocProvider.of<SeniorProfBloc>(context)
                          .add(NoVisitDocEvent(id));
                      Navigator.pushNamed(context, Routes.noVisitDoctor);
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: AppPadding.p14),
                    child: Divider(
                      color: ColorManager.secondaryColor6,
                      thickness: 0.8,
                    ),
                  ),
                  RowList(
                    icon1: FontAwesomeIcons.solidNoteSticky,
                    text: "قائمة بالملاحظات الخاصة للمكتب العلمي",
                    function: () {

                      initSeniorReportScienceModule();
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          BlocProvider.of<ReportScienceBloc>(context)
                              .add(SenAllNoteDoctorEvent(id));
                          return NoteScienceDoctor(id: id);
                        },
                      ));
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: AppPadding.p14),
                    child: Divider(
                      color: ColorManager.secondaryColor6,
                      thickness: 0.8,
                    ),
                  ),
                  RowList(
                      icon1: FontAwesomeIcons.noteSticky,
                      text: "قائمة بالملاحظات الخاصة بالوكيل",
                    function: () {

                      initSeniorReportIssueModule();
                      BlocProvider.of<ReportIssueBloc>(context)
                          .add(SenAllIssueDoctorEvent(id));
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {

                          return NoteIssueDoctor(id: id);
                        },
                      ));
                    },



                  ),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: AppPadding.p14),
                    child: Divider(
                      color: ColorManager.secondaryColor6,
                      thickness: 0.8,
                    ),
                  ),
                  RowList(function: () {

                    initSeniorReportInventoryModule();
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        BlocProvider.of<ReportInventoryBloc>(context)
                            .add(SenAllInventoryEvent(id));
                        return ReportInventory();
                      },
                    ));
                  },
                      icon1: FontAwesomeIcons.clipboard,
                      text: "تقرير توزيع العينات (الجرد)"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
