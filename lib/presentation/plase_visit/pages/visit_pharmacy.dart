import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/plase_visit/bloc/place_visit_bloc.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/resources/values_manager.dart';
import 'package:domina_app/presentation/uniti/custom_dropdown.dart';
import 'package:domina_app/presentation/uniti/stateWidget.dart';
import 'package:domina_app/presentation/uniti/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VisitPharmacy extends StatelessWidget {
  const VisitPharmacy({super.key, this.pharmacyModel});
  final PharmacyModel? pharmacyModel;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Column(
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
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "اختر العينات :",
                  style: Theme.of(context).textTheme.labelLarge,
                ),
                BlocConsumer<PlaceVisitBloc, PlaceVisitState>(
                  listener: (context, state) {
                    if (state is BrandFlagErrorState) {
                      error(context, state.failure.massage, state.failure.code);
                    }
                  },
                  builder: (context, state) {
                    if (state is BrandFlagState) {
                      List<BrandModel>    brands = state.brands;
                      return CustomDropDown(

                        hintText: "العينات",
                        items: brands,
                        prefixIcon: null,
                        onChanged: (value) {},
                        validator: (value) {},
                      );
                    }
                    return CustomDropDown(
                      hintText: "العينات",
                      items: [],
                      prefixIcon: null,
                      onChanged: (value) {
                        BrandModel brand=value;
                        BlocProvider.of<PlaceVisitBloc>(context).add(SelectBrandEvent(brand));
                      },
                      validator: (value) {},
                    );
                  },
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
