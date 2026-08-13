import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/resources/responsive/app_responsive.dart';
import 'package:domina_app/presentation/senior/representative/bloc/senior_prof_bloc.dart';
import 'package:domina_app/presentation/uniti/num_list.dart';
import 'package:domina_app/presentation/uniti/search_field.dart';
import 'package:domina_app/presentation/uniti/stateWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SenVisitHospital extends StatelessWidget {
  SenVisitHospital({
    super.key,
  });

  final TextEditingController searchteDoctorController =
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

    switch (deviceType) {
    // =================================================
    // Mobile
    // =================================================
      case AppDeviceType.mobilePortrait:
        pageMaxWidth = 600;

        horizontalPadding = 16;

        searchTopPadding = 14;
        searchBottomPadding = 8;

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

        listTopPadding = 6;
        listBottomPadding = 28;
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
                  searchteDoctorController,

                  // نفس السلوك الموجود عندك
                  onPressed: (value) {
                    BlocProvider.of<
                        SeniorProfBloc>(
                      context,
                    ).add(
                      SenSearchVisitDoctorEvent(
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
                     List<NoVisitDocModel>
                    visitDoc =
                        context
                            .watch<
                            SeniorProfBloc>()
                            .visitDoc;

                    // ===========================================
                    // Loading
                    // ===========================================
                    if (state
                    is SenVisitDocLoadingState) {
                      return loadingFullScreen(
                        context,
                      );
                    }
                    if (state
                    is SenVisitDocsState) {
                      visitDoc=state.visitDoc;
                    }
                    // ===========================================
                    // Empty
                    // ===========================================
                    if (state
                    is SenVisitDocEmptyState ||
                        visitDoc.isEmpty) {
                      return emptyFullScreen(
                        context,
                      );
                    }

                    // ===========================================
                    // Error
                    // نفس السلوك الأصلي
                    // ===========================================
                    if (state
                    is SenVisitDocErrorState) {
                      return errorFullScreen(
                        context,
                        func: () {
                          BlocProvider.of<
                              SeniorProfBloc>(
                            context,
                          ).add(
                            VisitDocEvent(
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

                      physics:
                      const BouncingScrollPhysics(),

                      padding:
                      EdgeInsets.fromLTRB(
                        horizontalPadding,
                        listTopPadding,
                        horizontalPadding,
                        listBottomPadding,
                      ),

                      itemCount:
                      visitDoc.length + 1,

                      itemBuilder:
                          (context, index) {
                        if (index == 0) {
                          return Padding(
                            padding:
                            const EdgeInsets.only(
                              bottom: 12,
                            ),
                            child:
                            buildTotalReportsCard(
                              visitDoc.length,
                              'إجمالي الزيارات الناجحة',
                              'لهذا الشهر',
                            ),
                          );
                        }

                        return VisitedHospitalCard(
                          data:
                          visitDoc[index - 1],
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
// Visited Hospital Card
// =======================================================

class VisitedHospitalCard extends StatelessWidget {
  final NoVisitDocModel data;

  const VisitedHospitalCard({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    final deviceType =
    AppResponsive.deviceType(context);

    // =====================================================
    // نفس الحسابات الأصلية
    // =====================================================
    final int total =
        int.tryParse(
          data.visits ?? '0',
        ) ??
            0;

    final int remaining =
        data.remainingVisits ?? 0;

    final int done =
    (total - remaining)
        .clamp(0, total);

    // =====================================================
    // Responsive Values
    // =====================================================
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

    double visitLabelFontSize;
    double visitNumberFontSize;
    double visitTotalFontSize;

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

        visitLabelFontSize = 10;
        visitNumberFontSize = 22;
        visitTotalFontSize = 9.5;

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

        visitLabelFontSize = 12;
        visitNumberFontSize = 27;
        visitTotalFontSize = 11;

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

        visitLabelFontSize = 11;
        visitNumberFontSize = 24;
        visitTotalFontSize = 10;

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

          // ===============================================
          // Border موحد
          // حتى ما يتعارض مع borderRadius
          // ===============================================
          border: Border.all(
            color: const Color(
              0xFFE9EEF3,
            ),
            width: 1,
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
          // Stack يحل مشكلة الـ infinite height
          // =================================================
          child: Stack(
            children: [
              // ===============================================
              // Main Content
              // ===============================================
              Padding(
                padding: EdgeInsets.fromLTRB(
                  cardPadding,
                  cardPadding,

                  // مساحة إضافية بسبب الشريط
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
                                height: 4,
                              ),

                              Text(
                                data.spTitle,

                                maxLines: 1,

                                overflow:
                                TextOverflow
                                    .ellipsis,

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
                            ],
                          ),
                        ),

                        const SizedBox(
                          width: 10,
                        ),

                        // =====================================
                        // Visit Counter
                        // =====================================
                        _buildVisitCounter(
                          done: done,
                          total: total,
                          labelFontSize:
                          visitLabelFontSize,
                          numberFontSize:
                          visitNumberFontSize,
                          totalFontSize:
                          visitTotalFontSize,
                        ),
                      ],
                    ),

                    SizedBox(
                      height:
                      sectionSpacing,
                    ),

                    // =========================================
                    // Separator
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
                    // Progress
                    // =========================================
                    _buildProgressBar(
                      done,
                      total,
                      height:
                      progressHeight,
                    ),
                  ],
                ),
              ),

              // ===============================================
              // Side Bar
              // ===============================================
              Positioned(
                top: 0,
                bottom: 0,
                right: 0,

                child: Container(
                  width:
                  sideBarWidth,

                  color: const Color(
                    0xFF2D947A,
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
  // Visit Counter
  // =====================================================

  Widget _buildVisitCounter({
    required int done,
    required int total,
    required double labelFontSize,
    required double numberFontSize,
    required double totalFontSize,
  }) {
    return Container(
      constraints: const BoxConstraints(
        minWidth: 58,
      ),

      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 6,
      ),

      decoration: BoxDecoration(
        color: const Color(
          0xFFF0FDFA,
        ),

        borderRadius:
        BorderRadius.circular(
          12,
        ),

        border: Border.all(
          color: const Color(
            0xFFCCFBF1,
          ),
        ),
      ),

      child: Column(
        mainAxisSize:
        MainAxisSize.min,

        children: [
          Text(
            "تمت الزيارة",

            maxLines: 1,

            style: TextStyle(
              fontSize:
              labelFontSize,

              color: const Color(
                0xFF2D947A,
              ),

              fontWeight:
              FontWeight.w500,
            ),
          ),

          const SizedBox(
            height: 2,
          ),

          Text(
            "$done",

            style: TextStyle(
              fontSize:
              numberFontSize,

              height: 1,

              fontWeight:
              FontWeight.w800,

              color: const Color(
                0xFF2D947A,
              ),
            ),
          ),

          const SizedBox(
            height: 3,
          ),

          Text(
            "من أصل $total",

            maxLines: 1,

            style: TextStyle(
              fontSize:
              totalFontSize,

              color:
              Colors.grey.shade600,

              fontWeight:
              FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  // =====================================================
  // Progress
  // =====================================================

  Widget _buildProgressBar(
      int done,
      int total, {
        required double height,
      }) {
    final double percent =
    total == 0
        ? 0
        : (done / total)
        .clamp(
      0.0,
      1.0,
    );

    return Column(
      crossAxisAlignment:
      CrossAxisAlignment.start,

      children: [
        Row(
          children: [
            Text(
              "نسبة الإنجاز",

              style: TextStyle(
                fontSize: 11,

                color:
                Colors.grey.shade600,

                fontWeight:
                FontWeight.w500,
              ),
            ),

            const Spacer(),

            Container(
              padding:
              const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 3,
              ),

              decoration: BoxDecoration(
                color: const Color(
                  0xFFF0FDFA,
                ),

                borderRadius:
                BorderRadius.circular(
                  7,
                ),
              ),

              child: Text(
                "${(percent * 100).round()}%",

                style:
                const TextStyle(
                  fontSize: 11,

                  color: Color(
                    0xFF2D947A,
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
            value: percent,

            minHeight: height,

            backgroundColor:
            const Color(
              0xFFE0F2F1,
            ),

            valueColor:
            const AlwaysStoppedAnimation<
                Color>(
              Color(
                0xFF2D947A,
              ),
            ),
          ),
        ),
      ],
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
              fontSize: fontSize,

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