// ignore_for_file: must_be_immutable
import 'package:domina_app/app/user_info.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/resources/values_manager.dart';
import 'package:domina_app/presentation/senior/plan_review/bloc/future_rep_bloc.dart';
import 'package:domina_app/presentation/uniti/circle_number_widget.dart';
import 'package:domina_app/presentation/uniti/search_field.dart';
import 'package:domina_app/presentation/uniti/stateWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RepPlanBrandSpPage extends StatefulWidget {
  final String title;
  final int? flag;
  const RepPlanBrandSpPage({super.key, required this.title, this.flag});

  @override
  State<RepPlanBrandSpPage> createState() => _RepPlanBrandSpPageState();
}

class _RepPlanBrandSpPageState extends State<RepPlanBrandSpPage>
    with AutomaticKeepAliveClientMixin {
  List<PlanBrandSp> planBrandsp = [];

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final TextEditingController searchController = TextEditingController();

    return Scaffold(
      backgroundColor: const Color(0xFFF3F6F9), // خلفية ناعمة
      floatingActionButton: FloatingActionButton.extended(
        label: const Text("حفظ التعديلات",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        icon: const Icon(Icons.save_as_rounded, color: Colors.white),
        onPressed: () {
          BlocProvider.of<FutureRepBloc>(context).add(UpdateAmountEvent());
        },
        backgroundColor: ColorManager.secondaryColor1,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            // AppBar متفاعل يختفي عند التمرير
            SliverAppBar(
              pinned: true,
              floating: true,
              title: Text(widget.title),
            ),
            // شريط البحث "يتحرك" مع التمرير
            SliverToBoxAdapter(
              child: Container(
                color: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 8.h),
                child: SearchField(
                  searchController: searchController,
                  onPressed: (value) {
                    BlocProvider.of<FutureRepBloc>(context)
                        .add(SearchPlanBrandsEvent(value));
                  },
                ),
              ),
            ),
          ];
        },
        body: BlocConsumer<FutureRepBloc, FutureRepState>(
          listener: (context, state) {
            if (state is FutureRepPlanBrandSpErrorState) {
              error(context, state.failure.massage, state.failure.code);
            }
            if (state is SumErrorState) {
              error(context, state.failure.massage, state.failure.code);
            }
            if (state is FutureSpRepErrorState) {
              error(context, state.failure.massage, state.failure.code);
            }
            if (state is UpdateAmountLoadingState) {
              loading(context);
            }
            if (state is UpdateAmountState) {
              success(context);
              Navigator.pop(context);
            }
          },
          builder: (context, state) {
            if (state is FutureRepPlanBrandSpState) {
              planBrandsp = state.planBrandSp;
            }
            if (state is FutureRepPlanBrandSpLoadingState) {
              return loadingFullScreen(context);
            }
            if (state is FutureRepPlanBrandSpEmptyState) {
              return emptyFullScreen(context);
            }
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 80.h),
              child: Column(
                children: [
                  // بطاقة الإحصائيات العلوية
                  _buildSummaryInfo(),
                  SizedBox(height: 16.h),
                  // قائمة البطاقات
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: planBrandsp.length,
                    itemBuilder: (context, index) =>
                        _buildModernCard(index, state),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  // ملخص علوي أنيق
  Widget _buildSummaryInfo() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.r),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10)
        ],
        border: Border(
            right: BorderSide(color: ColorManager.secondaryColor1, width: 4)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "إحصائيات توزيع العينات:",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14.sp,
                color: Colors.grey.shade700),
          ),
          CircleNumberWidget(
              number: BlocProvider.of<FutureRepBloc>(context).number),
        ],
      ),
    );
  }

  // تصميم البطاقة الفاخر
  Widget _buildModernCard(int index, FutureRepState state) {
    final item = planBrandsp[index];
    Color typeColor = item.brandType == 1
        ? ColorManager.secondaryColor1
        : const Color(0xFF9C27B0);
    bool isEditable = widget.flag == 5 &&
        (UserInfo.otherstatus == 0 || state is! SumErrorState);

    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18.r),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 12,
              offset: const Offset(0, 4))
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18.r),
        child: Stack(
          children: [
            Positioned(
                left: 0,
                top: 0,
                bottom: 0,
                child: Container(width: 5, color: typeColor)),
            Padding(
              padding: EdgeInsets.all(16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.medication_rounded,
                          color: typeColor, size: 20.sp),
                      SizedBox(width: 8.w),
                      Expanded(
                        child: Text(
                          item.titleAr,
                          style: TextStyle(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.bold,
                              color: ColorManager.secondaryColor1),
                        ),
                      ),
                      _buildBadge(
                          item.brandType == 1 ? "هدف" : "مساعد", typeColor),
                    ],
                  ),
                  SizedBox(height: 12.h),
                  Row(
                    children: [
                      Icon(Icons.category_outlined,
                          size: 14.sp, color: Colors.grey),
                      SizedBox(width: 6.w),
                      Text("النوع: ${item.phTitle}",
                          style: TextStyle(
                              color: Colors.grey.shade600, fontSize: 12.sp)),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 12),
                    child: Divider(height: 1, thickness: 0.5),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("العدد المطلوب:",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 13.sp)),
                      Container(
                        width: 90.w,
                        height: 40.h,
                        decoration: BoxDecoration(),
                        child: TextField(
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          enabled: isEditable,
                          onChanged: (value) {
                            if (value.isNotEmpty) {
                              BlocProvider.of<FutureRepBloc>(context).add(
                                  ChangeFieldEvent(int.parse(value), index));
                            }
                          },
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: typeColor),
                          decoration: InputDecoration(
                            hintText: item.totalAmount.toString(),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.zero,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBadge(String text, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
      decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(6.r)),
      child: Text(text,
          style: TextStyle(
              color: color, fontSize: 10.sp, fontWeight: FontWeight.bold)),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
