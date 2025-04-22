import 'package:domina_app/app/di.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/drawer/pages/drawer_page.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/resources/routes_manager.dart';
import 'package:domina_app/presentation/resources/values_manager.dart';
import 'package:domina_app/presentation/senior/places/bloc/senior_reps_bloc.dart';
import 'package:domina_app/presentation/uniti/stateWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AllCitySenior extends StatelessWidget {
  AllCitySenior({super.key});
  
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
        title: Text('المدن'),
      ),
      body: bodyBuild(context),
    );
  }

  Widget bodyBuild(BuildContext context) {
    return BlocBuilder<SeniorRepsBloc, SeniorRepsState>(
      builder: (context, state) {
        List<CityModel> cities =
            context.watch<SeniorRepsBloc>().cities;
        if (state is AllCityLoadingState) {
          return loadingFullScreen(context);
        }
        else if (state is AllCityErrorState) {
          return errorFullScreen(context,
              func: () => BlocProvider.of<SeniorRepsBloc>(context)
                  .add(AllCityEvent()));
        }
        else  if (state is AllCityState) {
          cities = state.cities;
        }
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: ListView.builder(
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  initSeniorProfModule();
                  BlocProvider.of<SeniorRepsBloc>(context).add(
                      AllSeniorRepEvent());
                  Navigator.of(context).pushNamed(Routes.AllRepSenior);
                },
                child: Container(
                  margin: EdgeInsets.all(AppPadding.p8),
                  padding: EdgeInsets.all(AppPadding.p16),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      //  ColorManager.secondaryColor6,
                      ColorManager.secondaryColor7,
                      ColorManager.secondaryColor7,
                      ColorManager.secondaryColor7,
                    ]),
                    color: ColorManager.white,
                    borderRadius: const BorderRadius.all(
                        Radius.circular(AppSize.s8)),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${cities[index].name}",
                        style: Theme.of(context).textTheme.titleSmall,
                      ),

                    ],
                  ),
                ),
              );
            },
            itemCount: cities.length,
          ),
        );

      },
    );
  }
}
