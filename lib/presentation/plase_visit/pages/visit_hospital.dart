import 'package:domina_app/presentation/doctors/pages/hospital_page/hospital_view_details.dart';
import 'package:domina_app/presentation/plase_visit/bloc/visit_place_bloc.dart';
import 'package:domina_app/presentation/plase_visit/visit_widget.dart';
import 'package:domina_app/presentation/plase_visit/widget/personal_order.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/resources/language_manager.dart';
import 'package:domina_app/presentation/resources/values_manager.dart';
import 'package:domina_app/presentation/uniti/CustomDropDownSearch.dart';
import 'package:domina_app/presentation/uniti/CustomDropDownSearchSpec.dart';
import 'package:domina_app/presentation/uniti/box_filed.dart';
import 'package:domina_app/presentation/uniti/button.dart';
import 'package:domina_app/presentation/uniti/snack_bar_message.dart';
import 'package:domina_app/presentation/uniti/stateWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../domain/models/models.dart';

class VisitHospital extends StatefulWidget {
  VisitHospital({super.key, required this.hospitalModel});
  final HospitalModel hospitalModel;
  @override
  State<VisitHospital> createState() => _VisitHospitalState();
}

class _VisitHospitalState extends State<VisitHospital>
    with AutomaticKeepAliveClientMixin {
  final TextEditingController _noteController = TextEditingController();
  final TextEditingController _issueController = TextEditingController();
  final TextEditingController _noteeController = TextEditingController();
  final TextEditingController _targetController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    BlocProvider.of<VisitPlaceBloc>(context).selectBrand = [];
    BlocProvider.of<VisitPlaceBloc>(context).selectAddBrand = [];
    BlocProvider.of<VisitPlaceBloc>(context).visitBrandPharmacys = [];
    BlocProvider.of<VisitPlaceBloc>(context)
        .add(SpecializationHospitalEvent(widget.hospitalModel.id));
    BlocProvider.of<VisitPlaceBloc>(context).isBrand = false;
    BlocProvider.of<VisitPlaceBloc>(context).type = Type(2, "لا شيئ");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "إجراء زيارة",
          style: TextStyle(
            color: const Color(0xFF0D47A1),
            fontWeight: FontWeight.bold,
            fontSize: 18.sp,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF0D47A1)),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildFullHeader(),

              Padding(
                padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 18.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "اختر الاختصاص:",
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                    SizedBox(
                      height: 0.9,
                    ),
                    BlocConsumer<VisitPlaceBloc, VisitPlaceState>(
                        listener: (context, state) {
                      if (state is BrandFlagErrorState) {
                        error(
                            context, state.failure.massage, state.failure.code);
                      }
                    }, builder: (context, state) {
                      List<SpecHospitalSp> specialization =
                          context.watch<VisitPlaceBloc>().specialization;
                      if (state is SpecializationHospitalState) {
                        specialization = state.specialization;
                      }
                      return Customdropdownsearchspec(

                        hintText: "الإختصاصات",
                        items: specialization,
                        onChanged: (value) {
                          SpecHospitalSp specModel = value;
                          BlocProvider.of<VisitPlaceBloc>(context)
                              .add(SelectSpecEvent(specModel));
                        },
                        validator: (value) {
                          if (value == null) {
                            return "اختر الإختصاص";
                          }
                          return null;
                        },
                        errorText: 'لايوجد نتيجة',
                      );
                    }),
                    BlocBuilder<VisitPlaceBloc, VisitPlaceState>(
                      buildWhen: (previous, current) {
                        return current is SpecState;
                      },
                      builder: (context, state) {
                        if (state is SpecState) {
                          return Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: AppPaddingH.p8,
                                horizontal: AppPaddingW.p8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "اجمالي الزيارات: ${state.visits}",
                                  style:
                                      Theme.of(context).textTheme.headlineLarge,
                                ),
                                Text(
                                  "تمت الزيارة: ${state.visited}",
                                  style:
                                      Theme.of(context).textTheme.headlineLarge,
                                ),
                                Text(
                                  "عدد الأطباء: ${state.total}",
                                  style:
                                      Theme.of(context).textTheme.headlineLarge,
                                ),
                              ],
                            ),
                          );
                        } else {
                          return Container();
                          // واجهة بديلة عند عدم تطابق الحالة
                        }
                      },
                    ),
                    Text(
                      " الهدف من الزيارة:",
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
                      controller: _targetController,
                      obscureText: false,
                      minLines: 3,
                      inputFormatters: [],
                    ),
                    Text(
                      " ملاحظة للمكتب العلمي:",
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
                      "ملاحظة صيدلية مجاورة:",
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
                    ),
                    PersonalOrder(noteeController: _noteeController),
                    Text(
                      "اختر العينات المقدمة:",
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                    SizedBox(
                      height: 0.9,
                    ),
                    BlocBuilder<VisitPlaceBloc, VisitPlaceState>(
                      builder: (context, state) {
                        return Row(
                          children: [
                            Checkbox(
                              focusColor: ColorManager.secondaryColor,
                              activeColor: ColorManager.secondaryColor2,
                              value: context.read<VisitPlaceBloc>().isBrand,
                              onChanged: (value) {
                                BlocProvider.of<VisitPlaceBloc>(context)
                                    .add(IsBrandEvent());
                              },
                            ),
                            Text('لم يتم توزيع العينات'),
                          ],
                        );
                      },
                    ),
                    SizedBox(
                      height: AppSize.s8,
                    ),
                    context.read<VisitPlaceBloc>().isBrand == false
                        ? BlocListener<VisitPlaceBloc, VisitPlaceState>(
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
                                    SelectBrandEvent(
                                        brand, widget.hospitalModel.id));
                              },
                              validator: (value) {
                                if (value == null) {
                                  return "اختر نوع الطلب";
                                }
                                return null;
                              },
                              errorText: 'لايوجد نتيجة',
                            ),
                          )
                        : SizedBox(),
                    SizedBox(
                      height: 8,
                    ),
                    BlocBuilder<VisitPlaceBloc, VisitPlaceState>(
                      buildWhen: (previous, current) {
                        return current is SelectBrandState ||
                            current is DeleteBrandState ||
                            current is EditAmountBrandState;
                      },
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
                                        amount.text =
                                            visitBrand[index].amount.toString();
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
                                                                int.parse(convertArabicNumberToEnglish(value))

                                                            ));
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
                          SnackBarMessage().showAlertSScaffoldMessenger(
                              context: context, message: "تم حفظ التغيرات");
                          BlocProvider.of<VisitPlaceBloc>(context).add(
                              HospitalByPlace(widget.hospitalModel.placeId, 1));
                          Navigator.pop(context);
                        }
                        if (state is AllVisitBrandHospitalErrorState) {
                          error(context, state.failure.massage,
                              state.failure.code);
                        }
                        if (state is AllVisitBrandHospitalState) {
                          success(context);
                          SnackBarMessage().showAlertSScaffoldMessenger(
                              context: context, message: "تم حفظ التغيرات");
                          BlocProvider.of<VisitPlaceBloc>(context).add(
                              HospitalByPlace(widget.hospitalModel.placeId, 1));
                          Navigator.pop(context);
                        }
                      },
                      child:

                      ButtonWidget( () {
                        if (_formKey.currentState!.validate()) {
                          DateTime now = DateTime.now();
                          // String formattedTime = DateFormat('EEEE, dd-MM-yyyy – HH:mm', 'ar').format(now);
                          VisitHospitalModel visitHospitalModel =
                          VisitHospitalModel(
                            0,
                            now.toIso8601String(),
                            _issueController.text,
                            _noteController.text,
                            _noteeController.text,
                            0,
                            0,
                            _targetController.text,
                          );
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
                                InsertVisitHospitalEvent(visitHospitalModel,
                                    widget.hospitalModel.id));
                          }
                        }
                      }, "تمت الزيارة"),
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
  Widget _buildFullHeader(){
    return    Container(
      margin: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, 10),
          )
        ],
      ),
      child: Column(
        children: [
          // الهيدر الأزرق داخل الكرت
          _buildBlueHeader(),

          SizedBox(height: 20.h),

          // قائمة المعلومات
        //  buildDetailRow(Icons.location_on_outlined, "المنطقة:", widget.hospitalModel.placeTitle),
        //  buildDivider(),
          buildDetailRow(Icons.business_outlined, "العنوان:", widget.hospitalModel.address),
         // buildDivider(),
        //  buildDetailRow(Icons.assignment_outlined, "ملاحظة:",
       //       widget.hospitalModel.note),
          SizedBox(height: 20.h),
        ],
      ),
    );

  }
  // الهيدر الأزرق المنحني
  Widget _buildBlueHeader() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 25.h),
      decoration: BoxDecoration(
        color: const Color(0xFF1A4B8F),
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(25.r),
          topLeft: Radius.circular(25.r),
          bottomRight: Radius.circular(5.r),
          bottomLeft: Radius.circular(5.r),
        ),
      ),
      child: Column(
        children: [
          // الحاوية الزجاجية للحرف
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HospitalViewDetails(
                        hospital: widget.hospitalModel,
                        hospitalsp: context
                            .read<VisitPlaceBloc>()
                            .specialization),
                  ));
            },
            child: Container(
              padding: EdgeInsets.all(15.w),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.15),
                borderRadius: BorderRadius.circular(15.r),
                border: Border.all(color: Colors.white.withOpacity(0.3)),
              ),
              child: Text( widget.hospitalModel.title.substring(0, 1), style: TextStyle(color: Colors.white, fontSize: 30.sp, fontWeight: FontWeight.bold)),
            ),
          ),
          SizedBox(height: 12.h),
          Text( widget.hospitalModel.title, style: TextStyle(color: Colors.white, fontSize: 20.sp, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
