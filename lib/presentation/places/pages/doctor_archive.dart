import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/places/bloc/place_bloc.dart';
// استدعاء كارد الطبيب الفردي المطور والسريع
import 'package:domina_app/presentation/uniti/basic/doctor.dart';
import 'package:domina_app/presentation/uniti/search_field.dart';
import 'package:domina_app/presentation/uniti/stateWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DoctorArchive extends StatelessWidget {
  DoctorArchive({super.key});
  final TextEditingController searchDocController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50], // خلفية ناعمة ومريحة للعين تعزل الكروت
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          child: BlocBuilder<PlaceBloc, PlaceState>(
            buildWhen: (previous, current) =>
            current is AllDoctorArchiveByPlaceState ||
                current is AllDoctorArchiveByPlaceErrorState ||
                current is EmptyArchiveState,
            builder: (context, state) {

              // 1. حالة النجاح وعرض البيانات
              if (state is AllDoctorArchiveByPlaceState) {
                List<DoctorModel> doctorModel = state.searchData;

                return CustomScrollView(
                  physics: const BouncingScrollPhysics(),
                  slivers: [
                    // حقل البحث مدمج بسلاسة في الأعلى
                    SliverToBoxAdapter(
                      child: Column(
                        children: [
                          SizedBox(height: 12.h),
                          SearchField(
                            searchController: searchDocController,
                            onPressed: (value) {
                              BlocProvider.of<PlaceBloc>(context)
                                  .add(SearchDoctorArchive(value, state.BaseData));
                            },
                          ),
                          SizedBox(height: 16.h),
                        ],
                      ),
                    ),

                    // الحل السحري: بناء قائمة الأطباء بذكاء وسرعة صاروخية 🚀
                    SliverList.builder(
                      itemCount: doctorModel.length,
                      itemBuilder: (context, index) {
                        // نمرر طبيب واحد فقط لكل كارد ليتم بناء العناصر الظاهرة على الشاشة فقط
                        return DoctorCardItem(doctor: doctorModel[index]);
                      },
                    ),

                    // مسافة أمان مريحة في الأسفل بعد انتهاء القائمة
                    SliverToBoxAdapter(child: SizedBox(height: 24.h)),
                  ],
                );
              }

              // 2. حالة الخطأ
              if (state is AllDoctorArchiveByPlaceErrorState) {
                return CustomScrollView(
                  slivers: [
                    SliverFillRemaining(
                      hasScrollBody: false,
                      child: Center(
                        child: errorFullScreen(
                          context,
                          mes: state.failure.massage,
                          func: () {},
                        ),
                      ),
                    ),
                  ],
                );
              }

              // 3. حالة القائمة فارغة
              if (state is EmptyArchiveState) {
                return CustomScrollView(
                  slivers: [
                    SliverFillRemaining(
                      hasScrollBody: false,
                      child: Center(child: emptyFullScreen(context)),
                    ),
                  ],
                );
              }

              // 4. حالة التحميل الأساسي (Loading)
              return const CustomScrollView(
                slivers: [
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Center(child: CircularProgressIndicator(color: Colors.blue)),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}