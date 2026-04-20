import 'package:domina_app/app/user_info.dart';
import 'package:domina_app/presentation/senior/all_city/bloc/bloc/all_city_bloc.dart';
import 'package:domina_app/presentation/senior/general_reports/pages/all_city-seniors.dart';
import 'package:domina_app/presentation/senior/general_reports/bloc/bloc/general_reports_bloc.dart';
import 'package:domina_app/presentation/senior/general_reports/pages/team_leader.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GeneralReports extends StatelessWidget {
  GeneralReports({
    super.key,
  });
  // final int repPlan;
  // final TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Future<bool> onWillPop() async {
      // BlocProvider.of<ManageFutureBloc>(context).add(AllSeniorRepFutureEvent());
      return true;
    }

    return DefaultTabController(
      length: 2,
      child: WillPopScope(
        onWillPop: onWillPop,
        child: Scaffold(
          appBar: UserInfo.repType == "4"
              ? AppBar(
            leading: const SizedBox(),
            bottom: TabBar(
              dividerColor: Colors.transparent,
              labelColor: ColorManager.secondaryColor1,
              labelPadding: const EdgeInsets.all(0.9),
              onTap: (value) {
                if (value == 0) {
                  BlocProvider.of<GeneralReportsBloc>(context)
                      .add(const TeamLeaderAndCityEvent());
                } else {
                  BlocProvider.of<AllCityBloc>(context)
                      .add(const GetAllCityEvent());
                }
              },
              tabs: const [
                Tab(
                  // icon: context.watch<EditBrandPlanBloc>().current == 0
                  //     ? Icon(Icons.groups, color: ColorManager.secondaryColor1)
                  //     : Icon(Icons.groups),
                  text: 'Team Leader',
                ),
                Tab(
                  // icon: context.watch<EditBrandPlanBloc>().current == 1
                  //     ? Icon(Icons.local_hospital,
                  //         color: ColorManager.secondaryColor1)
                  //     : Icon(Icons.local_hospital),
                  text: 'Senior',
                ),
              ],
            ),
          )
              : UserInfo.repType == "5"
              ? AppBar(
            leading: const SizedBox(),
            backgroundColor: Colors.transparent,
            bottom: Tab(
              child: Container(
                width: 100,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      style: BorderStyle.solid,
                      color: ColorManager.secondaryColor1,
                      width: 3.5,
                    ),
                  ),
                ),
                child: Padding(
                  padding:
                  const EdgeInsets.only(bottom: 8.0, right: 10),
                  child: Text(
                    'Seniors',
                    style: TextStyle(
                        color: ColorManager.secondaryColor1,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                ),
              ),
            ),
            centerTitle: true,
            // title: const Padding(
            //   padding: EdgeInsets.only(top: 45.0),
            //   child: Text('Seniors'),
            // ),
          )
              : AppBar(

          ),
          body: UserInfo.repType == "4"
              ? const Stack(
            children: [
              TabBarView(
                physics: NeverScrollableScrollPhysics(),
                children: [TeamLeader(), AllCitySeniors()],
              ),
            ],
          )
              : UserInfo.repType == "5"
              ? const AllCitySeniors()
              : const SizedBox(),
        ),
      ),
    );
  }
}
