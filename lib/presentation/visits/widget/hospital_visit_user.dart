import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/resources/values_manager.dart';
import 'package:domina_app/presentation/uniti/search_field.dart';
import 'package:domina_app/presentation/uniti/stateWidget.dart';
import 'package:domina_app/presentation/uniti/text.dart';
import 'package:domina_app/presentation/visits/bloc/visit_bloc.dart';
import 'package:domina_app/presentation/visits/pages/info_visit_hospital.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HospitalVisitUser extends StatefulWidget {
  const HospitalVisitUser({super.key});

  @override
  State<HospitalVisitUser> createState() => _HospitalVisitUserState();
}

class _HospitalVisitUserState extends State<HospitalVisitUser>
    with AutomaticKeepAliveClientMixin {
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SearchField(searchController: searchController,onPressed: (value) {
            BlocProvider.of<VisitBloc>(context).add(SearchHospitalVisitEvent(value: value));},),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: BlocConsumer<VisitBloc, VisitState>(
                listener: (context, state) {
                  if (state is VisitHospitalErrorState) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      error(context, state.failure.massage, state.failure.code);
                    });
                  }
                  /*
                  if(state is AllPharmacyByPlaceLoadingState){
                    loading(context);
                  }
                  if(state is AllPharmacyByPlaceState){
                success(context);}
                 */
                },
                builder: (context, state) {
                  List<VisitHospitalAndHospital> hospitals=context.watch<VisitBloc>().hospitals;
                  if(state is VisitHospitalState){
                    hospitals=state.hospitals;
                  }
                  if (state is SearchVisitHospitalState) {
                    hospitals = state.hospitals;
                  }
                  if(state is EmptyVisitHospitalState){
                    return emptyFullScreen(context);
                  }
                  return ListView.builder(
                      itemBuilder: (context, index) {

                        return InkWell(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                                  return InfoVisitHospital(
                                    hospitalModel: hospitals[index],
                                  );
                                }));
                          },
                          child: Container(
                            margin: EdgeInsets.all(AppPadding.p8),
                            padding: EdgeInsets.all(AppPadding.p8),
                            //    height: AppSize.s150,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(color: ColorManager.secondaryColor4)
                              ],
                              color: ColorManager.white,
                              border: Border.all(color: ColorManager.hintGrey),
                              borderRadius: const BorderRadius.all(
                                  Radius.circular(AppSize.s8)),
                              //        color: ColorManager.card,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  textAlign: TextAlign.center,
                                  hospitals[index]
                                      .hospitalModel
                                      .title,
                                  style: Theme.of(context).textTheme.labelLarge,
                                ),
                                TextRach(
                                    s1: "العنوان : ",
                                    s2: hospitals[index]
                                        .hospitalModel
                                        .address)
                              ],
                            ),
                          ),
                        );
                      },
                      itemCount:
                      hospitals.length);
                }
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
