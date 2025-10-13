import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';
class TextInfo extends StatelessWidget {
  const TextInfo({super.key,required this.title,required this.supTitle});
final String title;
final String? supTitle;
  @override
  Widget build(BuildContext context) {
    return  ( supTitle!=null&&  supTitle!=""&&  supTitle!=".")? Padding(
      padding:  EdgeInsets.only(bottom:AppPaddingH.p8 ),
      child: Column(
        children: [
          Row(
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
                    "${title}: ",
                    style: Theme.of(context).textTheme.labelLarge,
                    children: <TextSpan>[
                      TextSpan(
                        text: supTitle,
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall,
                      ),
                    ],
                  ),
                ),
              ),

            ],
          ),
          SizedBox(height: 20,),
          Divider(height: 0.5,
          thickness: 1,color: ColorManager.secondaryColor7,),
        ],
      ),
    ):SizedBox();
  }
}

