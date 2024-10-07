import 'package:domina_app/app/di.dart';
import 'package:domina_app/app/user_info.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/resources/routes_manager.dart';
import 'package:domina_app/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';

class DrawerPage extends StatelessWidget {
  DrawerPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  ColorManager.secondaryColor6,
                  ColorManager.secondaryColor7,
                  ColorManager.secondaryColor7,
                ]),
                color: ColorManager.white,
              ), //BoxDecoration
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppPadding.p18, vertical: AppPadding.p5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CircleAvatar(
                      maxRadius: 35,
                      backgroundColor: ColorManager.secondaryColor5,
                      child: Text(
                        "L",
                        style: TextStyle(fontSize: 30.0, color: Colors.blue),
                      ), //Text
                    ),
                    Text(
                      " Lina Mahayni ",
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              )),
          ListTile(
            leading: Icon(Icons.location_city_outlined,
                color: ColorManager.secondaryColor4),
            title: const Text('إِجراء زيارة'),
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
            leading: Icon(Icons.local_pharmacy_outlined,
                color: ColorManager.secondaryColor4),
            title: const Text('الزيارات'),
            onTap: () {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  Routes.visits,
                  (route) => true,
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
            leading: Icon(Icons.medical_services_outlined,
                color: ColorManager.secondaryColor4),
            title: const Text('الاختصاصات'),
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
            leading:
                Icon(Icons.group_outlined, color: ColorManager.secondaryColor4),
            title: const Text('الأطباء '),
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
            leading: Icon(Icons.local_hospital_outlined,
                color: ColorManager.secondaryColor4),
            title: const Text('المشافي '),
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
          ListTile(
            leading: Icon(Icons.local_pharmacy_outlined,
                color: ColorManager.secondaryColor4),
            title: const Text('الصيدليات'),
            onTap: () {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  Routes.pharmacy,
                  (route) => true,
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
            leading: Icon(Icons.medication_outlined,
                color: ColorManager.secondaryColor4),
            title: const Text('الأصناف'),
            onTap: () {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  Routes.brand,
                  (route) => true,
                );
              });
            },
          ),
                Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Divider(thickness:0.5,color:ColorManager.secondaryColor ,),
        ),    ListTile(
             leading:  Icon(Icons.list_alt_outlined ,color: ColorManager.secondaryColor4),
            title:  Text('لائحة العينات',style: TextStyle(color: ColorManager.secondaryColor1),),
            onTap: () {
             WidgetsBinding.instance.addPostFrameCallback((_) {
                Navigator.pushNamed(
                  context,
                  Routes.Listbrand,
                );

              });
            },
          ),
           Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Divider(thickness:0.5,color:ColorManager.secondaryColor ,),
        ),  
          ListTile(
            leading:
                Icon(Icons.sync_outlined, color: ColorManager.secondaryColor4),
            title: Text(
              'المزامنة',
              style: TextStyle(color: ColorManager.secondaryColor1),
            ),
            onTap: () {
              initAsyncInModule();
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Navigator.pushNamed(
                  context,
                  UserInfo.isLogging == 2
                      ? Routes.asyncIn
                      : UserInfo.isLogging == 3
                          ? Routes.delete
                          : Routes.syncData,
                );
              });
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Divider(
              thickness: 0.5,
              color: ColorManager.secondaryColor,
            ),
          ),
          ListTile(
            leading: Icon(Icons.logout_outlined,
                color: ColorManager.secondaryColor4),
            title: Text(
              'تسجيل خروج',
              style: TextStyle(color: ColorManager.secondaryColor1),
            ),
            onTap: () {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Navigator.pushNamed(
                  context,
                  UserInfo.isLogging==3?Routes.deleteLogout:
                  Routes.logout,
                );
              });
            },
          ),
        ],
      ),
    );
  }
}
