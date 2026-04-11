// ignore_for_file: deprecated_member_use

import 'package:domina_app/presentation/ss.dart';
import 'package:domina_app/presentation/upload_delete/bloc/async_in_bloc.dart';
import 'package:domina_app/presentation/resources/assets_manager.dart';
import 'package:domina_app/presentation/resources/routes_manager.dart';
import 'package:domina_app/presentation/resources/values_manager.dart';
import 'package:domina_app/presentation/uniti/stateWidget.dart';
import 'package:domina_app/presentation/upload_delete/widget/dialog_change_plan.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lucide_icons/lucide_icons.dart';

class AsyncLogoutPage extends StatefulWidget {
  const AsyncLogoutPage({super.key});

  @override
  State<AsyncLogoutPage> createState() => _AsyncLogoutPageState();
}

class _AsyncLogoutPageState extends State<AsyncLogoutPage> with TickerProviderStateMixin {
  late AnimationController _rotateCtrl;
  late AnimationController _bounceCtrl;

  @override
  void initState() {
    super.initState();
    // أنيميشن الدوران لأيقونة المزامنة
    _rotateCtrl = AnimationController(duration: const Duration(seconds: 2), vsync: this)..repeat();
    // أنيميشن القفز الخفيف للمندوب
    _bounceCtrl = AnimationController(duration: const Duration(milliseconds: 1500), vsync: this)..repeat(reverse: true);
  }

  @override
  void dispose() {
    _rotateCtrl.dispose();
    _bounceCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    precacheImage(AssetImage(ImageAssets.upload), context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // 1. الشريط الجانبي الرمادي المميز للديزاين
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
            padding: EdgeInsets.symmetric(horizontal: AppPaddingW.p40),
            child: SingleChildScrollView(
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 100.h), // موازنة المسافة العلوية

                    // 2. الرسم التوضيحي مع الأنيميشن (محاكاة الصورة بـ Widgets)
                    Container(
                      width: 260.w,
                      height: 260.w,
                      decoration: const BoxDecoration(
                        color: Color(0xFFF8F9FB),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                // حركة المندوب
                                AnimatedBuilder(
                                  animation: _bounceCtrl,
                                  builder: (context, _) => Transform.translate(
                                    offset: Offset(0, -12 * _bounceCtrl.value),
                                    child: const Icon(LucideIcons.user, size: 80, color: Color(0xFF1A3E62)),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                const DatabaseWidget(), // ويدجت السيرفر من ملف ss.dart
                              ],
                            ),
                            // أيقونة المزامنة الدوارة
                            Positioned(
                              top: 65,
                              left: 110,
                              child: RotationTransition(
                                turns: _rotateCtrl,
                                child: const Icon(LucideIcons.refreshCw, size: 28, color: Colors.blue),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 40),

                    // 3. النص المطلوب
                    const Text(
                      "تأكد من اتصالك بالانترنت واضغط على زر رفع البيانات ",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0D47A1),
                        height: 1.4,
                      ),
                    ),

                    const SizedBox(height: 50),

                    // 4. البلوك كونسيومر مع الحفاظ على اللوجيك الخاص بالـ Logout
                    BlocConsumer<AsyncInBloc, AsyncInState>(
                      buildWhen: (previous, current) {
                        return current is SyncData0LoadingState || current is SyncData1ErrorState ;
                      },
                      listener: (context, state) {
                        if (state is SyncData1ErrorState) {
                          error(context, state.failure.massage, state.failure.code);
                        }
                        if (state is SyncData1State) {
                          Navigator.pushReplacementNamed(
                            context,
                            Routes.deleteLogout,
                          );
                        }
                        if (state is IsActiveState) {
                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (_) => dialogChangePlan(context,true),
                          );
                        }
                        if (state is GetState) {
                          BlocProvider.of<AsyncInBloc>(context).add(GetEvent());
                        }
                        // if (state is UpdateFlagErrorState) {
                        //   error(context, state.failure.massage, state.failure.code);
                        // }
                        // if (state is UpdateFlagState) {
                        //   BlocProvider.of<AsyncInBloc>(context).add(EditEventIn(3));
                        // }
                      },
                      builder: (context, state) {
                        return SizedBox(
                          width: double.infinity,
                          height: 60.h,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF0D47A1),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.r),
                              ),
                              elevation: 5,
                            ),
                            onPressed: state is SyncData0LoadingState
                                ? null
                                : () {
                              BlocProvider.of<AsyncInBloc>(context).add(Async0DataEvent());
                            },
                            child: Text(
                              state is SyncData0LoadingState ? "جاري الرفع..." : " رفع البيانات ",
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    SizedBox(height: AppSize.s50),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}