import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/resources/responsive/app_responsive.dart';
import 'package:domina_app/presentation/senior/representative/bloc/senior_prof_bloc.dart';
import 'package:domina_app/presentation/senior/representative/widget/hos_card.dart';
import 'package:domina_app/presentation/uniti/num_list.dart';
import 'package:domina_app/presentation/uniti/search_field.dart';
import 'package:domina_app/presentation/uniti/stateWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HospitalSenior extends StatefulWidget {
  const HospitalSenior({super.key});

  @override
  State<HospitalSenior> createState() => _HospitalSeniorState();
}

class _HospitalSeniorState extends State<HospitalSenior> {

  final TextEditingController searchHosController = TextEditingController();

  @override
  void dispose() {
    searchHosController.dispose();
    super.dispose();
  }

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
                          List<HospitalSpModel> hospitalModel =
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

                          final Map<int, List<HospitalSpModel>>
                              groupedByHospitalId = {};
                          for (final hospital in hospitalModel) {
                            groupedByHospitalId
                                .putIfAbsent(hospital.hospitalId, () => [])
                                .add(hospital);
                          }
                          final List<List<HospitalSpModel>> hospitalGroups =
                              groupedByHospitalId.values.toList();

                          return Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: horizontalPadding,
                                  vertical: headerVerticalPadding,
                                ),
                                child: buildTotalReportsCard(
                                  hospitalGroups.length,
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
                                itemCount: hospitalGroups.length,
                                itemBuilder: (context, index) {
                                  return HospitalCardWidget(
                                    hospitalGroup: hospitalGroups[index],
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