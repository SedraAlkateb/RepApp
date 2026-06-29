import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/doctors/bloc/doctors_bloc.dart';
// تم استبدال الكلاس القديم بكارد الطبيب الفردي المستقر
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/uniti/basic/doctor.dart';
import 'package:domina_app/presentation/uniti/search_field.dart';
import 'package:domina_app/presentation/uniti/stateWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Doctors extends StatefulWidget {
  const Doctors({super.key});

  @override
  State<Doctors> createState() => _DoctorsState();
}

class _DoctorsState extends State<Doctors> {
  final TextEditingController searchDocController = TextEditingController();

  @override
  void dispose() {
    searchDocController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.w),
        child: BlocBuilder<DoctorsBloc, DoctorsState>(
          buildWhen: (previous, current) =>
          current is AllDoctorState ||
              current is AllDoctorEmptyState ||
              current is AllDoctorErrorState ||
              current is AllDoctorLoadingState,
          builder: (context, state) {
            // جلب القائمة الأساسية من الـ Bloc
            List<DoctorModel> doctorModel = context.read<DoctorsBloc>().doctor;

            if (state is AllDoctorLoadingState) {
              return const Center(child: CircularProgressIndicator(color: Colors.blue));
            }

            if (state is AllDoctorErrorState) {
              return errorFullScreen(context, mes: state.failure.massage, func: () {});
            }

            if (state is AllDoctorEmptyState || doctorModel.isEmpty) {
              return emptyFullScreen(context);
            }

            if (state is AllDoctorState) {
              doctorModel = state.doctor;
            }

            return CustomScrollView(
              slivers: [
                // 1. شريط البحث العلوي ثابت
                SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 12.h),
                      SearchField(
                        searchController: searchDocController,
                        onPressed: (value) {
                          // البحث هنا سيكون فوري وسريع جداً لأنه فلترة محليّة بالـ Bloc
                          BlocProvider.of<DoctorsBloc>(context).add(SearchDocEvent(value));
                        },
                      ),

                      // عنوان القسم والعدد الاجمالي
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "قائمة الأطباء المسجلين",
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
                                " ${doctorModel.length} طبيب",
                                style: TextStyle(
                                    color: ColorManager.medicalPrimary,
                                    fontSize: 11.sp),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // 2. عرض الـ 2000 طبيب بكفاءة عالية (Lazy Loading) 🚀
                SliverList.builder(
                  itemCount: doctorModel.length,
                  itemBuilder: (context, index) {
                    return DoctorCardItem(doctor: doctorModel[index]);
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}