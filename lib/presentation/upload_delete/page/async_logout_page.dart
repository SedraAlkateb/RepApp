import 'package:domina_app/presentation/upload_delete/bloc/async_in_bloc.dart';
import 'package:domina_app/presentation/resources/assets_manager.dart';
import 'package:domina_app/presentation/resources/routes_manager.dart';
import 'package:domina_app/presentation/resources/values_manager.dart';
import 'package:domina_app/presentation/uniti/stateWidget.dart';
import 'package:domina_app/presentation/upload_delete/widget/dialog_change_plan.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AsyncLogoutPage extends StatelessWidget {
  const AsyncLogoutPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding:
             EdgeInsets.only(left: AppPaddingW.p40, right: AppPaddingW.p40),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: AppSize.s30),
                SizedBox(
                  height: 400,
                  width: 400,
                  child: Image.asset(
                    ImageAssets.upload,
                    height: 500,
                  ),
                ),
                Text(
                  textAlign: TextAlign.center,
                  "تأكد من اتصالك بالانترنت واضغط على زر رفع البيانات ",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                SizedBox(height: AppSize.s40),
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
                  builder:(context, state) =>  ElevatedButton(
                      onPressed:state is SyncData0LoadingState?null: () {
                        BlocProvider.of<AsyncInBloc>(context)
                            .add(Async0DataEvent());
                      },
                      child: Text(
                        state is SyncData0LoadingState?"loading":    " رفع البيانات ",
                      )),
                ),
                SizedBox(height: AppSize.s50),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
