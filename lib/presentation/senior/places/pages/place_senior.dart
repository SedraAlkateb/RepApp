import 'package:domina_app/presentation/drawer/pages/drawer_page.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';

class PlaceSenior extends StatelessWidget {
  const PlaceSenior({super.key});

  @override
  Widget build(BuildContext context) {
     return Scaffold(
         drawer: DrawerPage(),
       appBar: AppBar(
         leading: Builder(
           builder: (BuildContext context) {
             return IconButton(
               icon: Icon(
                 size: AppSize.s30,
                 Icons.menu,
                 color: ColorManager.secondaryColor1,
               ),
               onPressed: () {
                 Scaffold.of(context).openDrawer();
               },
             );
           },
         ),
         title: Text('تقارير المندوبين'),
       ),);
  }
}
