import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/plase_visit/bloc/visit_place_bloc.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/resources/values_manager.dart';
import 'package:domina_app/presentation/uniti/box_filed.dart';
import 'package:domina_app/presentation/uniti/custom_dropdown.dart';
import 'package:domina_app/presentation/uniti/stateWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VisitPharmacy extends StatefulWidget {
  VisitPharmacy({super.key, required this.pharmacyModel});
  final PharmacyModel pharmacyModel;
  final TextEditingController _noteController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  State<VisitPharmacy> createState() => _VisitPharmacyState();
}

class _VisitPharmacyState extends State<VisitPharmacy> {
  final TextEditingController _noteController = TextEditingController();
@override
  void initState() {
    BlocProvider.of<VisitPlaceBloc>(context).selectBrand=[];
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 250,
              decoration: BoxDecoration(
                color: ColorManager.secondaryColor1,
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(50)),
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
                   widget.pharmacyModel.title,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "عنوان الصيدلية : ${widget.pharmacyModel.address}",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "أضف ملاحظاتك :",
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                  BoxTextField(
                    keyboardType: TextInputType.text,
                    prefixIcon: null,
                    maxLines: 4,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'ادخل الملاخطاتك من فضلك';
                      }
                    },
                    controller: _noteController,
                    obscureText: false,
                    minLines: 3,
                    inputFormatters: [],
                  ),
                  Text(
                    "اختر العينات :",
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                  BlocListener<VisitPlaceBloc, VisitPlaceState>(
                    listener: (context, state) {
                      if (state is BrandFlagErrorState) {
                        print("object");
                        error(
                            context, state.failure.massage, state.failure.code);
                      }
                    },
                    child: CustomDropDown(
                      hintText: "العينات",
                      items: context.watch<VisitPlaceBloc>().bandFlag,
                      prefixIcon: null,
                      onChanged: (value) {
                        BrandModel brand = value;
                        BlocProvider.of<VisitPlaceBloc>(context)
                            .add(SelectBrandEvent(brand,widget.pharmacyModel.id));
                      },
                      validator: (value) {
                        return null;
                      },
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  BlocBuilder<VisitPlaceBloc, VisitPlaceState>(
                    builder: (context, state) {
                      final selectBrand =
                          context.watch<VisitPlaceBloc>().selectBrand;
                      if(state is SelectBrandState){
                        return selectBrand.isNotEmpty? Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Table(
                            border: TableBorder.all(),
                            columnWidths: {
                              0: FlexColumnWidth(1),
                              1: FlexColumnWidth(1),
                              2: FlexColumnWidth(1),
                              3: FlexColumnWidth(1),
                            },
                            children: [
                              TableRow(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Center(
                                      child: Text('العينات',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Center(
                                      child: Text('نوع العينة',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Center(
                                      child: Text('الكمية',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),

                                  ),
                                ],
                              ),
                              ...selectBrand.asMap().entries.map((entry) {
                                final index = entry.key;
                                final brand = entry.value;
                                return TableRow(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8),
                                      child: Text(
                                        brand.title,
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8),
                                      child: Text(brand.phTitle, textAlign: TextAlign.center),
                                    ),
                                    IntrinsicHeight(
                                      child: TextField(
                                        onChanged: (value) {
                                          BlocProvider.of<VisitPlaceBloc>(context).add(EditAmountBrandEvent(index, int.parse(value)));
                                        },
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                          hintText: '1',
                                          hintStyle: Theme.of(context).textTheme.labelSmall,
                                          errorText: null,
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.transparent,
                                              width: AppSize.s1_5,
                                            ),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.transparent,
                                              width: AppSize.s1_5,
                                            ),
                                          ),
                                          focusedErrorBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.transparent,
                                              width: AppSize.s1_5,
                                            ),
                                          ),
                                          fillColor: ColorManager.white,
                                          filled: true,
                                        ),
                                        cursorColor: Colors.black,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Center(
                                        child: IconButton(
                                          icon: Icon(Icons.delete),
                                          onPressed: () {},
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              }).toList(),

                            ],
                          ),
                        ):SizedBox();
                      }
                      return  SizedBox();
                    },
                  ),
                  BlocListener<VisitPlaceBloc, VisitPlaceState>(
  listener: (context, state) {
   if(state is InsertVisitPharmacyLoadingState){
     loading(context);
   }
   if(state is InsertVisitPharmacyErrorState){
     error(context,state.failure.massage,state.failure.code);
   }
   if(state is InsertVisitPharmacyState){
     success(context);
   }
   if(state is AllVisitBrandPharmacyLoadingState){
     loading(context);
   }
   if(state is AllVisitBrandPharmacyErrorState){
     error(context,state.failure.massage,state.failure.code);
   }
   if(state is AllVisitBrandPharmacyState){
     success(context);
   }
  },
  child: ElevatedButton(
      onPressed: (){
                    if(_noteController.text.isNotEmpty){
                      DateTime now = DateTime.now();
                      VisitPharmacyModel visitPharmacyModel= VisitPharmacyModel(0,
                          now.toString()
                          , _noteController.text, widget.pharmacyModel.id);
                      if(context.read<VisitPlaceBloc>().selectBrand.isNotEmpty){

                        BlocProvider.of<VisitPlaceBloc>(context).add(InsertBrandVisitEvent(visitPharmacyModel));
                      }else{
                        BlocProvider.of<VisitPlaceBloc>(context).add(InsertVisitPharmacyEvent(visitPharmacyModel));
                      }
                    }
                  }, child: Text("ارسال")),
)                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}



