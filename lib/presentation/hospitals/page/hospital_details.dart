import 'package:domina_app/app/di.dart';
import 'package:domina_app/presentation/Recipes/pages/recipes_hospital.dart';
import 'package:domina_app/presentation/doctors/bloc/doctors_bloc.dart';
import 'package:domina_app/presentation/doctors/widget/html_info.dart';
import 'package:domina_app/presentation/doctors/widget/row_info.dart';
import 'package:domina_app/presentation/resources/assets_manager.dart';
import 'package:domina_app/presentation/uniti/stateWidget.dart';
import 'package:flutter/material.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../resources/color_manager.dart';

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
                         elevation: 20,
              shadowColor:ColorManager.secondaryColor4.withOpacity(0.5),
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
                        children: [   buildDetailRow(context, Icons.place, 'المنطقة',
                            hospital.placeTitle!),
                          Divider(thickness: 0.4,),
                          buildDetailRow(
                              context, Icons.location_city_outlined, 'العنوان', hospital.address!),
                          Divider(thickness: 0.4,),
                          buildDetailRow(context, Icons.visibility, 'عدد الزيارات',
                              '${hospital.visit}'),
                          Divider(thickness: 0.4,),
                          buildDetailRow(context, Icons.star, 'التصنيف',
                              '${hospital.rate}'),
                          Divider(thickness: 0.4,),
                          buildDetailRow(
                              context, Icons.group, 'عدد الأطباء', hospital.totalDocs.toString()),
                          Divider(thickness: 0.4,),
                          buildDetailRow(
                              context, Icons.medical_services, 'الإختصاص', hospital.titleSp.toString()),
                          Divider(thickness: 0.4,),
                          if (hospital.note != null && hospital.note!.isNotEmpty && hospital.note!=" " )
                            buildHtmlDetailRow(context, Icons.note, 'ملاحظات',
                                hospital.note ?? ''),
                          BlocListener<DoctorsBloc, DoctorsState>(
                            listener: (context, state) {
                              if (state is CheckRecipesState) {
                                if (state.isCheck == true) {
                                  initBrandRecModule();
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => RecipesHospital(HospitalId: hospital.hospitalId??0,
                                      //  docId: doctor.id,
                                        st: state.st,
                                      ),
                                    ),
                                  );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text(
                                            'لقد تجاوزت الحد المسموح لعدد الوصفات')),
                                  );
                                }
                              }
                              if (state is CheckRecipesErrorState) {
                                error(context, state.failure.massage,
                                    state.failure.code);
                              }
                            },
                            child: BlocBuilder<DoctorsBloc, DoctorsState>(
                              builder: (context, state) {
                                return Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    ElevatedButton(
                                      onPressed:state is CheckRecipesLoadingState?null: () {
                                        WidgetsBinding.instance
                                            .addPostFrameCallback((_) {
                                          // BlocProvider.of<DoctorsBloc>(context)
                                          //     .add(CheckReciEvent(doctor.id,0));
                                        });
                                      },
                                      child: Text('إنشاء وصفة'),
                                    ),
                                    ElevatedButton(
                                      onPressed:state is CheckRecipesLoadingState?null: () {
                                        WidgetsBinding.instance
                                            .addPostFrameCallback((_) {
                                          // BlocProvider.of<DoctorsBloc>(context)
                                          //     .add(CheckReciEvent(doctor.id,1));
                                        });
                                      },
                                      child: Text('تكرار وصفة'),
                                    ),
                                  ],
                                );
                              },
                            ),
                          )
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
