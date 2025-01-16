import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
class RowList extends StatelessWidget {
  const RowList({super.key,required this.text,required this.icon1});
final
String text;
final IconData icon1;
  @override
  Widget build(BuildContext context) {
    return  InkWell(
      onTap: () {

      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding:  EdgeInsets.symmetric(horizontal:  AppPadding.p18,vertical: AppPadding.p12),
            child: Container(
                margin: EdgeInsets.only(left: 10, bottom: 5),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(color:ColorManager.secondaryColor9 ),
                  // color: ColorManager.secondaryColor9,
                  borderRadius: BorderRadius.vertical(

                      top: Radius.circular(10),
                      bottom: Radius.circular(10)),
                ),
                child: Icon(
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
          SizedBox(width: 10,)
        ],
      ),
    );
  }
}
