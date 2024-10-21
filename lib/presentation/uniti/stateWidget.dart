import 'package:domina_app/presentation/common/state_renderer/state_renderer.dart';
import 'package:domina_app/presentation/common/state_renderer/state_renderer_imp.dart';
import 'package:flutter/cupertino.dart';

void loading(BuildContext context)
{
  LoadingState(
      stateRendererType:
      StateRendererType.popupLoadingState)
      .showPopup(
      context,
      StateRendererType.popupLoadingState,
      "loading");
}
void loadingFullScreen(BuildContext context)
{
  LoadingState(
      stateRendererType:
      StateRendererType.fullScreenLoadingState)
      .showPopup(
      context,
      StateRendererType.fullScreenLoadingState,
      "");
}
void error(BuildContext context,String massage,int code)
{
  ErrorState ( StateRendererType.popupErrorState,
      massage )
      .dismissDialog(context);
  ErrorState(StateRendererType.popupErrorState,
      massage)
      .showPopup(
      context,
      StateRendererType.popupErrorState,
      massage);


}

void errorFullScreen(BuildContext context,String massage,int code)
{
  ErrorState ( StateRendererType.fullScreenErrorState,
      massage )
      .dismissDialog(context);
  ErrorState(StateRendererType.fullScreenErrorState,
      massage)
      .showPopup(
      context,
      StateRendererType.fullScreenErrorState,
      massage);


}
void success(BuildContext context){
  ContentState().dismissDialog(context);


}
void successWithMessage(BuildContext context,String message) {
  ContentState().dismissDialog(context);
  SuccessState(message).showPopup(
  context,
  StateRendererType.popupSuccess,
  message);
}
Widget emptyFullScreen(BuildContext context)
{
return  StateRenderer(stateRendererType: StateRendererType.fullScreenEmptyState, message: "لا يوجد بيانات", retryActionFunction: (){});



}