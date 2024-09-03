import 'package:domina_app/presentation/auth/bloc/auth_bloc.dart';
import 'package:domina_app/presentation/resources/routes_manager.dart';
import 'package:domina_app/presentation/uniti/stateWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AsyncPage extends StatelessWidget {
  const AsyncPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
           if(state is SyncDataErrorState){
             error(context, state.failure.massage, state.failure.code);
           }
           if(state is SyncDataLoadingState){
             loading(context);
           }
           if(state is SyncDataState){
             success(context);
             Navigator.pushNamed(context, Routes.places);
           }
          },
          child: InkWell(
              onTap: () {
                BlocProvider.of<AuthBloc>(context).add(AsyncDataEvent());
              },
              child: Text("async")),
        ),
      ),
    );
  }
}
