import 'package:domina_app/app/di.dart';
import 'package:domina_app/presentation/Recipes/pages/recipes_hospital.dart';
import 'package:domina_app/presentation/doctors/widget/html_info.dart';
import 'package:domina_app/presentation/doctors/widget/row_info.dart';
import 'package:domina_app/presentation/hospitals/bloc/hospitals_bloc.dart';
import 'package:domina_app/presentation/resources/assets_manager.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/uniti/stateWidget.dart';
import 'package:flutter/material.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HospitalViewDetails extends StatelessWidget {
  final List<SpecHospitalSp> hospitalsp;
  final HospitalModel hospital;
  HospitalViewDetails({required this.hospital, required this.hospitalsp});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //    backgroundColor: ColorManager.secondaryColor8,
      appBar: AppBar(
        title: Text("معلومات المشفى"),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                opacity: 0.1,
                fit: BoxFit.contain,
                scale: 0.5,
                image: ExactAssetImage(ImageAssets.hospital, scale: 2))),
        child: SingleChildScrollView(
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
                        hospital.title,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                      ),
                      SizedBox(height: 10)
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildDetailRow(context, Icons.location_on, 'العنوان',
                        hospital.address),
                    Divider(
                      thickness: 0.5,
                    ),
                    buildHtmlDetailRow(
                        context, Icons.place, 'المكان', hospital.placeTitle),
                    Divider(
                      thickness: 0.5,
                    ),
                    if (hospital.note != null && hospital.note!.isNotEmpty && hospital.note!=" " )
                      buildHtmlDetailRow(
                          context, Icons.note, 'ملاحظات', hospital.note ?? ''),
                    Text(
                      "معلومات اضافية:",
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    ListView.separated(
                      separatorBuilder: (context, index) => SizedBox(
                        height: 10,
                      ),
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: hospitalsp.length,
                      itemBuilder: (context, index) {
                        return Container(
                          padding: EdgeInsets.only(left: 20),
                          decoration: BoxDecoration(
                              color: ColorManager.secondaryColor8
                                  .withOpacity(0.06),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              border: Border.all(
                                  color: ColorManager.secondaryColor7)),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(16),
                                child: Image.asset(
                                  ImageAssetsSpec()
                                      .getImage(hospitalsp[index].specModel.id),
                                  width: 35,
                                  height: 60,
                                  color: ColorManager.secondaryColor4,
                                  colorBlendMode: BlendMode.modulate,
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Text.rich(
                                            textAlign: TextAlign.start,
                                            softWrap: false,
                                            maxLines: 3,
                                            overflow: TextOverflow.ellipsis,
                                            TextSpan(
                                              text: 'عدد الزيارات: ',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .displaySmall,
                                              children: <TextSpan>[
                                                TextSpan(
                                                  text:
                                                      '${hospitalsp[index].hospitalSpModel.visit}',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headlineMedium,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Text.rich(
                                            textAlign: TextAlign.start,
                                            softWrap: false,
                                            maxLines: 3,
                                            overflow: TextOverflow.ellipsis,
                                            TextSpan(
                                              text: 'التصنيف: ',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .displaySmall,
                                              children: <TextSpan>[
                                                TextSpan(
                                                  text:
                                                      '${hospitalsp[index].hospitalSpModel.rate}',
                                                  style: TextStyle(
                                                      color: ColorManager
                                                          .secondaryColor4,
                                                      fontSize: 16,
                                                      fontStyle:
                                                          FontStyle.normal),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Text.rich(
                                            textAlign: TextAlign.start,
                                            softWrap: false,
                                            maxLines: 3,
                                            overflow: TextOverflow.ellipsis,
                                            TextSpan(
                                              text: 'عدد الاطباء: ',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .displaySmall,
                                              children: <TextSpan>[
                                                TextSpan(
                                                  text:
                                                      '${hospitalsp[index].hospitalSpModel.totalDocs}',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headlineMedium,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Text.rich(
                                            textAlign: TextAlign.start,
                                            softWrap: false,
                                            maxLines: 3,
                                            overflow: TextOverflow.ellipsis,
                                            TextSpan(
                                              text: 'الاختصاص: ',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .displaySmall,
                                              children: <TextSpan>[
                                                TextSpan(
                                                  text: hospitalsp[index]
                                                      .specModel
                                                      .title
                                                      .toString(),
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headlineMedium,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),

                                      ],
                                    ),
                                  ],
                                ),
                              ),

                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: BlocListener<HospitalsBloc, HospitalsState>(
                  listener: (context, state) {
                    if (state is CheckRecipesState) {
                      if (state.isCheck == true) {
                        initBrandRecModule();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RecipesHospital(HospitalId: hospital.id,
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
                  child: BlocBuilder<HospitalsBloc, HospitalsState>(
                    builder: (context, state) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                            onPressed:state is CheckRecipesLoadingState?null: () {
                              WidgetsBinding.instance
                                  .addPostFrameCallback((_) {
                                BlocProvider.of<HospitalsBloc>(context)
                                    .add(CheckReciEvent(hospital.id??0,0));
                              });
                            },
                            child: Text('إنشاء وصفة'),
                          ),
                          ElevatedButton(
                            onPressed:state is CheckRecipesLoadingState?null: () {
                              WidgetsBinding.instance
                                  .addPostFrameCallback((_) {
                                BlocProvider.of<HospitalsBloc>(context)
                                    .add(CheckReciEvent(hospital.id,1));
                              });
                            },
                            child: Text('تكرار وصفة'),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
