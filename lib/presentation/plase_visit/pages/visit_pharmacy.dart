import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/plase_visit/bloc/visit_place_bloc.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/uniti/custom_dropdown.dart';
import 'package:domina_app/presentation/uniti/stateWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VisitPharmacy extends StatelessWidget {
  const VisitPharmacy({super.key, this.pharmacyModel});
  final PharmacyModel? pharmacyModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 250,
              decoration: BoxDecoration(
                color: ColorManager.secondaryColor,
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(50)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          iconSize: 30,
                          padding: EdgeInsets.only(right: 15),
                          icon: Icon(Icons.arrow_back_sharp,
                              color: ColorManager.white))),
                  Text(
                    pharmacyModel?.title ?? " ",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "عنوان الصيدلية : ${pharmacyModel?.address ?? " "}",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
            ),
            Padding(
              padding:  EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Column (
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "اختر العينات :",
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                  BlocConsumer<VisitPlaceBloc, VisitPlaceState>(
                    listener: (context, state) {
                      if(state is BrandFlagErrorState) {
                        error(context, state.failure.massage, state.failure.code);
                      }
                      },
                    builder: (context, state) {
                      if (state is BrandFlagState) {

                        return CustomDropDown(
                          hintText: "العينات",
                          items: context.watch<VisitPlaceBloc>().bandFlag,
                          prefixIcon: null,
                          onChanged: (value) {
                            BrandModel brand=value;
                            BlocProvider.of<VisitPlaceBloc>(context).add(SelectBrandEvent(brand));
                            },
                          validator: (value) {
                            return null;
                          },);
                      }
                      return CustomDropDown(
                        hintText: "العينات",
                        items:  context.read<VisitPlaceBloc>().bandFlag,
                        prefixIcon: null,
                        onChanged: (value) {
                          BrandModel brand=value;
                          BlocProvider.of<VisitPlaceBloc>(context).add(SelectBrandEvent(brand));
                        },
                        validator: (value) {
                          return null;
                        },
                      );
                    },
                  ),
                  BlocBuilder<VisitPlaceBloc, VisitPlaceState>(
  builder: (context, state) {
    if(state is SelectBrandState){
      print("ddddddddddddddddddddddddddddd");
    }
    return ListView.builder (
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount:context.watch<VisitPlaceBloc>().selectBrand.length ,
                    itemBuilder: (context, index) {
                      return    Text(context.watch<VisitPlaceBloc>().selectBrand[index].title,style: TextStyle(color: Colors.black,fontSize: 50),);
                      },
                  );
  },
)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
