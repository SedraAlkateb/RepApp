//import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:flutter/material.dart';


class SnackBarMessage {

  void showSuccessSnackBar(
      {required String message,
        required BuildContext context,
        required var btnOkOnPress}) {
    // AwesomeDialog(
    //   context: context,
    //   dialogType: DialogType.success,
    //   animType: AnimType.bottomSlide,
    //   title: message,
    //   btnOkText: 'تأكيد',
    //   btnOkOnPress: btnOkOnPress,
    // ).show();
  }

  void showErrorSnackBar(
      {required String message,
        required BuildContext context,
        required var btnOkOnPress}) {
    // AwesomeDialog(
    //   context: context,
    //   dialogType: DialogType.error,
    //   animType: AnimType.bottomSlide,
    //   title: message,
    //   btnCancelText: 'خروج',
    //   btnCancelOnPress: btnOkOnPress,
    // ).show();
  }
  void showAlertSnackBar(
      {required String message,
        required BuildContext context,
        required var btnOkOnPress}) {

    // AwesomeDialog(
    //     context: context,
    //     dialogType: DialogType.question,
    //     animType: AnimType.bottomSlide,
    //     title: message,
    //     btnCancelText: 'خروج',
    //     btnOkText: 'تأكيد',
    //     btnCancelOnPress:() {Navigator.of(context);},
    //     btnOkOnPress:btnOkOnPress
    // ).show();
  }
  void showAlertSScaffoldMessenger(
      {required BuildContext context, required String message}) {
    bool tablet=MediaQuery.of(context).size.width>800;

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        message,
        style: TextStyle(color: ColorManager.secondaryColor3,fontSize:tablet?19:14),
      ),
      backgroundColor: Colors.green,
    ));
  }

  void showAlertFailedMessenger(
      {required BuildContext context, required String message}) {
    bool tablet=MediaQuery.of(context).size.width>800;

    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            message,
            style: TextStyle(color:  ColorManager.secondaryColor3,fontSize:tablet?19:14),
          ),
          backgroundColor: Colors.red,
        ));
  }

  void showBottomSheetMessage({required BuildContext context, required var onPressedConfirm, required var onPressedCancel }){
    final size = MediaQuery.of(context).size;
    bool tablet=MediaQuery.of(context).size.width>800;

    showModalBottomSheet(


        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(30.0)),
        ),
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return Container(
              height: size.height*0.3,

              decoration: BoxDecoration(
                  color: Colors.white,

                  borderRadius: BorderRadius.horizontal(left: Radius.circular(15),right:  Radius.circular(15))
              ),
              child: Column(

                children: [
                  Container(
                      height: size.height*0.3,
                      child:Column(
                        children: [
                          SizedBox(height: size.height*0.05,),
                          Text("We_will_contact_you_as_soon_as_possible",
                            style: TextStyle(color:   ColorManager.secondaryColor1,
                                fontSize:tablet?19:14
                            ),),
                          SizedBox(height: size.height*0.05,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    padding: EdgeInsets.all(8),
                                    fixedSize: Size(
                                        tablet?size.width*0.1:
                                        size.width*0.35
                                        ,size.height*0.05),
                                    backgroundColor:  ColorManager.secondaryColor4,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                  ),
                                  onPressed: onPressedConfirm,
                                  child: Text("Confirm_Click",
                                    style: TextStyle(color:  ColorManager.secondaryColor3,fontSize:tablet?19:14),),
                                ),
                              ),
                              SizedBox(width: 20,),
                              Expanded(
                                child: ElevatedButton(


                                  style: ElevatedButton.styleFrom(
                                    padding: EdgeInsets.all(8),
                                    fixedSize: Size(
                                        tablet?size.width*0.1:
                                        size.width*0.35
                                        ,size.height*0.05),
                                    backgroundColor:  ColorManager.secondaryColor4, // Change the button color
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0), // Set the border radius
                                    ),
                                  ),
                                  onPressed: onPressedCancel,
                                  child: Text("Cancel",style:
                                  TextStyle(color:  ColorManager.secondaryColor3,fontSize:tablet?19:14),),
                                ),
                              ),
                            ],
                          ),
                        ],
                      )
                  ),
                ],
              )
          );

        });
  }
  void showBottomSheetPaymentMessage({required BuildContext context,
    required var onPressedCash, required var onPressedBank }){
    final size = MediaQuery.of(context).size;
    bool tablet=MediaQuery.of(context).size.width>800;

    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(30.0)),
        ),
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return Container(
              height: size.height*0.3,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.horizontal(left: Radius.circular(15),right:  Radius.circular(15))
              ),
              child: Column(

                children: [
                  Container(
                      height: size.height*0.3,
                      child:Column(
                        children: [
                          SizedBox(height: size.height*0.05,),
                          Text("LocaleKeys.payment.tr()",style: TextStyle(color:
                          ColorManager.secondaryColor4,fontSize:tablet?19:14),),
                          SizedBox(height: size.height*0.05,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  fixedSize: Size(
                                      tablet?size.width*0.1:
                                      size.width*0.35
                                      ,size.height*0.05),
                                  backgroundColor:  ColorManager.secondaryColor4,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                ),
                                onPressed: onPressedCash,
                                child: Text("LocaleKeys.Cash.tr()",style: TextStyle
                                  (color:  ColorManager.secondaryColor3
                                    ,fontSize:tablet?19:14
                                ),),
                              ),
                              SizedBox(width: 20,),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  fixedSize: Size(
                                      tablet?size.width*0.1:
                                      size.width*0.35
                                      ,size.height*0.05),
                                  backgroundColor:  ColorManager.secondaryColor4, // Change the button color
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0), // Set the border radius
                                  ),
                                ),
                                onPressed: onPressedBank,
                                child: Text("LocaleKeys.Bank.tr()",
                                  style: TextStyle(color:  ColorManager.secondaryColor3,
                                      fontSize:tablet?19:14
                                  ),),
                              ),
                            ],
                          ),
                        ],
                      )
                  ),
                ],
              )
          );

        });
  }

}

