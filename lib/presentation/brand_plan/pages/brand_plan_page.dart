import 'package:domina_app/presentation/brand_plan/bloc/brand_plan_bloc.dart';
import 'package:domina_app/presentation/brand_plan/widget/brand_plan_active_page.dart';
import 'package:domina_app/presentation/brand_plan/widget/brand_plan_other_page.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BrandPlanPage extends StatelessWidget {
  const BrandPlanPage({super.key});
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length:2, 
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: ColorManager.secondaryColor7,
            bottom: TabBar(
                labelPadding: EdgeInsets.all(0.9),
                tabs: [
                  Tab(
                    icon: Icon(Icons.groups),
                    text: 'الخطة الحالية',
                  ),
                  Tab(
                    icon: Icon(Icons.local_hospital),
                    text: 'قيد المعالجة',
                  ),
                ]),
          ),
          body: TabBarView(
              physics: NeverScrollableScrollPhysics(),
              children: [
            BrandPlanActivePage(),
                BrandPlanOtherPage(),
          ]),
        ));
  }
}
