import 'package:domina_app/presentation/drawer/pages/drawer_page.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
//import 'package:domina_app/presentation/uniti/custom_dropdown.dart';
import 'package:flutter/material.dart';

class AllRepSenior extends StatelessWidget {
  const AllRepSenior({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        // decoration: BoxDecoration(
        //   gradient: LinearGradient(
        //     colors: [
        //       ColorManager.secondaryColor6,
        //       ColorManager.secondaryColor7,
        //     ],
        //   ),
        // ),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Text(
              "اختر المندوب",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: ColorManager.secondaryColor1,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            // Container(
            //   width: 200,
            //   height: 50,
            //   decoration: BoxDecoration(
            //     color: ColorManager.white,
            //
            //   ),
            //   child: CustomDropDown(
            //     hintText: "اختر المندوبين",
            //     onChanged: (value) {},
            //     validator: (value) {
            //       if (value == null) {
            //         return "اختر نوع الطلب";
            //       }
            //       return null;
            //     },
            //     errorText: 'لايوجد نتيجة',
            //     prefixIcon: null,
            //     items: [],
            //   ),
            // ),
            //  SizedBox(height: 10,),

          ],
        ),
      ),
      drawer: DrawerPage(),
      appBar: AppBar(
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Icon(
                size: 30,
                Icons.menu,
                color: ColorManager.secondaryColor,
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        title: Text('تقارير المندوبين',),
      ),
    );
  }
}
