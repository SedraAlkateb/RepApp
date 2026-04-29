// ignore_for_file: deprecated_member_use
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
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFF), // لون خلفية مريح جداً للعين
      body: WillPopScope(
        onWillPop: () async => false,
        child: Stack(
          children: [
            // خلفية فنية انسيابية
            CustomWavyBackground()
                .animate()
                .fadeIn(duration: 1.seconds)
                .slideY(begin: -0.1, end: 0),

            Center(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 60.h),

                      // شعار احترافي مع تأثير "النبض" الخفيف
                      _buildProfessionalLogo(),

                      SizedBox(height: 50.h),

                      // حاوية البيانات (Card-like design)
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 24.w),
                        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
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
                        child: Column(
                          children: [
                            Text(
                              "مرحباً بك مجدداً",
                              style: TextStyle(
                                fontSize: 24.sp,
                                fontWeight: FontWeight.w800,
                                color: ColorManager.medicalPrimary,
                              ),
                            ).animate().fadeIn().moveY(begin: 10, end: 0),

                            SizedBox(height: 10.h),

                            Text(
                              "سجل دخولك للمتابعة",
                              style: TextStyle(fontSize: 14.sp, color: Colors.grey),
                            ).animate().fadeIn(delay: 200.ms),

                            SizedBox(height: 35.h),

                            // حقل الإسم
                            _buildModernTextField(
                              controller: userName,
                              hint: "اسم المستخدم",
                              icon: Icons.alternate_email_rounded,
                              validator: (val) => val!.length < 3 ? "يرجى التحقق من الاسم" : null,
                            ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.1, end: 0),

                            SizedBox(height: 20.h),

                            // حقل كلمة السر
                            BlocBuilder<AuthBloc, AuthState>(
                              builder: (context, state) {
                                bool isObscured = state is ShowPasswordState ? state.isObscured : true;
                                return _buildModernTextField(
                                  controller: password,
                                  hint: "كلمة المرور",
                                  icon: Icons.lock_open_rounded,
                                  isPassword: true,
                                  isObscured: isObscured,
                                  onSuffixTap: () {
                                    BlocProvider.of<AuthBloc>(context).add(ShowPasswordEvent(!isObscured));
                                  },
                                  validator: (val) => val!.length < 2 ? "كلمة المرور قصيرة" : null,
                                );
                              },
                            ).animate().fadeIn(delay: 500.ms).slideY(begin: 0.1, end: 0),

                            SizedBox(height: 40.h),

                            // زر الدخول
                            _buildPremiumButton(context),
                          ],
                        ),
                      ).animate().scale(delay: 200.ms, curve: Curves.easeOutQuad),

                      SizedBox(height: 60.h),

                      Text(
                        "DOMINA PHARMACEUTICALS",
                        style: TextStyle(
                          color: Colors.grey.withOpacity(0.6),
                          letterSpacing: 1.5,
                          fontSize: 11.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ).animate().fadeIn(delay: 1.seconds),
                      SizedBox(height: 20.h),
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

  Widget _buildProfessionalLogo() {
    return Container(
      width: 120.w,
      height: 120.w,
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
        child: Image.asset(ImageAssets.domina, width: 75.w)
            .animate(onPlay: (c) => c.repeat(reverse: true))
            .shimmer(duration: 2.seconds, color: Colors.blue.shade50)
            .scale(begin: const Offset(1, 1), end: const Offset(1.05, 1.05), duration: 2.seconds),
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
        prefixIcon: Icon(icon, color: ColorManager.medicalPrimary.withOpacity(0.6), size: 22.sp),
        suffixIcon: isPassword
            ? IconButton(
          icon: Icon(isObscured ? Icons.visibility_off_rounded : Icons.visibility_rounded, color: Colors.grey),
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
          borderSide: BorderSide(color: ColorManager.medicalPrimary.withOpacity(0.2), width: 2),
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 20.h),
      ),
    );
  }

  Widget _buildPremiumButton(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is LoginLoadingState) loading(context);
        if (state is LoginState) BlocProvider.of<AuthBloc>(context).add(LoginInsertEvent());
        if (state is InsertLoginState) {
          success(context);
          Navigator.pushNamedAndRemoveUntil(context, Routes.syncData, (route) => false);
        }



        if (state is LoginErrorState || state is InsertLoginErrorState) {
          dynamic errorState = state;
          error(context, errorState.failure.massage, errorState.failure.code);
        }
      },
      child: GestureDetector(
        onTap: () {
          if (formKey.currentState!.validate()) {
            BlocProvider.of<AuthBloc>(context).add(LoginEvent(userName.text, password.text));
          }
        },
        child: Container(
          width: double.infinity,
          height: 60.h,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                ColorManager.medicalPrimary,
                ColorManager.medicalPrimary.withBlue(255), // تدرج لوني خفيف
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
                style: TextStyle(color: Colors.white, fontSize: 17.sp, fontWeight: FontWeight.bold),
              ),
              SizedBox(width: 12.w),
              const Icon(Icons.login_rounded, color: Colors.white),
            ],
          ),
        ),
      ),
    ).animate().fadeIn(delay: 700.ms);
  }
}