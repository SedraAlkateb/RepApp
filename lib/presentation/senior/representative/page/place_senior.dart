import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/drawer/pages/drawer_page.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/resources/values_manager.dart';
import 'package:domina_app/presentation/senior/representative/bloc/senior_prof_bloc.dart';
import 'package:domina_app/presentation/uniti/stateWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PlaceSenior extends StatelessWidget {
  PlaceSenior({super.key});
  final TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerPage(),
      appBar: AppBar(
        leading: Builder(
          builder: (BuildContext context) {
            return Center(
              child: IconButton(
                icon: Icon(
                  size: AppSize.s30,
                  Icons.arrow_back_sharp,
                  color: ColorManager.secondaryColor,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            );
          },
        ),
        title: Text('المناطق'),
      ),
      body: bodyBuild(context),
    );
  }

  Widget bodyBuild(BuildContext context) {
    return   BlocBuilder<SeniorProfBloc, SeniorProfState>(
      builder: (context, state) {
        if(state is SenAllPlaceState){
          final List<PlaceModel> placeModel=state.places;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: ListView.builder(
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.all(AppPaddingH.p8),
                  padding: EdgeInsets.all(AppPaddingH.p16),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      ColorManager.secondaryColor6,
                      ColorManager.secondaryColor7,
                      ColorManager.secondaryColor7,
                    ]),
                    color: ColorManager.white,
                    borderRadius:
                     BorderRadius.all(Radius.circular(AppSize.s8)),
                  ),
                  child: Center(
                    child: Text(
                      placeModel[index].title,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ),
                );
              },
              itemCount: placeModel.length,
            ),
          );
        }
        if(state is SenAllPlaceLoadingState){
          print("gtggggggggggggggggg");
          return loadingFullScreen(context);

        }
        if(state is SenAllPlaceErrorState){
          return errorFullScreen(context
              ,func:()=> BlocProvider.of<SeniorProfBloc>(context).add(SenAllPlaceEvent(203))
          );
        }
        return SizedBox();
      },
    );
  }
}
