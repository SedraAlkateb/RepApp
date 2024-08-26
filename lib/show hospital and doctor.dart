import 'package:flutter/material.dart';
class Show_All_Visit_Doctors extends StatelessWidget {
  const Show_All_Visit_Doctors({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
body: Center(
  child:   ListView (children: [ 
               Card(
               
                         elevation: 50,
               
                         shadowColor: Colors.black,
               
                         color: Colors.white70,
               
                         child: SizedBox(
               
               
                           child: Padding(
               
                padding: const EdgeInsets.all(20.0),    
               
                child: Column(
                  children: [
                    Center(child: Text('تاريخ الزيارة : 2024-06-25	')),
                      Center(child: Text('اسم المنطقة : ميدان')),
                        Center(child: Text(' اسم الطبيب :ايمن بدر الدين')),
                          Center(child: Text('الاختصاص : داخلية')),
                            Center(child: Text('المكتب العلمي: لا يوجد')),
                             Center(child: Text(' مستودع قاسيون : لايوجد')),
                                Center(child: Text(' طلبات خاصة : لايوجد')),
                                    Center(child: Text(' بريدنيزولون دومِنا شراب : 4')),
                  ],
                ),
               
               ))),
               Card(
                 
                           elevation: 50,
                 
                           shadowColor:  Color.fromARGB(255, 20, 38, 48),
                 
                           color: Colors.white70,
                 
                           child: SizedBox(
                 
                 
                             child: Padding(
                 
                  padding: const EdgeInsets.all(20.0),    
                 
                  child: Column(
                    children: [
                      Center(child: Text('تاريخ الزيارة : 2024-05-25	')),
                        Center(child: Text('اسم المنطقة : برامكة')),
                          Center(child: Text(' اسم الطبيب :ايمن بدر الدين')),
                            Center(child: Text('الاختصاص : أطفال')),
                              Center(child: Text('المكتب العلمي: لا يوجد')),
                               Center(child: Text(' مستودع قاسيون : لايوجد')),
                                  Center(child: Text(' طلبات خاصة : لايوجد')),
                                      Center(child: Text('	بريدنيزولون دومِنا (تعبئة 10مل) قطرة عينية أذنية: 1')),
                    ],
                  ),
                 
                 ))),
                     Card(
                 

     


                           elevation: 50,
                 
                           shadowColor:  Color.fromARGB(255, 20, 38, 48),
                 
                           color: Colors.white70,
                 
                           child: SizedBox(
                 
                 
                             child: Padding(
                 
                  padding: const EdgeInsets.all(20.0),    
                 
                  child: Column(
                    children: [
                      Center(child: Text('تاريخ الزيارة : 2024-05-25	')),
                        Center(child: Text('اسم المنطقة : 29آيار')),
                          Center(child: Text(' اسم الطبيب :ايمن بدر الدين')),
                            Center(child: Text('الاختصاص : أذنية')),
                              Center(child: Text('المكتب العلمي: لا يوجد')),
                               Center(child: Text(' مستودع قاسيون : لايوجد')),
                                  Center(child: Text(' طلبات خاصة : لايوجد')),
                                      Center(child: Text(' العينات الموزعة :أسبرين دومِنا 75 7')),
                    ],
                  ),
                 
                 ))),
               ]),
),    
    );
  }
}