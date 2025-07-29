import 'package:domina_app/app/di.dart';
import 'package:domina_app/app/user_info.dart';
import 'package:domina_app/presentation/drawer/widget/text_drawer.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/resources/routes_manager.dart';
import 'package:domina_app/presentation/visits/bloc/visit_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DrawerPage extends StatelessWidget {
  DrawerPage({super.key});
  @override
  Widget build(BuildContext context) {

    return Drawer(
      shape: Border.all(color: ColorManager.secondaryColor4),
      child: ListView(
        padding: EdgeInsets.only(top: 0),
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  ColorManager.secondaryColor6,
                  ColorManager.secondaryColor7,
                  ColorManager.secondaryColor7,
                ],
              ),
              color: ColorManager.white,
            ),
            height: 150,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CircleAvatar(
                    maxRadius: 35,
                    backgroundColor: ColorManager.secondaryColor5,
                    child: Text(
                      UserInfo.name![0],
                      style: TextStyle(fontSize: 30.0, color: Colors.blue),
                    ),
                  ),
                  SizedBox(width: 10),
                  Text(
                    UserInfo.name ?? "",
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextDrawer(
                  s1: "زيارات المشافي : ",
                  s2: "${UserInfo.numOfHospitalVisit.toString()}",
                ),
                TextDrawer(
                  s1: "زيارات الأطباء : ",
                  s2: "${UserInfo.numOfDoctorVisit.toString()}",
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Divider(
              thickness: 0.5,
              color: ColorManager.hintGrey,
            ),
          ),
          ListTile(
            focusColor: ColorManager.secondaryColor,
            minTileHeight: 10,
            leading: Icon(Icons.location_city_outlined,
                color: ColorManager.secondaryColor4),
            title: Text(
              'إجراء زيارة',
              style: TextStyle(color: ColorManager.secondaryColor1),
            ),
            onTap: () {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  Routes.places,
                  (route) => false,
                );
              });
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Divider(
              thickness: 0.5,
              color: ColorManager.hintGrey,
            ),
          ),

          ListTile(
            focusColor: ColorManager.secondaryColor,
            minTileHeight: 10,
            leading: Icon(Icons.location_history_outlined,
                color: ColorManager.secondaryColor4),
            title: Text(
              'الزيارات',
              style: TextStyle(color: ColorManager.secondaryColor1),
            ),
            onTap: () {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  Routes.visits,
                  (route) => true,
                );
                BlocProvider.of<VisitBloc>(context).add(VisitDoctorEvent());
              });
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Divider(
              thickness: 0.5,
              color: ColorManager.hintGrey,
            ),
          ),
          ListTile(
            focusColor: ColorManager.secondaryColor,
            minTileHeight: 10,
            leading:
            Icon(Icons.search_rounded, color: ColorManager.secondaryColor4),
            title: Text(
              'البحث عن طبيب',
              style: TextStyle(color: ColorManager.secondaryColor1),
            ),
            onTap: () {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  Routes.searchdoctors,
                      (route) => false,
                );
              }
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Divider(
              thickness: 0.5,
              color: ColorManager.hintGrey,
            ),
          ),
          ListTile(
            focusColor: ColorManager.secondaryColor,
            minTileHeight: 10,
            leading:
            Icon(Icons.search_rounded, color: ColorManager.secondaryColor4),
            title: Text(
              'عرض الوصفات',
              style: TextStyle(color: ColorManager.secondaryColor1),
            ),
            onTap: () {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  Routes.allRecip,
                      (route) => false,
                );
              }
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Divider(
              thickness: 0.5,
              color: ColorManager.hintGrey,
            ),
          ),
          (UserInfo.repType != "7")
              ? ListTile(
                  focusColor: ColorManager.secondaryColor,
                  minTileHeight: 10,
                  leading: Icon(Icons.list_alt_outlined,
                      color: ColorManager.secondaryColor4),
                  title: Text(
                    'تقارير المندوبين',
                    style: TextStyle(color: ColorManager.secondaryColor1),
                  ),
                  onTap: () {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        Routes.cities,
                        (route) => false,
                      );
                    });
                  },
                )
              : SizedBox(),
          (UserInfo.repType != "7")
              ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Divider(
                    thickness: 0.5,
                    color: ColorManager.hintGrey,
                  ),
                )
              : SizedBox(),
          ListTile(
            focusColor: ColorManager.secondaryColor,
            minTileHeight: 10,
            leading: Icon(Icons.medical_services_outlined,
                color: ColorManager.secondaryColor4),
            title: Text(
              'الإختصاصات',
              style: TextStyle(color: ColorManager.secondaryColor1),
            ),
            onTap: () {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  Routes.spec,
                  (route) => false,
                );
              });
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Divider(
              thickness: 0.5,
              color: ColorManager.hintGrey,
            ),
          ),
          ListTile(
            focusColor: ColorManager.secondaryColor,
            minTileHeight: 10,
            leading:
                Icon(Icons.group_outlined, color: ColorManager.secondaryColor4),
            title: Text(
              'الأطباء ',
              style: TextStyle(color: ColorManager.secondaryColor1),
            ),
            onTap: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                Routes.doctors,
                (route) => false,
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Divider(
              thickness: 0.5,
              color: ColorManager.hintGrey,
            ),
          ),
          ListTile(
            focusColor: ColorManager.secondaryColor,
            minTileHeight: 10,
            leading: Icon(Icons.local_hospital_outlined,
                color: ColorManager.secondaryColor4),
            title: Text(
              'المشافي ',
              style: TextStyle(color: ColorManager.secondaryColor1),
            ),
            onTap: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                Routes.hospital,
                (route) => false,
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Divider(
              thickness: 0.5,
              color: ColorManager.hintGrey,
            ),
          ),
          // ListTile(
          //   focusColor: ColorManager.secondaryColor,
          //   minTileHeight: 10,
          //   leading: Icon(Icons.local_pharmacy_outlined,
          //       color: ColorManager.secondaryColor4),
          //   title: const Text('الصيدليات'),
          //   onTap: () {
          //     WidgetsBinding.instance.addPostFrameCallback((_) {
          //       Navigator.pushNamedAndRemoveUntil(
          //         context,
          //         Routes.pharmacy,
          //         (route) => true,
          //       );
          //     });
          //   },
          // ),
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 10),
          //   child: Divider(
          //     thickness: 0.5,
          //     color: ColorManager.hintGrey,
          //   ),
          // ),
          ListTile(
            focusColor: ColorManager.secondaryColor,
            minTileHeight: 10,
            leading: Icon(Icons.medication_outlined,
                color: ColorManager.secondaryColor4),
            title: Text(
              'الأصناف',
              style: TextStyle(color: ColorManager.secondaryColor1),
            ),
            onTap: () {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  Routes.brand,
                  (route) => false,
                );
              });
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Divider(thickness: 0.5, color: ColorManager.hintGrey),
          ),
          ListTile(
            focusColor: ColorManager.secondaryColor,
            minTileHeight: 10,
            leading: Icon(Icons.list_alt_outlined,
                color: ColorManager.secondaryColor4),
            title: Text('الخطط',
                style: TextStyle(color: ColorManager.secondaryColor1)),
            onTap: () {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Navigator.pushNamed(
                  context,
                  Routes.brandPlan,
                );
              });
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Divider(
              thickness: 0.5,
              color: ColorManager.hintGrey,
            ),
          ),
          ListTile(
            focusColor: ColorManager.secondaryColor,
            minTileHeight: 10,
            leading: Icon(Icons.wifi_protected_setup_outlined,
                color: ColorManager.secondaryColor4),
            title: Text(
              'المزامنة',
              style: TextStyle(color: ColorManager.secondaryColor1),
            ),
            onTap: () {
              initAsyncInModule();
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Navigator.pushNamed(
                  context,
                  Routes.asyncIn,
                );
              });
            },
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Divider(
              thickness: 0.5,
              color: ColorManager.hintGrey,
            ),
          ),
          ListTile(
            focusColor: ColorManager.secondaryColor,
            minTileHeight: 10,
            leading: Icon(Icons.logout_outlined,
                color: ColorManager.secondaryColor4),
            title: Text(
              'تسجيل خروج',
              style: TextStyle(color: ColorManager.secondaryColor1),
            ),
            onTap: () {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Navigator.pushNamed(context, Routes.logout);
              });
            },
          ),
          SizedBox(
            height: 35,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              textAlign: TextAlign.left,
              'Version 4',
              style: TextStyle(
                color: ColorManager.secondaryColor7,
                shadows: [
                  Shadow(
                    offset: Offset(1.0, 1.5),
                    blurRadius: 1.0,
                    color: ColorManager.secondaryColor.withOpacity(0.5),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
