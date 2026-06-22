import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/doctors/bloc/doctors_bloc.dart';
import 'package:domina_app/presentation/doctors/widget/hospital_card.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/uniti/search_field.dart';
import 'package:domina_app/presentation/uniti/stateWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Hospital extends StatelessWidget {
  Hospital({super.key});
  final TextEditingController searchhosController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50], // خلفية مريحة تعزل الكروت
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.w),
        child: BlocBuilder<DoctorsBloc, DoctorsState>(
          buildWhen: (previous, current) =>
          current is AllHospitalsState ||
              current is AllHospitalEmptyState ||
              current is AllHospitalErrorState,
          builder: (context, state) {
            List<HospitalSpAllModel> hospitalModel = context.read<DoctorsBloc>().hospital;

            if (state is AllHospitalsState) {
              hospitalModel = state.hospital;
            }

            if (state is AllHospitalEmptyState || hospitalModel.isEmpty) {
              return CustomScrollView(
                slivers: [
                  _buildSearchHeader(context),
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Center(child: emptyFullScreen(context)),
                  ),
                ],
              );
            }

            if (state is AllHospitalErrorState) {
              return CustomScrollView(
                slivers: [
                  _buildSearchHeader(context),
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Center(child: errorFullScreen(context)),
                  ),
                ],
              );
            }

            return CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                // 1. ترويسة البحث والعدد الإجمالي
                _buildSearchHeader(context, count: hospitalModel.length),

                // 2. البناء الذكي والسريع لقائمة المشافي 🚀
                SliverList.builder(
                  itemCount: hospitalModel.length,
                  itemBuilder: (context, index) {
                    return HospitalCardItem(hospital: hospitalModel[index]);
                  },
                ),

                // مسافة أمان سفلية
                SliverToBoxAdapter(child: SizedBox(height: 24.h)),
              ],
            );
          },
        ),
      ),
    );
  }

  // ويدجت جانبي لبناء قسم البحث العلوي والعداد لمنع تكرار الكود
  Widget _buildSearchHeader(BuildContext context, {int count = 0}) {
    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 12.h),
          SearchField(
            searchController: searchhosController,
            onPressed: (value) {
              BlocProvider.of<DoctorsBloc>(context).add(SearchhosEvent(value));
            },
          ),
          if (count > 0) ...[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "قائمة المشافي المسجلة",
                    style: TextStyle(
                        color: ColorManager.medicalText.withOpacity(0.8),
                        fontWeight: FontWeight.bold,
                        fontSize: 16.sp),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
                    decoration: BoxDecoration(
                      color: ColorManager.medicalPrimary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Text(
                      " $count مشفى",
                      style: TextStyle(
                          color: ColorManager.medicalPrimary, fontSize: 11.sp),
                    ),
                  ),
                ],
              ),
            ),
          ] else
            SizedBox(height: 16.h),
        ],
      ),
    );
  }
}
