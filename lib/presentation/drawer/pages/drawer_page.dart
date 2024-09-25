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
        padding: EdgeInsets.zero,
        children: [
           DrawerHeader(
            
            decoration: BoxDecoration(
              gradient:  LinearGradient(colors: [
                                  ColorManager.secondaryColor6,
                                  ColorManager.secondaryColor7,
                                  ColorManager.secondaryColor7,
                                ]),
              color: ColorManager.white,
            ), //BoxDecoration
            child:Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppPadding.p18,vertical: AppPadding.p5),
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
            )  ),

          ListTile(
   leading:Icon(Icons.location_city_outlined,color: ColorManager.secondaryColor4),
            title: const Text('المناطق '),
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
          ListTile(
            leading:  Icon(Icons.local_pharmacy_outlined,color: ColorManager.secondaryColor4),
            title: const Text('الزيارات'),
            onTap: () {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  Routes.visits,(route) => true,
                );

              });

            },
          ),
           ListTile(
             leading:  Icon(Icons.sync_outlined  ,color: ColorManager.secondaryColor4),
            title: const Text('المزامنة'),
            onTap: () {
             WidgetsBinding.instance.addPostFrameCallback((_) {
                Navigator.pushNamed(
                  context,
                  Routes.syncData,
                );

              });
            },
          ),
         
        ],
      ),
    );
  }
}
