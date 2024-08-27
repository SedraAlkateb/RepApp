import 'package:flutter/material.dart';
class TextRach extends StatelessWidget {
   const TextRach({super.key,required this.s1,required this.s2,this.c1,this.c2,this.size1,this.size2
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
      children: [
        Expanded(
          child: Text.rich(
            softWrap: false,
            maxLines: 3,
            overflow:
            TextOverflow.ellipsis,
            TextSpan(
              text:
              s1,
              style: textStyle!=null?textStyle:Theme.of(context).textTheme.displaySmall,
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
