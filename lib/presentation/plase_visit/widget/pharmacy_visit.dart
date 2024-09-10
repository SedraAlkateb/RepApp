import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/plase_visit/bloc/place_visit_bloc.dart';
import 'package:domina_app/presentation/plase_visit/pages/visit_pharmacy.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/resources/values_manager.dart';
import 'package:domina_app/presentation/uniti/stateWidget.dart';
import 'package:domina_app/presentation/uniti/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PharmacyVisit extends StatelessWidget {
  const PharmacyVisit({super.key});
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal:8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Text("الصيدليات",),
            Expanded(
              child: BlocConsumer<PlaceVisitBloc, PlaceVisitState>(
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
                builder: (context, state) {
                  if(state is AllPharmacyByPlaceState){
                    List<PharmacyModel> pharmacyModel=state.pharmacy;
                    return ListView.builder
                      (
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              BlocProvider.of<PlaceVisitBloc>(context).add(BrandFlagEvent());
                              Navigator.push(context, MaterialPageRoute(builder: (context) {
                              return  VisitPharmacy(pharmacyModel: pharmacyModel[index],);
                              },));
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
                                  TextRach(s1: "الاسم : ", s2: pharmacyModel[index].title),
                                  TextRach(s1: "العنوان : ", s2: pharmacyModel[index].address)
                                ],
                              ),
                            ),
                          );
                        }, itemCount: pharmacyModel.length);
                  }
                  return SizedBox(
                  );
                },
              ),
            ),
          ],
        ),
      ),

    );
  }
}
