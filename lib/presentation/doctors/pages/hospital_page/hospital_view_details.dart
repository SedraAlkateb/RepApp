
import 'package:domina_app/presentation/doctors/widget/bottom.dart';
import 'package:domina_app/presentation/doctors/widget/card.dart';
import 'package:domina_app/presentation/doctors/widget/header.dart';
import 'package:domina_app/presentation/doctors/widget/note.dart';
import 'package:domina_app/presentation/resources/assets_manager.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildHeader(hospital.title),
                SizedBox(height: 20.h),
                _buildDetailsCard(),

                SizedBox(height: 15.h),
                buildNotesCard(hospital.note),
                SizedBox(height: 15.h),
                _buildAddNote(context),
                SizedBox(
                  height: 150,
                ),
              ],
            ),
          ),
          buildBottomButtons(hospital.id),
        ],
      ),
    );

  }
  Widget _buildDetailsCard() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(25.r)),
      child: Column(
        children: [
          buildInfoRow(Icons.location_on_outlined, "المنطقة", hospital.placeTitle),
          const Divider(height: 30,thickness: 0.1,),
          buildInfoRow(Icons.business_outlined, "العنوان", hospital.address),

        ],
      ),
    );
  }
  Widget _buildAddNote(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(25.r)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "معلومات اضافية:",
            style: Theme.of(context).textTheme.labelLarge,
          ),
          SizedBox(height: 15.h),
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
                        errorBuilder: (context, error, stackTrace) {
                          return SizedBox();
                        },
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
                                            fontSize: 16.sp,
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
    );
  }
}
