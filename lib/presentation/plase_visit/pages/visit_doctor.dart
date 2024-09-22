import 'package:domina_app/presentation/plase_visit/bloc/visit_place_bloc.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/resources/values_manager.dart';
import 'package:domina_app/presentation/uniti/CustomDropDownSearch.dart';
import 'package:domina_app/presentation/uniti/box_filed.dart';
import 'package:domina_app/presentation/uniti/stateWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/models/models.dart';

class VisitDoctor extends StatefulWidget {
  VisitDoctor({super.key, required this.doctorModel});
  final DoctorModel doctorModel;

  @override
  State<VisitDoctor> createState() => _VisitDoctorState();
}

class _VisitDoctorState extends State<VisitDoctor> {
  final TextEditingController _noteController = TextEditingController();

  final TextEditingController _issueController = TextEditingController();

  final TextEditingController _noteeController = TextEditingController();
  @override
  void initState() {
    BlocProvider.of<VisitPlaceBloc>(context).selectBrand = [];
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
                  Center(
                    child: Text(
                      widget.doctorModel.title,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: Text(
                      "العنوان: ${widget.doctorModel?.address ?? " "}",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
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
                    " ملاحظات للمكتب العلمي :",
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
                  ),
                  Text(
                    "ملاحظات لمستودع قاسيون  :",
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                  BoxTextField(
                    keyboardType: TextInputType.text,
                    prefixIcon: null,
                    maxLines: 4,
                    validator: (value) {},
                    controller: _issueController,
                    obscureText: false,
                    minLines: 3,
                    inputFormatters: [],
                  ),
                  Text(
                    "طلبات شخصية:",
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                  BoxTextField(
                    keyboardType: TextInputType.text,
                    prefixIcon: null,
                    maxLines: 4,
                    validator: (value) {},
                    controller: _noteeController,
                    obscureText: false,
                    minLines: 3,
                    inputFormatters: [],
                  ),
                  Text(
                    "اختر العينات :",
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                  SizedBox(
                    height: 0.9,
                  ),
                  BlocListener<VisitPlaceBloc, VisitPlaceState>(
                    listener: (context, state) {
                      if (state is BrandFlagErrorState) {
                        print("object");
                        error(
                            context, state.failure.massage, state.failure.code);
                      }
                    },
                    child: CustomDropDownSearch(
                      hintText: "العينات",
                      items: context.watch<VisitPlaceBloc>().bandFlag,
                      onChanged: (value) {
                        BrandModel brand = value;
                        BlocProvider.of<VisitPlaceBloc>(context).add(
                            SelectBrandEvent(brand, widget.doctorModel.id));
                      },
                      validator: (value) {
                        return null;
                      },
                      errorText: 'لايوجد نتيجة',
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  BlocBuilder<VisitPlaceBloc, VisitPlaceState>(
                    builder: (context, state) {
                      final selectBrand =
                          context.watch<VisitPlaceBloc>().selectBrand;
                      final visitBrand =
                          context.watch<VisitPlaceBloc>().visitBrandPharmacys;

                      if (state is SelectBrandState ||
                          state is DeleteBrandState||state is  EditAmountBrandState) {
                        print(
                            "gggggggeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeggggggg");
                        return selectBrand.isNotEmpty
                            ? Padding(
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
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Center(
                                      child: Text('حذف العينة',
                                          style: TextStyle(
                                              fontWeight:
                                              FontWeight.bold)),
                                    ),
                                  ),
                                ],
                              ),
                              ...selectBrand.asMap().entries.map((entry) {
                                final index = entry.key;
                                final brand = entry.value;
                                TextEditingController amount=TextEditingController();
                                amount.text=visitBrand[index].amount.toString();
                                return TableRow(
                                  children: [
                                    Padding(
                                      padding:
                                      const EdgeInsets.only(top: 8),
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
                                    IntrinsicHeight(
                                      child: TextField(
                                        controller:amount ,
                                        onChanged: (value) {
                                          if (value.isEmpty) {
                                            BlocProvider.of<
                                                VisitPlaceBloc>(
                                                context)
                                                .add(EditAmountBrandEvent(
                                                index, 1));
                                          } else {
                                            BlocProvider.of<
                                                VisitPlaceBloc>(
                                                context)
                                                .add(EditAmountBrandEvent(
                                                index,
                                                int.parse(value)));
                                          }
                                        },
                                        keyboardType:
                                        TextInputType.number,
                                        decoration: InputDecoration(
                                          hintText: '1',
                                          hintStyle: Theme.of(context)
                                              .textTheme
                                              .labelSmall,
                                          errorText: null,
                                          enabledBorder:
                                          OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.transparent,
                                              width: AppSize.s1_5,
                                            ),
                                          ),
                                          focusedBorder:
                                          OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.transparent,
                                              width: AppSize.s1_5,
                                            ),
                                          ),
                                          focusedErrorBorder:
                                          OutlineInputBorder(
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
                                          color: const Color.fromARGB(
                                              255, 155, 23, 14),
                                          icon:
                                          Icon(Icons.delete_forever),
                                          onPressed: () {
                                            BlocProvider.of<
                                                VisitPlaceBloc>(
                                                context)
                                                .add(RemoveBrandEvent(
                                                brand));
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              }).toList(),
                            ],
                          ),
                        )
                            : SizedBox();
                      }
                      return SizedBox();
                    },
                  ),
                  ElevatedButton(
                      onPressed: () {
                        if (_noteController.text.isNotEmpty ||
                            context
                                .read<VisitPlaceBloc>()
                                .selectBrand
                                .isNotEmpty) {
                          DateTime now = DateTime.now();
                          VisitDoctorModel visitDoctorModel = VisitDoctorModel(
                              0,
                              now.toString(),
                              _noteController.text,
                              _noteController.text,
                              _noteController.text,
                              widget.doctorModel.id);
                          BlocProvider.of<VisitPlaceBloc>(context)
                              .add(InsertVisitDoctorEvent(visitDoctorModel));
                        }
                      },
                      child: Text("تمت الزيارة"))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
