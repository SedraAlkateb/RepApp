import 'dart:ui';

import 'package:domina_app/presentation/upload_delete/bloc/async_in_bloc.dart';
import 'package:domina_app/presentation/resources/assets_manager.dart';
import 'package:domina_app/presentation/resources/routes_manager.dart';
import 'package:domina_app/presentation/resources/values_manager.dart';
import 'package:domina_app/presentation/uniti/stateWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AsyncPage extends StatelessWidget {
  const AsyncPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:    Padding(
        padding: const EdgeInsets.only(left: AppPadding.p40, right:  AppPadding.p40, top: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                  height: 400,
                  width: 400,
                  child: Image.asset(ImageAssets.upload,)),
              Text(
                textAlign: TextAlign.center,
                "تأكد من اتصالك بالانترنت واضغط على زر رفع البيانات ",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              SizedBox(
                  height: AppSize.s50
              ),
              BlocListener<AsyncInBloc, AsyncInState>(
                listener: (context, state) {
                  if(state is SyncData1ErrorState){
                    error(context, state.failure.massage, state.failure.code);
                  }
                  if(state is SyncData1State){
                    BlocProvider.of<AsyncInBloc>(context).add(UpdateFlagEvent());
                  }
                  if(state is UpdateFlagErrorState){
                    error(context, state.failure.massage, state.failure.code);

                  }
                  if(state is UpdateFlagState){
                    BlocProvider.of<AsyncInBloc>(context).add(EditEventIn(3));
                  }
                  if(state is EditStatusSErrorState){
                    error(context, state.failure.massage, state.failure.code);
                  }
                  if(state is EditStatusState){
                    success(context);
                    Navigator.pushReplacementNamed(context, Routes.delete,);
                  }
                },
                child: ElevatedButton(onPressed: (){
                  BlocProvider.of<AsyncInBloc>(context).add(Async1DataEvent());
                },
                    child: Text(
                      " رفع البيانات ",
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
