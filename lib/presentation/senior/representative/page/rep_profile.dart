import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/resources/values_manager.dart';
import 'package:domina_app/presentation/senior/representative/widget/row_list.dart';
import 'package:domina_app/presentation/senior/representative/widget/row_list_info.dart';
import 'package:domina_app/presentation/senior/representative/widget/text_prof.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RepProfile extends StatelessWidget {
  const RepProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //  backgroundColor: ColorManager.white,
      appBar: null,
      body:   SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,

              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    ColorManager.secondaryColor6,
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
                      height: 50,
                    ),
                    IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.arrow_back_sharp,
                          size: 30,
                          color: ColorManager.white,
                        )),
                    SizedBox(
                      height: 30,
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
                        ) ,
                        SizedBox(width: 20,),
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
                    SizedBox(height: 50,),

                  ],
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: ColorManager.white,
                borderRadius: BorderRadius.vertical(
                  //   top: Radius.circular(80),
                ),
              ),

              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      SizedBox(width:10 ,),
                      Align(
                          alignment: Alignment.center,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Text("المعلومات الشخصية",style: Theme.of(context).textTheme.labelLarge,),
                          )

                      ),
                      Expanded(
                        child: Container(
                          height: 0.5,
                          color: ColorManager.secondaryColor1,
                        ),
                      ),
                    ],
                  ),
                  RowListInfo(text1: "عدد العينات المتبقي : ", text2: "5063"),
                  Padding(
                    padding:  EdgeInsets.symmetric(horizontal: AppPadding.p14),
                    child: Divider(color: ColorManager.secondaryColor6,thickness: 0.8,),
                  ),
                  RowListInfo(text1: "عدد العينات المتبقي : ", text2: "5063"),
                  Padding(
                    padding:  EdgeInsets.symmetric(horizontal: AppPadding.p14),
                    child: Divider(color: ColorManager.secondaryColor6,thickness: 0.8,),
                  ),
                  RowListInfo(text1: "عدد العينات المتبقي : ", text2: "5063"),
                  Padding(
                    padding:  EdgeInsets.symmetric(horizontal: AppPadding.p14),
                    child: Divider(color: ColorManager.secondaryColor6,thickness: 0.8,),
                  ),
                  RowListInfo(text1: "عدد العينات المتبقي : ", text2: "5063"),
                  Padding(
                    padding:  EdgeInsets.symmetric(horizontal: AppPadding.p14),
                    child: Divider(color: ColorManager.secondaryColor6,thickness: 0.8,),
                  ),
                  Row(
                    children: [
                      SizedBox(width:10 ,),
                      Align(
                          alignment: Alignment.center,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Text("معلومات عامة",style: Theme.of(context).textTheme.labelLarge,),
                          )

                      ),
                      Expanded(
                        child: Container(
                          height: 0.5,
                          color: ColorManager.secondaryColor1,
                        ),
                      ),
                    ],
                  ),
                  RowList(icon1:  FontAwesomeIcons.locationDot,text: "المناطق المرتبط بها"),
                  Padding(
                    padding:  EdgeInsets.symmetric(horizontal: AppPadding.p14),
                    child: Divider(color: ColorManager.secondaryColor6,thickness: 0.8,),
                  ),
                  RowList(icon1:  FontAwesomeIcons.tag,text: "الاختصاصات المرتبط بها"),
                  Padding(
                    padding:  EdgeInsets.symmetric(horizontal: AppPadding.p14),
                    child: Divider(color: ColorManager.secondaryColor6,thickness: 0.8,),
                  ),
                  RowList(icon1:  FontAwesomeIcons.folderOpen,text: "أرشيف الأطباء والمشافي المرتبط بهم"),
                  SizedBox(height: 20,),

                  Row(
                    children: [

                      Align(
                          alignment: Alignment.center,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text("تفاصيل الخط الفعالة",style: Theme.of(context).textTheme.labelLarge,),
                          )

                      ),
                      SizedBox(width: 10,),
                      Expanded(
                        child: Container(
                          height: 0.5,
                          color: ColorManager.secondaryColor1,
                        ),
                      ),
                    ],
                  ),
                  RowList(icon1:  FontAwesomeIcons.userDoctor,text: "الأطباء الذين تمت زيارتهم"),

                  Padding(
                    padding:  EdgeInsets.symmetric(horizontal: AppPadding.p14),
                    child: Divider(color: ColorManager.secondaryColor6,thickness: 0.8,),
                  ),
                  RowList(icon1:  FontAwesomeIcons.userDoctor,text: "الأطباء الذين لم تمت زيارتهم"),
                  Padding(
                    padding:  EdgeInsets.symmetric(horizontal: AppPadding.p14),
                    child: Divider(color: ColorManager.secondaryColor6,thickness: 0.8,),
                  ),
                  RowList(icon1:  FontAwesomeIcons.solidNoteSticky,text: "قائمة بالملاحظات الخاصة للمكتب العلمي"),

                  Padding(
                    padding:  EdgeInsets.symmetric(horizontal: AppPadding.p14),
                    child: Divider(color: ColorManager.secondaryColor6,thickness: 0.8,),
                  ),
                  RowList(icon1:  FontAwesomeIcons.noteSticky,text: "قائمة بالملاحظات الخاصة بالوكيل"),

                  Padding(
                    padding:  EdgeInsets.symmetric(horizontal: AppPadding.p14),
                    child: Divider(color: ColorManager.secondaryColor6,thickness: 0.8,),
                  ),
                  RowList(icon1:  FontAwesomeIcons.clipboard,text: "تقرير توزيع العينات (الجرد)"),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
