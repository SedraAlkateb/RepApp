import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/senior/search_doctors/bloc/search_doctors_bloc.dart';
import 'package:domina_app/presentation/senior/search_doctors/widgets/info_row_item.dart';
import 'package:domina_app/presentation/uniti/search_field.dart';
import 'package:domina_app/presentation/uniti/stateWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HospitalDetails extends StatefulWidget {
  final SearchHospitalModel searchHospitalModel;
  const HospitalDetails({super.key, required this.searchHospitalModel});

  @override
  State<HospitalDetails> createState() => _HospitalDetailsState();
}

class _HospitalDetailsState extends State<HospitalDetails>
    with AutomaticKeepAliveClientMixin {
  final TextEditingController searchNoteHospitalController =
  TextEditingController();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA), // خلفية فاتحة ومريحة للعين تبرز الكروت
      appBar: null,
      body: BlocBuilder<SearchDoctorsBloc, SearchDoctorsState>(
        buildWhen: (previous, current) =>
        current is FutureDocHospitalsState ||
            current is FutureDocHospitalsErrorState ||
            current is FutureDocHospitalsLoadingState ||
            current is FutureDocHospitalsEmptyState,
        builder: (context, state) {

          // 1. حالة الخطأ البرمجي
          if (state is FutureDocHospitalsErrorState) {
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

          // 2. حالة التحميل والانتظار
          if (state is FutureDocHospitalsLoadingState) {
            return CustomScrollView(
              slivers: [
                SliverFillRemaining(
                  child: Center(child: loadingFullScreen(context)),
                ),
              ],
            );
          }

          // 3. حالة البيانات الفارغة من السيرفر
          if (state is FutureDocHospitalsEmptyState) {
            return CustomScrollView(
              slivers: [
                SliverFillRemaining(
                  child: Center(child: emptyFullScreen(context)),
                ),
              ],
            );
          }

          // 4. حالة النجاح وعرض التقارير تدريجياً وبأناقة بصرية
          if (state is FutureDocHospitalsState) {

            // 🌟 خطوة استخراج أول حرف آمن [0] من اسم المستشفى مع تنظيف المسافات المخفية
            final String cleanName = widget.searchHospitalModel.name.trim();
            final String firstLetter = cleanName.isNotEmpty
                ? cleanName[0].toUpperCase()
                : "?";

            return CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                // هيدر الشاشة المتجاوب والملون بلغة الهوية البصرية للشركة
                SliverAppBar(
                  expandedHeight: 310.h, // تم تعديل الطول ليتناسب مع تصميم الكارت والمحتوى الجديد الهرمي
                  automaticallyImplyLeading: false,
                  pinned: true,
                  backgroundColor: ColorManager.secondaryColor1,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(40),
                    ),
                  ),
                  flexibleSpace: FlexibleSpaceBar(
                    background: Stack(
                      children: [
                        // زر العودة المثبت في الأعلى جهة اليمين المتوافق مع RTL
                        Positioned(
                          top: 40.h,
                          right: 10.w,
                          child: IconButton(
                            icon: const Icon(Icons.arrow_back, color: Colors.white, size: 30),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ),

                        // محتوى البيانات المركزي للهيدر الأنيق والمربع الناعم للحرف الأول
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
                                // 🌟 مربع الحرف الأول الاحترافي المحدث والمحمي بـ FittedBox
                                Container(
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
                                      fit: BoxFit.contain,
                                      child: Padding(
                                        padding: EdgeInsets.all(6.r),
                                        child: Text(
                                          firstLetter,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 12.h),

                                // اسم المستشفى الكامل
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                                  child: Text(
                                    widget.searchHospitalModel.name,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 22.sp,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // حقل البحث كعنصر ثابت مستقل داخل الـ ScrollView
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.h),
                    child: SearchField(
                      searchController: searchNoteHospitalController,
                      onPressed: (value) {
                        BlocProvider.of<SearchDoctorsBloc>(context)
                            .add(SearchNoteHosEvent(value));
                      },
                    ),
                  ),
                ),

                // قائمة التقارير والملاحظات المدمجة مباشرة وثابتة دون BottomSheet
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
                                // 🌟 1. استخدام ويدجت العرض الثنائي المشترك والمحمي من الـ Overflow لاسم المندوب والتاريخ
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 5,
                                      child: InfoRowItem(
                                        icon: Icons.person_outline_rounded,
                                        value: state.allNote[index].name,
                                      ),
                                    ),
                                    SizedBox(width: 8.w),
                                    Expanded(
                                      flex: 4,
                                      child: InfoRowItem(
                                        icon: Icons.calendar_month_outlined,
                                        value: state.allNote[index].visitDate,
                                      ),
                                    ),
                                  ],
                                ),

                                SizedBox(height: 12.h),

                                // 🌟 2. حاوية ملاحظات المكتب العلمي المدمجة مباشرة داخل الكارد لتوحيد مظهر التطبيق
                                Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.all(12.w),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFF8F9FA),
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
                                        state.allNote[index].note.toString().trim().isNotEmpty && state.allNote[index].note.toString() != "null"
                                            ? state.allNote[index].note.toString()
                                            : "لا توجد ملاحظات مسجلة.",
                                        style: TextStyle(
                                          fontSize: 12.sp,
                                          color: Colors.black87,
                                          height: 1.4,
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
                      childCount: state.allNote.length,
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

  @override
  bool get wantKeepAlive => true;
}

// 🌟 ويدجت العرض المنظم والأنيق الموحد للمشروع لضمان التناسق التام
