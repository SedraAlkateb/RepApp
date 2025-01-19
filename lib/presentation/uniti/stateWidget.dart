import 'package:domina_app/presentation/common/state_renderer/state_renderer.dart';
import 'package:domina_app/presentation/common/state_renderer/state_renderer_imp.dart';
import 'package:flutter/cupertino.dart';

void loading(BuildContext context, {String? text}) {
  LoadingState(stateRendererType: StateRendererType.popupLoadingState)
      .showPopup(context, StateRendererType.popupLoadingState, "loading $text");
}

Widget loadingFullScreen(BuildContext context) {
 return LoadingState(stateRendererType: StateRendererType.fullScreenLoadingState)
      .getScreenWidget(context, SizedBox(), (){});
}
Widget errorFullScreen(BuildContext context,{Function? func}) {
  return ErrorState(StateRendererType.fullScreenErrorState, "")
      .getScreenWidget(context, SizedBox(), func??(){});
}

void error(BuildContext context, String massage, int code) {
  ErrorState(StateRendererType.popupErrorState, massage).dismissDialog(context);
  ErrorState(StateRendererType.popupErrorState, massage)
      .showPopup(context, StateRendererType.popupErrorState, massage);
}



String success(BuildContext context) {
 try{
   ContentState().dismissDialog(context);
   return "true";
 }catch(e){
   print("KKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKK");
   return"$e ssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssss";
 }
}

void successWithMessage(BuildContext context, String message) {
  ContentState().dismissDialog(context);
  SuccessState(message)
      .showPopup(context, StateRendererType.popupSuccess, message);
}

Widget emptyFullScreen(BuildContext context) {
  return ErrorState(StateRendererType.fullScreenEmptyState, "لا يوجد بيانات")
      .getScreenWidget(context, SizedBox(),(){});
}
Widget errorFullScreenWidget(BuildContext context,String message) {
  return StateRenderer(
      stateRendererType: StateRendererType.fullScreenEmptyState,
      message: message,
      retryActionFunction: () {});

}