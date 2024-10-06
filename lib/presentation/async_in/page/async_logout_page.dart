import 'package:domina_app/presentation/async_in/bloc/async_in_bloc.dart';
import 'package:domina_app/presentation/resources/assets_manager.dart';
import 'package:domina_app/presentation/resources/routes_manager.dart';
import 'package:domina_app/presentation/resources/values_manager.dart';
import 'package:domina_app/presentation/uniti/stateWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AsyncLogoutPage extends StatelessWidget {
  const AsyncLogoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(ImageAssets.login,fit: BoxFit.fill,),
          Padding(
            padding: const EdgeInsets.only(left: AppPadding.p40, right:  AppPadding.p40, top: 300),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset(
                    ImageAssets.domina,width: 200,
                  ),
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
                     if(state is DeleteAllErrorState){
                       error(context, state.failure.massage, state.failure.code);
                     }
                     if(state is SyncData1LoadingState){
                       loading(context);
                     }
                     if(state is SyncData1State){
                       BlocProvider.of<AsyncInBloc>(context).add(DeleteAllEvent());
                     }
                     if(state is DeleteAllState){
                       success(context);
                       Navigator.pushNamedAndRemoveUntil(
                         context, Routes.login,
                             (route) => false,
                       );
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
        ],
      ),
    );
  }
}
