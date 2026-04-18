import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
class RowList extends StatelessWidget {
  const RowList({super.key,required this.text,required this.icon1,this.function});
final
String text;
final FaIconData icon1;
  final VoidCallback ?function;
  @override
  Widget build(BuildContext context) {
    return  InkWell(
      onTap: function,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding:  EdgeInsets.symmetric(horizontal:  AppPaddingW.p18,vertical: AppPaddingH.p12),
            child: Container(
                margin: EdgeInsets.only(left: 10.w, bottom: 5.h),
                padding: EdgeInsets.all(10.h),
                decoration: BoxDecoration(
                  border: Border.all(color:ColorManager.secondaryColor9 ),
                  // color: ColorManager.secondaryColor9,
                  borderRadius: BorderRadius.vertical(

                      top: Radius.circular(10),
                      bottom: Radius.circular(10)),
                ),
                child: FaIcon(

                  icon1,
                  color: ColorManager.secondaryColor2,
                )),
          ),
          Expanded(
            child: Text(
              text,
              style: Theme.of(context).textTheme.labelMedium,
            ),
          ),
          SizedBox(width: 10.w,)
        ],
      ),
    );
  }
}
