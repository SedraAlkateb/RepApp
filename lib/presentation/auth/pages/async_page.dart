import 'package:flutter/material.dart';

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
