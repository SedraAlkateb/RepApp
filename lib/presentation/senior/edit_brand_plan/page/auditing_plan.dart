import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/senior/edit_brand_plan/bloc/edit_brand_plan_bloc.dart';
import 'package:domina_app/presentation/senior/edit_brand_plan/widgets/editing_plan_assistant.dart';
import 'package:domina_app/presentation/senior/edit_brand_plan/widgets/editing_plan_target.dart';
import 'package:domina_app/presentation/senior/manage_future/bloc/manage_future_bloc.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class EditingPlan extends StatelessWidget {
  EditingPlan({super.key, required this.repPlan});
  final int repPlan;
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Future<bool> _onWillPop() async {
      BlocProvider.of<ManageFutureBloc>(context).add(AllSeniorRepFutureEvent());
      return true;
    }
    return DefaultTabController(
      length: 2,
      child:  WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: ColorManager.secondaryColor7,
            bottom: TabBar(
              labelPadding: const EdgeInsets.all(0.9),
              onTap: (value) {
                if (value == 0) {
                BlocProvider.of<EditBrandPlanBloc>(context).add(FutureGetPlanBrandEvent (Rep(repPlan ,1 ) ));
                }else {
                  BlocProvider.of<EditBrandPlanBloc>(context).add(FutureGetPlanBrandEvent (Rep(repPlan ,2 ) ));
                }
              },
              tabs: const [
                Tab(
                  // icon: context.watch<EditBrandPlanBloc>().current == 0
                  //     ? Icon(Icons.groups, color: ColorManager.secondaryColor1)
                  //     : Icon(Icons.groups),
                  text: 'هدف',
                ),
                Tab(
                  // icon: context.watch<EditBrandPlanBloc>().current == 1
                  //     ? Icon(Icons.local_hospital,
                  //         color: ColorManager.secondaryColor1)
                  //     : Icon(Icons.local_hospital),
                  text: 'مساعد',
                ),
              ],
            ),
          ),
          body: Stack(
            children: [
              TabBarView(
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  EditingPlanTarget(  repPlan: repPlan,),
                  EditingPlanAssistant( repPlan: repPlan,),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
