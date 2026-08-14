import 'package:domina_app/presentation/resources/color_manager.dart';
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
    double headerTitleFontSize;

    double countHorizontalPadding;
    double countVerticalPadding;
    double countFontSize;
    double countRadius;

    double listTopPadding;
    double listBottomPadding;

    switch (deviceType) {
      // =================================================
      // Mobile
      // =================================================
      case AppDeviceType.mobilePortrait:
        pageMaxWidth = 600;

        horizontalPadding = 16;
        topPadding = 16;

        searchBottomSpacing = 10;

        headerVerticalPadding = 12;
        headerTitleFontSize = 18;

        countHorizontalPadding = 12;
        countVerticalPadding = 5;
        countFontSize = 11;
        countRadius = 10;

        listTopPadding = 6;
        listBottomPadding = 24;
        break;

      // =================================================
      // Tablet Portrait
      // =================================================
      case AppDeviceType.tabletPortrait:
        pageMaxWidth = 760;

        horizontalPadding = 28;
        topPadding = 20;

        searchBottomSpacing = 14;

        headerVerticalPadding = 16;
        headerTitleFontSize = 21;

        countHorizontalPadding = 16;
        countVerticalPadding = 7;
        countFontSize = 13;
        countRadius = 12;

        listTopPadding = 8;
        listBottomPadding = 30;
        break;

      // =================================================
      // Tablet Landscape
      // =================================================
      case AppDeviceType.tabletLandscape:
        pageMaxWidth = 900;

        horizontalPadding = 32;
        topPadding = 16;

        searchBottomSpacing = 12;

        headerVerticalPadding = 14;
        headerTitleFontSize = 20;

        countHorizontalPadding = 16;
        countVerticalPadding = 6;
        countFontSize = 13;
        countRadius = 12;

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
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: pageMaxWidth,
          ),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
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

                    // =============================================
                    // نفس سلوك البحث
                    // =============================================
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
                    // =============================================
                    // نفس مصدر البيانات
                    // =============================================
                    List hospitalModel =
                        context.watch<SeniorProfBloc>().hospital;

                    if (state is SenAllHospitalsState) {
                      hospitalModel = state.hospital;
                    }

                    // =============================================
                    // Loading
                    // =============================================
                    if (state is SenAllHospitalLoadingState) {
                      return loadingFullScreen(
                        context,
                      );
                    }

                    // =============================================
                    // Empty
                    // =============================================
                    if (state is SenAllHospitalEmptyState) {
                      return emptyFullScreen(
                        context,
                      );
                    }

                    // =============================================
                    // Error
                    // =============================================
                    if (state is SenAllHospitalErrorState) {
                      return errorFullScreen(
                        context,
                      );
                    }

                    // =============================================
                    // List
                    // =============================================
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
                            hospitalModel
                                .length,
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
  }
}
