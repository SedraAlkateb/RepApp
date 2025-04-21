import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';

class TextSerachDoctor extends StatelessWidget {
  const TextSerachDoctor(
      {super.key,
      required this.s1,
      required this.s2,
      this.c1,
      this.c2,
      this.size1,
      this.size2,
      this.textStyle});
  final String s1;
  final String s2;
  final double? size1;
  final double? size2;
  final Color? c1;
  final Color? c2;
  final TextStyle? textStyle;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(AppPadding.p20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            s1,
            style: textStyle != null
                ? textStyle
                : Theme.of(context).textTheme.labelLarge,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.circle,color:ColorManager.secondaryColor1 ,size: AppSize.s12,),
              SizedBox(width: 10,),
              Expanded(
                child: Text(
                            s2,
                
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
