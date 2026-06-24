// ignore_for_file: must_be_immutable
import 'package:domina_app/app/di.dart';
import 'package:domina_app/app/user_info.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/resources/routes_manager.dart';
import 'package:domina_app/presentation/senior/edit_brand_plan/bloc/edit_brand_plan_bloc.dart';
import 'package:domina_app/presentation/senior/edit_brand_plan/page/auditing_plan.dart';
import 'package:domina_app/presentation/senior/manage_future/bloc/manage_future_bloc.dart';
import 'package:domina_app/presentation/senior/manage_future/widget/drop_down_change_plan.dart';
import 'package:domina_app/presentation/senior/plan_review/bloc/future_rep_bloc.dart';
import 'package:domina_app/presentation/senior/plan_review/page/future_spec.dart';
import 'package:domina_app/presentation/uniti/search_field.dart';
import 'package:domina_app/presentation/uniti/stateWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shimmer/shimmer.dart';

class AllRepWithFuture extends StatefulWidget {
  const AllRepWithFuture({super.key});

  @override
  State<AllRepWithFuture> createState() => _AllRepWithFutureState();
}

class _AllRepWithFutureState extends State<AllRepWithFuture> with TickerProviderStateMixin {
  final TextEditingController searchController = TextEditingController();
  int selectedIndex = -1;
  final RefreshController _refreshController = RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FA),
      appBar: AppBar(title: const Text("إدارة الخطة الفعالة")),
      body: Column(
        children: [
          SizedBox(height: 12.h),
          SearchField(
            searchController: searchController,
            onPressed: (value) {
              BlocProvider.of<ManageFutureBloc>(context).add(SenSearchRepFutureEvent(value));
            },
          ),
          Expanded(
            child: BlocBuilder<ManageFutureBloc, ManageFutureState>(
              builder: (context, state) {
                List<AllRepresentativeFuture> allRepresentative = context.watch<ManageFutureBloc>().allRepresentative;

                if (state is AllSeniorRepLoadingState) return _buildLoadingShimmer();
                if (state is AllSeniorRepErrorState) {
                  return errorFullScreen(context, func: () => BlocProvider.of<ManageFutureBloc>(context).add(AllSeniorRepFutureEvent()));
                }

                return SmartRefresher(
                  controller: _refreshController,
                  onRefresh: () {
                    BlocProvider.of<ManageFutureBloc>(context).add(AllSeniorRepFutureEvent());
                    _refreshController.refreshCompleted();
                  },
                  child: ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                    itemCount: allRepresentative.length,
                    itemBuilder: (context, index) {
                      // 1. Staggered Entrance Animation
                      return _buildRepItem(allRepresentative[index], index);
                    },
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 12.h),
        ],
      ),
    );
  }

  Widget _buildRepItem(AllRepresentativeFuture rep, int index) {
    bool isSelected = selectedIndex == index;
    return GestureDetector(
      onTap: () => setState(() => selectedIndex = isSelected ? -1 : index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOutQuart,
        margin: EdgeInsets.only(bottom: 16.h, left: 4.w, right: 4.w),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(22.r),
          // إضافة ظل ناعم جداً ملون عند الاختيار
          boxShadow: [
            BoxShadow(
              color: isSelected
                  ? ColorManager.secondaryColor1.withOpacity(0.15)
                  : Colors.black.withOpacity(0.05),
              blurRadius: 15,
              offset: const Offset(0, 8),
            ),
          ],
          border: Border.all(
              color: isSelected ? ColorManager.secondaryColor1 : Colors.transparent,
              width: 1.8
          ),
        ),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. زر السهم بتصميم دائري أكثر بروزاً
                AnimatedRotation(
                  turns: isSelected ? 0.0 : 0.5,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeOutBack,
                  child: Container(
                    padding: EdgeInsets.all(8.w),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? ColorManager.secondaryColor1
                          : ColorManager.secondaryColor1.withOpacity(0.08),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.keyboard_arrow_up_rounded,
                      color: isSelected ? Colors.white : ColorManager.secondaryColor1,
                      size: 22.sp,
                    ),
                  ),
                ),
                SizedBox(width: 14.w),

                // 2. المحتوى النصي بتنسيق أفضل
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Text(
                              rep.name,
                              style: TextStyle(
                                color: const Color(0xFF1A237E), // كحلي عميق للفخامة
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.3,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          // نقطة الحالة تنبض باللون الخاص بها
                          _buildPulseDot(rep.flag.flag,rep.reptype),
                        ],
                      ),
                      SizedBox(height: 12.h),


                      // الدرو داون مغلف بكونتينر رمادي فاتح لتمييزه كحقل إدخال
                      DropDownChangePlan(
                          hintText: rep.flag.name,
                          items: allFlags,
                          statusColor: getColor(rep.flag.flag),
                          onChanged: (x) {

                            BlocProvider.of<ManageFutureBloc>(context).add(

                              ChangPlanStatusEvent(rep.activePlan, x.flag, index),
                            );
                          },
                          errorText: "",
                        ),

                    ],
                  ),
                ),
              ],
            ),

            // 3. قسم الأزرار مع حركة انزلاق (Slide)
            AnimatedSize(
              duration: const Duration(milliseconds: 400),
              curve: Curves.fastOutSlowIn,
              child: isSelected
                  ? Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 20.h),
                    child: Divider(color: Colors.grey.shade100, thickness: 1.5),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: _buildMicroActionButton(
                          title: "تدقيق الخطة",
                          subtitle: "مراجعة شاملة",
                          icon: Icons.fact_check_rounded,
                          isActive: rep.flag.flag == UserInfo.statusPlan,
                          color: ColorManager.secondaryColor1,
                          onTap: () => _handleAuditing(rep),
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: _buildMicroActionButton(
                          title: "الأصناف",
                          subtitle: "تعديل القائمة",
                          icon: Icons.auto_awesome_motion_rounded,
                          isActive: true,
                          color: const Color(0xFF448AFF), // أزرق حيوي
                          onTap: () => _handleEditBrands(rep),
                        ),
                      ),
                    ],
                  ),
                ],
              )
                  : const SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }

  // تطوير زر الأكشن ليكون أكثر حيوية (Micro-interactions)
  Widget _buildMicroActionButton({
    required String title,
    required String subtitle,
    required IconData icon,
    required bool isActive,
    required Color color,
    required VoidCallback onTap,
  }) {
    return StatefulBuilder(
      builder: (context, setBtnState) {
        bool isPressed = false;
        return GestureDetector(
          onTapDown: (_) => setBtnState(() => isPressed = true),
          onTapUp: (_) => setBtnState(() => isPressed = false),
          onTapCancel: () => setBtnState(() => isPressed = false),
          onTap: isActive ? onTap : null,
          child: AnimatedScale(
            scale: 1.0,
            duration: const Duration(milliseconds: 100),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 10.w),
              decoration: BoxDecoration(
                // لون خلفية خفيف جداً من نفس لون الزر يعطي طابعاً احترافياً
                color: isActive ? color.withOpacity(0.05) : Colors.grey.shade50,
                borderRadius: BorderRadius.circular(18.r),
                border: Border.all(
                    color: isActive ? color.withOpacity(0.3) : Colors.transparent,
                    width: 1.5
                ),
              ),
              child: Column(
                children: [
                  Icon(icon, color: isActive ? color : Colors.grey, size: 22.sp),
                  SizedBox(height: 6.h),
                  FittedBox(
                    child: Text(
                      title,
                      style: TextStyle(
                        color: isActive ? color : Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontSize: 13.sp,
                      ),
                    ),
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(color: Colors.grey.shade500, fontSize: 9.sp),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
  Color getColor(int flag){
    if(flag==0){
      return Colors.blue;
    }else if(flag==5){
      return Colors.orange;
    }else if(flag==1){
      return Colors.red;
    }else if(flag==2){
      return Colors.green;
    }
    else if(flag==3){
      return Colors.black;
    }
    return Colors.purple;
  }
  // 4. Pulsing Dot Animation logic
  Widget _buildPulseDot(int flag,String repType) {
    Color color = getColor(flag);
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.4, end: 1.0),
      duration: const Duration(seconds: 1),
      curve: Curves.easeInOut,
      builder: (context, value, child) {
        return Row(
          children: [
            Text(UserInfo.getRepType(repType)),

            Container(
              width: 10.w,
              height: 10.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: color,
                boxShadow: [
                  BoxShadow(color: color.withOpacity(0.5), blurRadius: 10 * (1 - value), spreadRadius: 4 * (1 - value)),
                ],
              ),
            ),
          ],
        );
      },
      onEnd: () => {}, // Loop handled by the builder naturally
    );
  }

  // Navigation Handlers with Animation logic
  void _handleAuditing(AllRepresentativeFuture rep) {
    iniFutureModule();
    if(rep.reptype=="7"){

      Navigator.push(context, _createRoute(FutureSpecializationsPage(
        id: rep.id,
        repPlanId: rep.activePlan,
        flag: rep.flag,
        sampleCount: rep.samplesCount,
      )));
    }else{
      BlocProvider.of<FutureRepBloc>(context).add(
        FutureRepPlanBrandSpEvent(
          RepSp(rep.activePlan, 38, rep.id),
          rep.samplesCount,
        ),
      );
      Navigator.pushNamed(
        context,
        Routes.RepPlanBrandSp,
        arguments: {
          'title': "كل الاختصاصات",
          'flag':  rep.flag.flag,
        },
      );
    }


  }

  void _handleEditBrands(AllRepresentativeFuture rep) {
    iniEditBrandPlanModule();
    BlocProvider.of<EditBrandPlanBloc>(context).add(FutureGetPlanBrandEvent(Rep(rep.activePlan, 1)));
    Navigator.push(context, _createRoute(EditingPlan(repPlan: rep.activePlan)));
  }

  Route _createRoute(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = const Offset(1.0, 0.0);
        var end = Offset.zero;
        var curve = Curves.easeOutQuart;
        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        return SlideTransition(position: animation.drive(tween), child: child);
      },
    );
  }

  Widget _buildLoadingShimmer() {
    return ListView.builder(
      itemCount: 5,
      padding: EdgeInsets.all(16.w),
      itemBuilder: (context, index) => Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Container(
          height: 100.h,
          margin: EdgeInsets.only(bottom: 15.h),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(25.r)),
        ),
      ),
    );
  }
}