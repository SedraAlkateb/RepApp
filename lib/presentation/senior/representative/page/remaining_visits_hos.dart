import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/resources/responsive/app_responsive.dart';
import 'package:domina_app/presentation/senior/representative/bloc/senior_prof_bloc.dart';
import 'package:domina_app/presentation/senior/representative/widget/remainig_visit_card.dart';
import 'package:domina_app/presentation/uniti/num_list.dart';
import 'package:domina_app/presentation/uniti/search_field.dart';
import 'package:domina_app/presentation/uniti/stateWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RemainingVisitsHos extends StatefulWidget {
  const RemainingVisitsHos({super.key});

  @override
  State<RemainingVisitsHos> createState() => _RemainingVisitsHosState();
}

class _RemainingVisitsHosState extends State<RemainingVisitsHos> {
  final TextEditingController searchNoteDoctorController =
      TextEditingController();

  @override
  void dispose() {
    searchNoteDoctorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final deviceType = AppResponsive.deviceType(context);

    double pageMaxWidth;
    double headerVerticalPadding;
    double horizontalPadding;
    double searchTopPadding;
    double searchBottomPadding;

    double listTopPadding;
    double listBottomPadding;

    switch (deviceType) {
      // =================================================
      // Mobile
      // =================================================
      case AppDeviceType.mobilePortrait:
        pageMaxWidth = 600;

        horizontalPadding = 16;

        searchTopPadding = 14;
        searchBottomPadding = 8;
        headerVerticalPadding = 12;
        listTopPadding = 6;
        listBottomPadding = 24;
        break;

      // =================================================
      // Tablet Portrait
      // =================================================
      case AppDeviceType.tabletPortrait:
        pageMaxWidth = 760;

        horizontalPadding = 28;

        searchTopPadding = 18;
        searchBottomPadding = 10;
        headerVerticalPadding = 16;
        listTopPadding = 8;
        listBottomPadding = 30;
        break;

      // =================================================
      // Tablet Landscape
      // =================================================
      case AppDeviceType.tabletLandscape:
        pageMaxWidth = 900;

        horizontalPadding = 32;

        searchTopPadding = 14;
        searchBottomPadding = 8;
        headerVerticalPadding = 14;
        listTopPadding = 6;
        listBottomPadding = 28;
        break;
    }

    // ملاحظة: SingleChildScrollView على كامل العرض هون (بدون ConstrainedBox
    // خارجي) حتى يبقى السكرول بالماوس يعمل فوق الفراغ الجانبي بالعرض، وقيد
    // pageMaxWidth يُطبَّق داخلياً على المحتوى فقط.
    return ColoredBox(
      color: const Color(
        0xFFF8FAFC,
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: pageMaxWidth,
                  ),
                  child: Column(
                    children: [
                      // =================================================
                      // Search
                      // =================================================
                      Padding(
                        padding: EdgeInsets.fromLTRB(
                          horizontalPadding,
                          searchTopPadding,
                          horizontalPadding,
                          searchBottomPadding,
                        ),
                        child: SearchField(
                          searchController: searchNoteDoctorController,

                          // =============================================
                          // نفس السلوك الأصلي
                          // =============================================
                          onPressed: (value) {
                            BlocProvider.of<SeniorProfBloc>(
                              context,
                            ).add(
                              SenSearchRemainingVisitsDoctorEvent(
                                value,
                              ),
                            );
                          },
                        ),
                      ),

                      // =================================================
                      // List
                      // =================================================
                      BlocBuilder<SeniorProfBloc, SeniorProfState>(
                        builder: (context, state) {
                          // ===========================================
                          // نفس fallback الموجود عندك
                          // ===========================================
                          List<NoVisitDocModel> noVisitDoc =
                              context.watch<SeniorProfBloc>().remainingVisits;

                          // ===========================================
                          // Loading
                          // ===========================================
                          if (state is SenNoVisitDocLoadingState) {
                            return loadingFullScreen(
                              context,
                            );
                          }

                          // ===========================================
                          // Empty
                          // ===========================================
                          if (state is SenNoVisitDocEmptyState ||
                              noVisitDoc.isEmpty) {
                            return emptyFullScreen(
                              context,
                            );
                          }

                          // ===========================================
                          // Error
                          // نفس السلوك الأصلي
                          // ===========================================
                          if (state is SenNoVisitDocErrorState) {
                            return errorFullScreen(
                              context,
                            );
                          }
                          if (state is SenNoVisitDocsState) {
                            noVisitDoc = state.noVisitDoc;
                          }
                          // ===========================================
                          // Data
                          // ===========================================
                          return Column(
                            children: [
                              // =================================================
                              // Header + Count
                              // =================================================
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: horizontalPadding,
                                  vertical: headerVerticalPadding,
                                ),
                                child: buildTotalReportsCard(
                                  noVisitDoc.length,
                                  "عدد الأطباء",
                                  'قائمة المشافي الذين تمت زيارتهم ولم تكتمل',
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
                                itemCount: noVisitDoc.length,
                                itemBuilder: (context, index) {
                                  return RemainingVisitCard(
                                    data: noVisitDoc[index],
                                  );
                                },
                              ),
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
