import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/resources/values_manager.dart';
import 'package:domina_app/presentation/uniti/box_filed.dart';
import 'package:domina_app/presentation/visits/bloc/visit_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InfoVisitHospital extends StatefulWidget {
  InfoVisitHospital({super.key, required this.hospitalModel});
  final VisitHospitalAndHospital hospitalModel;

  @override
  State<InfoVisitHospital> createState() => _InfoVisitPharmacyState();
}

class _InfoVisitPharmacyState extends State<InfoVisitHospital> {
  final TextEditingController _noteController = TextEditingController();
  final TextEditingController _issueController = TextEditingController();
  final TextEditingController _noteeController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    _noteController.text=widget.hospitalModel.visitHospitalModel.science;
    _issueController.text=widget.hospitalModel.visitHospitalModel.kaswn;
    _noteeController.text=widget.hospitalModel.visitHospitalModel.additaion;
    BlocProvider.of<VisitBloc>(context).add(BrandHospitalVisitEvent(widget.hospitalModel.visitHospitalModel.id) );
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
              child:Padding(
                padding:  EdgeInsets.symmetric(horizontal: AppPadding.p18),
                child: Form(
                  key: _formKey,
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
                        textAlign: TextAlign.center,
                        widget.hospitalModel.hospitalModel.title,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(textAlign: TextAlign.center,
                        "العنوان : ${widget.hospitalModel.hospitalModel.address}",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Text(
                        textAlign: TextAlign.center,
                        "تاريخ الزيارة : ${widget.hospitalModel.visitHospitalModel.data}",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Text(
                        textAlign: TextAlign.center,
                        " الاختصاص : ${widget.hospitalModel.specModel.title}",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    " الملاحظات :",
                    style: Theme.of(context).textTheme.labelLarge,
                  ),

                  BoxTextField(
                    keyboardType: TextInputType.text,
                    prefixIcon: null,
                    maxLines: 4,
                    validator: (value) {},
                    controller: _noteController,
                    obscureText: false,
                    minLines: 3,
                    inputFormatters: [],
                    enabled: true,
                  ),
                  Text(
                    "ملاحظات لمستودع قاسيون  :",
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                  BoxTextField(
                    keyboardType: TextInputType.text,
                    prefixIcon: null,
                    maxLines: 4,
                    validator: (value) {
                      return null;
                    },
                    enabled: true,
                    controller: _issueController,
                    obscureText: false,
                    minLines: 3,
                    inputFormatters: [],
                  ),

                  _noteeController .text.isNotEmpty?
                  Column(
                    children: [
                      Text(
                        "طلبات شخصية:",
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                      BoxTextField(
                        keyboardType: TextInputType.text,
                        prefixIcon: null,
                        maxLines: 4,
                        validator: (value) {
                          return null;
                        },
                        controller: _noteeController,
                        obscureText: false,
                        minLines: 3,
                        inputFormatters: [],
                        enabled: true,
                      ),
                    ],
                  ):SizedBox(),
                  Text(
                    " العينات :",
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  BlocBuilder<VisitBloc, VisitState>(
                    builder: (context, state) {
                       List<PharmacyBrandModel> selectBrand =
                          context.watch<VisitBloc>().brands;
                      if (state is BrandPharmacyVisitState) {
                        selectBrand =state.brands;
                      }
                      return selectBrand.isNotEmpty
                          ? Padding(
                        padding: const EdgeInsets.all(10),

                        child: Table(
                          border: TableBorder.all(),
                          columnWidths: {
                            0: FlexColumnWidth(1),
                            1: FlexColumnWidth(1),
                            2: FlexColumnWidth(1),
                          },
                          children: [
                            TableRow(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Center(
                                    child: Text('العينات',
                                        style: TextStyle(
                                            fontWeight:
                                            FontWeight.bold)),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center(
                                    child: Text('نوع العينة',
                                        style: TextStyle(
                                            fontWeight:
                                            FontWeight.bold)),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center(
                                    child: Text('الكمية',
                                        style: TextStyle(
                                            fontWeight:
                                            FontWeight.bold)),
                                  ),
                                ),

                              ],
                            ),
                            ...selectBrand.asMap().entries.map((entry) {
                          //    final index = entry.key;
                              final brand = entry.value;
                              return TableRow(
                                children: [
                                  Padding(
                                    padding:
                                    const EdgeInsets.symmetric(vertical: 8),
                                    child: Text(
                                      brand.title,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                    const EdgeInsets.only(top: 8),
                                    child: Text(brand.phTitle,
                                        textAlign: TextAlign.center),
                                  ),
                                  Padding(
                                    padding:
                                    const EdgeInsets.only(top: 8),
                                    child: Text(brand.amount.toString(),
                                        textAlign: TextAlign.center),
                                  ),

                                ],
                              );
                            }).toList(),
                          ],
                        ),
                      )
                          : SizedBox();
                    },
                  ),
              /*
                  BlocListener<VisitBloc, VisitState>(
                    listener: (context, state) {
                      if(state is UpdateVisitHospitalState){
                        Navigator.pop(context);
                      }
                    },
                    child:
                    ElevatedButton( onPressed: () {
                      BlocProvider.of<VisitBloc>(context).add(
                          UpdateVisitHospitalEvent
                            (kas: _issueController.text,sc: _noteController.text, id: widget.hospitalModel .visitHospitalModel.id));
                    }, child: Text("تعديل")),
                  )
               */
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
