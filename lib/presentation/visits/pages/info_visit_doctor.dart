import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/resources/values_manager.dart';
import 'package:domina_app/presentation/uniti/CustomDropDownSearch.dart';
import 'package:domina_app/presentation/uniti/box_filed.dart';
import 'package:domina_app/presentation/uniti/stateWidget.dart';
import 'package:domina_app/presentation/uniti/time.dart';
import 'package:domina_app/presentation/visits/bloc/visit_bloc.dart';
import 'package:domina_app/presentation/visits/widget/table_visit_dynamic.dart';
import 'package:domina_app/presentation/visits/widget/table_visit_static.dart';
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
                          return TableVisitStatic(selectBrand: selectBrand);

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
                          ),
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
                              return TableVisitDynamic(selectBrand: selectBrand,);
                            },
                          )

                        ],
                      ),

                    ],
                  ):
                  Row(
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
                  widget.doctorModel.visitDoctorModel.flag==0?
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
                           BlocProvider.of<VisitBloc>(context).add(
                              UpdateVisitDoctorEvent(
                                  kas: _issueController.text,
                                  sc: _noteController.text,
                                  id: widget
                                      .doctorModel.visitDoctorModel.id,
                                  target: _targetController.text,
                                  selectBrand:context.read<VisitBloc>().brands
                              ))
                             ;
                        },
                        child: Text("تعديل")),
                  ):SizedBox()
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
