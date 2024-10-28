import 'package:domina_app/presentation/doctors/widget/html_info.dart';
import 'package:domina_app/presentation/doctors/widget/row_info.dart';
import 'package:domina_app/presentation/resources/assets_manager.dart';
import 'package:flutter/material.dart';
import 'package:domina_app/domain/models/models.dart';

class HospitalDetails extends StatelessWidget {
  final HospitalSpAllModel hospital;

  HospitalDetails({required this.hospital});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("معلومات المشفى"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 30,
            ),
            Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        elevation: 5,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                hospital.title!,
                                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,),
                              ),
                              SizedBox(height: 10)
                            ],
                          ),
                        ),
                      ),
            SizedBox(height: 20),
            Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Image.asset(
                      ImageAssets. hospital,
                      fit: BoxFit.cover,
                      
                      color: Colors.white.withOpacity(0.07),
                      colorBlendMode: BlendMode.modulate,
                    ),
                ),
            
                Container(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
            
                    
                      ListView(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        children: [
                          buildDetailRow(
                              context, Icons.location_on, 'العنوان', hospital.address!),
                          buildHtmlDetailRow(context, Icons.place, 'المكان',
                              hospital.placeTitle!),
                          buildDetailRow(context, Icons.visibility, 'عدد الزيارات',
                              '${hospital.visit}'),
                          buildDetailRow(context, Icons.star, 'التصنيف',
                              '${hospital.rate}'),
                          buildDetailRow(
                              context, Icons.location_on, 'عدد الاطباء', hospital.totalDocs.toString()),
                          buildDetailRow(
                              context, Icons.location_on, 'الاختصاص', hospital.titleSp.toString()),

                          if (hospital.note != null && hospital.note!.isNotEmpty && hospital.note!=" " )
                            buildHtmlDetailRow(context, Icons.note, 'ملاحظات',
                                hospital.note ?? ''),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
 
  }
