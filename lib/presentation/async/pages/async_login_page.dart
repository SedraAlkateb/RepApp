
import 'package:domina_app/app/user_info.dart';
import 'package:domina_app/presentation/async/bloc/async_bloc.dart';
import 'package:domina_app/presentation/resources/assets_manager.dart';
import 'package:domina_app/presentation/resources/routes_manager.dart';
import 'package:domina_app/presentation/resources/values_manager.dart';
import 'package:domina_app/presentation/uniti/circle_number_widget.dart';
import 'package:domina_app/presentation/uniti/stateWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

class AsyncLoginPage extends StatelessWidget {
  const AsyncLoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return  WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          leading: SizedBox(),
            actions:  [
            IconButton(
                onPressed: (){
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    Routes.login,
                        (route) => false,
                  );
                  BlocProvider.of<AsyncBloc>(context).add(DeleteAllEvent());
                }, icon: Icon(Icons.arrow_forward)),
          ]
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: AppPadding.p40,right: AppPadding.p40),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [

                BlocBuilder<AsyncBloc,AsyncState>
                  (builder: (context, state) =>  state is LoadingState?CircleNumberWidget(number: state.loading):SizedBox(),),
                Image.asset(
                  ImageAssets.download,
                  height: 300,

                ),
                Text(
                  textAlign: TextAlign.center,
                  "تأكد من اتصالك بالإنترنت واضغط على زر تحميل البيانات لبدء العمل على التطبيق ",
                style: Theme.of(context).textTheme.titleLarge,
                ),
                SizedBox(
                  height: AppSize.s25
                ),
                BlocConsumer<AsyncBloc, AsyncState>(
                  listener: (context, state) {

                    if(state is DeleteAllErrorState){
                      error(context, state.failure.massage, state.failure.code);

                    }
                   if(state is SyncDataErrorState){
                     error(context, state.failure.massage, state.failure.code);
                     BlocProvider.of<AsyncBloc>(context).add(OkEvent());
                   }
                   if(state is IsActiveErrorState){
                     error(context, state.failure.massage, state.failure.code);
                     BlocProvider.of<AsyncBloc>(context).add(OkEvent());
                   }
                   if(state is UpdateIsActiveErrorState){
                     error(context, state.failure.massage, state.failure.code);
                     BlocProvider.of<AsyncBloc>(context).add(OkEvent());
                   }
                   if(state is getDataSucState){
                   BlocProvider.of<AsyncBloc>(context).add(SetDataSEvent());
                   }
                   if(state is IsActiveState){
                     BlocProvider.of<AsyncBloc>(context).add(UpdateRepEvent());
                   }
                   if(state is UpdateIsActiveState){
                     BlocProvider.of<AsyncBloc>(context).add(AsyncDataEvent());
                   }
                   if(state is SyncDataLoadingState){
                     loading(context,text: state.loading.toString());
                   }
                   if(state is SyncDataState){
                     BlocProvider.of<AsyncBloc>(context).add(EditEvent(2));
                   }
                   if(state is EditStatusDErrorState){
                     error(context, state.failure.massage, state.failure.code);
                     BlocProvider.of<AsyncBloc>(context).add(OkEvent());
                   }
                   if(state is EditStatusDState){
                     success(context);
                     Phoenix.rebirth(context);
                   }
                  },

                    builder: (context, state)=>

                        ElevatedButton(onPressed: (){
                          print( ((UserInfo.flag1 == 0) &&!(UserInfo.flag == 1&&UserInfo.otherstatus==1)));
                    BlocProvider.of<AsyncBloc>(context).add(PlanIsActiveEvent());
                  },
                      child: Text(
                      "تحميل البيانات",
                  )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
