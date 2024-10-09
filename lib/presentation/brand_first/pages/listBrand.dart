import 'package:domina_app/presentation/drawer/pages/drawer_page.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';

class Listbrand extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    
      drawer: DrawerPage(),
      appBar: AppBar(
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Icon(
                size: AppSize.s30,
                Icons.menu,
                color: ColorManager.secondaryColor1,
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        title: Text('لائحة العينات'),
      ),
      body: Container(
          decoration: BoxDecoration(
              gradient:  LinearGradient(colors: [
                                  ColorManager.secondaryColor6,
                                  ColorManager.secondaryColor7,
                                  ColorManager.secondaryColor7,
                                ]),
              color: ColorManager.white,
            ), 
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView.builder(
            itemBuilder: (context, index) => Container(
              margin: EdgeInsets.all(AppPadding.p8),
              padding: EdgeInsets.all(AppPadding.p16),

              decoration: BoxDecoration(

                boxShadow: [

                  BoxShadow(
                  color: ColorManager.filedColor
                  ),
                ],
                color: ColorManager.white,
                border: Border.all(color: ColorManager.secondaryColor3),
                borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8)),
              ),
              child: Row(
               // crossAxisAlignment: CrossAxisAlignment.start, // محاذاة العناصر لليسار
                children: [
                  // الصف الأول: العينة والاختصاص
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                     crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                             mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment:CrossAxisAlignment.start,
                          children: [
                               Icon(Icons.medication_outlined),
                            Text( "العينة : بانتنول",style: Theme.of(context)
                            .textTheme
                            .headlineMedium,),
                          ],
                        ),
                  
                         Row(
                             mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment:CrossAxisAlignment.start,
                           children: [
                               Icon(Icons.medical_services_outlined),
                             Text( "الاختصاص : قلبية",style: Theme.of(context)
                              .textTheme
                              .headlineMedium,),
                           ],
                         )
                       
                      ],
                    ),
                  ),
          
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                      Row(
                           mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment:CrossAxisAlignment.start,
                        children: [
                             Icon(Icons.file_download_done_sharp),
                                 Text(
                          'النوع: كريم',
                          style: Theme.of(context)
                          .textTheme
                          .headlineMedium,
                        ),
                        ],
                      ),
                      SizedBox(height: 10,),
                      Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment:CrossAxisAlignment.center,
                        children: [
                  Icon(Icons.file_download_done_sharp),
                          Text(
                            'العدد:',
                           style: Theme.of(context)
                            .textTheme
                            .headlineMedium,
                          ),
                          SizedBox(width: 10), // مسافة بين النص وحقل الإدخال
                          Container(
                            width: 45,
                            height: 30,
                            child: TextField(
                              decoration: InputDecoration(
                        
                                contentPadding: EdgeInsets.symmetric(
                                  vertical: 8,
                                  horizontal: 10,
                                ), // تحسين المساحة الداخلية للحقل
                              ),
                              keyboardType: TextInputType.number,
                            ),
                          ),
                          
                        ],
                      ),
                  
                    
                      ],
                    ),
                  ),
                ],
              ),
            ),
            itemCount: 5, // عدد العناصر في القائمة
          ),
        ),
      ),
    );
  }
}
