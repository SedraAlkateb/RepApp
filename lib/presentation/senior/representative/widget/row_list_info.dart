import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
class RowListInfo extends StatelessWidget {
  const RowListInfo({super.key,required this.text1,required this.text2});
  final
  String text1;
  final
  String text2;
  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding:  EdgeInsets.all(AppPadding.p12),
      child: InkWell(
        onTap: () {

        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              text1,
              style: Theme.of(context).textTheme.labelMedium,
            ),
            Expanded(
              child: Text(
                text2,
                style: Theme.of(context).textTheme.labelMedium,
              ),
            ),
            SizedBox(width: 10,)
          ],
        ),
      ),
    );
  }
}
