import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/drawer/pages/drawer_page.dart';
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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<SpecializationBloc>(context).add(SpecEvent(117));
    });
    return Scaffold(
        drawer: DrawerPage(),
        appBar: AppBar(
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: Icon(
                  size: AppSize.s30,
                  Icons.menu,
                  color: ColorManager.white,
                ),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              );
            },
          ),
          title: Text('Representative Spec'),
        ),
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(color: ColorManager.secondaryColor),
            ),
            SingleChildScrollView(
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
                      Padding(
                        padding: const EdgeInsets.all(AppPadding.p16),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(Icons.location_city),
                            Text(
                              "   All spec",
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ],
                        ),
                      ),
                      BlocConsumer<SpecializationBloc, SpecializationState>(
                        listener: (context, state) {
                          if (state is AllSpecLoadingState) {
                            loading(context);
                          }
                          if (state is AllSpecErrorState) {
                            error(context, state.failure.massage,
                                state.failure.code);
                          }
                          if (state is AllSpecState) {
                            success(context);
                          }
                        },
                        builder: (context, state) {
                          if (state is AllSpecState) {
                            List<SpecModel> placeModel = state.Specs;
                            return GridView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2, // عدد الأعمدة في كل صف
                                crossAxisSpacing:
                                    8.0, // المسافة الأفقية بين الأعمدة
                                mainAxisSpacing:
                                    8.0, // المسافة العمودية بين الصفوف
                                childAspectRatio:
                                    1, // نسبة العرض إلى الارتفاع لكل عنصر (يمكنك تعديلها حسب الحاجة)
                              ),
                              itemCount: placeModel.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  margin: EdgeInsets.all(AppPadding.p16),
                                  padding: EdgeInsets.all(AppPadding.p16),
                                  width: 2,
                                  decoration: BoxDecoration(
                                    color: ColorManager.secondaryColor3,
                                    border: Border.all(
                                        color: ColorManager.secondaryColor),
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(AppSize.s25),
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      textAlign: TextAlign.center,
                                      placeModel[index].title,
                                      style: TextStyle(
                                          color: ColorManager.secondaryColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 25),
                                    ),
                                  ),
                                );
                              },
                            );
                          }

                          return Expanded(
                              child: Container(
                            color: Colors.white,
                          ));
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
