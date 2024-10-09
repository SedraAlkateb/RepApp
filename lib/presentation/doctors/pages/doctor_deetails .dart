import 'package:domina_app/presentation/resources/assets_manager.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:domina_app/domain/models/models.dart';

class DoctorDetails extends StatelessWidget {
  final DoctorModel doctor;

  DoctorDetails({required this.doctor});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    
      appBar: AppBar(
        shadowColor: ColorManager.secondaryColor8,
        title: Text(doctor.title),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(ImageAssets.blue),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            
            Center(
              child: SingleChildScrollView(
                  child: Padding(
                    padding:  EdgeInsets.only(right: AppPadding.p100,),
                    child: Padding(
                      padding: const EdgeInsets.all(AppPadding.p20),
            
                      child: Container(
                        
                        child: Column(
                        
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'الاختصاص : ${doctor.spTitle}',
                                style: Theme.of(context)
                                    .textTheme
                                    .displayLarge!
                                    .copyWith(color: const Color.fromARGB(255, 75, 89, 199)),
                              ),
                            ),
                            Divider(thickness: 0.5,),
                            SizedBox(height: 10),
                            Text(
                              'العنوان : ${doctor.address}',
                              style: Theme.of(context)
                                  .textTheme
                                  .displayLarge!
                                .copyWith(color: const Color.fromARGB(255, 75, 89, 199)),
                            ),
                            SizedBox(height: 10),
                               Divider(thickness: 0.5,),
                            Text(
                              'المكان : ${doctor.placeTitle}',
                              style: Theme.of(context)
                                  .textTheme
                                  .displayLarge!
                                .copyWith(color: const Color.fromARGB(255, 75, 89, 199)),
                            ),
                            SizedBox(height: 10),
                             Divider(thickness: 0.5,),
                            Text(
                              'عدد الزيارات : ${doctor.visits}',
                              style: Theme.of(context)
                                  .textTheme
                                  .displayLarge!
                                  .copyWith(color: const Color.fromARGB(255, 75, 89, 199)),
                            ),
                            SizedBox(height: 10),
                               Divider(thickness: 0.5,),
                            Text(
                              'التصنيف : ${doctor.rate}',
                              style: Theme.of(context)
                                  .textTheme
                                  .displayLarge!
                                 .copyWith(color: const Color.fromARGB(255, 75, 89, 199)),
                            ),
                            SizedBox(height: 10),
                           
                            if (doctor.note != null && doctor.note!.isNotEmpty)
                              Column(
                                children: [
                                   Divider(thickness: 0.5,),   
                                  Text(
                                    "ملاحظات : ${doctor.note}",
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayLarge!
                                       .copyWith(color: const Color.fromARGB(255, 75, 89, 199)),
                                  ),
                                ],
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                     
            ),
          
          Positioned(
            left: 40,
            top: 70,
            child: Text("معلومات الطبيب"
            ,style: Theme.of(context).textTheme.labelLarge,
            
            )),
          ],
        ),
      ),
    );
  }
}
