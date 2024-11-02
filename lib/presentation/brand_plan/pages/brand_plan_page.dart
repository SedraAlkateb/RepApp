import 'package:domina_app/presentation/brand_plan/pages/spec_plan_page.dart';
import 'package:domina_app/presentation/brand_plan/widget/brand_plan_active_page.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:flutter/material.dart';

class BrandPlanPage extends StatelessWidget {
  const BrandPlanPage({super.key});
  @override
  Widget build(BuildContext context) {

    return DefaultTabController(
        length:2,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: ColorManager.secondaryColor7,
        //    leading: SizedBox(),
            bottom: TabBar(
                labelPadding: EdgeInsets.all(0.9),
                tabs: [
                  Tab(
                    icon: Icon(Icons.list_alt_outlined),
                    text: 'الخطة الحالية',
                  ),
                  Tab(
                    icon: Icon(Icons.featured_play_list_outlined),
                    text: 'قيد المعالجة',
                  ),
                ]),
          ),
          body: TabBarView(
              physics: NeverScrollableScrollPhysics(),
              children: [
            BrandPlanActivePage(),
                SpecPlanPage(),
          ]
          ),
        ));
  }
}
