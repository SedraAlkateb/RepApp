import 'package:domina_app/presentation/async/bloc/async_bloc.dart';
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppPadding.p40, vertical: AppPadding.p120),
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
                "تأكد من اتصالك بالانترنت واضغط على زر تحميل البيانات لبدء العمل على التطبيق ",
              style: Theme.of(context).textTheme.titleLarge,
              ),
              SizedBox(
                height: AppSize.s50
              ),
              BlocListener<AsyncBloc, AsyncState>(
                listener: (context, state) {
                 if(state is SyncDataErrorState){
                   error(context, state.failure.massage, state.failure.code);
                 }
                 if(state is SyncDataLoadingState){
                   loading(context);
                 }
                 if(state is SyncDataState){
                   BlocProvider.of<AsyncBloc>(context).add(EditEvent());
                   success(context);
                   Navigator.pushNamed(context, Routes.places);
                 }
                },
                child: ElevatedButton(onPressed: (){
                  BlocProvider.of<AsyncBloc>(context).add(AsyncDataEvent());
                },
                    child: Text(
                    "تحميل البيانات",
                )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
