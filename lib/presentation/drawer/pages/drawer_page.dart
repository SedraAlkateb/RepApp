import 'package:domina_app/app/di.dart';
import 'package:domina_app/app/user_info.dart';
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
              padding: const EdgeInsets.all(20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CircleAvatar(
                    maxRadius: 35,
                    backgroundColor: ColorManager.secondaryColor5,
                    child: Text(
    UserInfo.name??"",
                      style: TextStyle(fontSize: 30.0, color: Colors.blue),
                    ),
                  ),
                  SizedBox(width: 10), // إضافة مسافة بين الصورة والنص
                  Text(




                    UserInfo.name??"",
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
            ),
          ),

          ListTile(
            focusColor: ColorManager.secondaryColor,
            minTileHeight: 10,
            leading: Icon(Icons.location_city_outlined,
                color: ColorManager.secondaryColor4),
            title: const Text('إجراء زيارة'),
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
            title: const Text('الزيارات'),
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
            focusColor: ColorManager.secondaryColor,
            minTileHeight: 10,
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
            focusColor: ColorManager.secondaryColor,
            minTileHeight: 10,
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
        ),
          ListTile(
            focusColor: ColorManager.secondaryColor,
            minTileHeight: 10,
             leading:  Icon(Icons.list_alt_outlined ,color: ColorManager.secondaryColor4),
            title:  Text('الخطط',style: TextStyle(color: ColorManager.secondaryColor1),),
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
          child: Divider(thickness:0.5,color:ColorManager.secondaryColor ,),
        ),  
          ListTile(
            focusColor: ColorManager.secondaryColor,
            minTileHeight: 10,
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
                    Routes.asyncIn
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
