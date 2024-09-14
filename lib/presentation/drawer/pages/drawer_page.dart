import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/resources/routes_manager.dart';
import 'package:flutter/material.dart';
class DrawerPage extends StatelessWidget {
   DrawerPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: const EdgeInsets.all(0),
        children: [
           DrawerHeader(
            decoration: BoxDecoration(
              color: ColorManager.secondaryColor,
            ), //BoxDecoration
            child: UserAccountsDrawerHeader(
              decoration:
              BoxDecoration(color: ColorManager.secondaryColor),
              accountName: Text(
                "Lina Al-Mahayni",
                style: TextStyle(fontSize: 18),
              ),

              currentAccountPictureSize: Size.square(50),
              currentAccountPicture: CircleAvatar(
                backgroundColor: ColorManager.secondaryColor,
                child: Text(
                  "L",
                  style: TextStyle(fontSize: 30.0, color: Colors.blue),
                ), //Text
              ),
              accountEmail: null,
              //circleAvatar
            ), //UserAccountDrawerHeader
          ),

          ListTile(
   leading:Icon(Icons.location_city_outlined,color: ColorManager.secondaryColor4),
            title: const Text('الأماكن '),
            onTap: () {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Navigator.pushNamedAndRemoveUntil(
                    context, Routes.places,
                  (route) => false,
                );

              });
            },
          ),
          ListTile(
             leading:  Icon(Icons.medical_services_outlined  ,color: ColorManager.secondaryColor4),
            title: const Text('الاختصاصات'),
            onTap: () {
             WidgetsBinding.instance.addPostFrameCallback((_) {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  Routes.spec,(route) => false,
                );

              });
            },
          ),
          ListTile(
            leading:  Icon(Icons.group_outlined ,color: ColorManager.secondaryColor4),
            title: const Text('الأطباء '),
            onTap: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                Routes.doctors,(route) => false,
              );
              
            },
          ),
            ListTile(
               leading:  Icon(Icons.local_hospital_outlined
,color: ColorManager.secondaryColor4),

            title: const Text('المشافي '),
            onTap: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                Routes.hospital,(route) => false,
              );
                         
            },
          ),
          ListTile(
            leading:  Icon(Icons. medication_outlined,color: ColorManager.secondaryColor4),
            title: const Text('الأصناف'),
            onTap: () {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  Routes.brand,(route) => true,
                );

              });


            },
          ),
          ListTile(
            leading:  Icon(Icons.local_pharmacy_outlined,color: ColorManager.secondaryColor4),
            title: const Text('الصيدليات'),
            onTap: () {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  Routes.pharmacy,(route) => true,
                );

              });

            },
          ),

        ],
      ),
    );
  }
}
