import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/places/bloc/place_bloc.dart';
import 'package:domina_app/presentation/plase_visit/widget/build_card_buttom.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/resources/routes_manager.dart';
import 'package:domina_app/presentation/uniti/search_field.dart';
import 'package:domina_app/presentation/uniti/stateWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HospitalArchive extends StatelessWidget {
  HospitalArchive({super.key});
  final TextEditingController searchhosController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: CustomScrollView(
            // لضمان حركة سلسة مثل الصورة
            physics: const BouncingScrollPhysics(),
            slivers: [
              BlocBuilder<PlaceBloc, PlaceState>(
                buildWhen: (previous, current) =>
                current is AllHospitalArchiveByPlaceErrorState ||
                    current is EmptyArchiveState ||
                    current is AllHospitalArchiveByPlaceState,
                builder: (context, state) {
                  // 1. حالة النجاح وعرض البيانات
                  if (state is AllHospitalArchiveByPlaceState) {
                    List<HospitalModel> hospitals = state.searchData;

                    return SliverMainAxisGroup(
                      slivers: [
                        // الجزء العلوي: حقل البحث
                        SliverToBoxAdapter(
                          child: Column(
                            children: [
                              SizedBox(height: 12.h),
                              SearchField(
                                searchController: searchhosController,
                                onPressed: (value) {
                                  BlocProvider.of<PlaceBloc>(context).add(
                                      SearchHospitalArchive(value, state.baseData));
                                },
                              ),
                            ],
                          ),
                        ),

                        // عنوان القائمة وعدد المشافي
                        SliverToBoxAdapter(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 12.w, vertical: 20.h),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "قائمة المشافي المسجلين",
                                  style: TextStyle(
                                      color: ColorManager.medicalText
                                          .withOpacity(0.8),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.sp),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 12.w, vertical: 4.h),
                                  decoration: BoxDecoration(
                                    color: ColorManager.medicalPrimary
                                        .withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(8.r),
                                  ),
                                  child: Text(
                                    " ${hospitals.length} مشفى",
                                    style: TextStyle(
                                        color: ColorManager.medicalPrimary,
                                        fontSize: 11.sp),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        // قائمة الكروت (الأفضل استخدام SliverList للتعامل مع العناصر الكثيرة)
                        SliverList(
                          delegate: SliverChildBuilderDelegate(
                                (context, index) {
                              final hospital = hospitals[index];
                              return _buildHospitalCard(context, hospital);
                            },
                            childCount: hospitals.length,
                          ),
                        ),

                        // مسافة أمان في الأسفل لسهولة التمرير
                        SliverToBoxAdapter(child: SizedBox(height: 20.h)),
                      ],
                    );
                  }

                  // 2. حالة القائمة فارغة
                  if (state is EmptyArchiveState) {
                    return SliverFillRemaining(
                      hasScrollBody: false,
                      child: Center(child: emptyFullScreen(context)),
                    );
                  }

                  // 3. حالة الخطأ
                  if (state is AllHospitalArchiveByPlaceErrorState) {
                    return SliverFillRemaining(
                      hasScrollBody: false,
                      child: Center(child: errorFullScreen(context)),
                    );
                  }

                  // 4. حالة التحميل الافتراضية
                  return const SliverFillRemaining(
                    hasScrollBody: false,
                    child: Center(child: CircularProgressIndicator()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ويدجت الكرت مفصول لتحسين الأداء ونظافة الكود
  Widget _buildHospitalCard(BuildContext context, HospitalModel hospital) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h, right: 8.w, left: 8.w),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 15,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [

              Expanded(
                child: Text(
                  hospital.title ,
                  textAlign: TextAlign.end,
                  style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: ColorManager.medicalPrimary),
                ),
              ),
            ],
          ),
          SizedBox(height: 10.h),
          _buildInfoRow(Icons.location_on_outlined, hospital.placeTitle),
          _buildInfoRow(Icons.map_outlined, hospital.address),
          SizedBox(height: 16.h),
          const Divider(thickness: 0.1, color: Colors.grey),
          Row(
            children: [
              const Spacer(),
              InkWell(
                onTap: () => Navigator.pushNamed(
                    context, Routes.hospitalDetails, arguments: hospital),
                child: buildCardButton(
                    "عرض التفاصيل",
                    ColorManager.medicalPrimary,
                    Colors.white,
                    Icons.directions_run),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text, {Color color = Colors.grey}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2.h),
      child: Row(
        children: [
          Icon(icon, size: 20.sp, color: color),
          SizedBox(width: 8.w),
          Expanded(
            child: Text(text,
                style: TextStyle(color: color, fontSize: 14.sp)),
          ),
        ],
      ),
    );
  }
}