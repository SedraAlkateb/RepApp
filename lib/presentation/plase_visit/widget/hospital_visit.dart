import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/plase_visit/bloc/visit_place_bloc.dart';
import 'package:domina_app/presentation/plase_visit/pages/visit_hospital.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/resources/values_manager.dart';
import 'package:domina_app/presentation/uniti/search_field.dart';
import 'package:domina_app/presentation/uniti/stateWidget.dart';
import 'package:domina_app/presentation/uniti/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HospitalVisit extends StatefulWidget {
   HospitalVisit({super.key});

  @override
  State<HospitalVisit> createState() => _HospitalVisitState();
}

class _HospitalVisitState extends State<HospitalVisit> with AutomaticKeepAliveClientMixin  {
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return  Scaffold(
      body:  SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               SearchField(
              searchController: searchController,
              onPressed: (value) {
                BlocProvider.of<VisitPlaceBloc>(context)
                    .add(SearchHospitalVisitEvent(value: value));
              },
            ),
           Padding(
             padding: const EdgeInsets.symmetric(horizontal: 8),
             child: BlocConsumer<VisitPlaceBloc, VisitPlaceState>(
                    listener: (context, state) {
                      if(state is AllHospitalByPlaceErrorState){
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          error(context, state.failure.massage, state.failure.code);
                        });
                      }
                       
                    
                    },builder:(context, state) {List<HospitalModel>hospitals=context.watch<VisitPlaceBloc>().hospitals;
                      if (state is SearchVisitHospitalState) {
                        hospitals = state.hospitalVisit;
                      }
                      if (state is AllHospitalByPlaceState) {
                        hospitals = state.data;
                      }
                        return  ListView.builder
                    (
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) {
                              return VisitHospital(
                                hospitalModel: hospitals[index],
                              );
                            }));
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
                            child:
                            Column(
                              children: [
                                Text( hospitals[index].title,style: Theme.of(context).textTheme.labelLarge,),
                                TextRach(s1: "العنوان : ", s2: hospitals[index].address)
                              ],
                            ),
                          ),
                        );
                      }, itemCount:hospitals.length);
                       
                    }
                  ),
           ),
            
            ],
          ),
        ),
   

    );
  }
  
  @override
  bool get wantKeepAlive => true;
}
