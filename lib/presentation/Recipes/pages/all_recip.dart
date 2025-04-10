import 'package:domina_app/app/di.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/Recipes/bloc/recipes_brand_bloc.dart';

import 'package:domina_app/presentation/Recipes/pages/update_recipes.dart';
import 'package:domina_app/presentation/Recipes/pages/update_recipes_hospital.dart';
import 'package:domina_app/presentation/drawer/pages/drawer_page.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/resources/values_manager.dart';
import 'package:domina_app/presentation/uniti/circle_number_widget.dart';
import 'package:domina_app/presentation/uniti/stateWidget.dart';
import 'package:domina_app/presentation/uniti/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AllRecip extends StatelessWidget {
  AllRecip({super.key});
  @override
  Widget build(BuildContext context) {
    Future.microtask(() {
      BlocProvider.of<RecipesBrandBloc>(context).add(AllReciEvent());
    });
    return Scaffold(
      drawer: DrawerPage(),
      appBar: AppBar(
        leading: Builder(
          builder: (BuildContext context) {
            return Center(
              child: IconButton(
                icon: Icon(
                  size: AppSize.s30,
                  Icons.menu,
                  color: ColorManager.secondaryColor,
                ),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              ),
            );
          },
        ),
        title: Text('الوصفات'),
      ),
      body: bodyBuild(context),
    );
  }

  Widget bodyBuild(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 10,
        ),
        Expanded(
          child: BlocBuilder<RecipesBrandBloc, RecipesBrandState>(
            buildWhen: (previous, current) =>
                current is AllReciLoadingState ||
                current is AllReciState ||
                current is AllReciErrorState ||
                current is AllReciEmptyState,
            builder: (context, state) {
              if (state is AllReciLoadingState) {
                return loadingFullScreen(context);
              }
              if (state is AllReciState) {
                List<ReciModel> recis = state.reci;
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          Text("عدد الأطباء : ",
                              style: Theme.of(context).textTheme.labelLarge),
                          CircleNumberWidget(number: recis.length),
                        ],
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                initBrandRecModule();
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => recis[index]
                                                  .recipeType ==
                                              "1"
                                          ? UpdateRecipesPage(
                                              recipeId: int.parse(
                                                  recis[index].id ?? "0"),
                                              docId:
                                                  int.parse(recis[index].docId),
                                              st: 1,
                                            )
                                          : UpdateRecipesHospital(
                                              recipeId: int.parse(
                                                  recis[index].id ?? "0"),
                                              HospitalId:
                                                  int.parse(recis[index].docId),
                                              st: 1,
                                            )),
                                );
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
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(AppSize.s8)),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    TextRach(
                                        s1: "اسم الطبيب: ",
                                        s2: recis[index].docName ?? ""),
                                    TextRach(
                                        s1: "الملاحظة: ",
                                        s2: recis[index].note_emp ?? ""),
                                    TextRach(
                                        s1: "المجموع: ",
                                        s2: recis[index].total ?? ""),
                                    TextRach(
                                        s1: "التاريخ: ",
                                        s2: recis[index].create_date ?? "")
                                  ],
                                ),
                              ),
                            );
                          },
                          itemCount: recis.length,
                        ),
                      ),
                    ],
                  ),
                );
              }
              if (state is AllReciErrorState) {
                return errorFullScreen(context,
                    mes: state.failure.massage, func: () {});
              }
              if (state is AllReciEmptyState) {
                return emptyFullScreen(context);
              }
              return SizedBox();
            },
          ),
        ),
      ],
    );
  }
}
