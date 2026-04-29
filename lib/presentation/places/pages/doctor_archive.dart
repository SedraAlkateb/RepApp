import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/places/bloc/place_bloc.dart';
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
      // لون الخلفية من الصورة يبدو فاتحاً جداً أو رمادي خفيف
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: CustomScrollView(
            // فيزياء الحركة "Bouncing" تعطي إحساساً رائعاً عند السحب مثل الصورة
            physics: const BouncingScrollPhysics(),
            slivers: [
              BlocBuilder<PlaceBloc, PlaceState>(
                buildWhen: (previous, current) =>
                current is AllDoctorArchiveByPlaceState ||
                    current is AllDoctorArchiveByPlaceErrorState ||
                    current is EmptyArchiveState,
                builder: (context, state) {

                  // 1. حالة النجاح: نعرض البحث والقائمة كـ Slivers لكي يتحركوا معاً
                  if (state is AllDoctorArchiveByPlaceState) {
                    List<DoctorModel> doctorModel = state.searchData;
                    return SliverMainAxisGroup(
                      slivers: [
                        // حقل البحث مغلف بـ SliverToBoxAdapter ليعمل داخل الـ CustomScrollView
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
                        // عرض قائمة الأطباء
                        SliverToBoxAdapter(
                          child: DoctorListWidget(doctorModel: doctorModel),
                        ),
                        // مسافة أمان في الأسفل
                        SliverToBoxAdapter(child: SizedBox(height: 20.h)),
                      ],
                    );
                  }

                  // 2. حالة الخطأ: نستخدم SliverFillRemaining لتتوسط الشاشة
                  if (state is AllDoctorArchiveByPlaceErrorState) {
                    return SliverFillRemaining(
                      hasScrollBody: false,
                      child: Center(
                        child: errorFullScreen(
                          context,
                          mes: state.failure.massage,
                          func: () {},
                        ),
                      ),
                    );
                  }

                  // 3. حالة القائمة فارغة
                  if (state is EmptyArchiveState) {
                    return SliverFillRemaining(
                      hasScrollBody: false,
                      child: Center(child: emptyFullScreen(context)),
                    );
                  }

                  // 4. حالة التحميل
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
}