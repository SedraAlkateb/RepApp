// ignore_for_file: deprecated_member_use

import 'package:domina_app/app/user_info.dart';
import 'package:domina_app/presentation/async/bloc/async_bloc.dart';
import 'package:domina_app/presentation/resources/routes_manager.dart';
import 'package:domina_app/presentation/uniti/circle_number_widget.dart';
import 'package:domina_app/presentation/uniti/stateWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lucide_icons/lucide_icons.dart';

class AsyncLoginPage extends StatefulWidget {
  const AsyncLoginPage({super.key});

  @override
  State<AsyncLoginPage> createState() => _AsyncLoginPageState();
}

class _AsyncLoginPageState extends State<AsyncLoginPage> with SingleTickerProviderStateMixin {
  late AnimationController _arrowCtrl;

  @override
  void initState() {
    super.initState();
    _arrowCtrl = AnimationController(
        duration: const Duration(seconds: 1),
        vsync: this
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _arrowCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false, // منع الرجوع للخلف أثناء المزامنة
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: const SizedBox(),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  Routes.login,
                      (route) => false,
                );
                BlocProvider.of<AsyncBloc>(context).add(DeleteAllEvent());
              },
              icon: const Icon(Icons.arrow_forward, color: Color(0xFF0D47A1)),
            ),
          ],
        ),
        body: Stack(
          children: [
            // الشريط الجانبي الرمادي المميز للديزاين
            Positioned(
              right: 0,
              top: 100.h,
              bottom: 100.h,
              child: Container(
                width: 8.w,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.horizontal(left: Radius.circular(10.r)),
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40.w),
              child: SingleChildScrollView(
                child: Center(
                  child: Column(
                    children: [
                      SizedBox(height: 20.h),

                      // مؤشر التحميل الرقمي
                      BlocBuilder<AsyncBloc, AsyncState>(
                        builder: (context, state) => state is LoadingState
                            ? CircleNumberWidget(number: state.loading)
                            : SizedBox(height: 60.h), // مسافة ثابتة للمحافظة على التوازن
                      ),
                      Container(
                        width: 250.w,
                        height: 250.w,
                        decoration: const BoxDecoration(
                            color: Color(0xFFF8F9FB),
                            shape: BoxShape.circle
                        ),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              const Icon(LucideIcons.user, size: 80, color: Color(0xFF1A3E62)),
                              SizedBox(width: 15.w),
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  AnimatedBuilder(
                                    animation: _arrowCtrl,
                                    builder: (context, _) => Icon(
                                        Icons.keyboard_arrow_up,
                                        color: Colors.blue,
                                        size: 25.sp + (10 * _arrowCtrl.value)
                                    ),
                                  ),
                                  const DatabaseWidget(), // الويدجت التي رسمناها يدوياً للسيرفر
                                  AnimatedBuilder(
                                    animation: _arrowCtrl,
                                    builder: (context, _) => Icon(
                                        Icons.keyboard_arrow_down,
                                        color: Colors.blue,
                                        size: 25.sp + (10 * _arrowCtrl.value)
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),

                      SizedBox(height: 40.h),

                       Text(
                        "تأكد من اتصالك بالإنترنت واضغط على زر تحميل البيانات لبدء العمل على التطبيق",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF0D47A1),
                            height: 1.5
                        ),
                      ),

                      SizedBox(height: 50.h),

                      // منطق الـ Bloc والزر
                      BlocConsumer<AsyncBloc, AsyncState>(
                        listener: (context, state) {
                          if (state is DeleteAllErrorState) {
                            error(context, state.failure.massage, state.failure.code);
                          }
                          if (state is SyncDataErrorState) {
                            error(context, state.failure.massage, state.failure.code);
                          }
                          if (state is IsActiveErrorState) {
                            error(context, state.failure.massage, state.failure.code);
                          }
                          if (state is UpdateIsActiveErrorState) {
                            error(context, state.failure.massage, state.failure.code);
                          }
                          if (state is getDataSucState) {
                            BlocProvider.of<AsyncBloc>(context).add(SetDataSEvent());
                          }
                          if (state is IsActiveState) {
                            BlocProvider.of<AsyncBloc>(context).add(UpdateRepEvent());
                          }
                          if (state is UpdateIsActiveState) {
                            BlocProvider.of<AsyncBloc>(context).add(AsyncDataEvent());
                          }
                          if (state is SyncDataLoadingState) {
                            loading(context, text: state.loading.toString());
                          }
                          if (state is SyncDataState) {
                            BlocProvider.of<AsyncBloc>(context).add(EditEvent(2));
                          }
                          if (state is EditStatusDErrorState) {
                            error(context, state.failure.massage, state.failure.code);
                          }
                          if (state is EditStatusDState) {
                            success(context);
                            UserInfo.isLogging = 2;
                            Phoenix.rebirth(context);
                          }
                        },
                        builder: (context, state) {
                          return SizedBox(
                            width: double.infinity,
                            height: 60.h,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF0D47A1),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.r)
                                  ),
                                  elevation: 5,
                                ),
                                onPressed: state is SyncDataLoadingState || state is LoadingState
                                    ? null // تعطيل الزر أثناء التحميل
                                    : () {
                                  BlocProvider.of<AsyncBloc>(context).add(PlanIsActiveEvent());
                                },
                                child: Text(
                                  state is SyncDataLoadingState || state is LoadingState
                                      ? "جاري التحميل..."
                                      : "تحميل البيانات",
                                  style:  TextStyle(
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white
                                  ),
                                )),
                          );
                        },
                      ),
                      SizedBox(height: 30.h),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// الكود اليدوي للسيرفر لضمان عدم وجود أخطاء في الـ imports
class DatabaseWidget extends StatelessWidget {
  const DatabaseWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70.w,
      height: 90.h,
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFF1A3E62), width: 3),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(2, (index) => Container(
          width: 45.w,
          height: 22.h,
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFF1A3E62), width: 2),
            borderRadius: BorderRadius.circular(4.r),
          ),
          child: const Center(
              child: Icon(Icons.circle, size: 6, color: Color(0xFF1A3E62))
          ),
        )),
      ),
    );
  }
}