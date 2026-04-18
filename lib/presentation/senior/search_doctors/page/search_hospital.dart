import 'package:domina_app/presentation/resources/assets_manager.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/senior/search_doctors/bloc/search_doctors_bloc.dart';
import 'package:domina_app/presentation/senior/search_doctors/page/hospital_details.dart';
import 'package:domina_app/presentation/uniti/search_field.dart';
import 'package:domina_app/presentation/uniti/stateWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchHospital extends StatefulWidget {
  const SearchHospital({super.key});

  @override
  State<SearchHospital> createState() => _SearchHospitalState();
}

class _SearchHospitalState extends State<SearchHospital>
    with AutomaticKeepAliveClientMixin {
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FA), // خلفية فاتحة جداً لإبراز الكروت
      body: Stack(
        children: [
          // خلفية الصورة مع طبقة شفافة علوية
          Positioned.fill(
            child: Opacity(
              opacity: 0.05,
              child: Image.asset(
                ImageAssets.doctor2,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                _buildHeaderSection(),
                Expanded(
                  child: _buildResultList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // الجزء العلوي الذي يحتوي على حقل البحث والزر
  Widget _buildHeaderSection() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(25.r),
          bottomRight: Radius.circular(25.r),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 5),
          )
        ],
      ),
      child: Row(
        children: [
          // زر البحث بتصميم عصري
          GestureDetector(
            onTap: () {
              if (searchController.text.isNotEmpty) {
                BlocProvider.of<SearchDoctorsBloc>(context)
                    .add(FutureSearchHosEvent(searchController.text));
              }
            },
            child: Container(
              height: 50.h,
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    ColorManager.secondaryColor1,
                    ColorManager.secondaryColor1.withOpacity(0.8),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(15.r),
                boxShadow: [
                  BoxShadow(
                    color: ColorManager.secondaryColor1.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  )
                ],
              ),
              child: const Center(
                child: Icon(Icons.search, color: Colors.white, size: 24),
              ),
            ),
          ),
          SizedBox(width: 10.w),
          // حقل البحث
          Expanded(
            child: SearchField(
              searchController: searchController,
            ),
          ),
        ],
      ),
    );
  }

  // عرض النتائج
  Widget _buildResultList() {
    return BlocBuilder<SearchDoctorsBloc, SearchDoctorsState>(
      buildWhen: (previous, current) =>
      current is FutureSearchHospitalsErrorState ||
          current is FutureSearchHospitalsLoadingState ||
          current is FutureSearchHospitalsState ||
          current is FutureSearchHospitalsEmptyState,
      builder: (context, state) {
        if (state is FutureSearchHospitalsErrorState) {
          return errorFullScreen(context, func: () {
            BlocProvider.of<SearchDoctorsBloc>(context)
                .add(FutureSearchHosEvent(searchController.text));
          }, mes: state.failure.massage);
        }
        if (state is FutureSearchHospitalsLoadingState) {
          return Padding(
            padding: EdgeInsets.all(16.w),
            child: loadingShimmer(context, 10, 100, 100, BorderRadius.circular(15.r)),
          );
        }
        if (state is FutureSearchHospitalsEmptyState) {
          return emptyFullScreen(context);
        }
        if (state is FutureSearchHospitalsState) {
          return ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
            itemCount: state.allSearch.length,
            itemBuilder: (context, index) {
              return _hospitalWidget(
                title: state.allSearch[index].name,
                function: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) => HospitalDetails(
                      searchHospitalModel: state.allSearch[index],
                    ),
                  ));
                  BlocProvider.of<SearchDoctorsBloc>(context).add(
                    FutureDocHospitalEvent(
                      int.parse(state.allSearch[index].hosId),
                      int.parse(state.allSearch[index].spId),
                    ),
                  );
                },
              );
            },
          );
        }
        return Center(
          child: Text(
            "ابدأ البحث عن المشافي الآن",
            style: TextStyle(color: Colors.grey, fontSize: 14.sp),
          ),
        );
      },
    );
  }

  // ويدجت عرض المشفى (الكارت)
  Widget _hospitalWidget({
    required String title,
    required VoidCallback function,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 15.h),
      padding: EdgeInsets.all(18.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: Colors.white, width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Icon(Icons.local_hospital_outlined, color: Colors.orangeAccent),
              Expanded(
                child: Text(
                  title,
                  textAlign: TextAlign.end,
                  style: TextStyle(
                    fontSize: 17.sp,
                    fontWeight: FontWeight.bold,
                    color: ColorManager.medicalPrimary,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          const Divider(height: 1, thickness: 0.5, color: Color(0xFFEEEEEE)),
          SizedBox(height: 12.h),
          Row(
            children: [
              const Spacer(),
              InkWell(
                onTap: function,
                borderRadius: BorderRadius.circular(10.r),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 8.h),
                  decoration: BoxDecoration(
                    color: ColorManager.medicalPrimary,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Row(
                    children: [
                      Text(
                        "عرض التقارير",
                        style: TextStyle(color: Colors.white, fontSize: 13.sp),
                      ),
                      SizedBox(width: 5.w),
                      Icon(Icons.analytics_outlined, color: Colors.white, size: 18.sp),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}