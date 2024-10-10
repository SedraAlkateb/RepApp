import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/drawer/pages/drawer_page.dart';
import 'package:domina_app/presentation/resources/assets_manager.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/resources/values_manager.dart';
import 'package:domina_app/presentation/specialization/bloc/specialization_bloc.dart';
import 'package:domina_app/presentation/specialization/pages/spec_d_h.dart';
import 'package:domina_app/presentation/uniti/search_field.dart';
import 'package:domina_app/presentation/uniti/stateWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SpecializationsPage extends StatelessWidget {
  SpecializationsPage({super.key});
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
          title: Text('الاختصاصات'),
        ),
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(color: ColorManager.white),
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
                            SearchField(searchController: searchController,
                      onPressed: (value) {
                        BlocProvider.of<SpecializationBloc>(context).add(SearchSpecEvent(value));
                      },
                      ),
                      BlocConsumer<SpecializationBloc, SpecializationState>(
                        listener: (context, state) {
                          /*
                          if (state is AllSpecLoadingState) {
                            loading(context);
                          }
                          if (state is AllSpecState) {
                            success(context);
                          }
                          */
                          if (state is AllSpecErrorState) {
                            error(context, state.failure.massage,
                                state.failure.code);
                          }
                        },
                        builder: (context, state) {
                          List<SpecModel> placeModel = context.watch<SpecializationBloc>().specialization;
                          if (state is AllSpecState) {
                            placeModel = state.Specs;
                          }
                          return   GridView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2, // عدد الأعمدة في كل صف
                                    crossAxisSpacing:
                                        1.0, // المسافة الأفقية بين الأعمدة
                                    mainAxisSpacing:
                                        2.0, // المسافة العمودية بين الصفوف
                                    childAspectRatio:
                                        1, // نسبة العرض إلى الارتفاع لكل عنصر (يمكنك تعديلها حسب الحاجة)
                                  ),
                                  itemCount: placeModel.length,
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      onTap: () {
                                        Navigator.push(context, MaterialPageRoute(
                                          builder: (context) {
                                            return SpecDH(
                                                spId: placeModel[index].id,);
                                          },
                                        )
                                        );
                                        BlocProvider.of<SpecializationBloc>(context).add(
                                            DoctorSpEvent(placeModel[index].id));
                                      },
                                      child: Container(
                                        margin: EdgeInsets.all(AppPadding.p10),
                                        padding: EdgeInsets.all(AppPadding.p5),
                                        width: 6,
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                              colors: [
                                            ColorManager.secondaryColor6,
                                            ColorManager.secondaryColor7,
                                          ]
                                          ),
                                          color: ColorManager.white,
                                          borderRadius: const BorderRadius.all(
                                            Radius.circular(AppSize.s25),
                                          ),
                                        ),
                                        child: Center(
                                          child: Column(
                                            children: [
                                              // SvgPicture.asset(
                                              //   ImageAssets.s14,
                                              //   width: 70,
                                              // ),
                                              Text(
                                                textAlign: TextAlign.center,
                                                placeModel[index].title,
                                                style: TextStyle(
                                                    color: ColorManager.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 13),
                                              ),
                                            ],
                                          ),
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
          ],
        ));
  }
}
