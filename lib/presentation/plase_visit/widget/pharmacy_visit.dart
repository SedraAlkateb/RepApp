import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/plase_visit/bloc/visit_place_bloc.dart';
import 'package:domina_app/presentation/plase_visit/pages/visit_pharmacy.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/resources/values_manager.dart';
import 'package:domina_app/presentation/uniti/search_field.dart';
import 'package:domina_app/presentation/uniti/stateWidget.dart';
import 'package:domina_app/presentation/uniti/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PharmacyVisit extends StatefulWidget {
   PharmacyVisit({super.key});

  @override
  State<PharmacyVisit> createState() => _PharmacyVisitState();
}

class _PharmacyVisitState extends State<PharmacyVisit> with AutomaticKeepAliveClientMixin {
  final TextEditingController searchController = TextEditingController();

  @override
  bool get wantKeepAlive => true;


  @override
  Widget build(BuildContext context) {
      super.build(context); // مهم لإبقاء الحالة

    return  Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             SearchField(
              searchController: searchController,
              onPressed: (value) {
                BlocProvider.of<VisitPlaceBloc>(context)
                    .add(SearchPharmacyVisitEvent(value: value));
              },
            ),
            BlocConsumer<VisitPlaceBloc, VisitPlaceState>(
              listener: (context, state) {
                if(state is AllPharmacyByPlaceErrorState){
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
             builder:(context, state) {

              List<PharmacyModel> pharmacies=context.watch<VisitPlaceBloc>().pharmacies;
               if (state is SearchVisitPharmacyState) {
                    pharmacies = state.pharmasyVisit;
                  }
                  if (state is AllPharmacyByPlaceState) {
                    pharmacies = state.pharmacy;
                  }
return   Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: ListView.builder
                  (physics: NeverScrollableScrollPhysics(),
                   shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                            
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return VisitPharmacy(
                    pharmacyModel:pharmacies [index],
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
                            border:
                            Border.all(color: ColorManager.hintGrey),
                            borderRadius: const BorderRadius.all(
                                Radius.circular(AppSize.s8)),
                            //        color: ColorManager.card,
                          ),
                          child:
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                textAlign: TextAlign.center,
                                pharmacies[index].title,style: Theme.of(context).textTheme.labelLarge,),
                              TextRach(s1: "العنوان : ", s2:  pharmacies[index].address)
                            ],
                          ),
                        ),
                      );
                    }, itemCount:  pharmacies.length),
              );
           
             }
             ),
          ],
        ),
      ),

    );
  }
}
