import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/resources/responsive/app_responsive.dart';
import 'package:domina_app/presentation/resources/routes_manager.dart';
import 'package:domina_app/presentation/senior/finished_plan/bloc/finished_plan_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';



class PlanCard extends StatelessWidget {
  final FinishedPlanModel plan;

  const PlanCard({
    super.key,
    required this.plan,
  });

  @override
  Widget build(BuildContext context) {
    final deviceType =
    AppResponsive.deviceType(context);

    // =====================================================
    // Status Logic
    // نفس المنطق الموجود عندك
    // =====================================================

    Color mainColor;
    String statusText;
    IconData statusIcon;

    if (plan.active == "-1") {
      mainColor =
      const Color(
        0xFF64748B,
      );

      statusText =
      "مؤرشفة";

      statusIcon =
          Icons.archive_outlined;
    } else if (plan.active == "0") {
      mainColor =
      const Color(
        0xFFEF4444,
      );

      statusText =
      "منتهية";

      statusIcon =
          Icons.check_circle_outline_rounded;
    } else {
      mainColor =
      const Color(
        0xFF0F9D8A,
      );

      statusText =
      "مراجعة نهائية";

      statusIcon =
          Icons.rate_review_outlined;
    }

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

    double statusFontSize;
    double statusIconSize;

    double dateFontSize;

    double arrowBoxSize;
    double arrowIconSize;

    double sectionSpacing;

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

        statusFontSize = 10.5;
        statusIconSize = 14;

        dateFontSize = 10.5;

        arrowBoxSize = 34;
        arrowIconSize = 15;

        sectionSpacing = 10;
        break;

    // =================================================
    // Tablet Portrait
    // =================================================
      case AppDeviceType.tabletPortrait:
        cardBottomSpacing = 15;

        cardRadius = 20;
        cardPadding = 20;

        sideBarWidth = 5;

        iconBoxSize = 52;
        iconSize = 26;
        iconRadius = 14;
        iconSpacing = 16;

        titleFontSize = 19;

        statusFontSize = 12;
        statusIconSize = 16;

        dateFontSize = 12;

        arrowBoxSize = 40;
        arrowIconSize = 18;

        sectionSpacing = 13;
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

        statusFontSize = 11;
        statusIconSize = 15;

        dateFontSize = 11.5;

        arrowBoxSize = 36;
        arrowIconSize = 16;

        sectionSpacing = 11;
        break;
    }

    return Padding(
      padding:
      EdgeInsets.only(
        bottom:
        cardBottomSpacing,
      ),

      child: Material(
        color:
        Colors.transparent,

        child: InkWell(
          borderRadius:
          BorderRadius.circular(
            cardRadius,
          ),

          // =================================================
          // نفس ترتيب المنطق الأصلي:
          // event ثم navigation
          // =================================================
          onTap: () {
            BlocProvider.of<
                FinishedPlanBloc>(
              context,
            ).add(
              GetPlanRepsEvent(
                planId:
                int.parse(
                  plan.id,
                ),
              ),
            );

            Navigator.pushNamed(
              context,
              Routes.planReps,
            );
          },

          child: Container(
            decoration:
            BoxDecoration(
              color:
              Colors.white,

              borderRadius:
              BorderRadius.circular(
                cardRadius,
              ),

              border:
              Border.all(
                color:
                const Color(
                  0xFFE2E8F0,
                ),
              ),

              boxShadow: [
                BoxShadow(
                  color:
                  Colors.black
                      .withOpacity(
                    0.025,
                  ),

                  blurRadius:
                  12,

                  offset:
                  const Offset(
                    0,
                    4,
                  ),
                ),
              ],
            ),

            clipBehavior:
            Clip.antiAlias,

            // =================================================
            // Stack للشريط الجانبي
            // =================================================
            child: Stack(
              children: [
                // ===============================================
                // Content
                // ===============================================
                Padding(
                  padding:
                  EdgeInsets.fromLTRB(
                    cardPadding,
                    cardPadding,

                    cardPadding +
                        sideBarWidth,

                    cardPadding,
                  ),

                  child: Row(
                    crossAxisAlignment:
                    CrossAxisAlignment.center,

                    children: [
                      // =========================================
                      // Plan Icon
                      // =========================================
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
                          mainColor.withOpacity(
                            0.08,
                          ),

                          borderRadius:
                          BorderRadius.circular(
                            iconRadius,
                          ),
                        ),

                        child: Icon(
                          Icons
                              .event_note_outlined,

                          size:
                          iconSize,

                          color:
                          mainColor,
                        ),
                      ),

                      SizedBox(
                        width:
                        iconSpacing,
                      ),

                      // =========================================
                      // Plan Content
                      // =========================================
                      Expanded(
                        child: Column(
                          mainAxisSize:
                          MainAxisSize.min,

                          crossAxisAlignment:
                          CrossAxisAlignment.start,

                          children: [
                            // =====================================
                            // Title
                            // =====================================
                            Text(
                              _generatePlanTitle(
                                plan.startDate,
                              ),

                              maxLines: 2,

                              overflow:
                              TextOverflow.ellipsis,

                              style:
                              TextStyle(
                                fontSize:
                                titleFontSize,

                                fontWeight:
                                FontWeight.w700,

                                color:
                                const Color(
                                  0xFF1E3A8A,
                                ),

                                height:
                                1.25,
                              ),
                            ),

                            SizedBox(
                              height:
                              sectionSpacing,
                            ),

                            // =====================================
                            // Status
                            // =====================================
                            _buildStatusBadge(
                              text:
                              statusText,

                              color:
                              mainColor,

                              icon:
                              statusIcon,

                              fontSize:
                              statusFontSize,

                              iconSize:
                              statusIconSize,
                            ),

                            SizedBox(
                              height:
                              sectionSpacing,
                            ),

                            // =====================================
                            // Dates
                            // =====================================
                            _buildDateContainer(
                              start:
                              plan.startDate,

                              end:
                              plan.endDate,

                              fontSize:
                              dateFontSize,
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(
                        width: 12,
                      ),

                      // =========================================
                      // Navigation Arrow
                      // =========================================
                      Container(
                        width:
                        arrowBoxSize,

                        height:
                        arrowBoxSize,

                        alignment:
                        Alignment.center,

                        decoration:
                        BoxDecoration(
                          color:
                          const Color(
                            0xFFF8FAFC,
                          ),

                          borderRadius:
                          BorderRadius.circular(
                            10,
                          ),
                        ),

                        child: Icon(
                          Icons
                              .arrow_forward_ios_rounded,

                          size:
                          arrowIconSize,

                          color:
                          const Color(
                            0xFF94A3B8,
                          ),
                        ),
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
                    mainColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  String _generatePlanTitle(
      String dateString,
      ) {
    final DateTime? date =
    DateTime.tryParse(
      dateString,
    );

    if (date == null) {
      return "خطة الشتاء";
    }

    const List<String> months = [
      "كانون الثاني",
      "شباط",
      "آذار",
      "نيسان",
      "أيار",
      "حزيران",
      "تموز",
      "آب",
      "أيلول",
      "تشرين الأول",
      "تشرين الثاني",
      "كانون الأول",
    ];

    final String monthName =
    months[
    date.month - 1];

    final String year =
    date.year.toString();

    return "خطة $monthName $year";
  }
  // =====================================================
  // Status Badge
  // =====================================================

  Widget _buildStatusBadge({
    required String text,
    required Color color,
    required IconData icon,
    required double fontSize,
    required double iconSize,
  }) {
    return Align(
      alignment:
      Alignment.centerRight,

      child: Container(
        padding:
        const EdgeInsets.symmetric(
          horizontal:
          9,

          vertical:
          5,
        ),

        decoration:
        BoxDecoration(
          color:
          color.withOpacity(
            0.08,
          ),

          borderRadius:
          BorderRadius.circular(
            8,
          ),

          border:
          Border.all(
            color:
            color.withOpacity(
              0.20,
            ),
          ),
        ),

        child: Row(
          mainAxisSize:
          MainAxisSize.min,

          children: [
            Icon(
              icon,

              size:
              iconSize,

              color:
              color,
            ),

            const SizedBox(
              width: 5,
            ),

            Text(
              text,

              style:
              TextStyle(
                color:
                color,

                fontSize:
                fontSize,

                fontWeight:
                FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // =====================================================
  // Date Container
  // =====================================================

  Widget _buildDateContainer({
    required String start,
    required String end,
    required double fontSize,
  }) {
    return Container(
      padding:
      const EdgeInsets.symmetric(
        horizontal:
        10,

        vertical:
        7,
      ),

      decoration:
      BoxDecoration(
        color:
        const Color(
          0xFFF8FAFC,
        ),

        borderRadius:
        BorderRadius.circular(
          10,
        ),

        border:
        Border.all(
          color:
          const Color(
            0xFFE9EEF5,
          ),
        ),
      ),

      child: Row(
        mainAxisSize:
        MainAxisSize.min,

        children: [
          const Icon(
            Icons
                .calendar_today_outlined,

            size: 13,

            color:
            Color(
              0xFF94A3B8,
            ),
          ),

          const SizedBox(
            width: 6,
          ),

          Flexible(
            child: Text(
              start,

              maxLines: 1,

              overflow:
              TextOverflow.ellipsis,

              style:
              TextStyle(
                fontSize:
                fontSize,

                color:
                const Color(
                  0xFF64748B,
                ),

                fontWeight:
                FontWeight.w500,
              ),
            ),
          ),

          const Padding(
            padding:
            EdgeInsets.symmetric(
              horizontal:
              7,
            ),

            child:
            Icon(
              Icons
                  .arrow_back_rounded,

              size: 13,

              color:
              Color(
                0xFFCBD5E1,
              ),
            ),
          ),

          Flexible(
            child: Text(
              end,

              maxLines: 1,

              overflow:
              TextOverflow.ellipsis,

              style:
              TextStyle(
                fontSize:
                fontSize,

                color:
                const Color(
                  0xFF64748B,
                ),

                fontWeight:
                FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

// =====================================================
// Generate Plan Title
// =====================================================


}
