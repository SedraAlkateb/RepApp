import 'package:domina_app/presentation/doctors/pages/doctor_page/doctor_details%20.dart';
import 'package:domina_app/presentation/plase_visit/bloc/visit_place_bloc.dart';
import 'package:domina_app/presentation/plase_visit/visit_widget.dart';
import 'package:domina_app/presentation/plase_visit/widget/personal_order.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/resources/language_manager.dart';
import 'package:domina_app/presentation/resources/values_manager.dart';
import 'package:domina_app/presentation/uniti/CustomDropDownSearch.dart';
import 'package:domina_app/presentation/uniti/box_filed.dart';
import 'package:domina_app/presentation/uniti/snack_bar_message.dart';
import 'package:domina_app/presentation/uniti/stateWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../domain/models/models.dart';

class VisitDoctor extends StatefulWidget {
  VisitDoctor({super.key, required this.doctorModel});
  final DoctorModel doctorModel;

  @override
  State<VisitDoctor> createState() => _VisitDoctorState();
}

class _VisitDoctorState extends State<VisitDoctor>
    with AutomaticKeepAliveClientMixin {
  final TextEditingController _noteController = TextEditingController();
  final TextEditingController _issueController = TextEditingController();
  final TextEditingController _noteeController = TextEditingController();
  final TextEditingController _targetController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    _noteeController.text="";
    BlocProvider.of<VisitPlaceBloc>(context).selectBrand = [];
    BlocProvider.of<VisitPlaceBloc>(context).selectAddBrand = [];
    BlocProvider.of<VisitPlaceBloc>(context).visitBrandPharmacys = [];
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
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: Column(
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
                    SizedBox(
                      height: AppSize.s8,
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
                    SizedBox(
                      height: AppSize.s8,
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
                    SizedBox(
                      height: AppSize.s8,
                    ),
                    Text(
                      "اختر العينات المقدمة:",
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                    SizedBox(
                      height: AppSize.s8,
                    ),
                    BlocBuilder<VisitPlaceBloc, VisitPlaceState>(
                      builder: (context, state) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text('لم يتم توزيع العينات',style: TextStyle(fontWeight: FontWeight.bold),),
                            Checkbox(

                              focusColor: ColorManager.secondaryColor,
                              activeColor: ColorManager.secondaryColor2,
                              value: context.read<VisitPlaceBloc>().isBrand,
                              onChanged: (value) {
                                BlocProvider.of<VisitPlaceBloc>(context)
                                    .add(IsBrandEvent());
                              },
                            ),

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
                                print("object");
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
                                        brand, widget.doctorModel.id));
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
                      height: 12,
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
                     return   selectBrand.isNotEmpty
                            ? Padding(
                          padding: const EdgeInsets.all(0),
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
                      },
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    BlocListener<VisitPlaceBloc, VisitPlaceState>(
                      listener: (context, state) {
                        if (state is InsertVisitDoctorErrorState) {
                          error(context, state.failure.massage,
                              state.failure.code);
                        }
                        if (state is InsertVisitDoctorState) {
                          BlocProvider.of<VisitPlaceBloc>(context).add(
                              DoctorByPlace(widget.doctorModel.placeId, 0));
                          success(context);
                          SnackBarMessage().showAlertSScaffoldMessenger(
                              context: context, message: "تم حفظ التغيرات");
                          Navigator.pop(context);
                        }
                        if (state is AllVisitBrandDoctorErrorState) {
                          error(context, state.failure.massage,
                              state.failure.code);
                        }
                        if (state is AllVisitBrandDoctorState) {
                          BlocProvider.of<VisitPlaceBloc>(context).add(
                              DoctorByPlace(widget.doctorModel.placeId, 0));
                          success(context);
                          SnackBarMessage().showAlertSScaffoldMessenger(
                              context: context, message: "تم حفظ التغيرات");

                          Navigator.pop(context);
                        }
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal:2, vertical: 8.h
                        ), // مسافة عن حواف الشاشة
                        child: SizedBox(
                          width: double.infinity, // لجعل الزر يأخذ عرض الصفحة بالكامل
                          height: 50.h, // التحكم بطول (ارتفاع) الزر
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor:  ColorManager.medicalPrimary, // نفس اللون الأزرق في صورك
                              foregroundColor: Colors.white, // لون النص
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.r), // زوايا منحنية لتناسب بقية الواجهة
                              ),
                              elevation: 2, // ظل خفيف للزر
                            ),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                DateTime now = DateTime.now();

                                VisitDoctorModel visitDoctorModel = VisitDoctorModel(
                                    0,
                                    now.toIso8601String(),
                                    _issueController.text,
                                    _noteController.text,
                                    _noteeController.text,
                                    widget.doctorModel.id,
                                    0,
                                    _targetController.text);

                                if (context.read<VisitPlaceBloc>().selectBrand.isNotEmpty) {
                                  BlocProvider.of<VisitPlaceBloc>(context)
                                      .add(InsertBrandVisitDoctorEvent(visitDoctorModel));
                                } else {
                                  BlocProvider.of<VisitPlaceBloc>(context)
                                      .add(InsertVisitDoctorEvent(visitDoctorModel));
                                }
                              }
                            },
                            child: Text(
                              "تمت الزيارة",
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
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
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Row(
              children: [

                buildStatBox(" تمت الزياراة", widget.doctorModel.visited.toString() , const Color(0xFF0D47A1)),
                SizedBox(width: 12.w),
                buildStatBox("إجمالي الزيارات", widget.doctorModel.visits.toString(), Colors.black),
              ],
            ),
          ),

          SizedBox(height: 20.h),

          // قائمة المعلومات
       //   buildDetailRow(Icons.location_on_outlined, "المنطقة:", widget.doctorModel.placeTitle),
        //  buildDivider(),
          buildDetailRow(Icons.business_outlined, "العنوان:", widget.doctorModel.address),
      //    buildDivider(),
       //   buildDetailRow(Icons.access_time, "أوقات العمل:", widget.doctorModel.workHours.toString()),
      //    buildDivider(),
      //    buildDetailRow(Icons.assignment_outlined, "ملاحظة:",
     //         widget.doctorModel.note),
          buildDivider(),
          buildDetailRow(Icons.star_rate_outlined, "التقيم:",
              widget.doctorModel.rate),

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
              print("Navigating to Doctor Details...");
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return DoctorDetails(
                      doctor: widget.doctorModel);
                },
              ));
            },
            child: Container(
              padding: EdgeInsets.all(15.w),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.15),
                borderRadius: BorderRadius.circular(15.r),
                border: Border.all(color: Colors.white.withOpacity(0.3)),
              ),
              child: Text( widget.doctorModel.title.substring(0, 1), style: TextStyle(color: Colors.white, fontSize: 30.sp, fontWeight: FontWeight.bold)),
            ),
          ),
          SizedBox(height: 12.h),
          Text( widget.doctorModel.title, style: TextStyle(color: Colors.white, fontSize: 20.sp, fontWeight: FontWeight.bold)),
          SizedBox(height: 8.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.15),
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.business_center_outlined, color: Colors.white, size: 14.sp),
                SizedBox(width: 6.w),
                Text(widget.doctorModel.spTitle, style: TextStyle(color: Colors.white, fontSize: 13.sp)),
              ],
            ),
          ),
        ],
      ),
    );
  }


  @override
  bool get wantKeepAlive => true;
}
