import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/resources/responsive/app_responsive.dart';
import 'package:domina_app/presentation/senior/representative/bloc/senior_prof_bloc.dart';
import 'package:domina_app/presentation/uniti/num_list.dart';
import 'package:domina_app/presentation/uniti/search_field.dart';
import 'package:domina_app/presentation/uniti/stateWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DoctorSenior extends StatelessWidget {
  DoctorSenior({
    super.key,
  });

  final TextEditingController searchDocController =
  TextEditingController();

  @override
  Widget build(BuildContext context) {
    final deviceType =
    AppResponsive.deviceType(context);

    double pageMaxWidth;

    double horizontalPadding;
    double searchTopPadding;
    double searchBottomPadding;

    double listTopPadding;
    double listBottomPadding;
    double headerVerticalPadding;
    switch (deviceType) {
    // =================================================
    // Mobile
    // =================================================
      case AppDeviceType.mobilePortrait:
        pageMaxWidth = 600;

        horizontalPadding = 16;
        searchTopPadding = 14;
        searchBottomPadding = 10;
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
        searchTopPadding = 20;
        searchBottomPadding = 14;

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
        searchTopPadding = 16;
        searchBottomPadding = 12;
        headerVerticalPadding = 14;
        listTopPadding = 6;
        listBottomPadding = 28;
        break;
    }

    return Scaffold(
      backgroundColor: const Color(
        0xFFF8FAFC,
      ),

      appBar: AppBar(
        title: const Text(
          'الأطباء',
        ),
      ),

      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: pageMaxWidth,
          ),

          child:  SingleChildScrollView(
    physics: const BouncingScrollPhysics(),
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
                    searchController:
                    searchDocController,

                    // =============================================
                    // نفس سلوك البحث
                    // =============================================
                    onPressed: (value) {
                      BlocProvider.of<
                          SeniorProfBloc>(
                        context,
                      ).add(
                        SenSearchDoctorEvent(
                          value,
                        ),
                      );
                    },
                  ),
                ),

                // =================================================
                // Doctors List
                // =================================================
                BlocBuilder<
                    SeniorProfBloc,
                    SeniorProfState>(

                  // نفس buildWhen
                  buildWhen: (
                      previous,
                      current,
                      ) =>
                  current
                  is SenAllDoctorsState ||
                      current
                      is SenAllDoctorEmptyState ||
                      current
                      is SenAllDoctorLoadingState ||
                      current
                      is SenAllDoctorErrorState,

                  builder: (context, state) {
                    // ===========================================
                    // نفس منطق تحديد القائمة
                    // ===========================================
                    List<DoctorModel>
                    doctorsList = [];

                    if (state
                    is SenAllDoctorsState) {
                      doctorsList =
                          state.doctor;
                    } else {
                      doctorsList = context
                          .read<
                          SeniorProfBloc>()
                          .doctor;
                    }

                    // ===========================================
                    // Loading
                    // ===========================================
                    if (state
                    is SenAllDoctorLoadingState) {
                      return loadingFullScreen(
                        context,
                      );
                    }

                    // ===========================================
                    // Empty
                    // ===========================================
                    if (state
                    is SenAllDoctorEmptyState ||
                        doctorsList.isEmpty) {
                      return emptyFullScreen(
                        context,
                      );
                    }

                    // ===========================================
                    // Error
                    // ===========================================
                    if (state
                    is SenAllDoctorErrorState) {
                      return errorFullScreen(
                        context,
                      );
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
                            doctorsList
                                .length,
                            "قائمة الأطباء المسجلة",
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
                          itemCount:
                          doctorsList.length,

                          itemBuilder:
                              (context, index) {
                            return AdminRepDoctorCard(
                              doctor:
                              doctorsList[index],
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
  }
}

// =====================================================
// Doctor Card
// =====================================================

class AdminRepDoctorCard extends StatelessWidget {
  final DoctorModel doctor;

  const AdminRepDoctorCard({
    super.key,
    required this.doctor,
  });

  @override
  Widget build(BuildContext context) {
    final deviceType =
    AppResponsive.deviceType(context);

    double cardBottomSpacing;
    double cardHorizontalMargin;

    double cardRadius;
    double cardPadding;

    double titleFontSize;
    double specializationFontSize;

    double headerSpacing;
    double sectionSpacing;

    double infoBoxSpacing;

    double infoBoxPadding;
    double infoBoxRadius;
    double infoLabelFontSize;
    double infoValueFontSize;

    double detailIconSize;
    double detailFontSize;
    double detailSpacing;

    double notePadding;
    double noteRadius;
    double noteTitleFontSize;
    double noteTextFontSize;

    double badgeHorizontalPadding;
    double badgeVerticalPadding;
    double badgeRadius;
    double badgeFontSize;

    switch (deviceType) {
    // =================================================
    // Mobile
    // =================================================
      case AppDeviceType.mobilePortrait:
        cardBottomSpacing = 12;
        cardHorizontalMargin = 0;

        cardRadius = 18;
        cardPadding = 16;

        titleFontSize = 17;
        specializationFontSize = 13;

        headerSpacing = 12;
        sectionSpacing = 12;

        infoBoxSpacing = 8;

        infoBoxPadding = 10;
        infoBoxRadius = 12;
        infoLabelFontSize = 10;
        infoValueFontSize = 12;

        detailIconSize = 16;
        detailFontSize = 12;
        detailSpacing = 6;

        notePadding = 12;
        noteRadius = 14;
        noteTitleFontSize = 12;
        noteTextFontSize = 12;

        badgeHorizontalPadding = 8;
        badgeVerticalPadding = 4;
        badgeRadius = 8;
        badgeFontSize = 12;
        break;

    // =================================================
    // Tablet Portrait
    // =================================================
      case AppDeviceType.tabletPortrait:
        cardBottomSpacing = 14;
        cardHorizontalMargin = 0;

        cardRadius = 20;
        cardPadding = 20;

        titleFontSize = 20;
        specializationFontSize = 15;

        headerSpacing = 14;
        sectionSpacing = 16;

        infoBoxSpacing = 12;

        infoBoxPadding = 14;
        infoBoxRadius = 14;
        infoLabelFontSize = 12;
        infoValueFontSize = 14;

        detailIconSize = 18;
        detailFontSize = 14;
        detailSpacing = 8;

        notePadding = 14;
        noteRadius = 16;
        noteTitleFontSize = 13;
        noteTextFontSize = 13;

        badgeHorizontalPadding = 10;
        badgeVerticalPadding = 5;
        badgeRadius = 10;
        badgeFontSize = 13;
        break;

    // =================================================
    // Tablet Landscape
    // =================================================
      case AppDeviceType.tabletLandscape:
        cardBottomSpacing = 12;
        cardHorizontalMargin = 0;

        cardRadius = 18;
        cardPadding = 18;

        titleFontSize = 18;
        specializationFontSize = 13;

        headerSpacing = 12;
        sectionSpacing = 14;

        infoBoxSpacing = 10;

        infoBoxPadding = 11;
        infoBoxRadius = 12;
        infoLabelFontSize = 11;
        infoValueFontSize = 13;

        detailIconSize = 16;
        detailFontSize = 12.5;
        detailSpacing = 7;

        notePadding = 13;
        noteRadius = 14;
        noteTitleFontSize = 12;
        noteTextFontSize = 12.5;

        badgeHorizontalPadding = 9;
        badgeVerticalPadding = 4;
        badgeRadius = 9;
        badgeFontSize = 12;
        break;
    }

    return Container(
      margin: EdgeInsets.only(
        left: cardHorizontalMargin,
        right: cardHorizontalMargin,
        bottom: cardBottomSpacing,
      ),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius:
        BorderRadius.circular(
          cardRadius,
        ),

        border: Border.all(
          color: Colors.black.withOpacity(
            0.03,
          ),
        ),

        boxShadow: [
          BoxShadow(
            color:
            Colors.black.withOpacity(
              0.03,
            ),
            blurRadius: 12,
            offset: const Offset(
              0,
              5,
            ),
          ),
        ],
      ),

      child: ClipRRect(
        borderRadius:
        BorderRadius.circular(
          cardRadius,
        ),

        child: Padding(
          padding: EdgeInsets.all(
            cardPadding,
          ),

          child: Column(
            crossAxisAlignment:
            CrossAxisAlignment.start,
            children: [
              // =================================================
              // Header
              // =================================================
              Row(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  // =============================================
                  // Doctor icon
                  // =============================================
                  Container(
                    width: deviceType ==
                        AppDeviceType
                            .mobilePortrait
                        ? 46
                        : deviceType ==
                        AppDeviceType
                            .tabletPortrait
                        ? 54
                        : 50,

                    height: deviceType ==
                        AppDeviceType
                            .mobilePortrait
                        ? 46
                        : deviceType ==
                        AppDeviceType
                            .tabletPortrait
                        ? 54
                        : 50,

                    alignment: Alignment.center,

                    decoration: BoxDecoration(
                      color: const Color(
                        0xFFE3F2FD,
                      ),

                      borderRadius:
                      BorderRadius.circular(
                        deviceType ==
                            AppDeviceType
                                .tabletPortrait
                            ? 15
                            : 13,
                      ),
                    ),

                    child: Icon(
                      Icons.person_outline_rounded,
                      color: const Color(
                        0xFF1976D2,
                      ),
                      size: deviceType ==
                          AppDeviceType
                              .mobilePortrait
                          ? 24
                          : deviceType ==
                          AppDeviceType
                              .tabletPortrait
                          ? 28
                          : 25,
                    ),
                  ),

                  SizedBox(
                    width: headerSpacing,
                  ),

                  // =============================================
                  // Doctor data
                  // =============================================
                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: [
                        Text(
                          doctor.title,
                          maxLines: 2,
                          overflow:
                          TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize:
                            titleFontSize,
                            fontWeight:
                            FontWeight.w700,
                            color: const Color(
                              0xFF0D47A1,
                            ),
                            height: 1.25,
                          ),
                        ),

                        const SizedBox(
                          height: 3,
                        ),

                        Text(
                          doctor.spTitle,
                          maxLines: 1,
                          overflow:
                          TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize:
                            specializationFontSize,
                            color: Colors
                                .grey.shade600,
                            fontWeight:
                            FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(
                    width: 10,
                  ),

                  // =============================================
                  // Rating
                  // =============================================
                  _buildRatingBadge(
                    doctor.rate,
                    horizontalPadding:
                    badgeHorizontalPadding,
                    verticalPadding:
                    badgeVerticalPadding,
                    radius: badgeRadius,
                    fontSize:
                    badgeFontSize,
                  ),
                ],
              ),

              SizedBox(
                height: sectionSpacing,
              ),

              // =================================================
              // Place + Visits
              // =================================================
              Row(
                children: [
                  _buildInfoBox(
                    "المكان",
                    doctor.placeTitle,
                    Icons
                        .location_on_outlined,
                    padding:
                    infoBoxPadding,
                    radius:
                    infoBoxRadius,
                    labelFontSize:
                    infoLabelFontSize,
                    valueFontSize:
                    infoValueFontSize,
                  ),

                  SizedBox(
                    width: infoBoxSpacing,
                  ),

                  _buildInfoBox(
                    "الزيارات",
                    "${doctor.visits} زيارة",
                    Icons
                        .calendar_month_outlined,
                    padding:
                    infoBoxPadding,
                    radius:
                    infoBoxRadius,
                    labelFontSize:
                    infoLabelFontSize,
                    valueFontSize:
                    infoValueFontSize,
                  ),
                ],
              ),

              SizedBox(
                height: sectionSpacing,
              ),

              // =================================================
              // Address
              // =================================================
              _buildDetailRow(
                Icons.map_outlined,
                doctor.address,
                iconSize:
                detailIconSize,
                fontSize:
                detailFontSize,
                spacing:
                detailSpacing,
              ),

              // =================================================
              // Work Hours
              // نفس الشرط الأصلي
              // =================================================
              if (doctor.workHours != null &&
                  doctor
                      .workHours!.isNotEmpty)
                _buildDetailRow(
                  Icons.access_time,
                  doctor.workHours!,
                  iconSize:
                  detailIconSize,
                  fontSize:
                  detailFontSize,
                  spacing:
                  detailSpacing,
                ),

              // =================================================
              // Notes
              // نفس الشرط الأصلي
              // =================================================
              if (doctor.note != null &&
                  doctor.note!.isNotEmpty) ...[
                SizedBox(
                  height: sectionSpacing,
                ),

                Container(
                  width: double.infinity,

                  padding: EdgeInsets.all(
                    notePadding,
                  ),

                  decoration:
                  BoxDecoration(
                    color: const Color(
                      0xFFE3F2FD,
                    ),

                    borderRadius:
                    BorderRadius.circular(
                      noteRadius,
                    ),

                    border: Border.all(
                      color: const Color(
                        0xFFBBDEFB,
                      ),
                    ),
                  ),

                  child: Row(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons
                            .info_outline_rounded,
                        color: Color(
                          0xFF1976D2,
                        ),
                        size: 19,
                      ),

                      const SizedBox(
                        width: 8,
                      ),

                      Expanded(
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment
                              .start,
                          children: [
                            Text(
                              "ملاحظات المدير",
                              style:
                              TextStyle(
                                fontSize:
                                noteTitleFontSize,
                                fontWeight:
                                FontWeight.bold,
                                color:
                                const Color(
                                  0xFF1976D2,
                                ),
                              ),
                            ),

                            const SizedBox(
                              height: 3,
                            ),

                            Text(
                              doctor.note!,
                              style:
                              TextStyle(
                                fontSize:
                                noteTextFontSize,
                                color: Colors
                                    .blueGrey
                                    .shade800,
                                height: 1.35,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  // =====================================================
  // Rating Badge
  // =====================================================

  Widget _buildRatingBadge(
      String? rate, {
        required double horizontalPadding,
        required double verticalPadding,
        required double radius,
        required double fontSize,
      }) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPadding,
        vertical: verticalPadding,
      ),

      decoration: BoxDecoration(
        color: const Color(
          0xFFFFECB3,
        ),

        borderRadius:
        BorderRadius.circular(
          radius,
        ),
      ),

      child: Text(
        rate ?? "A",

        style: TextStyle(
          fontSize: fontSize,
          color: const Color(
            0xFFFFA000,
          ),
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  // =====================================================
  // Info Box
  // =====================================================

  Widget _buildInfoBox(
      String label,
      String value,
      IconData icon, {
        required double padding,
        required double radius,
        required double labelFontSize,
        required double valueFontSize,
      }) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(
          padding,
        ),

        decoration: BoxDecoration(
          color: const Color(
            0xFFF5F7FA,
          ),

          borderRadius:
          BorderRadius.circular(
            radius,
          ),

          border: Border.all(
            color: Colors.black
                .withOpacity(0.025),
          ),
        ),

        child: Row(
          crossAxisAlignment:
          CrossAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: valueFontSize + 4,
              color: const Color(
                0xFF90CAF9,
              ),
            ),

            const SizedBox(
              width: 7,
            ),

            Expanded(
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: TextStyle(
                      fontSize:
                      labelFontSize,
                      color: Colors
                          .grey.shade500,
                      fontWeight:
                      FontWeight.w500,
                    ),
                  ),

                  const SizedBox(
                    height: 2,
                  ),

                  Text(
                    value,
                    maxLines: 1,
                    overflow:
                    TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize:
                      valueFontSize,
                      fontWeight:
                      FontWeight.w600,
                      color: const Color(
                        0xFF263238,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // =====================================================
  // Detail Row
  // =====================================================

  Widget _buildDetailRow(
      IconData icon,
      String text, {
        required double iconSize,
        required double fontSize,
        required double spacing,
      }) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 6,
      ),

      child: Row(
        crossAxisAlignment:
        CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            size: iconSize,
            color: const Color(
              0xFF90CAF9,
            ),
          ),

          SizedBox(
            width: spacing,
          ),

          Expanded(
            child: Text(
              text.isEmpty
                  ? "غير محدد"
                  : text,
              style: TextStyle(
                fontSize: fontSize,
                color:
                Colors.grey.shade700,
                height: 1.35,
              ),
            ),
          ),
        ],
      ),
    );
  }
}