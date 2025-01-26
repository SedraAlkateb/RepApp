import 'package:domina_app/app/di.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/drawer/pages/drawer_page.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/resources/values_manager.dart';
import 'package:domina_app/presentation/senior/places/bloc/senior_reps_bloc.dart';
import 'package:domina_app/presentation/senior/representative/bloc/senior_prof_bloc.dart';
import 'package:domina_app/presentation/senior/representative/page/rep_profile.dart';
import 'package:domina_app/presentation/uniti/stateWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AllRepSenior extends StatelessWidget {
  AllRepSenior({super.key});
  final TextEditingController searchController = TextEditingController();
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
        title: Text('المندوبين'),
      ),
      body: bodyBuild(context),
    );
  }

  Widget bodyBuild(BuildContext context) {
    return   BlocBuilder<SeniorRepsBloc, SeniorRepsState>(
      builder: (context, state) {
        if(state is AllSeniorRepState){
          final List<AllRepresentative> allRepresentative=state.representatives;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: ListView.builder(
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    initSeniorProfModule();
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                      return RepProfile(id: allRepresentative[index].id);
                    },));
                  },
                  child: Container(
                    margin: EdgeInsets.all(AppPadding.p8),
                    padding: EdgeInsets.all(AppPadding.p16),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                        ColorManager.secondaryColor6,
                        ColorManager.secondaryColor7,
                        ColorManager.secondaryColor7,
                      ]),
                      color: ColorManager.white,
                      borderRadius:
                      const BorderRadius.all(Radius.circular(AppSize.s8)),
                    ),
                    child: Text(
                      allRepresentative[index].name,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ),
                );
              },
              itemCount: allRepresentative.length,
            ),
          );
        }
        if(state is AllSeniorRepLoadingState){
          print("lllllllllllllllllllllllllll");
          return loadingFullScreen(context);
        }
        if(state is AllSeniorRepErrorState){
          return errorFullScreen(context,func:()=> BlocProvider.of<SeniorRepsBloc>(context).add( AllSeniorRepEvent())
          );
        }
        return SizedBox();
      },
    );
  }
}
