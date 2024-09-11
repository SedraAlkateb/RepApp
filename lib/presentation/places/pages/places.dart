import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/drawer/pages/drawer_page.dart';
import 'package:domina_app/presentation/places/bloc/place_bloc.dart';
import 'package:domina_app/presentation/plase_visit/bloc/place_visit_bloc.dart';
import 'package:domina_app/presentation/plase_visit/pages/place_visit_page.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/resources/values_manager.dart';
import 'package:domina_app/presentation/uniti/stateWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Places extends StatelessWidget {
  Places({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<PlaceBloc>(context).add(AllPlaceEvent());
    });
    //DialogFilter( text: "اختر احد الاماكن لاضهار ادكاترة , الصيادلة , المشافي في هذا المكان");
    return Scaffold(
        drawer: DrawerPage(),
        appBar: AppBar(
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: Icon(
                  size: AppSize.s30,
                  Icons.menu,
                  color: ColorManager.white, // هنا يمكنك تحديد لون الأيقونة
                ),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              );
            },
          ),
          title: Text('الأماكن المتاحة '),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  //        crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "   كل الاماكن ",
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    Icon(Icons.location_city),
                  ],
                ),
              ),
              Text(
                "اختر المكان لاضهار الدكاترة و الصيدليات المشافي في هذه المنطقة ",
              ),
              Expanded(
                child: BlocConsumer<PlaceBloc, PlaceState>(
                  listener: (context, state) {
                    if (state is AllPlaceErrorState) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        error(
                            context, state.failure.massage, state.failure.code);
                      });
                    }
                  },
                  builder: (context, state) {
                    if (state is AllPlaceState) {
                      List<PlaceModel> placeModel = state.places;
                      return ListView.builder(
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                                  return  PlaceVisitPage(placeId: placeModel[index].placeId);
                                  },)
                                  );
                                  BlocProvider.of<PlaceVisitBloc>(context).add(PharmacyByPlace(placeModel[index].placeId));
                              },
                              child: Container(
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
                                  children: [Text(placeModel[index].title)],
                                ),
                              ),
                            );
                          },
                          itemCount: placeModel.length);
                    }

                    return SizedBox();
                  },
                ),
              ),
            ],
          ),
        ));
  }
}
