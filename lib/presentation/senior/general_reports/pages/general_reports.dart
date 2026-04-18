import 'package:domina_app/app/user_info.dart';
import 'package:domina_app/presentation/senior/general_reports/pages/all_city-seniors.dart';
import 'package:domina_app/presentation/senior/general_reports/pages/senior-by-cityid.dart';
import 'package:domina_app/presentation/senior/general_reports/pages/team_leader.dart';
import 'package:flutter/material.dart';

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
                  ?
          SeniorByCityId(
            cityname:UserInfo.cityTitle ,
            cityid:UserInfo.cityId,
          )
                  : const SizedBox(),
        ),
      ),
    );
  }
}
