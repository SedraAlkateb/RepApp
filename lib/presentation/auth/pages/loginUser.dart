// ignore_for_file: deprecated_member_use
import 'package:domina_app/app/di/di.dart';
import 'package:domina_app/app/user_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'package:domina_app/presentation/auth/bloc/auth_bloc.dart';
import 'package:domina_app/presentation/resources/assets_manager.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/resources/routes_manager.dart';
import 'package:domina_app/presentation/uniti/custom-wavy-background.dart';
import 'package:domina_app/presentation/uniti/stateWidget.dart';

class MyLogin extends StatefulWidget {
  const MyLogin({Key? key}) : super(key: key);

  @override
  _MyLoginState createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController userName = TextEditingController();
  final TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // قياسات عامة
    final mq = MediaQuery.of(context);
    final deviceWidth = mq.size.width;
    final orientation = mq.orientation;
    final bool isLandscape = orientation == Orientation.landscape;

    // الشرط: التخطيط المزدوج ينطبق فقط على التابلت وفي الوضع العرضي حصراً
    final bool isTablet = deviceWidth >= 600;
    final bool useTwoColumnLayout = isTablet && isLandscape;

    // عرض النموذج في التابلت بالعرض
    final double formMaxWidth = 520.w;

    return BlocProvider<AuthBloc>(
      create: (context) => instance<AuthBloc>(),
      child: Scaffold(
        backgroundColor: const Color(0xFFF8FAFF),
        body: PopScope(
          canPop: false,
          child: Form(
            key: formKey,
            child: LayoutBuilder(builder: (context, constraints) {
              if (useTwoColumnLayout) {
                // 🌟 تخطيط خاص فقط بالتابلت في الوضع العرضي (Tablet Landscape)
                return Row(
                  children: [
                    // 👉 العمود الأيمن: الخلفية الموجية في الأعلى مع النصوص الترحيبية بدون الشعار
                    Expanded(
                      flex: 5,
                      child: Stack(
                        children: [
                          Positioned(
                            top: 0,
                            left: 0,
                            right: 0,
                            height: constraints.maxHeight * 0.45,
                            child: CustomWavyBackground()
                                .animate()
                                .fadeIn(duration: 700.ms)
                                .slideY(begin: -0.05, end: 0),
                          ),
                          Positioned(
                              // right: 100,
                              top: 140.h,
                              // bottom: 50.h,
                              left: 240.h,

                              //    right: 0,
                              child: _buildProfessionalLogo(true)),
                          // المحتوى الترحيبي في الجهة اليمنى
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 32.w),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                // الشعار الدائري مستقر حصراً في اليسار فوق النموذج

                                SizedBox(
                                  height: 12.h,
                                ),
                                Text(
                                  "مرحباً بك مجدداً في DOMINA",
                                  style: TextStyle(
                                    fontSize: 26.sp,
                                    fontWeight: FontWeight.w800,
                                    color: ColorManager.medicalPrimary,
                                  ),
                                ),
                                SizedBox(height: 12.h),
                                Text(
                                  "سجّل دخولك للوصول إلى لوحة التحكم والمهام اليومية.",
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    color: Colors.grey.shade600,
                                    height: 1.4,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    // 👈 العمود الأيسر: يحتوي على نموذج الدخول الشاهق مع الشعار في الأعلى
                    Expanded(
                      flex: 6,
                      child: Center(
                        child: SingleChildScrollView(
                          padding: EdgeInsets.symmetric(vertical: 20.h),
                          child: Container(
                            width: formMaxWidth,
                            height: mq.size.height,
                            //margin: EdgeInsets.symmetric(horizontal: 24.w),
                            padding: EdgeInsets.symmetric(
                              horizontal: 32.w,
                              vertical: 36
                                  .h, // زيادة الارتفاع الرأسي لإعطاء مظهر متطاول
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              //  borderRadius: BorderRadius.circular(30.r),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.blue.withOpacity(0.06),
                                  blurRadius: 25,
                                  offset: const Offset(0, 10),
                                ),
                              ],
                            ),
                            child: _buildFormContentsWidth(),
                          )
                              .animate()
                              .scale(delay: 200.ms, curve: Curves.easeOutQuad),
                        ),
                      ),
                    ),
                  ],
                );
              } else {
                // 📱 التخطيط المعتاد (للهواتف أو التابلت بالوضع الطولي)
                return Stack(
                  children: [
                    CustomWavyBackground()
                        .animate()
                        .fadeIn(duration: 700.ms)
                        .slideY(begin: -0.05, end: 0),
                    Center(
                      child: SafeArea(
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          padding: EdgeInsets.symmetric(
                            vertical: isLandscape ? 15.h : 30.h,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              if (!isLandscape) SizedBox(height: 20.h),
                              _buildProfessionalLogo(false),
                              SizedBox(height: isLandscape ? 20.h : 35.h),
                              Container(
                                width: double.infinity,
                                margin: EdgeInsets.symmetric(horizontal: 24.w),
                                padding: EdgeInsets.symmetric(
                                  horizontal: 20.w,
                                  vertical: isLandscape ? 20.h : 30.h,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(30.r),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.blue.withOpacity(0.05),
                                      blurRadius: 20,
                                      offset: const Offset(0, 10),
                                    ),
                                  ],
                                ),
                                child: _buildFormContents(
                                    isLandscape: isLandscape),
                              ).animate().scale(
                                  delay: 200.ms, curve: Curves.easeOutQuad),
                              SizedBox(height: isLandscape ? 20.h : 40.h),
                              Text(
                                "DOMINA PHARMACEUTICALS",
                                style: TextStyle(
                                  color: Colors.grey.withOpacity(0.6),
                                  letterSpacing: 1.5,
                                  fontSize: 11.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ).animate().fadeIn(delay: 1.seconds),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }
            }),
          ),
        ),
      ),
    );
  }

  // محتويات النموذج المخصص للتابلت بالعرض (على اليسار مع الشعار المرفق والارتفاع الممتد)
  Widget _buildFormContentsWidth() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: 10.h),

        //    SizedBox(height: 20.h),

        Text(
          "تسجيل الدخول",
          style: TextStyle(
            fontSize: 22.sp,
            fontWeight: FontWeight.w800,
            color: ColorManager.medicalPrimary,
          ),
        ),

        SizedBox(height: 30.h),

        _buildModernTextField(
          controller: userName,
          hint: "اسم المستخدم",
          icon: Icons.alternate_email_rounded,
          validator: (val) => val!.length < 3 ? "يرجى التحقق من الاسم" : null,
        ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.1, end: 0),

        SizedBox(height: 20.h),

        BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            bool isObscured =
                state is ShowPasswordState ? state.isObscured : true;
            return _buildModernTextField(
              controller: password,
              hint: "كلمة المرور",
              icon: Icons.lock_open_rounded,
              isPassword: true,
              isObscured: isObscured,
              onSuffixTap: () {
                BlocProvider.of<AuthBloc>(context)
                    .add(ShowPasswordEvent(!isObscured));
              },
              validator: (val) => val!.length < 2 ? "كلمة المرور قصيرة" : null,
            );
          },
        ).animate().fadeIn(delay: 500.ms).slideY(begin: 0.1, end: 0),

        SizedBox(height: 35.h),

        _buildPremiumButton(true),

        SizedBox(height: 10.h),
      ],
    );
  }

  // محتويات النموذج القياسي للهاتف أو التابلت الطولي
  Widget _buildFormContents({required bool isLandscape}) {
    return Column(
      children: [
        Text(
          "مرحباً بك مجدداً",
          style: TextStyle(
            fontSize: isLandscape ? 20.sp : 24.sp,
            fontWeight: FontWeight.w800,
            color: ColorManager.medicalPrimary,
          ),
        ).animate().fadeIn().moveY(begin: 10, end: 0),
        SizedBox(height: 6.h),
        Text(
          "سجل دخولك للمتابعة",
          style: TextStyle(
            fontSize: isLandscape ? 12.sp : 14.sp,
            color: Colors.grey,
          ),
        ).animate().fadeIn(delay: 200.ms),
        SizedBox(height: isLandscape ? 20.h : 35.h),
        _buildModernTextField(
          controller: userName,
          hint: "اسم المستخدم",
          icon: Icons.alternate_email_rounded,
          validator: (val) => val!.length < 3 ? "يرجى التحقق من الاسم" : null,
        ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.1, end: 0),
        SizedBox(height: 15.h),
        BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            bool isObscured =
                state is ShowPasswordState ? state.isObscured : true;
            return _buildModernTextField(
              controller: password,
              hint: "كلمة المرور",
              icon: Icons.lock_open_rounded,
              isPassword: true,
              isObscured: isObscured,
              onSuffixTap: () {
                BlocProvider.of<AuthBloc>(context)
                    .add(ShowPasswordEvent(!isObscured));
              },
              validator: (val) => val!.length < 2 ? "كلمة المرور قصيرة" : null,
            );
          },
        ).animate().fadeIn(delay: 500.ms).slideY(begin: 0.1, end: 0),
        SizedBox(height: isLandscape ? 25.h : 35.h),
        _buildPremiumButton(isLandscape),
      ],
    );
  }

  Widget _buildProfessionalLogo(bool isLandscape) {
    final double logoSize = isLandscape ? 120.r : 120.r;
    return Container(
      width: logoSize,
      height: logoSize,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.1),
            blurRadius: 30,
            spreadRadius: 5,
          )
        ],
      ),
      child: Center(
        child: Image.asset(ImageAssets.domina, width: logoSize * 0.6)
            .animate(onPlay: (c) => c.repeat(reverse: true))
            .shimmer(duration: 2.seconds, color: Colors.blue.shade50)
            .scale(
              begin: const Offset(1, 1),
              end: const Offset(1.05, 1.05),
              duration: 2.seconds,
            ),
      ),
    );
  }

  Widget _buildModernTextField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    bool isPassword = false,
    bool isObscured = false,
    VoidCallback? onSuffixTap,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: isObscured,
      validator: validator,
      style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w600),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14.sp),
        prefixIcon: Icon(icon,
            color: ColorManager.medicalPrimary.withOpacity(0.6), size: 22.sp),
        suffixIcon: isPassword
            ? IconButton(
                icon: Icon(
                  isObscured
                      ? Icons.visibility_off_rounded
                      : Icons.visibility_rounded,
                  color: Colors.grey,
                ),
                onPressed: onSuffixTap,
              )
            : null,
        fillColor: const Color(0xFFF3F7FF),
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18.r),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18.r),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18.r),
          borderSide: BorderSide(
            color: ColorManager.medicalPrimary.withOpacity(0.2),
            width: 2,
          ),
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
      ),
    );
  }

  Widget _buildPremiumButton(bool isLandscape) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is LoginLoadingState) {
          loading(context);
        }

        if (state is LoginState) {
          BlocProvider.of<AuthBloc>(context).add(LoginInsertEvent());
        }

        if (state is InsertLoginState) {
          success(context);
          Future.delayed(const Duration(milliseconds: 600), () {
            if (context.mounted) {
              if (UserInfo.isLogging == 2) {
                Navigator.pushNamedAndRemoveUntil(
                    context, Routes.adminControl, (route) => false);
              } else {
                Navigator.pushNamedAndRemoveUntil(
                    context, Routes.syncData, (route) => false);
              }
            }
          });
        }

        if (state is LoginErrorState || state is InsertLoginErrorState) {
          dynamic errorState = state;
          error(context, errorState.failure.massage, errorState.failure.code);
        }
      },
      builder: (context, state) {
        return GestureDetector(
          onTap: () {
            if (formKey.currentState!.validate()) {
              BlocProvider.of<AuthBloc>(context)
                  .add(LoginEvent(userName.text, password.text));
            }
          },
          child: Container(
            width: double.infinity,
            height: isLandscape ? 50.h : 55.h,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  ColorManager.medicalPrimary,
                  ColorManager.medicalPrimary.withBlue(255),
                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.circular(18.r),
              boxShadow: [
                BoxShadow(
                  color: ColorManager.medicalPrimary.withOpacity(0.3),
                  blurRadius: 15,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "تسجيل الدخول",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: isLandscape ? 15.sp : 17.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 12.w),
                const Icon(Icons.login_rounded, color: Colors.white),
              ],
            ),
          ),
        );
      },
    ).animate().fadeIn(delay: 700.ms);
  }
}
