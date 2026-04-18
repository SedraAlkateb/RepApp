import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/drawer/pages/drawer_launcher.dart';
import 'package:domina_app/presentation/pharmacy/bloc/pharmacy_bloc.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/resources/values_manager.dart';
import 'package:domina_app/presentation/uniti/search_field.dart';
import 'package:domina_app/presentation/uniti/stateWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PharmacyPage extends StatelessWidget {
  PharmacyPage({super.key});
  final TextEditingController searchphController = TextEditingController();
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
          title: Text('الصيدليات '),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SearchField(
                searchController: searchphController,
                onPressed: (value) {
                  BlocProvider.of<PharmacyBloc>(context)
                      .add(SearchphEvent(value));
                },
              ),
              Expanded(
                child: BlocConsumer<PharmacyBloc, PharmacyState>(
                  listener: (context, state) {
                    if (state is AllPharmacyErrorState) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        error(
                            context, state.failure.massage, state.failure.code);
                      });
                    }
                    /*
                  if(state is AllPharmacyLoadingState){
                    loading(context);
                  }
                  if(state is AllPharmacyState){
    success(context);}
                 */
                  },
                  builder: (context, state) {
                    if (state is AllPharmacyState) {
                      List<PharmacyModel> pharmacyModel = state.pharmacy;
                      return ListView.builder(
                          itemBuilder: (context, index) {
                            return Container(
                              margin: EdgeInsets.all(AppPaddingH.p8),
                              padding: EdgeInsets.all(AppPaddingH.p16),
                              //    height: AppSize.s150,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(colors: [
                                  ColorManager.secondaryColor6,
                                  ColorManager.secondaryColor7,
                                  ColorManager.secondaryColor7,
                                ]),
                                color: ColorManager.white,

                                borderRadius:  BorderRadius.all(
                                    Radius.circular(AppSize.s8)),
                                //        color: ColorManager.card,
                              ),
                              child: Column(
                                children: [
                                  Text(
                                    "${pharmacyModel[index].title} ",
                                    style:
                                        Theme.of(context).textTheme.labelLarge,
                                    textAlign: TextAlign.center,
                                  ),
                                  Text(
                                      " العنوان : ${pharmacyModel[index].address} ",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall),
                                ],
                              ),
                            );
                          },
                          itemCount: pharmacyModel.length);
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
