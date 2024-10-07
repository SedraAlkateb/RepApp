import 'package:domina_app/presentation/upload_delete/bloc/async_in_bloc.dart';
import 'package:domina_app/presentation/resources/assets_manager.dart';
import 'package:domina_app/presentation/resources/routes_manager.dart';
import 'package:domina_app/presentation/resources/values_manager.dart';
import 'package:domina_app/presentation/uniti/stateWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class DeletePage extends StatelessWidget {
  const DeletePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:   Padding(
        padding:  EdgeInsets.only(left: AppPadding.p40, right:  AppPadding.p40, top: 300),
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
                "سوف نحذف الداتا لاعادة تنزيلها  ",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              SizedBox(
                  height: AppSize.s50
              ),
              BlocListener<AsyncInBloc, AsyncInState>(
                listener: (context, state) {
                  if(state is DeleteBaseErrorState){
                    error(context, state.failure.massage, state.failure.code);
                  }
                  if(state is DeleteBaseLoadingState){
                    loading(context);
                  }
                  if(state is EditStatusSErrorState){
                    error(context, state.failure.massage, state.failure.code);
                  }
                  if(state is EditStatusState){
                    print("object");
                    success(context);
                    Navigator.pushNamedAndRemoveUntil(context, Routes.syncData,(route) => false,);
                  }
                  if(state is DeleteBaseState){
                    BlocProvider.of<AsyncInBloc>(context).add(EditEventIn(1));
                  }
                },
                child: ElevatedButton(onPressed: (){
                  BlocProvider.of<AsyncInBloc>(context).add(DeleteBaseEvent());
                },
                    child: Text(
                      " حذف البيانات ",
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }

}
