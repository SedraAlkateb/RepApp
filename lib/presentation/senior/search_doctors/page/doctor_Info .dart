import 'package:domina_app/presentation/doctors/widget/html_info.dart';
import 'package:domina_app/presentation/doctors/widget/row_info.dart';
import 'package:domina_app/presentation/resources/assets_manager.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/senior/search_doctors/bloc/search_doctors_bloc.dart';
import 'package:domina_app/presentation/uniti/stateWidget.dart';
import 'package:flutter/material.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DoctorInfo  extends StatelessWidget {
  DoctorInfo();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("معلومات الطبيب"),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Image.asset(
            ImageAssets.doctor2,
            fit: BoxFit.cover,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: ColorManager.secondaryColor4.withOpacity(0.07),
            colorBlendMode: BlendMode.modulate,
          ),
          SingleChildScrollView(
            child: BlocBuilder<SearchDoctorsBloc, SearchDoctorsState>(
  builder: (context, state) {
    if(state is DoctorInfoLoadingState){
     return loadingFullScreen(context);
    }
    else if(state is DoctorInfoErrorState){
      return errorFullScreen(context);
    }
    else if(state is DoctorInfoState){
      DoctorModel doctor=state.doctor;
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 30,
          ),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            elevation: 20,
            shadowColor: ColorManager.secondaryColor4.withOpacity(0.5),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    doctor.title,
                    style:
                    Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.medical_services, color: Colors.blue),
                      SizedBox(width: 8),
                      Text(
                        'الإختصاص: ${doctor.spTitle}',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListView(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  children: [
                    buildDetailRow(context, Icons.place, 'المنطقة',
                        doctor.placeTitle),
                    Divider(
                      thickness: 0.5,
                    ),
                    buildDetailRow(context, Icons.location_city_outlined,
                        'العنوان', doctor.address),
                    Divider(
                      thickness: 0.5,
                    ),
                    buildDetailRow(context, Icons.visibility,
                        'عدد الزيارات', '${doctor.visits}'),
                    Divider(
                      thickness: 0.5,
                    ),
                    buildDetailRow(
                        context, Icons.star, 'التصنيف', '${doctor.rate}'),
                    if (doctor.note != null && doctor.note!.isNotEmpty)
                      Column(
                        children: [
                          Divider(
                            thickness: 0.5,
                          ),
                          buildHtmlDetailRow(context, Icons.note,
                              'ملاحظات', doctor.note ?? ''),
                        ],
                      ),
                    if (doctor.workHours != null &&
                        doctor.workHours!.isNotEmpty &&
                        doctor.workHours != " ")
                      Column(
                        children: [
                          Divider(
                            thickness: 0.5,
                          ),
                          buildHtmlDetailRow(context, Icons.work,
                              'أوقات العمل', doctor.workHours ?? ''),
                        ],
                      ),

                  ],
                ),
              ],
            ),
          ),
        ],
      );
    }
    return SizedBox();
  },
),
          ),
        ],
      ),
    );
  }
}
