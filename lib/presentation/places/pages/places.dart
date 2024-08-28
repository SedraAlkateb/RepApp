import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';
 
class Places extends StatelessWidget {
   Places({super.key});
List<String> places=["d","D","d","d","D","d"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Text(
            'Representative Places'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal:8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,

                children: [
                  Icon(Icons.location_city),

                  Text("   All Place",style: Theme.of(context).textTheme.titleMedium,),
                ],
              ),

            ),
            Text("click to show all Doctor,Pharmacy,Hospital in place",),
            Expanded(
              child: ListView.builder
                (
                  itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.all(AppPadding.p8),
                  padding: EdgeInsets.all(AppPadding.p16),
                  //    height: AppSize.s150,
                  decoration: BoxDecoration(
                    color: ColorManager.white,
                    border:
                    Border.all(color: ColorManager.hintGrey),
                    borderRadius: const BorderRadius.all(
                        Radius.circular(AppSize.s8)),
                    //        color: ColorManager.card,
                  ),
                  child: Row(
                    children: [
                      Text(places[index])
                    ],
                  ),
                );
              }, itemCount: places.length),
            ),
          ],
        ),
      )
    );
  }
}