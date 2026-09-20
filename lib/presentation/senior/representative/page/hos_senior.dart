import 'package:domina_app/presentation/resources/responsive/app_responsive.dart';
import 'package:domina_app/presentation/senior/representative/bloc/senior_prof_bloc.dart';
import 'package:domina_app/presentation/senior/representative/widget/hos_card.dart';
import 'package:domina_app/presentation/uniti/num_list.dart';
import 'package:domina_app/presentation/uniti/search_field.dart';
import 'package:domina_app/presentation/uniti/stateWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HospitalSenior extends StatelessWidget {
  HospitalSenior({
    super.key,
  });

  final TextEditingController searchHosController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final deviceType = AppResponsive.deviceType(context);

    double pageMaxWidth;
    double horizontalPadding;
    double topPadding;
    double searchBottomSpacing;
    double headerVerticalPadding;
    double listTopPadding;
    double listBottomPadding;

    switch (deviceType) {
      case AppDeviceType.mobilePortrait:
        pageMaxWidth = 600;
        horizontalPadding = 16;
        topPadding = 16;
        searchBottomSpacing = 10;
        headerVerticalPadding = 12;
        listTopPadding = 6;
        listBottomPadding = 24;
        break;

      case AppDeviceType.tabletPortrait:
        pageMaxWidth = 760;
        horizontalPadding = 28;
        topPadding = 20;
        searchBottomSpacing = 14;
        headerVerticalPadding = 16;
        listTopPadding = 8;
        listBottomPadding = 30;
        break;

      case AppDeviceType.tabletLandscape:
        pageMaxWidth = 900;
        horizontalPadding = 32;
        topPadding = 16;
        searchBottomSpacing = 12;
        headerVerticalPadding = 14;
        listTopPadding = 6;
        listBottomPadding = 28;
        break;
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: const Text(
          'أرشيف المشافي',
        ),
      ),
      // ✅ وضع LayoutBuilder في الجذر لتمكين السكرول في كل المساحة الفارغة
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight, // لملء طول الشاشة بالكامل وتفعيل السكرول من الأسفل
              ),
              child: Center(
                // ✅ نقل الـ ConstrainedBox الخاص بالعرض إلى هنا ليحيط بالمحتوى فقط بينما السكرول يشمل كامل الشاشة
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: pageMaxWidth,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // =================================================
                      // Search
                      // =================================================
                      Padding(
                        padding: EdgeInsets.fromLTRB(
                          horizontalPadding,
                          topPadding,
                          horizontalPadding,
                          0,
                        ),
                        child: SearchField(
                          searchController: searchHosController,
                          onPressed: (value) {
                            BlocProvider.of<SeniorProfBloc>(
                              context,
                            ).add(
                              SenSearchHospEvent(
                                value,
                              ),
                            );
                          },
                        ),
                      ),

                      SizedBox(
                        height: searchBottomSpacing,
                      ),

                      // =================================================
                      // Hospitals List
                      // =================================================
                      BlocBuilder<SeniorProfBloc, SeniorProfState>(
                        builder: (context, state) {
                          List hospitalModel =
                              context.watch<SeniorProfBloc>().hospital;

                          if (state is SenAllHospitalsState) {
                            hospitalModel = state.hospital;
                          }

                          if (state is SenAllHospitalLoadingState) {
                            return loadingFullScreen(
                              context,
                            );
                          }

                          if (state is SenAllHospitalEmptyState) {
                            return emptyFullScreen(
                              context,
                            );
                          }

                          if (state is SenAllHospitalErrorState) {
                            return errorFullScreen(
                              context,
                            );
                          }

                          return Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: horizontalPadding,
                                  vertical: headerVerticalPadding,
                                ),
                                child: buildTotalReportsCard(
                                  hospitalModel.length,
                                  "قائمة المشافي المسجلة",
                                  'لهذا المندوب',
                                ),
                              ),
                              ListView.builder(
                                padding: EdgeInsets.fromLTRB(
                                  horizontalPadding,
                                  listTopPadding,
                                  horizontalPadding,
                                  listBottomPadding,
                                ),
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: hospitalModel.length,
                                itemBuilder: (context, index) {
                                  return HospitalCardWidget(
                                    hospital: hospitalModel[index],
                                  );
                                },
                              )
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}