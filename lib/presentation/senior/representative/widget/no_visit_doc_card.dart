import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/resources/responsive/app_responsive.dart';
import 'package:flutter/material.dart';

class RemainingVisitCard extends StatelessWidget {
  final NoVisitDocModel data;

  const RemainingVisitCard({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    // =====================================================
    // نفس المنطق البرمجي الموجود عندك
    // visits = الإجمالي
    // remainingVisits = المنجز
    // =====================================================
    final int totalVisits =
        int.tryParse(data.visits ?? '0') ?? 0;

    final int doneVisits =
        data.remainingVisits ?? 0;

    double progressPercent =
    totalVisits == 0
        ? 0.0
        : doneVisits / totalVisits;

    progressPercent =
        progressPercent.clamp(
          0.0,
          1.0,
        );

    // نفس ترتيب النص الموجود عندك
    final String progressLabel =
        "$totalVisits / $doneVisits";

    final deviceType =
    AppResponsive.deviceType(context);

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
    double specializationFontSize;

    double rateHorizontalPadding;
    double rateVerticalPadding;
    double rateRadius;
    double rateFontSize;

    double doneLabelFontSize;
    double doneNumberFontSize;

    double sectionSpacing;

    double progressTitleFontSize;
    double progressValueFontSize;
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
        specializationFontSize = 12;

        rateHorizontalPadding = 7;
        rateVerticalPadding = 3;
        rateRadius = 7;
        rateFontSize = 10;

        doneLabelFontSize = 10;
        doneNumberFontSize = 22;

        sectionSpacing = 14;

        progressTitleFontSize = 11;
        progressValueFontSize = 11;

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
        specializationFontSize = 14;

        rateHorizontalPadding = 9;
        rateVerticalPadding = 4;
        rateRadius = 8;
        rateFontSize = 12;

        doneLabelFontSize = 12;
        doneNumberFontSize = 27;

        sectionSpacing = 18;

        progressTitleFontSize = 13;
        progressValueFontSize = 13;

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
        specializationFontSize = 13;

        rateHorizontalPadding = 8;
        rateVerticalPadding = 3;
        rateRadius = 8;
        rateFontSize = 11;

        doneLabelFontSize = 11;
        doneNumberFontSize = 24;

        sectionSpacing = 15;

        progressTitleFontSize = 12;
        progressValueFontSize = 12;

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
          // Stack بدل IntrinsicHeight
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

                  // مساحة إضافية جهة الشريط
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
                        // Profile Icon
                        // =====================================
                        _buildProfileIcon(
                          boxSize:
                          iconBoxSize,

                          iconSize:
                          iconSize,

                          radius:
                          iconRadius,
                        ),

                        SizedBox(
                          width:
                          iconSpacing,
                        ),

                        // =====================================
                        // Doctor / Hospital Information
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
                              // Specialization + Rate
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
                                      specializationFontSize,

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
                        // Done Counter
                        // =====================================
                        _buildDoneCounter(
                          done:
                          doneVisits,

                          labelFontSize:
                          doneLabelFontSize,

                          numberFontSize:
                          doneNumberFontSize,
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
                    // Progress
                    // =========================================
                    _buildProgressBarRow(
                      percent:
                      progressPercent,

                      label:
                      progressLabel,

                      titleFontSize:
                      progressTitleFontSize,

                      valueFontSize:
                      progressValueFontSize,

                      progressHeight:
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

                  color:
                  ColorManager
                      .medicalSecondary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // =====================================================
  // Done Counter
  // =====================================================

  Widget _buildDoneCounter({
    required int done,
    required double labelFontSize,
    required double numberFontSize,
  }) {
    return Container(
      constraints:
      const BoxConstraints(
        minWidth: 58,
      ),

      padding:
      const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 7,
      ),

      decoration:
      BoxDecoration(
        color: const Color(
          0xFFEFF6FF,
        ),

        borderRadius:
        BorderRadius.circular(
          12,
        ),

        border: Border.all(
          color: const Color(
            0xFFDBEAFE,
          ),
        ),
      ),

      child: Column(
        mainAxisSize:
        MainAxisSize.min,

        children: [
          Text(
            "المنجز",

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
            "$done",

            style: TextStyle(
              fontSize:
              numberFontSize,

              height: 1,

              fontWeight:
              FontWeight.w800,

              color: const Color(
                0xFF2563EB,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // =====================================================
  // Progress
  // =====================================================

  Widget _buildProgressBarRow({
    required double percent,
    required String label,
    required double titleFontSize,
    required double valueFontSize,
    required double progressHeight,
  }) {
    final int percentage =
    (percent * 100).round();

    return Column(
      crossAxisAlignment:
      CrossAxisAlignment.start,

      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                "حالة الإنجاز من الهدف",

                maxLines: 1,

                overflow:
                TextOverflow.ellipsis,

                style:
                TextStyle(
                  fontSize:
                  titleFontSize,

                  color: Colors
                      .grey
                      .shade600,

                  fontWeight:
                  FontWeight.w500,
                ),
              ),
            ),

            const SizedBox(
              width: 10,
            ),

            // =============================================
            // Visits Value
            // =============================================
            Text(
              label,

              style: TextStyle(
                fontSize:
                valueFontSize,

                fontWeight:
                FontWeight.w700,

                color:
                const Color(
                  0xFF1F4E79,
                ),
              ),
            ),

            const SizedBox(
              width: 8,
            ),

            // =============================================
            // Percentage
            // =============================================
            Container(
              padding:
              const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 3,
              ),

              decoration:
              BoxDecoration(
                color:
                ColorManager
                    .medicalSecondary
                    .withOpacity(
                  0.10,
                ),

                borderRadius:
                BorderRadius.circular(
                  7,
                ),
              ),

              child: Text(
                "$percentage%",

                style:
                TextStyle(
                  fontSize:
                  valueFontSize -
                      1,

                  fontWeight:
                  FontWeight.w700,

                  color:
                  ColorManager
                      .medicalSecondary,
                ),
              ),
            ),
          ],
        ),

        const SizedBox(
          height: 8,
        ),

        ClipRRect(
          borderRadius:
          BorderRadius.circular(
            10,
          ),

          child:
          LinearProgressIndicator(
            value: percent,

            minHeight:
            progressHeight,

            backgroundColor:
            const Color(
              0xFFF1F5F9,
            ),

            valueColor:
            AlwaysStoppedAnimation<
                Color>(
              ColorManager
                  .medicalSecondary,
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
          0xFFFFF7ED,
        ),

        borderRadius:
        BorderRadius.circular(
          radius,
        ),

        border: Border.all(
          color: const Color(
            0xFFFED7AA,
          ),
        ),
      ),

      child: Text(
        rate,

        maxLines: 1,

        style: TextStyle(
          fontSize:
          fontSize,

          color: const Color(
            0xFFEA580C,
          ),

          fontWeight:
          FontWeight.w700,
        ),
      ),
    );
  }

  // =====================================================
  // Profile Icon
  // =====================================================

  Widget _buildProfileIcon({
    required double boxSize,
    required double iconSize,
    required double radius,
  }) {
    return Container(
      width: boxSize,
      height: boxSize,

      alignment:
      Alignment.center,

      decoration:
      BoxDecoration(
        color: const Color(
          0xFFEFF6FF,
        ),

        borderRadius:
        BorderRadius.circular(
          radius,
        ),
      ),

      child: Icon(
        Icons
            .pending_actions_outlined,

        color:
        ColorManager
            .medicalSecondary,

        size: iconSize,
      ),
    );
  }
}