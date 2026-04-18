// ignore_for_file: deprecated_member_use

import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/plase_visit/bloc/visit_place_bloc.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/resources/values_manager.dart';
import 'package:domina_app/presentation/uniti/CustomDropDownSearch.dart';
import 'package:domina_app/presentation/uniti/box_text_field.dart';
import 'package:domina_app/presentation/uniti/custom_dropdown.dart';
import 'package:domina_app/presentation/uniti/dialog_wid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PersonalOrder extends StatelessWidget {
  const PersonalOrder({super.key, required this.noteeController});
  final TextEditingController noteeController;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "طلبات شخصية:",
          style: Theme.of(context).textTheme.labelLarge,
        ),
        SizedBox(
          height: AppSize.s8,
        ),
        CustomDropDown(
          hintText: "لا شييء",
          items: type,
          prefixIcon: null,
          onChanged: (value) {
            noteeController.text = "";
            BlocProvider.of<VisitPlaceBloc>(context).br = "";
            BlocProvider.of<VisitPlaceBloc>(context).selectAddBrand = [];
            BlocProvider.of<VisitPlaceBloc>(context)
                .add(TypeAdditionEvent(value));
          },
          validator: (value) {
            // if (value == null ) {
            //   return "اختر نوع الطلب";
            // }
            return null;
          },
          errorText: '',
        ),
        Padding(
          padding:  EdgeInsets.only(top: AppPaddingH.p12),
          child: BlocBuilder<VisitPlaceBloc, VisitPlaceState>(
            buildWhen: (previous, current) {
              return current is BoxState ||
                  current is DropDownState ||
                  current is NothingState;
            },
            builder: (context, state) {
              if (state is BoxState) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "اكتب ملاحظاتك:",
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                    SizedBox(height: 8,),
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
                      controller: noteeController,
                      obscureText: false,
                      minLines: 3,
                      inputFormatters: [],
                      function: (p0) {
                        BlocProvider.of<VisitPlaceBloc>(context)
                            .add(BoxAddEvent(p0));
                      },
                    ),
                  ],
                );
              }
              if (state is DropDownState) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "اختر عينات: ",
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                    CustomDropDownSearch(
                      hintText: "العينات",
                      items: context.watch<VisitPlaceBloc>().allBandFlag,
                      onChanged: (value) {
                        BrandModel brand = value;
                        BlocProvider.of<VisitPlaceBloc>(context)
                            .add(SelectBrandAdditionAddEvent(brand));
                      },
                      validator: (value) {
                        if (value == null) {
                          return "اختر العينات";
                        }
                        return null;
                      },
                      errorText: 'لايوجد نتيجة',
                    ),
                    BlocConsumer<VisitPlaceBloc, VisitPlaceState>(
                      listenWhen: (previous, current) {
                        return current is SelectBrandAddState;
                      },
                      buildWhen: (previous, current) {
                        return current is SelectBrandAddNumState|| current is DeleteBrandAddState;
                      },
                      listener: (context, state) {
                        if (state is SelectBrandAddState) {
                          showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (context) => WillPopScope(
                                    onWillPop: () async => false,
                                    child: DialogFilter(
                                      text: "اختر عدد العينات",
                                    ),
                                  ));
                        }
                      },
                      builder: (context, state) {
                        List<BrandAddition> selectBrand =
                            context.watch<VisitPlaceBloc>().selectAddBrand;
                        if (state is SelectBrandAddNumState) {
                          selectBrand = state.brands;
                        }
                        if(state is DeleteBrandAddState){
                          selectBrand = state.brands;
                        }
                        return selectBrand.isNotEmpty
                            ? Padding(
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
                                    ...selectBrand.asMap().entries.map((entry) {
                                      final brand = entry.value;
                                      return TableRow(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8),
                                            child: Text(
                                              brand.title,
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8),
                                            child: Text(brand.phTitle,
                                                textAlign: TextAlign.center),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8),
                                            child: Text(
                                              brand.amount.toString(),
                                              textAlign: TextAlign.center,
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
                                                      .add(
                                                          RemoveBrandAdditionEvent(
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
                      },
                    ),
                  ],
                );
              }
              if (state is NothingState) {
                return SizedBox();
              }
              return SizedBox();
            },
          ),
        ),
      ],
    );
  }
}
