import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/drawer/pages/drawer_page.dart';
import 'package:domina_app/presentation/places/bloc/place_bloc.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/resources/values_manager.dart';
import 'package:domina_app/presentation/specialization/bloc/specialization_bloc.dart';
import 'package:domina_app/presentation/uniti/stateWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
 
class SpecializationsPage extends StatelessWidget {
  SpecializationsPage({super.key});
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<SpecializationBloc>(context).add(SpecEvent(117));
    return Scaffold(
    //  drawer:   DrawerPage(),
      appBar: AppBar(

        title: Text(
            'Representative Spec'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal:8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,

                children: [
                  Icon(Icons.location_city),

                  Text("   All spec",style: Theme.of(context).textTheme.titleMedium,),
                ],
              ),

            ),
            Expanded(
              child: BlocConsumer<SpecializationBloc, SpecializationState>(
  listener: (context, state) {
    if(state is AllSpecErrorState){
      error(context, state.failure.massage, state.failure.code);
    }
  },
  builder: (context, state) {
    if(state is AllSpecState){
      List<SpecModel> placeModel=state.Specs;
      success(context);
      return ListView.builder
        (
          itemBuilder: (context, index) {
            return Container(
              margin: EdgeInsets.all(AppPadding.p8),
              padding: EdgeInsets.all(AppPadding.p16),
              //    height: AppSize.s150,
              decoration: BoxDecoration(
                color: ColorManager.white,
                border:
                Border.all(color: ColorManager.hintGrey),
                borderRadius: const BorderRadius.all(
                    Radius.circular(AppSize.s8)),
                //        color: ColorManager.card,
              ),
              child: Row(
                children: [
                  Text(placeModel[index].title)
                ],
              ),
            );
          }, itemCount: placeModel.length);
    }
    if(state is AllSpecLoadingState){
      loading(context);
    }
    return SizedBox();
  },
),
            ),
          ],
        ),
      )
    );
  }
}