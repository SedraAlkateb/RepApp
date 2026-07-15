import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/senior/search_doctors/bloc/search_doctors_bloc.dart';
import 'package:domina_app/presentation/senior/search_doctors/page/hospital_details.dart';
import 'package:domina_app/presentation/senior/search_doctors/widgets/search_do_hos_widget.dart';
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
      body: Column(
        children: [
          buildHeaderSection(searchController, context),
          Expanded(
            child: _buildResultList(),
          ),
        ],
      ),
    );
  }

  // عرض النتائج باستخدام العرض التدريجي الكسول (Lazy Loading)
  Widget _buildResultList() {
    return BlocBuilder<SearchDoctorsBloc, SearchDoctorsState>(
      buildWhen: (previous, current) =>
      current is FutureSearchHospitalsErrorState ||
          current is FutureSearchHospitalsLoadingState ||
          current is FutureSearchHospitalsState ||
          current is FutureSearchHospitalsEmptyState,
      builder: (context, state) {

        // 1. حالة الخطأ
        if (state is FutureSearchHospitalsErrorState) {
          return CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: errorFullScreen(context, func: () {
                  BlocProvider.of<SearchDoctorsBloc>(context)
                      .add(FutureSearchHosEvent(searchController.text));
                }, mes: state.failure.massage),
              ),
            ],
          );
        }

        // 2. حالة التحميل
        if (state is FutureSearchHospitalsLoadingState) {
          return CustomScrollView(
            slivers: [
              SliverPadding(
                padding: EdgeInsets.all(16.w),
                sliver: SliverToBoxAdapter(
                  child: loadingShimmer(context, 10, 100, 100, BorderRadius.circular(15.r)),
                ),
              ),
            ],
          );
        }

        // 3. حالة البيانات الفارغة
        if (state is FutureSearchHospitalsEmptyState) {
          return CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: emptyFullScreen(context),
              ),
            ],
          );
        }

        // 4. حالة نجاح جلب البيانات وعرضها تدريجياً بكفاءة عالية (SliverList)
        if (state is FutureSearchHospitalsState) {
          return CustomScrollView(
            physics: const BouncingScrollPhysics(), // تمرير مرن ومريح للمستخدم
            slivers: [
              SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                        (context, index) {
                      // بناء العنصر فقط عندما يقترب من الظهور على الشاشة
                      return _hospitalWidget(
                        title: state.allSearch[index].name,
                        function: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HospitalDetails(
                                searchHospitalModel: state.allSearch[index],
                              ),
                            ),
                          );
                          BlocProvider.of<SearchDoctorsBloc>(context).add(
                            FutureDocHospitalEvent(
                              int.parse(state.allSearch[index].hosId),
                              int.parse(state.allSearch[index].spId),
                            ),
                          );
                        },
                      );
                    },
                    childCount: state.allSearch.length, // العدد الإجمالي للمشافي
                  ),
                ),
              ),
            ],
          );
        }

        // الحالة الافتراضية قبل البدء بالبحث
        return CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Center(
                child: Text(
                  "ابدأ البحث عن المشافي الآن",
                  style: TextStyle(color: Colors.grey, fontSize: 14.sp),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  // ويدجت عرض المشفى (الكارت) بقيت كما هي تماماً
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