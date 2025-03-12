import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/resources/values_manager.dart';
import 'package:domina_app/presentation/uniti/CustomDropDownSearch.dart';
import 'package:domina_app/presentation/uniti/box_filed.dart';
import 'package:domina_app/presentation/uniti/stateWidget.dart';
import 'package:domina_app/presentation/uniti/time.dart';
import 'package:domina_app/presentation/visits/bloc/visit_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InfoVisitDoctor extends StatefulWidget {
  InfoVisitDoctor({super.key, required this.doctorModel});
  final VisitDoctorAndDoctor doctorModel;
  @override
  State<InfoVisitDoctor> createState() => _InfoVisitPharmacyState();
}

class _InfoVisitPharmacyState extends State<InfoVisitDoctor> {
  final TextEditingController _noteController = TextEditingController();
  final TextEditingController _issueController = TextEditingController();
  final TextEditingController _noteeController = TextEditingController();
  final TextEditingController _targetController = TextEditingController();

  @override
  void initState() {
    _noteController.text = widget.doctorModel.visitDoctorModel.science ?? "";
    _issueController.text = widget.doctorModel.visitDoctorModel.kaswn ?? "";
    _noteeController.text = widget.doctorModel.visitDoctorModel.additaion ?? "";
    _targetController.text = widget.doctorModel.visitDoctorModel.target ?? "";
    print(_targetController.text);
    BlocProvider.of<VisitBloc>(context)
        .add(BrandDoctorVisitEvent(widget.doctorModel.visitDoctorModel.id));
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
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: AppPadding.p18),
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
                      widget.doctorModel.doctorModel.title,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      textAlign: TextAlign.center,
                      "عنوان الطبيب : ${widget.doctorModel.doctorModel.address}",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Text(
                      "تاريخ الزيارة : \n${formatDateTime(widget.doctorModel.visitDoctorModel.data)}",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _targetController.text.isNotEmpty
                      ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "الهدف من الزيارة:",
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                      SizedBox(
                        height: AppSize.s8,
                      ),
                      BoxTextField(
                        enabled:
                        widget.doctorModel.visitDoctorModel.flag == 0
                            ? false
                            : true,
                        keyboardType: TextInputType.text,
                        prefixIcon: null,
                        maxLines: 4,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "الحقل مطلوب";
                          }
                          return null;
                        },
                        controller: _targetController,
                        obscureText: false,
                        minLines: 3,
                        inputFormatters: [],
                      ),
                    ],
                  )
                      : SizedBox(),
                  _issueController.text.isNotEmpty
                      ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        " ملاحظات لمستودع قاسيون :",
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                      BoxTextField(
                        keyboardType: TextInputType.text,
                        prefixIcon: null,
                        maxLines: 4,
                        validator: (value) {
                          return null;
                        },
                        controller: _issueController,
                        obscureText: false,
                        minLines: 3,
                        inputFormatters: [],
                        enabled:
                        widget.doctorModel.visitDoctorModel.flag == 0
                            ? false
                            : true,
                      ),
                    ],
                  )
                      : SizedBox(),
                  _noteController.text.isNotEmpty
                      ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "ملاحظات للمكتب العلمي :",
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                      BoxTextField(
                        keyboardType: TextInputType.text,
                        prefixIcon: null,
                        maxLines: 4,
                        validator: (value) {
                          return null;
                        },
                        enabled:
                        widget.doctorModel.visitDoctorModel.flag == 0
                            ? false
                            : true,
                        controller: _noteController,
                        obscureText: false,
                        minLines: 3,
                        inputFormatters: [],
                      ),
                    ],
                  )
                      : SizedBox(),
                  _noteeController.text.isNotEmpty
                      ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "طلبات شخصية:",
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                      BoxTextField(
                        enabled: true,
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
                      ),
                    ],
                  )
                      : SizedBox(),
                  widget.doctorModel.visitDoctorModel.flag ==0?
                  BlocBuilder<VisitBloc, VisitState>(
                    builder: (context, state) {
                      return Row(
                        children: [
                          Checkbox(
                            focusColor: ColorManager.secondaryColor,
                            activeColor: ColorManager.secondaryColor2,
                            value: context.read<VisitBloc>().isBrand,
                            onChanged: (value) {
                              BlocProvider.of<VisitBloc>(context)
                                  .add(IsBrandEvent());
                            },
                          ),
                          Text('لم يتم توزيع العينات'),
                        ],
                      );
                    },
                  ):SizedBox(),
                  context.read<VisitBloc>().isBrand == false?
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: AppSize.s8,
                      ),
                      widget.doctorModel.visitDoctorModel.flag ==
                          1?
                      ///////////////////////////////ss
                      BlocBuilder<VisitBloc, VisitState>(
                        buildWhen: (previous, current) {
                          return current is SelectBrandState ||
                              current is DeleteBrandState ||
                              current is BrandPharmacyVisitState ||
                              current is EditAmountBrandState;
                        },
                        builder: (context, state) {
                          List<PharmacyBrandModel> selectBrand =
                              context.watch<VisitBloc>().brands;
                          if (state
                          is BrandPharmacyVisitState) {
                            selectBrand = state.brands;
                          }
                          return selectBrand.isNotEmpty ?
                          BlocBuilder<VisitBloc, VisitState>(
                            builder: (context, state) {

                              return selectBrand.isNotEmpty
                                  ? Padding(
                                  padding:
                                  const EdgeInsets.all(8.0),
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
                                              padding:
                                              const EdgeInsets
                                                  .all(8.0),
                                              child: Center(
                                                child: Text(
                                                    'العينات',
                                                    style: TextStyle(
                                                        fontWeight:
                                                        FontWeight.bold)),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                              const EdgeInsets
                                                  .all(8.0),
                                              child: Center(
                                                child: Text(
                                                    'نوع العينة',
                                                    style: TextStyle(
                                                        fontWeight:
                                                        FontWeight.bold)),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                              const EdgeInsets
                                                  .all(8.0),
                                              child: Center(
                                                child: Text(
                                                    'الكمية',
                                                    style: TextStyle(
                                                        fontWeight:
                                                        FontWeight.bold)),
                                              ),
                                            ),
                                          ],
                                        ),
                                        ...selectBrand
                                            .asMap()
                                            .entries
                                            .map((entry) {
                                          //    final index = entry.key;
                                          final brand =
                                              entry.value;
                                          return TableRow(
                                            children: [
                                              Padding(
                                                padding:
                                                const EdgeInsets
                                                    .only(
                                                    top: 8),
                                                child: Text(
                                                  brand.title,
                                                  textAlign:
                                                  TextAlign
                                                      .center,
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                const EdgeInsets
                                                    .only(
                                                    top: 8),
                                                child: Text(
                                                    brand
                                                        .phTitle,
                                                    textAlign:
                                                    TextAlign
                                                        .center),
                                              ),
                                              Padding(
                                                padding:
                                                const EdgeInsets
                                                    .only(
                                                    top: 8),
                                                child: Text(
                                                  brand.amount
                                                      .toString(),
                                                  textAlign:
                                                  TextAlign
                                                      .center,
                                                ),
                                              ),
                                            ],
                                          );
                                        })
                                      ]))
                                  : SizedBox();
                            },
                          )
                              : SizedBox();
                        },
                      ):
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            "اختر العينات المقدمة:",
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                          BlocListener<VisitBloc, VisitState>(
                            listener: (context, state) {
                              if (state is BrandFlagErrorState) {
                                print("object");
                                error(context, state.failure.massage,
                                    state.failure.code);
                              }
                            },
                            child: CustomDropDownSearch(
                              hintText: "العينات",
                              items: context.watch<VisitBloc>().bandFlag,
                              onChanged: (value) {
                                BrandModel brand = value;
                                BlocProvider.of<VisitBloc>(context)
                                    .add(SelectBrandEvent(brand));
                              },
                              validator: (value) {
                                if (value == null) {
                                  return "اختر نوع الطلب";
                                }
                                return null;
                              },
                              errorText: 'لايوجد نتيجة',
                            ),
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          Text(
                            " العينات :",
                            style: Theme.of(context).textTheme.labelLarge,
                          )

                          ,
                          BlocBuilder<VisitBloc, VisitState>(
                            buildWhen: (previous, current) {
                              return current is SelectBrandState ||
                                  current is DeleteBrandState ||
                                  current is BrandPharmacyVisitState ||
                                  current is EditAmountBrandState;
                            },
                            builder: (context, state) {
                              List<PharmacyBrandModel> selectBrand =
                                  context.watch<VisitBloc>().brands;
                              if (state
                              is BrandPharmacyVisitState) {
                                selectBrand = state.brands;
                              }
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Table(
                                  border: TableBorder.all(
                                      width: 1,
                                      color: ColorManager.grey1,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(15))),
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
                                          padding: const EdgeInsets.all(15),
                                          child: Center(
                                            child: Text('العينات',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontWeight:
                                                    FontWeight.bold)),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(15),
                                          child: Center(
                                            child: Text('نوع العينة',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontWeight:
                                                    FontWeight.bold)),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(15),
                                          child: Center(
                                            child: Text('الكمية',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontWeight:
                                                    FontWeight.bold)),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(15),
                                          child: Center(
                                            child: Text('حذف العينة',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontWeight:
                                                    FontWeight.bold)),
                                          ),
                                        ),
                                      ],
                                    ),
                                    ...selectBrand
                                        .asMap()
                                        .entries
                                        .map((entry) {
                                      final index = entry.key;
                                      final brand = entry.value;
                                      TextEditingController amount =
                                      TextEditingController();
                                      amount.text = selectBrand[index]
                                          .amount
                                          .toString();
                                      return TableRow(
                                        children: [
                                          Padding(
                                            padding:
                                            const EdgeInsets.all(8),
                                            child: Text(
                                              brand.title,
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                            const EdgeInsets.all(8),
                                            child: Text(brand.phTitle,
                                                textAlign:
                                                TextAlign.center),
                                          ),
                                          IntrinsicHeight(
                                            child: TextField(
                                              controller: amount,
                                              onChanged: (value) {
                                                if (value.isEmpty) {
                                                  BlocProvider.of<
                                                      VisitBloc>(
                                                      context)
                                                      .add(
                                                      EditAmountBrandEvent(
                                                          index, 1));
                                                } else {
                                                  BlocProvider.of<
                                                      VisitBloc>(
                                                      context)
                                                      .add(
                                                      EditAmountBrandEvent(
                                                          index,
                                                          int.parse(
                                                              value)));
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
                                                    color:
                                                    Colors.transparent,
                                                    width: AppSize.s1_5,
                                                  ),
                                                ),
                                                focusedBorder:
                                                OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color:
                                                    Colors.transparent,
                                                    width: AppSize.s1_5,
                                                  ),
                                                ),
                                                focusedErrorBorder:
                                                OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color:
                                                    Colors.transparent,
                                                    width: AppSize.s1_5,
                                                  ),
                                                ),
                                                fillColor:
                                                ColorManager.white,
                                                filled: true,
                                              ),
                                              cursorColor: Colors.black,
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                            const EdgeInsets.all(8.0),
                                            child: Center(
                                              child: IconButton(
                                                color: const Color.fromARGB(
                                                    255, 155, 23, 14),
                                                icon: Icon(
                                                    Icons.delete_forever),
                                                onPressed: () {
                                                  BlocProvider.of<
                                                      VisitBloc>(
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
                              );
                            },
                          )

                        ],
                      ),

                    ],
                  ):  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.circle,
                        color: ColorManager.secondaryColor1,
                      ),
                      Text(
                        " لم يتم توزيع عينات ",
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                    ],
                  ),

                  BlocListener<VisitBloc, VisitState>(
                    listener: (context, state) {
                      if (state is UpdateVisitDoctorState) {
                        Navigator.pop(context);
                        BlocProvider.of<VisitBloc>(context)
                            .add(VisitDoctorEvent());
                      }
                    },
                    child: ElevatedButton(
                        onPressed: () {
                          widget.doctorModel.visitDoctorModel.flag == 0
                              ? BlocProvider.of<VisitBloc>(context).add(
                              UpdateVisitDoctorEvent(
                                  kas: _issueController.text,
                                  sc: _noteController.text,
                                  id: widget
                                      .doctorModel.visitDoctorModel.id,
                                  target: _targetController.text))
                              : null;
                        },
                        child: Text("تعديل")),
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
