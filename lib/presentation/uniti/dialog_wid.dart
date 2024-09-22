import 'dart:ui';
import 'package:domina_app/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';
class DialogFilter extends StatelessWidget{
  const DialogFilter({super.key,required this.text});

  final String text;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return
      Stack(
        children: <Widget>[
          Container(
            color: Colors.transparent,
          ),
          // Blurred overlay
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
              child: Container(
                color: Colors.white.withOpacity(0.5), // Adjust opacity as needed
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: SizedBox(
                    height:  size.height * 0.9 ,
                    width:  size.width ,
                    child: AlertDialog(
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding:  const EdgeInsets.only(right: AppPadding.p8),
                            child:  Text(text,style: const TextStyle(fontSize: 20)),
                          ),
                          ElevatedButton(onPressed: (){}, child:
                          Text("data"))

                        ],
                      ),

                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      );
  }
}
