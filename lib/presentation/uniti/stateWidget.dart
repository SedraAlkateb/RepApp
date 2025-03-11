import 'package:domina_app/presentation/common/state_renderer/state_renderer.dart';
import 'package:domina_app/presentation/common/state_renderer/state_renderer_imp.dart';
import 'package:flutter/cupertino.dart';
Widget loadingFullScreen(BuildContext context) {
 return LoadingState(stateRendererType: StateRendererType.fullScreenLoadingState)
      .getScreenWidget(context, SizedBox(), (){});
}
Widget errorFullScreen(BuildContext context,{Function? func,String? mes}) {
  return ErrorState(StateRendererType.fullScreenErrorState, mes??"")
      .getScreenWidget(context, SizedBox(), func??(){});
}
Widget emptyFullScreen(BuildContext context,{String ? message}) {
  return ErrorState(StateRendererType.fullScreenEmptyState,message?? "لا يوجد بيانات")
      .getScreenWidget(context, SizedBox(),(){});
}
void error(BuildContext context, String massage, int code) {
  dismissDialog(context);
  ErrorState(StateRendererType.popupErrorState, massage)
      .showPopup(context, StateRendererType.popupErrorState, massage);
}
void loading(BuildContext context, {String? text}) {
  LoadingState(stateRendererType: StateRendererType.popupLoadingState)
      .showPopup(context, StateRendererType.popupLoadingState, "loading $text");
}
Future<bool> success(BuildContext context) async{
  try {
    ContentState().dismissDialog(context);
    return true;
  } catch (e) {
    print("ssssssssssssssssss: $e");
    return false;
  }
}
void successWithMessage(BuildContext context, String message) {
  SuccessState(message)
      .showPopup(context, StateRendererType.popupSuccess, message);
}
Future<bool> dismissDialog(BuildContext context) async {
  try {
    if (_isCurrentDialogShowing(context)) {
      Navigator.of(context, rootNavigator: true).pop(true);
      print("Dialog dismissed successfully.");
    }
    return true;
  } catch (e) {
    print("ssssssssssssssssss: $e");
    return false;
  }
}
bool _isCurrentDialogShowing(BuildContext context) {
  return ModalRoute.of(context)?.isCurrent != true;
}
