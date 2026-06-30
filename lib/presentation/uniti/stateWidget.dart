import 'package:domina_app/presentation/uniti/common/state_renderer/state_renderer.dart';
import 'package:domina_app/presentation/uniti/common/state_renderer/state_renderer_imp.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
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
Widget loadingShimmer(BuildContext context, int count, double? width,
    double? height, BorderRadiusGeometry? borderRadius) {
  return ListView.builder(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    itemCount: count,
    itemBuilder: (context, index) => Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        margin:  EdgeInsets.all(AppPaddingH.p8),
        padding:  EdgeInsets.all(AppPaddingH.p16),
        decoration: BoxDecoration(
          border: Border.all(color: ColorManager.secondaryColor22),
          color: const Color.fromARGB(255, 250, 254, 255),
          borderRadius: borderRadius,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: width,
              height: height,
              color: Colors.grey[300],
            ),
            Container(
              width: width,
              height: height,
              decoration: BoxDecoration(
                borderRadius: borderRadius,
                color: Colors.grey[300],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
void error(BuildContext context, String massage, int code)async {
  await dismissDialog(context);
  ErrorState(StateRendererType.popupErrorState, massage)
      .showPopup(context, StateRendererType.popupErrorState, massage);
}
void loading(BuildContext context, {String? text}) {
  LoadingState(stateRendererType: StateRendererType.popupLoadingState)
      .showPopup(context, StateRendererType.popupLoadingState, "loading $text");
}
Future<bool> success(BuildContext context) async{

  try {
   dismissDialog(context);
    return true;
  } catch (e) {
    print("ssssssssssssssssss: $e");
    return false;
  }
}
void successWithMessage(BuildContext context, String message) {
  SuccessState(message)//
      .showPopup(context, StateRendererType.popupSuccess, message);
}
Future<bool> dismissDialog(BuildContext context) async {
  try {
    // نتحقق مباشرة من الـ rootNavigator إذا كان لديه أي Dialog مفتوح يمكن إغلاقه
    if (Navigator.of(context, rootNavigator: true).canPop()) {
      Navigator.of(context, rootNavigator: true).pop(true);
      print("Dialog dismissed successfully.");

      // نمنح المعالج 50 ملي ثانية لإنهاء حركة الإغلاق والتأكد من استقرار الـ Context
      await Future.delayed(const Duration(milliseconds: 50));
      return true;
    }
    print("No dialog found to dismiss.");
    return false;
  } catch (e) {
    print("Error during dismissDialog: $e");
    return false;
  }
}