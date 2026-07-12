import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/resources/routes_manager.dart';
import 'package:domina_app/presentation/resources/values_manager.dart';
import 'package:domina_app/presentation/senior/search_doctors/bloc/search_doctors_bloc.dart';
import 'package:domina_app/presentation/senior/search_doctors/widgets/info_row_item.dart';
import 'package:domina_app/presentation/senior/search_doctors/widgets/text__serach_doctor.dart';
import 'package:domina_app/presentation/uniti/search_field.dart';
import 'package:domina_app/presentation/uniti/stateWidget.dart';
import 'package:domina_app/presentation/uniti/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DoctorDetails extends StatefulWidget {
  final doctorsModel doctorModel;
  const DoctorDetails({super.key, required this.doctorModel});

  @override
  State<DoctorDetails> createState() => _DoctorDetailsState();
}

class _DoctorDetailsState extends State<DoctorDetails>
    with AutomaticKeepAliveClientMixin {
  final TextEditingController searchNoteDoctorController =
  TextEditingController();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA), // خلفية هادئة لإبراز كروت التقارير
      appBar: null,
      body: BlocBuilder<SearchDoctorsBloc, SearchDoctorsState>(
        buildWhen: (previous, current) =>
        current is FutureDocDoctorsState ||
            current is FutureDocDoctorsErrorState ||
            current is FutureDocDoctorsLoadingState ||
            current is FutureDocDoctorsEmptyState,
        builder: (context, state) {

          // 1. حالة الخطأ
          if (state is FutureDocDoctorsErrorState) {
            return CustomScrollView(
              slivers: [
                SliverFillRemaining(
                  child: Center(
                    child: errorFullScreen(context,
                        mes: state.failure.massage, func: () {}),
                  ),
                ),
              ],
            );
          }

          // 2. حالة التحميل
          if (state is FutureDocDoctorsLoadingState) {
            return CustomScrollView(
              slivers: [
                SliverFillRemaining(
                  child: Center(child: loadingFullScreen(context)),
                ),
              ],
            );
          }

          // 3. حالة البيانات الفارغة
          if (state is FutureDocDoctorsEmptyState) {
            return CustomScrollView(
              slivers: [
                SliverFillRemaining(
                  child: Center(child: emptyFullScreen(context)),
                ),
              ],
            );
          }

          // 4. حالة نجاح جلب البيانات (الهيدر المطور مع عرض كروت التقارير بالملاحظات المدمجة)
          if (state is FutureDocDoctorsState) {
            final String cleanName = widget.doctorModel.name.trim();
            final String firstLetter = cleanName.isNotEmpty
                ? cleanName[0].toUpperCase()
                : "?";
            return CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                // هيدر الشاشة المتجاوب والمطوّر
                SliverAppBar(
                  expandedHeight: 310.h,
                  automaticallyImplyLeading: false,
                  pinned: true,
                  backgroundColor: ColorManager.medicalPrimary,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(40),
                    ),
                  ),
                  flexibleSpace: FlexibleSpaceBar(
                    background: Stack(
                      children: [
                        // زر العودة المثبت في الأعلى جهة اليمين
                        Positioned(
                          top: 40.h,
                          right: 10.w,
                          child: IconButton(
                            icon: const Icon(Icons.arrow_back, color: Colors.white, size: 30),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ),

                        // محتوى البيانات المركزي للهيدر الأنيق
                        Align(
                          alignment: Alignment.center,
                          child: Padding(
                            padding: EdgeInsets.only(
                              top: 60.h,
                              left: 20.w,
                              right: 20.w,
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                // زر الحرف المربع الناعم (iOS Style Icon)
                                InkWell(
                                  borderRadius: BorderRadius.circular(12.r),
                                  onTap: () {
                                    BlocProvider.of<SearchDoctorsBloc>(context)
                                        .add(DoctorInfoEvent(widget.doctorModel.id));
                                    Navigator.pushNamed(context, Routes.doctorInfo);
                                  },
                                  child: Container(
                                    width: 60.r,
                                    height: 60.r,
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(12.r),
                                      border: Border.all(
                                        color: Colors.white.withOpacity(0.4),
                                        width: 1.5,
                                      ),
                                    ),
                                    child: Center(
                                      child: FittedBox(
                                        fit: BoxFit.contain, // 🌟 يجبر الحرف على البقاء داخل الحدود مهما كان حجم الشاشة
                                        child: Padding(
                                          padding: EdgeInsets.all(4.r), // مسافة أمان صغيرة حول الحرف
                                          child: Text(
                                            firstLetter,
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 30,
                                              fontWeight: FontWeight.bold,
                                              // قمنا بإلغاء الـ fontSize هنا لأن FittedBox ستتولى الحجم تلقائياً وبأمان
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 12.h),

                                InkWell(
                                  borderRadius: BorderRadius.circular(12.r),
                                  onTap: () {
                                    BlocProvider.of<SearchDoctorsBloc>(context)
                                        .add(DoctorInfoEvent(widget.doctorModel.id));
                                    Navigator.pushNamed(context, Routes.doctorInfo);
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                                    child: Text(
                                      widget.doctorModel.name,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 22.sp,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),

                                SizedBox(height: 14.h),

                                // صف المعلومات الأول: الاختصاص
                                _buildHeaderInfo(
                                  icon: Icons.medical_services_outlined,
                                  label: widget.doctorModel.spTitle,
                                ),

                                SizedBox(height: 10.h),

                                // صف المعلومات الثاني: العنوان
                                _buildHeaderInfo(
                                  icon: Icons.location_on_outlined,
                                  label: widget.doctorModel.placeTitle,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // حقل البحث المدمج كجزء من قائمة التمرير
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.h),
                    child: SearchField(
                      searchController: searchNoteDoctorController,
                      onPressed: (value) {
                        BlocProvider.of<SearchDoctorsBloc>(context)
                            .add(SearchNoteDoctorEvent(value));
                      },
                    ),
                  ),
                ),

                // القائمة التدريجية لكروت التقارير (SliverList) مع الملاحظة المدمجة مباشرة
                SliverPadding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 5.h),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                          (context, index) {
                        return Container(
                          margin: EdgeInsets.only(bottom: 15.h),
                          decoration: BoxDecoration(
                            color: ColorManager.white,
                            borderRadius: BorderRadius.circular(15.r),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.03),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                            border: Border.all(color: ColorManager.hintGrey.withOpacity(0.3)),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(16.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                // 1. استخدام الويدجت الجديد لعرض اسم المندوب
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    InfoRowItem(
                                      icon: Icons.person_outline_rounded,
                                      value: state.doctordetails[index].repName,
                                    ),
                                    InfoRowItem(
                                      icon: Icons.calendar_month_outlined,
                                      value: state.doctordetails[index].visitDate,
                                    ),
                                  ],
                                ),
                                //
                                // SizedBox(height: 8.h),
                                // const Divider(height: 1, thickness: 0.5, color: Color(0xFFF1F1F1)),
                                SizedBox(height: 12.h),
                                // 🌟 3. قسم ملاحظة المكتب العلمي (مدمج مباشرة وثابت داخل الكارد)
                                Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.all(12.w),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFF8F9FA), // لون هادئ لتمييز الملاحظة
                                    borderRadius: BorderRadius.circular(10.r),
                                    border: Border.all(color: Colors.grey.shade100),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(Icons.rate_review_outlined, color: ColorManager.secondaryColor1, size: 16.sp),
                                          SizedBox(width: 6.w),
                                          Text(
                                            "ملاحظات المكتب العلمي:",
                                            style: TextStyle(
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.bold,
                                              color: ColorManager.secondaryColor1,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 6.h),
                                      Text(
                                        state.doctordetails[index].note.toString().isNotEmpty
                                            ? state.doctordetails[index].note.toString()
                                            : "لا توجد ملاحظات مسجلة.",
                                        style: TextStyle(
                                          fontSize: 12.sp,
                                          color: Colors.black87,
                                          height: 1.4, // تباعد سطري مريح للقراءة
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      childCount: state.doctordetails.length,
                    ),
                  ),
                ),
              ],
            );
          }
          return const SizedBox();
        },
      ),
    );
  }

  // دالة مساعدة لتنسيق أيقونة الهيدر مع النصوص بشكل آمن ومحمي من الـ Overflow
  Widget _buildHeaderInfo({required IconData icon, required String label}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.white70, size: 14.sp),
          SizedBox(width: 6.w),
          Flexible(
            child: Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white70, fontSize: 13.sp),
            ),
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
