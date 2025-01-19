import 'package:domina_app/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';
class RowListInfo extends StatelessWidget {
  const RowListInfo({super.key,required this.text1,required this.text2});
  final String text1;
  final String text2;
  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding:  EdgeInsets.symmetric(horizontal: AppPadding.p14,vertical: AppPadding.p5),
      child: InkWell(
        onTap: () {

        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:[
            Text(
              text1,
              style: Theme.of(context).textTheme.bodySmall,
            ),
            Text(
              text2,
              style: Theme.of(context).textTheme.labelMedium,
            ),
          ],
        ),
      ),
    );
  }
}
