import 'package:domina_app/presentation/brand_plan/bloc/brand_plan_bloc.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/resources/values_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

 Widget dialogPlan(BuildContext context,bool conf,String text){
   return WillPopScope(
     onWillPop: () async {
       return false;
     },
     child: Dialog(
       shape: RoundedRectangleBorder(
         borderRadius: BorderRadius.circular(AppSize.s14),

       ),
       elevation: AppSize.s1_5,
       backgroundColor: Colors.transparent,
       child: Container(
         padding: EdgeInsets.all(8),
         decoration: BoxDecoration(
             color: ColorManager.white,
             shape: BoxShape.rectangle,
             borderRadius: BorderRadius.circular(AppSize.s14),
             boxShadow: const [
               BoxShadow(
                   color: Colors.black26
               )
             ]
         ),
         child: Padding(
           padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 40),
           child: Column(
             mainAxisSize: MainAxisSize.min,
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
             crossAxisAlignment: CrossAxisAlignment.center,
             children: [Text(text),
               SizedBox(height: 20,),
               Row(
                 mainAxisAlignment: MainAxisAlignment.center,
                 crossAxisAlignment: CrossAxisAlignment.center,
                 children: [
                   ElevatedButton(onPressed: (){
                     Navigator.pop(context);
                   }, child: Text("الغاء")),
                   SizedBox(width: 8,),
                   ElevatedButton(onPressed:() =>conf?
                       BlocProvider.of<BrandPlanBloc>(context).add(UpdateAmountSucEvent()):
                   BlocProvider.of<BrandPlanBloc>(context)
                       .add(SendToS())
                       , child: Text("تاكيد"))
                 ],),
               SizedBox(height: 20,)
             ],
           ),
         ),
       ),
     ),
   );

}