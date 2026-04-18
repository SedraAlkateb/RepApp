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

class InfoVisitHospital extends StatefulWidget {
  InfoVisitHospital({super.key, required this.hospitalModel});
  final VisitHospitalAndHospital hospitalModel;

  @override
  State<InfoVisitHospital> createState() => _InfoVisitHospitalState();
}

class _InfoVisitHospitalState extends State<InfoVisitHospital> {
  final TextEditingController _noteController = TextEditingController();
  final TextEditingController _issueController = TextEditingController();
  final TextEditingController _noteeController = TextEditingController();
  final TextEditingController _targetController = TextEditingController();
  @override
  void initState() {
    _noteController.text =
        widget.hospitalModel.visitHospitalModel.science ?? "";
    _issueController.text = widget.hospitalModel.visitHospitalModel.kaswn ?? "";
    _noteeController.text =
        widget.hospitalModel.visitHospitalModel.additaion ?? "";
    _targetController.text =
        widget.hospitalModel.visitHospitalModel.target ?? "";
    BlocProvider.of<VisitBloc>(context).add(
        BrandHospitalVisitEvent(widget.hospitalModel.visitHospitalModel.id));
    super.initState();
  }

  @override
  void dispose() {
    _noteController.dispose();
    _issueController.dispose();
    _noteeController.dispose();
    _targetController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isEditable=widget.hospitalModel.visitHospitalModel.flag == 0?true:false;
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
                      iconColor: Colors.redAccent ,
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
                  widget.hospitalModel.hospitalModel.title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 22.sp,
                      fontWeight: FontWeight.bold
                  ),
                ),

                SizedBox(height: 12.h),

                // 2. صف المعلومات (الاختصاص + العنوان)
                // وضعناهما في صف واحد لتقليل التكدس الرأسي
                _buildHeaderInfo(
                  icon: Icons.medical_services_outlined,
                  label: widget.hospitalModel.specModel.title, // نص مباشر بدون format
                ),
                SizedBox(height: 10.w),
                _buildHeaderInfo(
                  icon: Icons.location_on_outlined,
                  label: widget.hospitalModel.hospitalModel.address,
                ),

                SizedBox(height: 15.h),

                // 3. كبسولة التاريخ (منفصلة لتعطي أهمية للوقت)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
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
                        formatDateTime(widget.hospitalModel.visitHospitalModel.data),
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600
                        ),
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
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: Colors.white70, size: 14.sp),
        SizedBox(width: 4.w),
        Text(
          label,
          style: TextStyle(color: Colors.white70, fontSize: 13.sp),
        ),
      ],
    );
  }
  Widget _buildFloatingEditButton(bool isEditable) {
    if (!isEditable) return const SizedBox();

    return BlocListener<VisitBloc, VisitState>(
      listener: (context, state) {
        if (state is UpdateVisitHospitalState) {
          Navigator.pop(context);
          BlocProvider.of<VisitBloc>(context)
              .add(VisitHospitalEvent());
        }
      },
      child:
      ButtonWidget(() {
        BlocProvider.of<VisitBloc>(context).add(
            UpdateVisitHospitalEvent(
                kas: _issueController.text,
                sc: _noteController.text,
                id: widget.hospitalModel
                    .visitHospitalModel.id,
                target: _targetController.text,
                selectBrand:context.read<VisitBloc>().brands
            ));
      }, "تعديل"),

    );
  }

  Widget _buildSamplesSection(bool isEditable) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10)],
      ),
      child:      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(6.w),
                decoration: BoxDecoration(color: Colors.green.withOpacity(0.1), borderRadius: BorderRadius.circular(8.r)),
                child: Icon(Icons.link, color: Colors.green, size: 20.sp),
              ),
              SizedBox(width: 10.w),
              Text("العينات المقدمة", style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold, color: const Color(0xFF0D47A1))),
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
              ( !isEditable&&context.watch<VisitBloc>().brands.isNotEmpty)
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
                  return TableVisitStatic(
                      selectBrand: selectBrand);
                },
              )
                  :
              (! isEditable&&context.watch<VisitBloc>().brands.isEmpty)  ?
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
              ):
              Column(
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
              )

            ],
          )
              : SizedBox()



        ],
      ),
    );
  }


}


