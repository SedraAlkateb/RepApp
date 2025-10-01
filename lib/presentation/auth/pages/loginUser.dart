// ignore_for_file: deprecated_member_use

import 'package:domina_app/presentation/auth/bloc/auth_bloc.dart';
import 'package:domina_app/presentation/resources/assets_manager.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/resources/routes_manager.dart';
import 'package:domina_app/presentation/uniti/custom-wavy-background.dart';
import 'package:domina_app/presentation/uniti/stateWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
      body: WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Stack(
          children: [
            CustomWavyBackground(),
            Container(
              decoration: BoxDecoration(
                  // image: DecorationImage(
                  //   image: AssetImage('assets/images/login.png'),
                  //   fit: BoxFit.cover,
                  // ),
                  ),
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 120.h),
                      Image.asset(ImageAssets.domina, scale: 5.r ),
                      SizedBox(height: 8.h),
                      Container(
                        margin: EdgeInsets.only(left: 35.w, right: 35.w),
                        child: Column(
                          children: [
                            TextFormField(
                              validator: (val) =>
                                  val!.length < 3 ? "حقل الاسم مطلوب" : null,
                              controller: userName,
                              style: TextStyle(color: Colors.black),
                              decoration: InputDecoration(
                                fillColor: Colors.grey.shade100,
                                filled: true,
                                hintText: "الإسم",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                            SizedBox(height: 30.h),
                            BlocBuilder<AuthBloc, AuthState>(
                              builder: (context, state) {
                                bool isObscured = true;
                                if (state is ShowPasswordState) {
                                  isObscured = state.isObscured;
                                }

                                return TextFormField(
                                  controller: password,
                                  validator: (val) => val!.length < 2
                                      ? "كلمة السر يجب ان تكون أطول من 2"
                                      : null,
                                  style: TextStyle(),
                                  obscureText: isObscured,
                                  decoration: InputDecoration(
                                    fillColor: Colors.grey.shade100,
                                    filled: true,
                                    hintText: "كلمة السر",
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        isObscured
                                            ? Icons.visibility_off_outlined
                                            : Icons.visibility_outlined,
                                      ),
                                      onPressed: () {
                                        BlocProvider.of<AuthBloc>(context).add(
                                            ShowPasswordEvent(!isObscured));
                                      },
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.r),
                                    ),
                                  ),
                                );
                              },
                            ),
                            SizedBox(height: 40.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'تسجيل الدخول',
                                  style: TextStyle(
                                      fontSize: 27.sp,
                                      fontWeight: FontWeight.w700),
                                ),
                                BlocListener<AuthBloc, AuthState>(
                                  listener: (context, state) {
                                    if (state is LoginLoadingState) {
                                      loading(context);
                                    }
                                    if (state is LoginState) {
                                      BlocProvider.of<AuthBloc>(context)
                                          .add(LoginInsertEvent());
                                    }
                                    if (state is InsertLoginState) {
                                      success(context);
                                      Navigator.pushNamedAndRemoveUntil(context,
                                          Routes.syncData, (route) => false);
                                    }
                                    if (state is LoginErrorState) {
                                      error(context, state.failure.massage,
                                          state.failure.code);
                                    }
                                    if (state is InsertLoginErrorState) {
                                      error(context, state.failure.massage,
                                          state.failure.code);
                                    }
                                  },
                                  child: CircleAvatar(
                                    radius: 30.r,
                                    backgroundColor:
                                        ColorManager.secondaryColor1,
                                    child: IconButton(
                                      color: Colors.white,
                                      onPressed: () {
                                        if (formKey.currentState!.validate()) {
                                          BlocProvider.of<AuthBloc>(context)
                                              .add(LoginEvent(userName.text,
                                                  password.text));
                                          formKey.currentState!.save();
                                        }
                                      },
                                      icon: Icon(Icons.arrow_forward),
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
