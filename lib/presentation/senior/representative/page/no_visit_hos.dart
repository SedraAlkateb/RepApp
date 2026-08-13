import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/resources/responsive/app_responsive.dart';
import 'package:domina_app/presentation/senior/representative/bloc/senior_prof_bloc.dart';
import 'package:domina_app/presentation/uniti/num_list.dart';
import 'package:domina_app/presentation/uniti/search_field.dart';
import 'package:domina_app/presentation/uniti/stateWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NoVisitHos extends StatelessWidget {
  NoVisitHos({
    super.key,
  });

  final TextEditingController searchNoteDoctorController =
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

   // double countFontSize;
    double countBottomSpacing;

    switch (deviceType) {
    // =================================================
    // Mobile
    // =================================================
      case AppDeviceType.mobilePortrait:
        pageMaxWidth = 600;

        horizontalPadding = 16;

        searchTopPadding = 14;
        searchBottomPadding = 8;

        listTopPadding = 4;
        listBottomPadding = 24;

        //countFontSize = 13;
        countBottomSpacing = 10;
        break;

    // =================================================
    // Tablet Portrait
    // =================================================
      case AppDeviceType.tabletPortrait:
        pageMaxWidth = 760;

        horizontalPadding = 28;

        searchTopPadding = 18;
        searchBottomPadding = 10;

        listTopPadding = 6;
        listBottomPadding = 30;

      //  countFontSize = 15;
        countBottomSpacing = 12;
        break;

    // =================================================
    // Tablet Landscape
    // =================================================
      case AppDeviceType.tabletLandscape:
        pageMaxWidth = 900;

        horizontalPadding = 32;

        searchTopPadding = 14;
        searchBottomPadding = 8;

        listTopPadding = 4;
        listBottomPadding = 28;

      //  countFontSize = 14;
        countBottomSpacing = 10;
        break;
    }

    return ColoredBox(
      color: const Color(
        0xFFF8FAFC,
      ),
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
                  searchController:
                  searchNoteDoctorController,

                  // =============================================
                  // نفس السلوك الموجود عندك
                  // =============================================
                  onPressed: (value) {
                    BlocProvider.of<
                        SeniorProfBloc>(
                      context,
                    ).add(
                      SenSearchNoVisitDoctorEvent(
                        value,
                      ),
                    );
                  },
                ),
              ),

              // =================================================
              // List
              // =================================================
              Expanded(
                child: BlocBuilder<
                    SeniorProfBloc,
                    SeniorProfState>(
                  builder: (context, state) {
                    // ===========================================
                    // نفس مصدر البيانات
                    // ===========================================
                     List<NoVisitDocModel>
                    noVisitDoc =
                        context
                            .watch<
                            SeniorProfBloc>()
                            .noVisitDoc;

                    // ===========================================
                    // Loading
                    // ===========================================
                    if (state
                    is SenNoVisitDocLoadingState) {
                      return loadingFullScreen(
                        context,
                      );
                    }
                    if (state
                    is SenNoVisitDocsState) {
                      noVisitDoc=state.noVisitDoc;
                    }
                    // ===========================================
                    // Empty
                    // ===========================================
                    if (state
                    is SenNoVisitDocEmptyState ||
                        noVisitDoc.isEmpty) {
                      return emptyFullScreen(
                        context,
                      );
                    }

                    // ===========================================
                    // Error
                    // نفس السلوك الأصلي
                    // ===========================================
                    if (state
                    is SenNoVisitDocErrorState) {
                      return errorFullScreen(
                        context,
                        func: () {
                          BlocProvider.of<
                              SeniorProfBloc>(
                            context,
                          ).add(
                            NoVisitDocEvent(
                              156,
                              state.planId,
                            ),
                          );
                        },
                      );
                    }

                    // ===========================================
                    // Data
                    // ===========================================
                    return ListView.builder(
                      keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior
                          .onDrag,

                      padding:
                      EdgeInsets.fromLTRB(
                        horizontalPadding,
                        listTopPadding,
                        horizontalPadding,
                        listBottomPadding,
                      ),

                      itemCount:
                      noVisitDoc.length + 1,

                      itemBuilder:
                          (context, index) {
                        // =======================================
                        // Count
                        // =======================================
                        if (index == 0) {
                          return Padding(
                            padding:
                            EdgeInsets.only(
                              bottom:
                              countBottomSpacing,
                            ),
                            child:buildTotalReportsCard(noVisitDoc
                                .length, "عدد المشافي", "المشافي الذين لم تتم زيارتهم"),
                          );
                        }

                        return NoVisitHospitalCard(
                          data:
                          noVisitDoc[
                          index - 1],
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// =======================================================
// No Visit Hospital Card
// =======================================================

class NoVisitHospitalCard extends StatelessWidget {
  final NoVisitDocModel data;

  const NoVisitHospitalCard({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    final deviceType =
    AppResponsive.deviceType(context);

    final String totalRequired =
        data.visits ?? '0';

    double cardBottomSpacing;

    double cardRadius;
    double cardPadding;

    double sideBarWidth;

    double iconBoxSize;
    double iconSize;
    double iconRadius;
    double iconSpacing;

    double titleFontSize;
    double subtitleFontSize;

    double rateHorizontalPadding;
    double rateVerticalPadding;
    double rateRadius;
    double rateFontSize;

    double requiredLabelFontSize;
    double requiredNumberFontSize;

    double sectionSpacing;

    double addressIconSize;
    double addressFontSize;
    double addressSpacing;

    double progressHeight;

    switch (deviceType) {
    // =================================================
    // Mobile
    // =================================================
      case AppDeviceType.mobilePortrait:
        cardBottomSpacing = 12;

        cardRadius = 18;
        cardPadding = 15;

        sideBarWidth = 4;

        iconBoxSize = 44;
        iconSize = 22;
        iconRadius = 12;
        iconSpacing = 12;

        titleFontSize = 16;
        subtitleFontSize = 12;

        rateHorizontalPadding = 7;
        rateVerticalPadding = 3;
        rateRadius = 7;
        rateFontSize = 10;

        requiredLabelFontSize = 10;
        requiredNumberFontSize = 22;

        sectionSpacing = 12;

        addressIconSize = 15;
        addressFontSize = 11.5;
        addressSpacing = 6;

        progressHeight = 7;
        break;

    // =================================================
    // Tablet Portrait
    // =================================================
      case AppDeviceType.tabletPortrait:
        cardBottomSpacing = 14;

        cardRadius = 20;
        cardPadding = 20;

        sideBarWidth = 5;

        iconBoxSize = 52;
        iconSize = 26;
        iconRadius = 14;
        iconSpacing = 16;

        titleFontSize = 19;
        subtitleFontSize = 14;

        rateHorizontalPadding = 9;
        rateVerticalPadding = 4;
        rateRadius = 8;
        rateFontSize = 12;

        requiredLabelFontSize = 12;
        requiredNumberFontSize = 27;

        sectionSpacing = 16;

        addressIconSize = 18;
        addressFontSize = 13;
        addressSpacing = 8;

        progressHeight = 8;
        break;

    // =================================================
    // Tablet Landscape
    // =================================================
      case AppDeviceType.tabletLandscape:
        cardBottomSpacing = 12;

        cardRadius = 18;
        cardPadding = 17;

        sideBarWidth = 5;

        iconBoxSize = 48;
        iconSize = 24;
        iconRadius = 13;
        iconSpacing = 14;

        titleFontSize = 18;
        subtitleFontSize = 13;

        rateHorizontalPadding = 8;
        rateVerticalPadding = 3;
        rateRadius = 8;
        rateFontSize = 11;

        requiredLabelFontSize = 11;
        requiredNumberFontSize = 24;

        sectionSpacing = 13;

        addressIconSize = 16;
        addressFontSize = 12;
        addressSpacing = 7;

        progressHeight = 7;
        break;
    }

    return Directionality(
      textDirection: TextDirection.rtl,

      child: Container(
        margin: EdgeInsets.only(
          bottom: cardBottomSpacing,
        ),

        decoration: BoxDecoration(
          color: Colors.white,

          borderRadius:
          BorderRadius.circular(
            cardRadius,
          ),

          border: Border.all(
            color: const Color(
              0xFFE2E8F0,
            ),
          ),

          boxShadow: [
            BoxShadow(
              color:
              Colors.black.withOpacity(
                0.025,
              ),

              blurRadius: 12,

              offset: const Offset(
                0,
                4,
              ),
            ),
          ],
        ),

        child: ClipRRect(
          borderRadius:
          BorderRadius.circular(
            cardRadius - 1,
          ),

          // =================================================
          // Stack
          // بدون IntrinsicHeight
          // وبدون Row stretch
          // =================================================
          child: Stack(
            children: [
              // ===============================================
              // Content
              // ===============================================
              Padding(
                padding: EdgeInsets.fromLTRB(
                  cardPadding,
                  cardPadding,
                  cardPadding +
                      sideBarWidth,
                  cardPadding,
                ),

                child: Column(
                  mainAxisSize:
                  MainAxisSize.min,

                  crossAxisAlignment:
                  CrossAxisAlignment.stretch,

                  children: [
                    // =========================================
                    // Header
                    // =========================================
                    Row(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,

                      children: [
                        // =====================================
                        // Hospital Icon
                        // =====================================
                        Container(
                          width:
                          iconBoxSize,
                          height:
                          iconBoxSize,

                          alignment:
                          Alignment.center,

                          decoration:
                          BoxDecoration(
                            color:
                            const Color(
                              0xFFE0F2F1,
                            ),

                            borderRadius:
                            BorderRadius
                                .circular(
                              iconRadius,
                            ),
                          ),

                          child: Icon(
                            Icons
                                .local_hospital_outlined,

                            color:
                            const Color(
                              0xFF00897B,
                            ),

                            size: iconSize,
                          ),
                        ),

                        SizedBox(
                          width:
                          iconSpacing,
                        ),

                        // =====================================
                        // Hospital Data
                        // =====================================
                        Expanded(
                          child: Column(
                            mainAxisSize:
                            MainAxisSize.min,

                            crossAxisAlignment:
                            CrossAxisAlignment
                                .start,

                            children: [
                              Text(
                                data.docTitle,

                                maxLines: 2,

                                overflow:
                                TextOverflow
                                    .ellipsis,

                                style:
                                TextStyle(
                                  fontSize:
                                  titleFontSize,

                                  fontWeight:
                                  FontWeight
                                      .w700,

                                  color:
                                  const Color(
                                    0xFF1F4E79,
                                  ),

                                  height: 1.25,
                                ),
                              ),

                              const SizedBox(
                                height: 5,
                              ),

                              // =================================
                              // Type + Rate
                              // =================================
                              Wrap(
                                crossAxisAlignment:
                                WrapCrossAlignment
                                    .center,

                                spacing: 8,
                                runSpacing: 5,

                                children: [
                                  Text(
                                    data.spTitle,

                                    style:
                                    TextStyle(
                                      fontSize:
                                      subtitleFontSize,

                                      color: Colors
                                          .grey
                                          .shade600,

                                      fontWeight:
                                      FontWeight
                                          .w500,
                                    ),
                                  ),

                                  _buildRateBadge(
                                    data.rate,

                                    horizontalPadding:
                                    rateHorizontalPadding,

                                    verticalPadding:
                                    rateVerticalPadding,

                                    radius:
                                    rateRadius,

                                    fontSize:
                                    rateFontSize,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(
                          width: 10,
                        ),

                        // =====================================
                        // Required
                        // =====================================
                        _buildRequiredVisits(
                          total:
                          totalRequired,

                          labelFontSize:
                          requiredLabelFontSize,

                          numberFontSize:
                          requiredNumberFontSize,
                        ),
                      ],
                    ),

                    SizedBox(
                      height:
                      sectionSpacing,
                    ),

                    // =========================================
                    // Divider
                    // =========================================
                    Container(
                      height: 1,

                      color: const Color(
                        0xFFF1F5F9,
                      ),
                    ),

                    SizedBox(
                      height:
                      sectionSpacing,
                    ),

                    // =========================================
                    // Address
                    // =========================================
                    _buildAddressRow(
                      iconSize:
                      addressIconSize,

                      fontSize:
                      addressFontSize,

                      spacing:
                      addressSpacing,
                    ),

                    SizedBox(
                      height:
                      sectionSpacing,
                    ),

                    // =========================================
                    // Status
                    // =========================================
                    _buildEmptyProgress(
                      height:
                      progressHeight,
                    ),
                  ],
                ),
              ),

              // ===============================================
              // Status Side Bar
              // ===============================================
              Positioned(
                top: 0,
                bottom: 0,
                right: 0,

                child: Container(
                  width:
                  sideBarWidth,

                  color: const Color(
                    0xFF94A3B8,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // =====================================================
  // Required Visits
  // =====================================================

  Widget _buildRequiredVisits({
    required String total,
    required double labelFontSize,
    required double numberFontSize,
  }) {
    return Container(
      constraints: const BoxConstraints(
        minWidth: 58,
      ),

      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 7,
      ),

      decoration: BoxDecoration(
        color: const Color(
          0xFFF8FAFC,
        ),

        borderRadius:
        BorderRadius.circular(
          12,
        ),

        border: Border.all(
          color: const Color(
            0xFFE2E8F0,
          ),
        ),
      ),

      child: Column(
        mainAxisSize:
        MainAxisSize.min,

        children: [
          Text(
            "المطلوب",

            style: TextStyle(
              fontSize:
              labelFontSize,

              color: const Color(
                0xFF64748B,
              ),

              fontWeight:
              FontWeight.w500,
            ),
          ),

          const SizedBox(
            height: 2,
          ),

          Text(
            total,

            style: TextStyle(
              fontSize:
              numberFontSize,

              height: 1,

              color: const Color(
                0xFF475569,
              ),

              fontWeight:
              FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }

  // =====================================================
  // Empty Progress
  // =====================================================

  Widget _buildEmptyProgress({
    required double height,
  }) {
    return Column(
      crossAxisAlignment:
      CrossAxisAlignment.start,

      children: [
        Row(
          children: [
            Container(
              width: 7,
              height: 7,

              decoration:
              const BoxDecoration(
                color: Color(
                  0xFFF59E0B,
                ),

                shape: BoxShape.circle,
              ),
            ),

            const SizedBox(
              width: 7,
            ),

            const Expanded(
              child: Text(
                "لم يتم البدء بالزيارات بعد",

                style: TextStyle(
                  fontSize: 11,

                  color: Color(
                    0xFFD97706,
                  ),

                  fontWeight:
                  FontWeight.w600,
                ),
              ),
            ),

            Container(
              padding:
              const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 3,
              ),

              decoration: BoxDecoration(
                color: const Color(
                  0xFFFFF7ED,
                ),

                borderRadius:
                BorderRadius.circular(
                  7,
                ),
              ),

              child: const Text(
                "0%",

                style: TextStyle(
                  fontSize: 10,

                  color: Color(
                    0xFFD97706,
                  ),

                  fontWeight:
                  FontWeight.w700,
                ),
              ),
            ),
          ],
        ),

        const SizedBox(
          height: 7,
        ),

        ClipRRect(
          borderRadius:
          BorderRadius.circular(
            10,
          ),

          child:
          LinearProgressIndicator(
            value: 0,

            minHeight: height,

            backgroundColor:
            const Color(
              0xFFF1F5F9,
            ),

            valueColor:
            const AlwaysStoppedAnimation<
                Color>(
              Color(
                0xFFF59E0B,
              ),
            ),
          ),
        ),
      ],
    );
  }

  // =====================================================
  // Rate Badge
  // =====================================================

  Widget _buildRateBadge(
      String rate, {
        required double horizontalPadding,
        required double verticalPadding,
        required double radius,
        required double fontSize,
      }) {
    return Container(
      padding:
      EdgeInsets.symmetric(
        horizontal:
        horizontalPadding,

        vertical:
        verticalPadding,
      ),

      decoration:
      BoxDecoration(
        color: const Color(
          0xFFE8F5E9,
        ),

        borderRadius:
        BorderRadius.circular(
          radius,
        ),
      ),

      child: Text(
        rate,

        maxLines: 1,

        style: TextStyle(
          fontSize:
          fontSize,

          color: const Color(
            0xFF2E7D32,
          ),

          fontWeight:
          FontWeight.w700,
        ),
      ),
    );
  }

  // =====================================================
  // Address
  // =====================================================

  Widget _buildAddressRow({
    required double iconSize,
    required double fontSize,
    required double spacing,
  }) {
    return Row(
      crossAxisAlignment:
      CrossAxisAlignment.start,

      children: [
        Container(
          width:
          iconSize + 12,

          height:
          iconSize + 12,

          alignment:
          Alignment.center,

          decoration:
          BoxDecoration(
            color: const Color(
              0xFFEFF6FF,
            ),

            borderRadius:
            BorderRadius.circular(
              8,
            ),
          ),

          child: Icon(
            Icons
                .location_on_outlined,

            size: iconSize,

            color: const Color(
              0xFF64B5F6,
            ),
          ),
        ),

        SizedBox(
          width: spacing,
        ),

        Expanded(
          child: Text(
            data.address.isEmpty
                ? "العنوان غير محدد"
                : data.address,

            maxLines: 2,

            overflow:
            TextOverflow.ellipsis,

            style: TextStyle(
              fontSize:
              fontSize,

              color:
              Colors.grey.shade700,

              height: 1.4,

              fontWeight:
              FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}