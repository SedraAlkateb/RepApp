import 'package:domina_app/domain/models/models.dart';

import 'package:domina_app/presentation/senior/edit_brand_plan/bloc/edit_brand_plan_bloc.dart';
import 'package:domina_app/presentation/senior/edit_brand_plan/widgets/editing_plan_assistant.dart';
import 'package:domina_app/presentation/senior/edit_brand_plan/widgets/editing_plan_target.dart';
import 'package:domina_app/presentation/senior/manage_future/bloc/manage_future_bloc.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/uniti/stateWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EditingPlan extends StatelessWidget {
  EditingPlan({super.key, required this.repPlan,required this.repName});
  final int repPlan;
  final String repName;
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // منطق الرجوع للخلف لتحديث القائمة السابقة
    Future<bool> _onWillPop() async {
      BlocProvider.of<ManageFutureBloc>(context).add(AllSeniorRepFutureEvent());
      return true;
    }

    return DefaultTabController(
      length: 2,
      child: WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(


          backgroundColor: const Color(0xFFF8F9FB), // خلفية ناعمة لإبراز العناصر
          body: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                // الهيدر المتفاعل (SliverAppBar)
                SliverAppBar(
                  elevation: 0,
                  pinned: true,
                  floating: true,
                  snap: true,
                  backgroundColor: Colors.white,
                  leading: IconButton(
                    icon: Icon(Icons.arrow_back_ios_new, color: ColorManager.secondaryColor1, size: 22.sp),
                    onPressed: () {
                      _onWillPop();
                      Navigator.pop(context);
                    },
                  ),
                  title: Text(
                    "تعديل أصناف خطة ${repName}",
                    style: TextStyle(
                      color: ColorManager.secondaryColor1,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.sp,
                    ),
                  ),
                ),
                // الـ TabBar العائم داخل الحاوية البيضاء
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 12.h),
                    child: Container(
                      height: 55.h,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15.r),
                        border: Border.all(color: Colors.grey.shade200),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.02),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: TabBar(
                        padding: const EdgeInsets.all(4),
                        dividerColor: Colors.transparent,
                        labelColor: Colors.white,
                        unselectedLabelColor: Colors.grey.shade400,
                        labelStyle: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14.sp),
                        indicatorSize: TabBarIndicatorSize.tab,
                        indicator: BoxDecoration(
                          color: ColorManager.secondaryColor1, // اللون الرئيسي المعتمد
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        onTap: (value) {
                          // استدعاء أحداث الـ Bloc بناءً على التبويب المختار
                          if (value == 0) {
                            BlocProvider.of<EditBrandPlanBloc>(context)
                                .add(FutureGetPlanBrandEvent(Rep(repPlan, 1)));
                          } else {
                            BlocProvider.of<EditBrandPlanBloc>(context)
                                .add(FutureGetPlanBrandEvent(Rep(repPlan, 2)));
                          }
                        },
                        tabs: [
                          Tab(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.star_outline_rounded),
                                SizedBox(width: 8.w),
                                const Text('الهدف'),
                              ],
                            ),
                          ),
                          Tab(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.support_agent_rounded),
                                SizedBox(width: 8.w),
                                const Text('مساعد'),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ];
            },
            // المحتوى الذي يتغير بناءً على الـ Tabs
            body: TabBarView(
              physics: const NeverScrollableScrollPhysics(),              children: [
                EditingPlanTarget(repPlan: repPlan),
                EditingPlanAssistant(repPlan: repPlan),
              ],
            ),
          ),
        ),
      ),
    );
  }
}