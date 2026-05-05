import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/resources/values_manager.dart';
import 'package:domina_app/presentation/uniti/CustomDropDownSearch.dart';
import 'package:domina_app/presentation/uniti/button.dart';
import 'package:domina_app/presentation/uniti/stateWidget.dart';
import 'package:domina_app/presentation/uniti/time.dart';
import 'package:domina_app/presentation/visits/bloc/visit_bloc.dart';
import 'package:domina_app/presentation/visits/widget/build_widget_for_visit.dart';
import 'package:domina_app/presentation/visits/widget/table_visit_dynamic.dart';
import 'package:domina_app/presentation/visits/widget/table_visit_static.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
    bool isEditable =
        widget.doctorModel.visitDoctorModel.flag == 0 ? true : false;
    return Scaffold(
      appBar: null,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(context),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  buildEditableSection(
                    title: "الهدف من الزيارة",
                    controller: _targetController,
                    icon: Icons.timeline,
                    isEditable: isEditable,
                    iconColor: Colors.blue,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "الحقل مطلوب";
                      }
                      return null;
                    },
                  ),

                  SizedBox(height: 15.h),
                  // القسم الثالث: ملاحظة المكتب العلمي
                  buildEditableSection(
                    title: "ملاحظة للمكتب العلمي",
                    controller: _noteController,
                    icon: Icons.note_alt_outlined,
                    isEditable: isEditable,
                    iconColor: Colors.purple,
                    validator: (value) {
                      return null;
                    },
                  ),

                  if (_issueController.text.isNotEmpty || isEditable) ...[
                    SizedBox(height: 15.h),
                    buildEditableSection(
                      title: "ملاحظة صيدلية مجاورة",
                      controller: _issueController,
                      icon: Icons.warehouse_outlined,
                      isEditable: isEditable,
                      iconColor: Colors.orange,
                      validator: (value) {
                        return null;
                      },
                    ),
                  ],
                  if (_noteeController.text.isNotEmpty || isEditable) ...[
                    SizedBox(height: 15.h),
                    buildEditableSection(
                      title: "طلبات شخصية",
                      controller: _noteeController,
                      icon: Icons.person_outline,
                      isEditable: isEditable,
                      iconColor: Colors.redAccent,
                      validator: (value) {
                        return null;
                      },
                    ),
                  ],
                  SizedBox(height: 15.h),

                  // القسم الثاني: العينات المقدمة
                  _buildSamplesSection(isEditable),

                  SizedBox(height: 15.h),
                  _buildFloatingEditButton(isEditable),
                  SizedBox(height: 100.h), // مساحة للزر العائم

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 280.h,
      decoration: BoxDecoration(
        color: ColorManager.medicalPrimary,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(40.r)),
      ),
      child: Stack(
        children: [
          // زر العودة
          Positioned(
            top: 40.h,
            right: 10.w,
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white, size: 30),
              onPressed: () => Navigator.pop(context),
            ),
          ),

          Align(
            alignment: Alignment.center,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // 1. اسم المشفى
                Text(
                  widget.doctorModel.doctorModel.title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 22.sp,
                      fontWeight: FontWeight.bold),
                ),

                SizedBox(height: 12.h),

                // 2. صف المعلومات (الاختصاص + العنوان)
                // وضعناهما في صف واحد لتقليل التكدس الرأسي
                _buildHeaderInfo(
                  icon: Icons.medical_services_outlined,
                  label: widget
                      .doctorModel.doctorModel.spTitle, // نص مباشر بدون format
                ),
                SizedBox(height: 10.w),
                _buildHeaderInfo(
                  icon: Icons.location_on_outlined,
                  label: widget.doctorModel.doctorModel.address,
                ),

                SizedBox(height: 15.h),

                // 3. كبسولة التاريخ (منفصلة لتعطي أهمية للوقت)
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20.r),
                    border: Border.all(color: Colors.white.withOpacity(0.1)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.access_time, color: Colors.white, size: 14.sp),
                      SizedBox(width: 6.w),
                      Text(
                        formatDateTime(
                            widget.doctorModel.visitDoctorModel.data),
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

// دالة مساعدة لتجنب تكرار الكود وتنسيق أيقونة + نص
  Widget _buildHeaderInfo({required IconData icon, required String label}) {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: 10.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.white70, size: 14.sp),
          SizedBox(width: 4.w),
          Expanded(
            child: Text(textAlign: TextAlign.center,
              label,
              style: TextStyle(color: Colors.white70, fontSize: 13.sp),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFloatingEditButton(bool isEditable) {
    if (!isEditable) return const SizedBox();
    return BlocListener<VisitBloc, VisitState>(
      listener: (context, state) {
        if (state is UpdateVisitDoctorState) {
          Navigator.pop(context);
          BlocProvider.of<VisitBloc>(context).add(VisitDoctorEvent());
        }
      },
      child: ButtonWidget(() {
        BlocProvider.of<VisitBloc>(context).add(UpdateVisitDoctorEvent(
            kas: _issueController.text,
            sc: _noteController.text,
            id: widget.doctorModel.visitDoctorModel.id,
            target: _targetController.text,
            selectBrand: context.read<VisitBloc>().brands));
      }, "تعديل"),
    );
  }

  Widget _buildSamplesSection(bool isEditable) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10)
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(6.w),
                decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8.r)),
                child: Icon(Icons.link, color: Colors.green, size: 20.sp),
              ),
              SizedBox(width: 10.w),
              Text("العينات المقدمة",
                  style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF0D47A1))),
            ],
          ),
          SizedBox(height: 10.h),
          isEditable
              ? BlocBuilder<VisitBloc, VisitState>(
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
                )
              : SizedBox(),
          context.read<VisitBloc>().isBrand == false
              ? Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: AppSize.s8,
              ),
              widget.doctorModel.visitDoctorModel.flag == 1
                  ?
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
                  if (state is BrandPharmacyVisitState) {
                    selectBrand = state.brands;
                  }
                  if (state is DeleteBrandState) {
                    selectBrand = state.brands;
                  }
                  return TableVisitStatic(
                      selectBrand: selectBrand);
                },
              )
                  : Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 8,
                  ),
                  BlocListener<VisitBloc, VisitState>(
                    listener: (context, state) {
                      if (state is BrandFlagErrorState) {
                        error(
                            context,
                            state.failure.massage,
                            state.failure.code);
                      }
                    },
                    child: CustomDropDownSearch(
                      hintText: "العينات",
                      items: context
                          .watch<VisitBloc>()
                          .bandFlag,
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

                  BlocBuilder<VisitBloc, VisitState>(
                    buildWhen: (previous, current) {
                      return current is SelectBrandState ||
                          current is DeleteBrandState ||
                          current
                          is BrandPharmacyVisitState ||
                          current is EditAmountBrandState;
                    },
                    builder: (context, state) {
                      List<PharmacyBrandModel> selectBrand =
                          context.watch<VisitBloc>().brands;
                      if (state
                      is BrandPharmacyVisitState) {
                        selectBrand = state.brands;
                      }
                      return TableVisitDynamic(
                        selectBrand: selectBrand,
                      );
                    },
                  )
                ],
              ),
            ],
          ):SizedBox(),

        ],
      ),
    );
  }
}
