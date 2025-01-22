import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/resources/assets_manager.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/resources/values_manager.dart';
import 'package:domina_app/presentation/senior/representative/bloc/senior_prof_bloc.dart';
import 'package:domina_app/presentation/uniti/search_field.dart';
import 'package:domina_app/presentation/uniti/stateWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SpecSeniorPage extends StatelessWidget {
  SpecSeniorPage({super.key});
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Icon(
                size: AppSize.s30,
                Icons.arrow_back_sharp,
                color: ColorManager.secondaryColor1,
              ),
              onPressed: () {
              Navigator.pop(context);
              },
            );
          },
        ),
        title: Text('الإختصاصات'),
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  blurRadius: 0.6,
                  color: ColorManager.white,
                  spreadRadius: 0.5,
                  offset: Offset(2, 3))
            ],
            borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SearchField(
                  searchController: searchController,
                  onPressed: (value) {
                    BlocProvider.of<SeniorProfBloc>(context)
                        .add(SenSearchSpecEvent(value));
                  },
                ),
                BlocConsumer<SeniorProfBloc, SeniorProfState>(
                  listener: (context, state) {
                    /*
                          if (state is AllSpecLoadingState) {
                            loading(context);
                          }
                          if (state is AllSpecState) {
                            success(context);
                          }
                          */
                    if (state is SenAllSpecErrorState) {
                      error(context, state.failure.massage, state.failure.code);
                    }
                  },
                  builder: (context, state) {
                    List<SpecDModel> placeModel =
                        context.watch<SeniorProfBloc>().specialization;
                    if (state is SenAllSpecState) {
                      placeModel = state.Specs;
                    }
                    if(state is SenAllSpecLoadingState){
                      return loadingFullScreen(context);
                    }

                    return GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 1.0,
                        mainAxisSpacing: 2.0,
                        childAspectRatio: 1,
                      ),
                      itemCount: placeModel.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.all(AppPadding.p10),
                          padding: EdgeInsets.all(AppPadding.p5),
                          width: 6,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(colors: [
                              ColorManager.secondaryColor6,
                              ColorManager.secondaryColor7,
                            ]),
                            color: ColorManager.white,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(AppSize.s25),
                            ),
                          ),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  ImageAssetsSpec()
                                      .getImage(placeModel[index].id),
                                  width: 45,
                                  height: 45,
                                  color: ColorManager.white.withOpacity(0.8),
                                  colorBlendMode: BlendMode.modulate,
                                ),
                                SizedBox(height: 10),
                                Column(
                                  children: [
                                    Text(
                                      textAlign: TextAlign.center,
                                      placeModel[index].title,
                                      style: TextStyle(
                                          color: ColorManager.white,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 20),
                                    ),
                                    placeModel[index].sumDoctor != 0
                                        ? Text(
                                      textAlign: TextAlign.center,
                                      " زيارات الاطباء : ${placeModel[index].sumDoctor}",
                                      style: TextStyle(
                                          color: ColorManager.white,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12),
                                    )
                                        : SizedBox(),
                                    placeModel[index].sumHospital != 0
                                        ? Text(
                                      textAlign: TextAlign.center,
                                      " زيارات المشافي : ${placeModel[index].sumHospital}",
                                      style: TextStyle(
                                          color: ColorManager.white,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12),
                                    )
                                        : SizedBox(),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
