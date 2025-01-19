import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/resources/routes_manager.dart';
import 'package:domina_app/presentation/resources/values_manager.dart';
import 'package:domina_app/presentation/senior/representative/bloc/senior_prof_bloc.dart';
import 'package:domina_app/presentation/senior/representative/widget/row_list.dart';
import 'package:domina_app/presentation/senior/representative/widget/row_list_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RepProfile extends StatelessWidget {
  const RepProfile({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //  backgroundColor: ColorManager.white,
      appBar: null,
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  ColorManager.secondaryColor10,
                  ColorManager.secondaryColor7,
                ],
              ),
            ),
            child: Padding(
              padding: EdgeInsets.only(right: AppPadding.p20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 100,
                  ),


                  Row(
                    children: [
                      CircleAvatar(
                        child: Icon(
                          Icons.person,
                          size: 50,
                          color: ColorManager.secondaryColor4,
                        ),
                        maxRadius: 40,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("الأسم : سيدرا",
                              style: Theme.of(context).textTheme.titleSmall),
                          Text("العنوان : شارع الحمرة",
                              style: Theme.of(context).textTheme.titleSmall),
                          Text("الجوال : 09635827",
                              style: Theme.of(context).textTheme.titleSmall),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      RowListInfo(
                          text1: "عالاختصاصات المرتبط بها: ", text2: "5063"),
                      Divider(),
                      RowListInfo(
                          text1: "عدد الوصفات المسموح : ", text2: "5063"),
                      Divider(),
                      RowListInfo(
                          text1: "مجموع الزيارات المطلوبة للمندوب",
                          text2: "5063"),
                      Divider(),
                      RowListInfo(
                          text1: "عدد الزيارات المتبقية لتحقيق الهدف : ",
                          text2: "5063"),
                    ],
                  ),
                  SizedBox(
                    height: 50,
                  ),
                ],
              ),
            ),
          ),
          SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.only(top: 600),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: ColorManager.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(50),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Align(
                      alignment: Alignment.center,
                      child: Icon(
                        size: 50,
                        Icons.maximize_rounded,
                        color: ColorManager.secondaryColor1,
                      )),

                  //
                  //
                  // Padding(
                  //   padding:  EdgeInsets.symmetric(horizontal: AppPadding.p14),
                  //   child: Divider(color: ColorManager.secondaryColor6,thickness: 0.8,),
                  // ),
                  Row(
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      Align(
                          alignment: Alignment.center,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Text(
                              "معلومات عامة",
                              style: Theme.of(context).textTheme.labelLarge,
                            ),
                          )),
                      Expanded(
                        child: Container(
                          height: 0.5,
                          color: ColorManager.secondaryColor1,
                        ),
                      ),
                    ],
                  ),
                  RowList(
                      function: () {
                        BlocProvider.of<SeniorProfBloc>(context).add(SenAllPlaceEvent(203));

                        Navigator.pushNamed(context, Routes.seniorPlaces);
                      },
                      icon1: FontAwesomeIcons.locationDot,
                      text: "المناطق المرتبط بها"),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: AppPadding.p14),
                    child: Divider(
                      color: ColorManager.secondaryColor6,
                      thickness: 0.8,
                    ),
                  ),
                  RowList(
                      function: () {
                        BlocProvider.of<SeniorProfBloc>(context)
                            .add(SenAllSpecEvent(203));
                        Navigator.pushNamed(context, Routes.seniorSpec);
                      },
                      icon1: FontAwesomeIcons.tag,
                      text: "الاختصاصات المرتبط بها"),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: AppPadding.p14),
                    child: Divider(
                      color: ColorManager.secondaryColor6,
                      thickness: 0.8,
                    ),
                  ),
                  RowList(
                      icon1: FontAwesomeIcons.folderOpen,
                      text: "أرشيف الأطباء والمشافي المرتبط بهم",
                  function: () {
                        BlocProvider.of<SeniorProfBloc>(context).add(SenAllHospitalEvent(203));
                        Navigator.pushNamed(context, Routes.seniorHosDoc);
                  },),
                  SizedBox(
                    height: 20,
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
                      text: "الأطباء الذين تمت زيارتهم"),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: AppPadding.p14),
                    child: Divider(
                      color: ColorManager.secondaryColor6,
                      thickness: 0.8,
                    ),
                  ),
                  RowList(
                      icon1: FontAwesomeIcons.userDoctor,
                      text: "الأطباء الذين لم تمت زيارتهم"),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: AppPadding.p14),
                    child: Divider(
                      color: ColorManager.secondaryColor6,
                      thickness: 0.8,
                    ),
                  ),
                  RowList(
                      icon1: FontAwesomeIcons.solidNoteSticky,
                      text: "قائمة بالملاحظات الخاصة للمكتب العلمي"),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: AppPadding.p14),
                    child: Divider(
                      color: ColorManager.secondaryColor6,
                      thickness: 0.8,
                    ),
                  ),
                  RowList(
                      icon1: FontAwesomeIcons.noteSticky,
                      text: "قائمة بالملاحظات الخاصة بالوكيل"),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: AppPadding.p14),
                    child: Divider(
                      color: ColorManager.secondaryColor6,
                      thickness: 0.8,
                    ),
                  ),
                  RowList(
                      icon1: FontAwesomeIcons.clipboard,
                      text: "تقرير توزيع العينات (الجرد)"),
                ],
              ),
            ),
          ),
          Positioned(
            top:40,
            right: 10,
            child: Row(
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.arrow_back_sharp,
                      size: 30,
                      color: ColorManager.white,
                    )),
                Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        "المعلومات الشخصية",
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
