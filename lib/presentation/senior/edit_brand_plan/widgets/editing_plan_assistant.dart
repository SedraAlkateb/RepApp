// ignore_for_file: must_be_immutable
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/senior/edit_brand_plan/bloc/edit_brand_plan_bloc.dart';
import 'package:domina_app/presentation/uniti/custom_dropdown.dart';
import 'package:domina_app/presentation/uniti/search_field.dart';
import 'package:domina_app/presentation/uniti/stateWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class EditingPlanAssistant extends StatefulWidget {
  const EditingPlanAssistant({super.key, required this.repPlan});
  final int repPlan;

  @override
  State<EditingPlanAssistant> createState() => _EditingPlanAssistantState();
}

class _EditingPlanAssistantState extends State<EditingPlanAssistant> with AutomaticKeepAliveClientMixin {
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: Colors.transparent, // ليظهر لون خلفية الصفحة الأب
      body: Column(
        children: [
          // شريط البحث
          Padding(
            padding: EdgeInsets.only(top: 8.h),
            child: SearchField(
              searchController: searchController,
              onPressed: (value) {
                BlocProvider.of<EditBrandPlanBloc>(context).add(FutureSearchSpecEvent(value));
              },
            ),
          ),
          Expanded(
            child: BlocBuilder<EditBrandPlanBloc, EditBrandPlanState>(
              builder: (context, state) {
                List<PlanBrandModel> planBrand = context.watch<EditBrandPlanBloc>().planBrands;
                if (state is FuturePlanBrandState) planBrand = state.planbrand;

                if (state is FutureSpRepLoadingState) return loadingFullScreen(context);
                if (state is FutureSpRepErrorState) return errorFullScreen(context, func: () {});

                return
                  planBrand.isEmpty?emptyFullScreen(context):
                  ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.fromLTRB(16.w, 10.h, 16.w, 90.h),
                  itemCount: planBrand.length,
                  itemBuilder: (context, index) => _buildElegantCard(index, planBrand),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildElegantCard(int index, List<PlanBrandModel> planBrand) {
    int brandTypeId = planBrand[index].brandType.i;
    String brandTypeHintText = "غير محدد";
    for (var type in brandType) {
      if (type.i == brandTypeId) {
        brandTypeHintText = type.name;
        break;
      }
    }

    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              // أيقونة الدواء الجانبية
              Container(
                width: 45.w,
                height: 45.w,
                decoration: BoxDecoration(
                  color: ColorManager.secondaryColor1.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Icon(Icons.medication_liquid_rounded, color: ColorManager.secondaryColor1, size: 24.sp),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      planBrand[index].title,
                      style: TextStyle(fontWeight: FontWeight.w800, fontSize: 14.sp, color: const Color(0xFF2D3142)),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      planBrand[index].pharmaceuticalForm,
                      style: TextStyle(color: Colors.grey.shade500, fontSize: 11.sp, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 15.h),
          // منطقة الـ Dropdown المحدثة (بدون أيقونات داخلية)
          BlocConsumer<EditBrandPlanBloc, EditBrandPlanState>(
            listener: (context, state) {
              if (state is FutureChangePlanBrandTypeErrorState) {
                error(context, state.failure.massage, state.failure.code);
              }
            },
            builder: (context, state) {
              if (state is FutureChangeLoadingItemValueState && state.index == index) {
                return SizedBox(
                  height: 45.h,
                  child: Center(
                    child: SpinKitThreeBounce(color: ColorManager.secondaryColor1, size: 20.0),
                  ),
                );
              }
              return CustomDropDown(
                hintText: brandTypeHintText,
                items: brandType,
                prefixIcon: null, // تم إلغاء الأيقونة هنا لتطابق الطلب
                onChanged: (value) {
                  BlocProvider.of<EditBrandPlanBloc>(context).add(
                    FutureChangePlanBrandTypeEvent(planBrand[index].id, value.i),
                  );
                  planBrand[index].brandType.i = value.i;
                  BlocProvider.of<EditBrandPlanBloc>(context).add(
                    FutureChangeLoadingItemValueEvent(index),
                  );
                },
                validator: (value) => null,
                errorText: '',
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}