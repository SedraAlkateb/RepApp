import 'package:domina_app/presentation/upload_delete/bloc/async_in_bloc.dart';
import 'package:domina_app/presentation/resources/assets_manager.dart';
import 'package:domina_app/presentation/resources/routes_manager.dart';
import 'package:domina_app/presentation/resources/values_manager.dart';
import 'package:domina_app/presentation/uniti/stateWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AsyncPage extends StatelessWidget {
  const AsyncPage({super.key});
  @override
  Widget build(BuildContext context) {
    precacheImage(AssetImage(ImageAssets.upload), context);
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
                    height: 400.h,
                    width: 400.w,
                    child: Image.asset(
                      ImageAssets.upload,
                    )),
                Text(
                  textAlign: TextAlign.center,
                  "تأكد من اتصالك بالإنترنت واضغط على زر رفع البيانات ",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                SizedBox(height: AppSize.s40),
                BlocConsumer<AsyncInBloc, AsyncInState>(
                  buildWhen: (previous, current) {
                    return current is SyncData1LoadingState || current is SyncData1ErrorState ;
                  },
                  listener: (context, state) {
                    if (state is SyncData1ErrorState) {
                      error(context, " ${state.failure.massage}ffffff",
                          state.failure.code);
                    }
                    if (state is SyncData1State) {
                      // BlocProvider.of<AsyncInBloc>(context)
                      //     .add(UpdateFlagEvent());
                      Navigator.pushReplacementNamed(
                        context,
                        Routes.delete,
                      );
                    }
                    if (state is GetState) {
                      BlocProvider.of<AsyncInBloc>(context).add(GetEvent());
                    }
                  },
                  builder: (context, state) => ElevatedButton(
                      onPressed:  state is SyncData1LoadingState?null:() {
                        BlocProvider.of<AsyncInBloc>(context)
                            .add(Async1DataEvent());
                      },
                      child: Text(
                        state is SyncData1LoadingState
                            ? "loading"
                            : " رفع البيانات ",
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
