import 'package:domina_app/presentation/plase_visit/bloc/visit_place_bloc.dart';
import 'package:domina_app/presentation/plase_visit/widget/personal_order.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/resources/routes_manager.dart';
import 'package:domina_app/presentation/resources/values_manager.dart';
import 'package:domina_app/presentation/uniti/CustomDropDownSearch.dart';
import 'package:domina_app/presentation/uniti/CustomDropDownSearchSpec.dart';
import 'package:domina_app/presentation/uniti/box_filed.dart';
import 'package:domina_app/presentation/uniti/custom_dropdown.dart';
import 'package:domina_app/presentation/uniti/snack_bar_message.dart';
import 'package:domina_app/presentation/uniti/stateWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/models/models.dart';

class VisitHospital extends StatefulWidget {
  VisitHospital({super.key, required this.hospitalModel});
  final HospitalModel hospitalModel;

  @override
  State<VisitHospital> createState() => _VisitHospitalState();
}

class _VisitHospitalState extends State<VisitHospital>  with AutomaticKeepAliveClientMixin{
  final TextEditingController _noteController = TextEditingController();
  final TextEditingController _issueController = TextEditingController();
  final TextEditingController _noteeController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    BlocProvider.of<VisitPlaceBloc>(context).selectBrand = [];
    BlocProvider.of<VisitPlaceBloc>(context).visitBrandPharmacys = [];
    BlocProvider.of<VisitPlaceBloc>(context)
        .add(SpecializationHospitalEvent(widget.hospitalModel.id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: null,
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
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
                  padding:  EdgeInsets.symmetric(horizontal: AppPadding.p18),
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
                        widget.hospitalModel.title,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        textAlign: TextAlign.center,
                        "العنوان: ${widget.hospitalModel.address ?? " "}",
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
                    Text(
                      " ملاحظات للمكتب العلمي :",
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                    BoxTextField(
                      keyboardType: TextInputType.text,
                      prefixIcon: null,
                      maxLines: 4,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "الحقل مطلوب";
                        }
                        return null;
                      },
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
                      validator: (value) {
                        // if (value!.isEmpty) {
                        //   return "الحقل مطلوب";
                        // }
                        return null;
                      },
                      controller: _issueController,
                      obscureText: false,
                      minLines: 3,
                      inputFormatters: [],
                    ),
                    PersonalOrder(noteeController: _noteeController),
                    BlocBuilder<VisitPlaceBloc, VisitPlaceState>(
                      builder: (context, state) {
                        print("object");
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Checkbox(
                                  focusColor: ColorManager.secondaryColor,
                                  activeColor: ColorManager.secondaryColor4,
                                  value:
                                      context.read<VisitPlaceBloc>().isScience,
                                  splashRadius: 30,
                                  onChanged: (value) {
                                    BlocProvider.of<VisitPlaceBloc>(context)
                                        .add(IsScienceEvent(true));
                                  },
                                ),
                                Text('مكتب علمي'),
                              ],
                            ),
                            Row(
                              children: [
                                Checkbox(
                                  focusColor: ColorManager.secondaryColor,
                                  activeColor: ColorManager.secondaryColor4,
                                  value: !context
                                      .read<VisitPlaceBloc>()
                                      .isScience,
                                  onChanged: (value) {
                                    BlocProvider.of<VisitPlaceBloc>(context)
                                        .add(IsScienceEvent(false));
                                  },
                                ),
                                Text('مع الخطة'),
                              ],
                            ),
                          ],
                        );
                      },
                    ),
                    Text(
                      "اختر الاختصاص :",
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                    SizedBox(
                      height: 0.9,
                    ),
                    BlocListener<VisitPlaceBloc, VisitPlaceState>(
                      listener: (context, state) {
                        if (state is BrandFlagErrorState) {
                          error(context, state.failure.massage,
                              state.failure.code);
                        }
                      },
                      child: Customdropdownsearchspec(
                        hintText: "الاختصاصات",
                        items: context.watch<VisitPlaceBloc>().specialization,
                        onChanged: (value) {
                          SpecHospitalSp specModel = value;
                          BlocProvider.of<VisitPlaceBloc>(context)
                              .add(SelectSpecEvent(specModel));
                        },
                        validator: (value) {
                          if (value == null) {
                            return "اختر الاختصاص";
                          }
                          return null;
                        },
                        errorText: 'لايوجد نتيجة',
                      ),
                    ),
                    BlocBuilder<VisitPlaceBloc, VisitPlaceState>(
                      buildWhen: (previous, current) {
                        return current is SpecState;
                      },
                      builder: (context, state) {
                        if (state is SpecState) {
                          return Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: AppPadding.p8,
                                horizontal: AppPadding.p8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "اجمالي الزيارات : ${state.visits}",
                                  style:
                                      Theme.of(context).textTheme.headlineLarge,
                                ),
                                Text(
                                  "عدد الاطباء : ${state.total}",
                                  style:
                                      Theme.of(context).textTheme.headlineLarge,
                                ),
                              ],
                            ),
                          );
                        } else {
                          return Container(); // واجهة بديلة عند عدم تطابق الحالة
                        }
                      },
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
                          error(context, state.failure.massage,
                              state.failure.code);
                        }
                      },
                      child: CustomDropDownSearch(
                        hintText: "العينات",
                        items: context.watch<VisitPlaceBloc>().bandFlag,
                        onChanged: (value) {
                          BrandModel brand = value;
                          BlocProvider.of<VisitPlaceBloc>(context).add(
                              SelectBrandEvent(brand, widget.hospitalModel.id));
                        },
                        validator: (value) {
                          if (value == null ) {
                            return "اختر نوع الطلب";
                          }
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
                            state is DeleteBrandState ||
                            state is EditAmountBrandState) {
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
                                      ...selectBrand
                                          .asMap()
                                          .entries
                                          .map((entry) {
                                        final index = entry.key;
                                        final brand = entry.value;
                                        TextEditingController amount =
                                            TextEditingController();
                                        amount.text =
                                            visitBrand[index].amount.toString();
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
                                                controller: amount,
                                                onChanged: (value) {
                                                  if (value.isEmpty) {
                                                    BlocProvider.of<
                                                                VisitPlaceBloc>(
                                                            context)
                                                        .add(
                                                            EditAmountBrandEvent(
                                                                index, 1));
                                                  } else {
                                                    BlocProvider.of<
                                                                VisitPlaceBloc>(
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
                    SizedBox(
                      height: 8,
                    ),
                    BlocListener<VisitPlaceBloc, VisitPlaceState>(
                      listener: (context, state) {
                        if (state is InsertVisitHospitalErrorState) {
                          error(context, state.failure.massage,
                              state.failure.code);
                        }
                        if (state is InsertVisitHospitalState) {
                          success(context);
                          SnackBarMessage().showSuccessSnackBar(
                              message: "succsec",
                              context: context,
                              btnOkOnPress: "d");
                          Navigator.pushNamedAndRemoveUntil(
                            context, Routes.places,
                                (route) => false,
                          );
                        }
                        if (state is AllVisitBrandHospitalErrorState) {
                          error(context, state.failure.massage,
                              state.failure.code);}
                        if (state is AllVisitBrandHospitalState) {
                          success(context);
                          SnackBarMessage().showSuccessSnackBar(
                              message: "succsec",
                              context: context,
                              btnOkOnPress: "d");
                          Navigator.pushNamedAndRemoveUntil(
                            context, Routes.places,
                                (route) => false,
                          );
                        }
                      },
                      child: ElevatedButton(
                          onPressed: () {

                            if (_formKey.currentState!.validate())  {
                                DateTime now = DateTime.now();
                                //   String formattedTime = DateFormat('EEEE, dd-MM-yyyy – HH:mm', 'ar').format(now);
                                VisitHospitalModel visitHospitalModel =
                                    VisitHospitalModel(
                                        0,
                                        now.toIso8601String(),
                                        _issueController.text,
                                        _noteController.text,
                                        _noteeController.text,
                                        0);
                                if (context
                                    .read<VisitPlaceBloc>()
                                    .selectBrand
                                    .isNotEmpty) {
                                  BlocProvider.of<VisitPlaceBloc>(context).add(
                                      InsertBrandVisitHospitalEvent(
                                          visitHospitalModel,
                                          widget.hospitalModel.id));
                                } else {
                                  BlocProvider.of<VisitPlaceBloc>(context).add(
                                      InsertVisitHospitalEvent(
                                          visitHospitalModel,
                                          widget.hospitalModel.id));
                                }
                              }

                          },
                          child: Text("تمت الزيارة")),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override

  bool get wantKeepAlive => true;
}
