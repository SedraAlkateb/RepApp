import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/resources/values_manager.dart';
import 'package:domina_app/presentation/uniti/text.dart';
import 'package:flutter/material.dart';
class RepProfile extends StatelessWidget {
  const RepProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: ColorManager.secondaryColor6,
      appBar:AppBar(
        backgroundColor: ColorManager.secondaryColor4,
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon:Icon(Icons.arrow_back)),

      ) ,
      body: Padding(
        padding: const EdgeInsets.all(AppPadding.p20),
        child: Column(
          children: [
            Container(

            //  color: ColorManager.white,
              height: 200,
              width: MediaQuery.of(context).size.width
              ,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      blurRadius: 0.6,
                      color: ColorManager.white,
                      spreadRadius: 0.5,
                      offset: Offset(2, 3)
                  )
                ],
                borderRadius:
                BorderRadius.vertical(
                    top: Radius.circular(30),
                    bottom: Radius.circular(30)
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextRach(s2: " : الجوال", s1: ' الجوال',),
                  Text("data"),
                  Text("data"),
                ],
              ),
            )
          ],

        ),
      ),
    );
  }
}
