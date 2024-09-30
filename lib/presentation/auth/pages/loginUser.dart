import 'package:domina_app/presentation/auth/bloc/auth_bloc.dart';
import 'package:domina_app/presentation/resources/assets_manager.dart';
import 'package:domina_app/presentation/resources/routes_manager.dart';
import 'package:domina_app/presentation/uniti/stateWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyLogin extends StatefulWidget {
  const MyLogin({Key? key}) : super(key: key);
  @override
  _MyLoginState createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> {
  final formKey = new GlobalKey<FormState>();
  final TextEditingController userName = TextEditingController();
  final TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(ImageAssets.login), fit: BoxFit.cover),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: WillPopScope(
            onWillPop: () async {
              return false;
            },
            child: Form(
              key: formKey,
              child: Stack(
                children: [
                  Positioned(
                    top: MediaQuery.of(context).size.height / 9,
                    right: MediaQuery.of(context).size.height / 5,
                    child: Text(
                      'مرحبا بك\nفي Domina',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 33),
                    ),
                  ),
                  SingleChildScrollView(
                    child: Container(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 35, right: 35),
                            child: Column(
                              children: [
                                TextFormField(
                                  validator: (val) => val!.length < 3
                                      ? "حقل الاسم مطلوب "
                                      : null,
                                  controller: userName,
                                  style: TextStyle(color: Colors.black),
                                  decoration: InputDecoration(
                                      fillColor: Colors.grey.shade100,
                                      filled: true,
                                      hintText: "الاسم",
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      )),
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                TextFormField(
                                  controller: password,
                                  validator: (val) => val!.length < 2
                                      ? "كلمة السر يجب ان تكون اطول من 2"
                                      : null,
                                  style: TextStyle(),
                                  obscureText: true,
                                  decoration: InputDecoration(
                                      fillColor: Colors.grey.shade100,
                                      filled: true,
                                      hintText: "كلمة السر",
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      )),
                                ),
                                SizedBox(
                                  height: 40,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'تسجيل الدخول',
                                      style: TextStyle(
                                          fontSize: 27,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    BlocListener<AuthBloc, AuthState>(
                                      listener: (context, state) {
                                        if (state is LoginLoadingState) {
                                          loading(context);
                                        }
                                        if (state is LoginState) {
                                          BlocProvider.of<AuthBloc>(context)
                                              .add(DeleteDataEvent());
                                        }
                                        if (state is DeleteState) {
                                          BlocProvider.of<AuthBloc>(context)
                                              .add(LoginInsertEvent());
                                        }
                                        if (state is InsertLoginState) {
                                          success(context);
                                          Navigator.pushNamed(
                                              context, Routes.syncData);
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
                                        radius: 30,
                                        backgroundColor: Color(0xff4c505b),
                                        child: IconButton(
                                            color: Colors.white,
                                            onPressed: () {
                                              if (formKey.currentState!
                                                  .validate()) {
                                                BlocProvider.of<AuthBloc>(
                                                        context)
                                                    .add(LoginEvent(
                                                        userName.text,
                                                        password.text));
                                                formKey.currentState!.save();
                                              }
                                            },
                                            icon: Icon(
                                              Icons.arrow_forward,
                                            )),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
