import 'package:flutter/material.dart';
class TextSerachDoctor extends StatelessWidget {
  const TextSerachDoctor({super.key,required this.s1,required this.s2,this.c1,this.c2,this.size1,this.size2
    , this.textStyle
  });
  final String s1;
  final String s2;
  final   double? size1;
  final  double? size2;
  final Color? c1;
  final Color? c2;
  final TextStyle? textStyle;
  @override
  Widget build(BuildContext context) {

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Text.rich(
            textAlign: TextAlign.center,
            softWrap: false,
            maxLines: 20,
            overflow:
            TextOverflow.ellipsis,
            TextSpan(

              text:
              s1,
              style: textStyle!=null?textStyle:Theme.of(context).textTheme.labelLarge,
              children: <TextSpan>[
                TextSpan(
                  text: s2,
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
