import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/resources/values_manager.dart';
import 'package:domina_app/presentation/senior/representative/bloc/senior_prof_bloc.dart';
import 'package:domina_app/presentation/uniti/circle_number_widget.dart';
import 'package:domina_app/presentation/uniti/search_field.dart';
import 'package:domina_app/presentation/uniti/stateWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HospitalSenior extends StatelessWidget {
  HospitalSenior({super.key});
  final TextEditingController searchHosController = TextEditingController();

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
        title: Text('أرشيف المشافي'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SearchField(
                    searchController: searchHosController,
                    onPressed: (value) {
                      BlocProvider.of<SeniorProfBloc>(context)
                          .add(SenSearchHospEvent(value));
                    },
                  ),
                ],
              ),
            ),
            BlocBuilder<SeniorProfBloc, SeniorProfState>(
              builder: (context, state) {
                List<HospitalModel> hospitalModel =
                    context.watch<SeniorProfBloc>().hospital;
                if (state is SenAllHospitalsState) {
                  hospitalModel = state.hospital;
                }
                if (state is SenAllHospitalEmptyState) {
                  return SliverList(
                      delegate: SliverChildListDelegate([
                        SizedBox(
                          height: 100,
                        ),
                        emptyFullScreen(context)
                      ]));
                }

                if(state is SenAllHospitalLoadingState){
                  return
                    SliverList(
                      delegate: SliverChildListDelegate([
                      loadingFullScreen(context)
                      ]),
                    );
                }
                if(state is SenAllHospitalErrorState){
                  return
                    SliverList(
                      delegate: SliverChildListDelegate([
                        errorFullScreen(context,
                        func: (){
                        }
                        )
                      ]),
                    );
                }
                return SliverList(
                  delegate: SliverChildListDelegate([
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("عدد المشافي: ",
                              style: Theme.of(context).textTheme.labelLarge),
                          CircleNumberWidget(number: hospitalModel.length),
                        ],
                      ),
                    ),
                    // القائمة
                    ...hospitalModel.map((hospital) {
                      return  Container(
                        margin: EdgeInsets.all(AppPadding.p8),
                        padding: EdgeInsets.all(AppPadding.p16),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              ColorManager.secondaryColor6,
                              ColorManager.secondaryColor7,
                            ],
                          ),
                          borderRadius:
                          BorderRadius.all(Radius.circular(AppSize.s8)),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              hospital.title,
                              style: Theme.of(context).textTheme.labelLarge,
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              "${hospital.address}_${hospital.placeTitle}",
                              style: Theme.of(context).textTheme.titleMedium,
                              textAlign: TextAlign.center,
                            ),
                            hospital.note!=null?
                            Text(
                              "ملاحظة ",
                              style: Theme.of(context).textTheme.labelLarge,
                              textAlign: TextAlign.center,
                            ):SizedBox(),
                            hospital.note!=null?
                            Text(
                              hospital.note??"",
                              style: Theme.of(context).textTheme.titleMedium,
                              textAlign: TextAlign.center,
                            ):SizedBox(),
                          ],
                        ),
                      );
                    }).toList(),
                  ]),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
