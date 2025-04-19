import 'package:domina_app/app/user_info.dart';
import 'package:domina_app/presentation/active_plan/widget/dialog_plan.dart';
import 'package:domina_app/presentation/resources/assets_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SaveSendBottom extends StatelessWidget {
  const SaveSendBottom({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
        bottom: 20,
        left: 10,
        child: Column(
          children: [
            InkWell(
              onTap: () {
                UserInfo.otherstatus == 0
                    ? showDialog(
                  context: context,
                  builder: (context) {
                    return dialogPlan(
                        context,
                        fun: () {} 
                        // BlocProvider.of<
                        //     BrandPlanBloc>(context)
                        //     .add(UpdateAmountSucEvent())
                            ,
                        "هل أنت متأكد من حفظ التغيرات");
                  },
                )
                    : null;
              },
              child: SizedBox(
                height: 80,
                width: 100,
                child: Stack(
                  //    alignment: Alignment.bottomCenter,
                  children: [
                    Image.asset(
                      ImageAssets.top,
                    ),
                    Positioned(
                      bottom: 20,
                      left: 35,
                      child: Text(
                        "حفظ",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {
                UserInfo.otherstatus == 0
                    ? showDialog(
                  context: context,
                  builder: (context) {
                    return dialogPlan(
                        context,
                        fun: () {}
                            // BlocProvider.of<BrandPlanBloc>(
                            //     context)
                            //     .add(SendToS())
                                ,
                        "هل أنت متأكد من إرسال التغيرات");
                  },
                )
                    : null;
              },
              child: SizedBox(
                height: 80,
                width: 100,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.asset(
                      ImageAssets.bottom,
                    ),
                    Positioned(
                      bottom: 50,
                      left: 35,
                      child: Text(
                        "إرسال",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
