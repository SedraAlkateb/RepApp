import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/drawer/pages/drawer_page.dart';
import 'package:domina_app/presentation/places/bloc/place_bloc.dart';
import 'package:domina_app/presentation/plase_visit/bloc/visit_place_bloc.dart';
import 'package:domina_app/presentation/plase_visit/pages/place_visit_page.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/resources/values_manager.dart';
import 'package:domina_app/presentation/uniti/custom_button.dart';
import 'package:domina_app/presentation/uniti/search_field.dart';
import 'package:domina_app/presentation/uniti/stateWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Places extends StatelessWidget {
  Places({super.key});
 final TextEditingController searchController =TextEditingController();
  int k=0;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;


    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<PlaceBloc>(context).add(AllPlaceEvent());
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (k == 0) {
        showDialog(
            context: context,
            builder: (context) {
              return Container(
                child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 20, right: 20, top: 20, bottom: 20),
                      child: Container(
                        height: size.height / 3,
                        decoration: BoxDecoration(
                            color: ColorManager.white,
                            borderRadius: BorderRadius.circular(15)),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, top: 20, bottom: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 20),
                                child: Text(
                                  textAlign: TextAlign.center,
                                  " :اختر احد المناطق لاظهار (الأطباء,الصيادلة,المشافي) في المنطقة المختارة",
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: ColorManager.secondaryColor1,
                                      fontWeight: FontWeight.normal,
                                      decoration: TextDecoration.none),
                                ),
                              ),
                              SizedBox(
                                height: 40,
                              ),
                              CustomButton(
                                  text: "ok",
                                  onPressed: () {
                                    k = 1;
                                    Navigator.pop(context);
                                  })
                            ],
                          ),
                        ),
                      ),
                    )),
              );
            });
        k = 1;
      }
    });
    return Scaffold(
        drawer: DrawerPage(),
        appBar: AppBar(
          /*
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [ColorManager.secondaryColor1, ColorManager.secondaryColor4],
               // begin: Alignment.topLeft,
             //   end: Alignment.bottomRight,
              ),
            ),
          ),
        */
          leading: Builder(
            builder: (BuildContext context) {
              return Center(
                child: IconButton(
                  icon: Icon(
                    size: AppSize.s30,
                    Icons.menu,
                    color: ColorManager
                        .secondaryColor, // هنا يمكنك تحديد لون الأيقونة
                  ),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                ),
              );
            },
          ),
          title: Text('المناطق'),
        ),
        body: bodyBuild());
  }
  Widget bodyBuild(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
SizedBox(height: 10,),
        SearchField(searchController:searchController ),
        Expanded(
          child: BlocConsumer<PlaceBloc, PlaceState>(
            listener: (context, state) {
              if (state is AllPlaceErrorState) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  error(context, state.failure.massage, state.failure.code);
                });
              }
            },
            builder: (context, state) {
              if (state is AllPlaceState) {
                List<PlaceModel> placeModel = state.places;
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: ListView.builder(
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) {
                                return PlaceVisitPage(
                                    placeId: placeModel[index].placeId);
                              },
                            ));
                            BlocProvider.of<VisitPlaceBloc>(context).add(
                                PharmacyByPlace(placeModel[index].placeId,0));
                            },
                          child: Container(
                            margin: EdgeInsets.all(AppPadding.p8),
                            padding: EdgeInsets.all(AppPadding.p16),
                            //    height: AppSize.s150,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(colors:
                              [
                                ColorManager.secondaryColor6,
                                ColorManager.secondaryColor7,
                                ColorManager.secondaryColor7,
                              ]
                              ),
                              color: ColorManager.white,
                              borderRadius: const BorderRadius.all(
                                  Radius.circular(AppSize.s8)),
                              //        color: ColorManager.card,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(placeModel[index].title,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall)
                              ],
                            ),
                          ),
                        );
                      },
                      itemCount: placeModel.length),
                );
              }

              return SizedBox();
            },
          ),
        ),
      ],
    );
  }
}
