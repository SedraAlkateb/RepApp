import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/resources/responsive/app_responsive.dart';
import 'package:domina_app/presentation/senior/report_visit_doctor/bloc/report_visit_doctor_bloc.dart';
import 'package:domina_app/presentation/senior/report_visit_doctor/widget/text_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// =======================================================
// Doctor Bottom Sheet
// =======================================================

Widget stackInputDoctor({
  required int indexRep,
  required bool iscanedite,
}) {
  return _buildReportBottomSheet(
    indexRep: indexRep,
    iscanedite: iscanedite,
    isHospital: false,
  );
}

// =======================================================
// Hospital Bottom Sheet
// =======================================================

Widget stackInputHospital({
  required int indexRep,
  required bool iscanedite,
}) {
  return _buildReportBottomSheet(
    indexRep: indexRep,
    iscanedite: iscanedite,
    isHospital: true,
  );
}

// =======================================================
// Unified Report Bottom Sheet
// =======================================================

Widget _buildReportBottomSheet({
  required int indexRep,
  required bool iscanedite,
  required bool isHospital,
}) {
  return BlocBuilder<
      ReportVisitDoctorBloc,
      ReportVisitDoctorState>(
    builder: (context, state) {
      final bloc =
      BlocProvider.of<ReportVisitDoctorBloc>(
        context,
      );

      bool num = bloc.num;
      bool isExpanded = bloc.isExpanded;

      RepVisitsModel doctorNoteModel =
          bloc.doctorNoteModel;

      int index = bloc.index;

      // =================================================
      // Expanded
      // =================================================
      if (state is DocIsExpandedNoteState) {
        isExpanded = true;

        index = state.index;

        doctorNoteModel =
            state.doctorNoteModel;
      }

      // =================================================
      // Closed
      // =================================================
      if (state is DocNoIsExpandedNoteState) {
        isExpanded = false;
      }

      if (!isExpanded) {
        return const SizedBox.shrink();
      }

      final deviceType =
      AppResponsive.deviceType(context);

      double maxSheetWidth;

      double initialChildSize;
      double minChildSize;

      double sheetRadius;

      double horizontalPadding;
      double contentTopPadding;

      double headerIconBoxSize;
      double headerIconSize;
      double headerIconRadius;
      double headerSpacing;

      double titleFontSize;
      double dateFontSize;

      double sectionSpacing;

      switch (deviceType) {
      // ===============================================
      // Mobile
      // ===============================================
        case AppDeviceType.mobilePortrait:
          maxSheetWidth =
              double.infinity;

          initialChildSize = 0.46;
          minChildSize = 0.12;

          sheetRadius = 26;

          horizontalPadding = 18;
          contentTopPadding = 4;

          headerIconBoxSize = 46;
          headerIconSize = 23;
          headerIconRadius = 13;
          headerSpacing = 12;

          titleFontSize = 18;
          dateFontSize = 11;

          sectionSpacing = 16;
          break;

      // ===============================================
      // Tablet Portrait
      // ===============================================
        case AppDeviceType.tabletPortrait:
          maxSheetWidth = 760;

          initialChildSize = 0.42;
          minChildSize = 0.12;

          sheetRadius = 28;

          horizontalPadding = 28;
          contentTopPadding = 8;

          headerIconBoxSize = 54;
          headerIconSize = 27;
          headerIconRadius = 15;
          headerSpacing = 16;

          titleFontSize = 21;
          dateFontSize = 13;

          sectionSpacing = 20;
          break;

      // ===============================================
      // Tablet Landscape
      // ===============================================
        case AppDeviceType.tabletLandscape:
          maxSheetWidth = 900;

          // Landscape أقصر، لذلك نفتح مساحة أكبر
          initialChildSize = 0.58;
          minChildSize = 0.16;

          sheetRadius = 24;

          horizontalPadding = 28;
          contentTopPadding = 4;

          headerIconBoxSize = 48;
          headerIconSize = 24;
          headerIconRadius = 13;
          headerSpacing = 14;

          titleFontSize = 19;
          dateFontSize = 12;

          sectionSpacing = 16;
          break;
      }

      return Stack(
        children: [
          // =================================================
          // Dark Background
          // =================================================
          GestureDetector(
            onTap: () {
              bloc.add(
                DocNoIsExpandedNoteEvent(),
              );
            },
            child: ModalBarrier(
              color: Colors.black.withOpacity(
                0.42,
              ),
              dismissible: true,
            ),
          ),

          // =================================================
          // Sheet
          // =================================================
          DraggableScrollableSheet(
            initialChildSize:
            initialChildSize,

            minChildSize:
            minChildSize,

            maxChildSize: 1,

            builder:
                (context, scrollController) {
              return NotificationListener<
                  DraggableScrollableNotification>(
                onNotification:
                    (notification) {
                  if (notification.extent ==
                      1.0) {
                    bloc.add(
                      ExpandedBorder(true),
                    );
                  } else if (bloc.num == true) {
                    bloc.add(
                      ExpandedBorder(false),
                    );
                  } else if (notification
                      .extent <=
                      minChildSize) {
                    bloc.add(
                      DocNoIsExpandedNoteEvent(),
                    );
                  }

                  return true;
                },

                child: Align(
                  alignment:
                  Alignment.bottomCenter,

                  child: ConstrainedBox(
                    constraints:
                    BoxConstraints(
                      maxWidth:
                      maxSheetWidth,
                    ),

                    child: Container(
                      width:
                      double.infinity,

                      decoration:
                      BoxDecoration(
                        color:
                        ColorManager.white,

                        border:
                        Border.all(
                          color: ColorManager
                              .secondaryColor3
                              .withOpacity(
                            0.35,
                          ),
                        ),

                        borderRadius:
                        BorderRadius.vertical(
                          top: Radius.circular(
                            num
                                ? 0
                                : sheetRadius,
                          ),
                        ),

                        boxShadow: [
                          BoxShadow(
                            color: Colors.black
                                .withOpacity(
                              0.08,
                            ),
                            blurRadius: 16,
                            offset:
                            const Offset(
                              0,
                              -4,
                            ),
                          ),
                        ],
                      ),

                      clipBehavior:
                      Clip.antiAlias,

                      child: SafeArea(
                        top: false,

                        child:
                        CustomScrollView(
                          controller:
                          scrollController,

                          keyboardDismissBehavior:
                          ScrollViewKeyboardDismissBehavior
                              .onDrag,

                          slivers: [
                            // =================================
                            // Drag Handle
                            // =================================
                            SliverToBoxAdapter(
                              child: num
                                  ? const SizedBox(
                                height:
                                16,
                              )
                                  : Center(
                                child:
                                InkWell(
                                  borderRadius:
                                  BorderRadius.circular(
                                    12,
                                  ),

                                  onTap:
                                      () {
                                    bloc.add(
                                      DocNoIsExpandedNoteEvent(),
                                    );
                                  },

                                  child:
                                  Padding(
                                    padding:
                                    const EdgeInsets.symmetric(
                                      horizontal:
                                      24,
                                      vertical:
                                      14,
                                    ),

                                    child:
                                    Container(
                                      width:
                                      48,
                                      height:
                                      5,

                                      decoration:
                                      BoxDecoration(
                                        color: ColorManager
                                            .secondaryColor1
                                            .withOpacity(
                                          0.32,
                                        ),

                                        borderRadius:
                                        BorderRadius.circular(
                                          3,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            // =================================
                            // Main Content
                            // =================================
                            SliverPadding(
                              padding:
                              EdgeInsets.fromLTRB(
                                horizontalPadding,
                                contentTopPadding,
                                horizontalPadding,
                                30,
                              ),

                              sliver:
                              SliverToBoxAdapter(
                                child: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,

                                  children: [
                                    // =============================
                                    // Header
                                    // =============================
                                    _buildSheetHeader(
                                      context:
                                      context,

                                      data:
                                      doctorNoteModel,

                                      isHospital:
                                      isHospital,

                                      iconBoxSize:
                                      headerIconBoxSize,

                                      iconSize:
                                      headerIconSize,

                                      iconRadius:
                                      headerIconRadius,

                                      spacing:
                                      headerSpacing,

                                      titleFontSize:
                                      titleFontSize,

                                      dateFontSize:
                                      dateFontSize,
                                    ),

                                    SizedBox(
                                      height:
                                      sectionSpacing,
                                    ),

                                    const Divider(
                                      height: 1,
                                      thickness:
                                      0.8,
                                      color: Color(
                                        0xFFE2E8F0,
                                      ),
                                    ),

                                    SizedBox(
                                      height:
                                      sectionSpacing,
                                    ),

                                    // =============================
                                    // Basic Information
                                    // =============================
                                    TextInfo(
                                      title:
                                      "العنوان",
                                      supTitle:
                                      doctorNoteModel
                                          .placeTitle,
                                      icon: Icons
                                          .location_on_outlined,
                                    ),

                                    TextInfo(
                                      title:
                                      "الاختصاص",
                                      supTitle:
                                      doctorNoteModel
                                          .spTitle,
                                      icon: Icons
                                          .medical_services_outlined,
                                    ),

                                    // Doctor-specific info
                                    if (!isHospital) ...[
                                      TextInfo(
                                        title:
                                        "التقييم",
                                        supTitle:
                                        doctorNoteModel
                                            .rate,
                                        icon: Icons
                                            .star_outline,
                                      ),

                                      TextInfo(
                                        title:
                                        "الأهداف",
                                        supTitle:
                                        doctorNoteModel
                                            .target,
                                        icon: Icons
                                            .ads_click,
                                      ),
                                    ],

                                    SizedBox(
                                      height:
                                      sectionSpacing -
                                          4,
                                    ),

                                    // =============================
                                    // Notes
                                    // =============================
                                    _buildResponsiveNoteCard(
                                      context,

                                      title:
                                      "ملاحظات المكتب العلمي",

                                      content:
                                      doctorNoteModel
                                          .note,

                                      accentColor:
                                      ColorManager
                                          .primary1,

                                      icon: Icons
                                          .science_outlined,
                                    ),

                                    _buildResponsiveNoteCard(
                                      context,

                                      title:
                                      "ملاحظات إضافية",

                                      content:
                                      doctorNoteModel
                                          .special,

                                      accentColor:
                                      Colors
                                          .amber
                                          .shade800,

                                      icon: Icons
                                          .note_alt_outlined,
                                    ),

                                    _buildResponsiveNoteCard(
                                      context,

                                      title:
                                      "ملاحظات مستودع قاسيون",

                                      content:
                                      doctorNoteModel
                                          .issue,

                                      accentColor:
                                      ColorManager
                                          .secondaryColor2,

                                      icon: Icons
                                          .inventory_2_outlined,
                                    ),

                                    // =============================
                                    // Samples
                                    // =============================
                                    if (doctorNoteModel
                                        .samples
                                        .isNotEmpty) ...[
                                      SizedBox(
                                        height:
                                        sectionSpacing -
                                            4,
                                      ),

                                      Text(
                                        "المستحضرات الموزعة",

                                        style:
                                        TextStyle(
                                          fontSize:
                                          deviceType ==
                                              AppDeviceType
                                                  .mobilePortrait
                                              ? 13
                                              : 15,

                                          fontWeight:
                                          FontWeight
                                              .w700,

                                          color:
                                          const Color(
                                            0xFF334155,
                                          ),
                                        ),
                                      ),

                                      const SizedBox(
                                        height: 10,
                                      ),

                                      Wrap(
                                        spacing: 8,
                                        runSpacing: 8,

                                        children:
                                        doctorNoteModel
                                            .samples
                                            .map<Widget>(
                                              (sample) {
                                            return _buildSampleChip(
                                              context,
                                              sample,
                                            );
                                          },
                                        ).toList(),
                                      ),
                                    ],

                                    SizedBox(
                                      height:
                                      sectionSpacing,
                                    ),

                                    // =============================
                                    // Read Button
                                    // =============================
                                    if (iscanedite)
                                      Align(
                                        alignment:
                                        Alignment.centerLeft,

                                        child:
                                        _buildReadReportButton(
                                          context:
                                          context,

                                          state:
                                          state,

                                          doctorNoteModel:
                                          doctorNoteModel,

                                          indexRep:
                                          indexRep,

                                          index:
                                          index,

                                          isHospital:
                                          isHospital,
                                        ),
                                      ),

                                    const SizedBox(
                                      height: 12,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      );
    },
  );
}

// =======================================================
// Sheet Header
// =======================================================

Widget _buildSheetHeader({
  required BuildContext context,
  required RepVisitsModel data,
  required bool isHospital,
  required double iconBoxSize,
  required double iconSize,
  required double iconRadius,
  required double spacing,
  required double titleFontSize,
  required double dateFontSize,
}) {
  return Row(
    crossAxisAlignment:
    CrossAxisAlignment.start,

    children: [
      // =================================================
      // Icon
      // =================================================
      Container(
        width: iconBoxSize,
        height: iconBoxSize,

        alignment:
        Alignment.center,

        decoration:
        BoxDecoration(
          color: ColorManager.primary1
              .withOpacity(
            0.08,
          ),

          borderRadius:
          BorderRadius.circular(
            iconRadius,
          ),
        ),

        child: Icon(
          isHospital
              ? Icons
              .local_hospital_outlined
              : Icons.person_outline,

          color:
          ColorManager.primary1,

          size: iconSize,
        ),
      ),

      SizedBox(
        width: spacing,
      ),

      // =================================================
      // Title + Date
      // =================================================
      Expanded(
        child: Column(
          mainAxisSize:
          MainAxisSize.min,

          crossAxisAlignment:
          CrossAxisAlignment.start,

          children: [
            Text(
              data.docTitle.isNotEmpty
                  ? data.docTitle
                  : isHospital
                  ? "اسم المشفى غير محدد"
                  : "اسم الطبيب غير محدد",

              maxLines: 2,

              overflow:
              TextOverflow.ellipsis,

              style: TextStyle(
                fontSize:
                titleFontSize,

                fontWeight:
                FontWeight.w700,

                color:
                const Color(
                  0xFF0F172A,
                ),

                height: 1.25,
              ),
            ),

            const SizedBox(
              height: 7,
            ),

            Row(
              children: [
                const Icon(
                  Icons
                      .calendar_today_outlined,

                  size: 14,

                  color: Color(
                    0xFF94A3B8,
                  ),
                ),

                const SizedBox(
                  width: 5,
                ),

                Expanded(
                  child: Text(
                    data.visitDate,

                    maxLines: 1,

                    overflow:
                    TextOverflow
                        .ellipsis,

                    style:
                    TextStyle(
                      fontSize:
                      dateFontSize,

                      color:
                      const Color(
                        0xFF64748B,
                      ),

                      fontWeight:
                      FontWeight
                          .w500,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ],
  );
}

// =======================================================
// Note Card
// =======================================================

Widget _buildResponsiveNoteCard(
    BuildContext context, {
      required String title,
      required String? content,
      required Color accentColor,
      required IconData icon,
    }) {
  if (content == null ||
      content.trim().isEmpty ||
      content.trim() == ".") {
    return const SizedBox.shrink();
  }

  final deviceType =
  AppResponsive.deviceType(context);

  double padding;
  double radius;

  double iconBoxSize;
  double iconSize;

  double titleFontSize;
  double contentFontSize;

  double bottomSpacing;

  switch (deviceType) {
    case AppDeviceType.mobilePortrait:
      padding = 12;
      radius = 14;

      iconBoxSize = 30;
      iconSize = 15;

      titleFontSize = 11.5;
      contentFontSize = 12;

      bottomSpacing = 10;
      break;

    case AppDeviceType.tabletPortrait:
      padding = 15;
      radius = 16;

      iconBoxSize = 36;
      iconSize = 18;

      titleFontSize = 13;
      contentFontSize = 13.5;

      bottomSpacing = 12;
      break;

    case AppDeviceType.tabletLandscape:
      padding = 13;
      radius = 14;

      iconBoxSize = 32;
      iconSize = 16;

      titleFontSize = 12;
      contentFontSize = 12.5;

      bottomSpacing = 10;
      break;
  }

  return Container(
    width: double.infinity,

    margin: EdgeInsets.only(
      bottom: bottomSpacing,
    ),

    padding: EdgeInsets.all(
      padding,
    ),

    decoration:
    BoxDecoration(
      color: accentColor.withOpacity(
        0.045,
      ),

      borderRadius:
      BorderRadius.circular(
        radius,
      ),

      border: Border.all(
        color: accentColor.withOpacity(
          0.10,
        ),
      ),
    ),

    child: Column(
      crossAxisAlignment:
      CrossAxisAlignment.start,

      children: [
        Row(
          children: [
            Container(
              width: iconBoxSize,
              height: iconBoxSize,

              alignment:
              Alignment.center,

              decoration:
              BoxDecoration(
                color: accentColor
                    .withOpacity(
                  0.10,
                ),

                borderRadius:
                BorderRadius.circular(
                  8,
                ),
              ),

              child: Icon(
                icon,

                size: iconSize,

                color:
                accentColor,
              ),
            ),

            const SizedBox(
              width: 8,
            ),

            Expanded(
              child: Text(
                title,

                maxLines: 2,

                overflow:
                TextOverflow
                    .ellipsis,

                style:
                TextStyle(
                  fontSize:
                  titleFontSize,

                  color:
                  accentColor,

                  fontWeight:
                  FontWeight
                      .w700,
                ),
              ),
            ),
          ],
        ),

        const SizedBox(
          height: 9,
        ),

        Text(
          content,

          style: TextStyle(
            fontSize:
            contentFontSize,

            color:
            const Color(
              0xFF334155,
            ),

            height: 1.5,

            fontWeight:
            FontWeight.w400,
          ),
        ),
      ],
    ),
  );
}

// =======================================================
// Sample Chip
// =======================================================

Widget _buildSampleChip(
    BuildContext context,
    String sample,
    ) {
  final deviceType =
  AppResponsive.deviceType(context);

  double horizontalPadding;
  double verticalPadding;

  double iconSize;
  double fontSize;

  switch (deviceType) {
    case AppDeviceType.mobilePortrait:
      horizontalPadding = 10;
      verticalPadding = 7;

      iconSize = 15;
      fontSize = 11;
      break;

    case AppDeviceType.tabletPortrait:
      horizontalPadding = 13;
      verticalPadding = 9;

      iconSize = 17;
      fontSize = 13;
      break;

    case AppDeviceType.tabletLandscape:
      horizontalPadding = 12;
      verticalPadding = 8;

      iconSize = 16;
      fontSize = 12;
      break;
  }

  return Container(
    constraints:
    const BoxConstraints(
      maxWidth: 260,
    ),

    padding:
    EdgeInsets.symmetric(
      horizontal:
      horizontalPadding,

      vertical:
      verticalPadding,
    ),

    decoration:
    BoxDecoration(
      color: ColorManager
          .secondaryColor7
          .withOpacity(
        0.10,
      ),

      borderRadius:
      BorderRadius.circular(
        12,
      ),

      border: Border.all(
        color: ColorManager
            .secondaryColor7
            .withOpacity(
          0.25,
        ),
      ),
    ),

    child: Row(
      mainAxisSize:
      MainAxisSize.min,

      children: [
        Icon(
          Icons.medication_outlined,

          size:
          iconSize,

          color:
          ColorManager.primary1,
        ),

        const SizedBox(
          width: 6,
        ),

        Flexible(
          child: Text(
            sample,

            maxLines: 2,

            overflow:
            TextOverflow.ellipsis,

            style: TextStyle(
              fontSize:
              fontSize,

              color:
              const Color(
                0xFF1E293B,
              ),

              fontWeight:
              FontWeight.w600,
            ),
          ),
        ),
      ],
    ),
  );
}

// =======================================================
// Read Report Button
// =======================================================

Widget _buildReadReportButton({
  required BuildContext context,
  required ReportVisitDoctorState state,
  required RepVisitsModel doctorNoteModel,
  required int indexRep,
  required int index,
  required bool isHospital,
}) {
  final deviceType =
  AppResponsive.deviceType(context);

  final bool isRead =
      doctorNoteModel.flag;

  final Color color = isRead
      ? ColorManager.secondaryColor2
      : ColorManager.primary1;

  double horizontalPadding;
  double verticalPadding;

  double iconSize;
  double fontSize;

  switch (deviceType) {
    case AppDeviceType.mobilePortrait:
      horizontalPadding = 13;
      verticalPadding = 9;

      iconSize = 19;
      fontSize = 12;
      break;

    case AppDeviceType.tabletPortrait:
      horizontalPadding = 16;
      verticalPadding = 11;

      iconSize = 22;
      fontSize = 14;
      break;

    case AppDeviceType.tabletLandscape:
      horizontalPadding = 14;
      verticalPadding = 9;

      iconSize = 20;
      fontSize = 13;
      break;
  }

  return Material(
    color: Colors.transparent,

    child: InkWell(
      borderRadius:
      BorderRadius.circular(
        12,
      ),

      onTap:
      state is AsReadLoadingState
          ? null
          : () {
        if (isHospital) {
          BlocProvider.of<
              ReportVisitDoctorBloc>(
            context,
          ).add(
            ChangeReadHosNoteEvent(
              index:
              indexRep,

              indexBook:
              index,

              repVisitsModel:
              doctorNoteModel,
            ),
          );
        } else {
          BlocProvider.of<
              ReportVisitDoctorBloc>(
            context,
          ).add(
            ChangeReadDocNoteEvent(
              repVisitsModel:
              doctorNoteModel,

              index:
              indexRep,

              indexBook:
              index,
            ),
          );
        }
      },

      child: Container(
        padding:
        EdgeInsets.symmetric(
          horizontal:
          horizontalPadding,

          vertical:
          verticalPadding,
        ),

        decoration:
        BoxDecoration(
          color:
          color.withOpacity(
            0.08,
          ),

          borderRadius:
          BorderRadius.circular(
            12,
          ),

          border: Border.all(
            color:
            color.withOpacity(
              0.65,
            ),
          ),
        ),

        child: Row(
          mainAxisSize:
          MainAxisSize.min,

          children: [
            if (state
            is AsReadLoadingState)
              SizedBox(
                width:
                iconSize,
                height:
                iconSize,

                child:
                CircularProgressIndicator(
                  strokeWidth: 2,
                  color:
                  color,
                ),
              )
            else
              Icon(
                isRead
                    ? Icons.bookmark
                    : Icons
                    .bookmark_border_outlined,

                size:
                iconSize,

                color:
                color,
              ),

            const SizedBox(
              width: 7,
            ),

            Text(
              isRead
                  ? "تم الاطلاع"
                  : "تعليم كمقروء",

              style:
              TextStyle(
                fontSize:
                fontSize,

                fontWeight:
                FontWeight.w700,

                color:
                color,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

// =======================================================
// Global Helpers
// =======================================================

// =======================================================
// Icon Button
// =======================================================

Widget buildIconButton(
    bool flag, {
      required IconData icon,
      VoidCallback? onPressed,
      bool isLoading = false,
    }) {
  return Builder(
    builder: (context) {
      final deviceType =
      AppResponsive.deviceType(context);

      double boxSize;
      double iconSize;
      double radius;

      switch (deviceType) {
        case AppDeviceType.mobilePortrait:
          boxSize = 38;
          iconSize = 18;
          radius = 10;
          break;

        case AppDeviceType.tabletPortrait:
          boxSize = 44;
          iconSize = 21;
          radius = 12;
          break;

        case AppDeviceType.tabletLandscape:
          boxSize = 40;
          iconSize = 19;
          radius = 10;
          break;
      }

      return Container(
        width: boxSize,
        height: boxSize,

        decoration:
        BoxDecoration(
          color:
          const Color(
            0xFFF1F5F9,
          ),

          borderRadius:
          BorderRadius.circular(
            radius,
          ),

          border: Border.all(
            color:
            const Color(
              0xFFE2E8F0,
            ),
          ),
        ),

        child: IconButton(
          constraints:
          const BoxConstraints(),

          padding:
          EdgeInsets.zero,

          onPressed:
          isLoading
              ? null
              : onPressed,

          icon: isLoading
              ? SizedBox(
            width:
            iconSize,
            height:
            iconSize,

            child:
            const CircularProgressIndicator(
              strokeWidth:
              2,
            ),
          )
              : Icon(
            icon,

            size:
            iconSize,

            color: flag
                ? ColorManager
                .secondaryColor2
                : ColorManager
                .primary1,
          ),
        ),
      );
    },
  );
}

// =======================================================
// WhatsApp Button
// =======================================================

Widget buildIconWatsAppButton({
  VoidCallback? onPressed,
  bool isLoading = false,
}) {
  return Builder(
    builder: (context) {
      final deviceType =
      AppResponsive.deviceType(context);

      double boxSize;
      double iconSize;
      double radius;

      switch (deviceType) {
        case AppDeviceType.mobilePortrait:
          boxSize = 38;
          iconSize = 18;
          radius = 10;
          break;

        case AppDeviceType.tabletPortrait:
          boxSize = 44;
          iconSize = 21;
          radius = 12;
          break;

        case AppDeviceType.tabletLandscape:
          boxSize = 40;
          iconSize = 19;
          radius = 10;
          break;
      }

      return Container(
        width:
        boxSize,
        height:
        boxSize,

        decoration:
        BoxDecoration(
          color:
          const Color(
            0xFFF1F5F9,
          ),

          borderRadius:
          BorderRadius.circular(
            radius,
          ),

          border: Border.all(
            color:
            const Color(
              0xFFE2E8F0,
            ),
          ),
        ),

        child: IconButton(
          constraints:
          const BoxConstraints(),

          padding:
          EdgeInsets.zero,

          onPressed:
          isLoading
              ? null
              : onPressed,

          icon: isLoading
              ? SizedBox(
            width:
            iconSize,
            height:
            iconSize,

            child:
            const CircularProgressIndicator(
              strokeWidth:
              2,
            ),
          )
              : FaIcon(
            FontAwesomeIcons
                .whatsapp,

            size:
            iconSize,

            color:
            ColorManager
                .primary1,
          ),
        ),
      );
    },
  );
}

// =======================================================
// Small Info Box
// =======================================================

Widget buildSmallInfoBox(
    String title,
    String value,
    IconData icon, {
      bool isStar = false,
    }) {
  return Expanded(
    child: Builder(
      builder: (context) {
        final deviceType =
        AppResponsive.deviceType(context);

        double padding;
        double radius;

        double iconSize;
        double fontSize;

        switch (deviceType) {
          case AppDeviceType.mobilePortrait:
            padding = 9;
            radius = 12;

            iconSize = 15;
            fontSize = 11;
            break;

          case AppDeviceType.tabletPortrait:
            padding = 13;
            radius = 14;

            iconSize = 18;
            fontSize = 13;
            break;

          case AppDeviceType.tabletLandscape:
            padding = 10;
            radius = 12;

            iconSize = 16;
            fontSize = 12;
            break;
        }

        return Container(
          padding:
          EdgeInsets.all(
            padding,
          ),

          decoration:
          BoxDecoration(
            color:
            const Color(
              0xFFF8FAFC,
            ),

            borderRadius:
            BorderRadius.circular(
              radius,
            ),

            border:
            Border.all(
              color:
              const Color(
                0xFFE2E8F0,
              ),
            ),
          ),

          child: Row(
            children: [
              Icon(
                icon,

                size:
                iconSize,

                color: isStar
                    ? Colors.orange
                    : const Color(
                  0xFF3B82F6,
                ),
              ),

              const SizedBox(
                width: 6,
              ),

              Expanded(
                child: Column(
                  mainAxisSize:
                  MainAxisSize.min,

                  crossAxisAlignment:
                  CrossAxisAlignment.start,

                  children: [
                    Text(
                      title,

                      maxLines: 1,

                      overflow:
                      TextOverflow
                          .ellipsis,

                      style:
                      TextStyle(
                        fontSize:
                        fontSize -
                            1,

                        color:
                        const Color(
                          0xFF94A3B8,
                        ),

                        fontWeight:
                        FontWeight
                            .w500,
                      ),
                    ),

                    const SizedBox(
                      height: 2,
                    ),

                    Text(
                      value,

                      maxLines: 1,

                      overflow:
                      TextOverflow
                          .ellipsis,

                      style:
                      TextStyle(
                        fontSize:
                        fontSize,

                        fontWeight:
                        FontWeight
                            .w700,

                        color:
                        const Color(
                          0xFF1E3A8A,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    ),
  );
}

// =======================================================
// Detail Box
// =======================================================

Widget buildDetailBox(
    String title,
    Widget content,
    ) {
  return Builder(
    builder: (context) {
      final deviceType =
      AppResponsive.deviceType(context);

      double padding;
      double radius;

      double titleFontSize;

      switch (deviceType) {
        case AppDeviceType.mobilePortrait:
          padding = 12;
          radius = 14;
          titleFontSize = 12;
          break;

        case AppDeviceType.tabletPortrait:
          padding = 15;
          radius = 16;
          titleFontSize = 14;
          break;

        case AppDeviceType.tabletLandscape:
          padding = 13;
          radius = 14;
          titleFontSize = 13;
          break;
      }

      return Container(
        width:
        double.infinity,

        padding:
        EdgeInsets.all(
          padding,
        ),

        decoration:
        BoxDecoration(
          color:
          const Color(
            0xFFF8FAFC,
          ),

          borderRadius:
          BorderRadius.circular(
            radius,
          ),

          border:
          Border.all(
            color:
            const Color(
              0xFFE2E8F0,
            ),
          ),
        ),

        child: Column(
          crossAxisAlignment:
          CrossAxisAlignment.start,

          children: [
            Text(
              title,

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
              ),
            ),

            const SizedBox(
              height: 7,
            ),

            content,
          ],
        ),
      );
    },
  );
}

// =======================================================
// Bullet Item
// =======================================================

Widget buildBulletItem(
    String text,
    ) {
  return Builder(
    builder: (context) {
      final deviceType =
      AppResponsive.deviceType(context);

      final double fontSize;

      switch (deviceType) {
        case AppDeviceType.mobilePortrait:
          fontSize = 11.5;
          break;

        case AppDeviceType.tabletPortrait:
          fontSize = 13.5;
          break;

        case AppDeviceType.tabletLandscape:
          fontSize = 12.5;
          break;
      }

      return Padding(
        padding:
        const EdgeInsets.symmetric(
          vertical: 3,
        ),

        child: Row(
          crossAxisAlignment:
          CrossAxisAlignment.start,

          children: [
            Container(
              width: 6,
              height: 6,

              margin:
              const EdgeInsets.only(
                top: 6,
              ),

              decoration:
              const BoxDecoration(
                color:
                Color(
                  0xFF3B82F6,
                ),

                shape:
                BoxShape.circle,
              ),
            ),

            const SizedBox(
              width: 8,
            ),

            Expanded(
              child: Text(
                text,

                textAlign:
                TextAlign.right,

                style:
                TextStyle(
                  fontSize:
                  fontSize,

                  color:
                  const Color(
                    0xFF1E3A8A,
                  ),

                  height: 1.4,
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}

// =======================================================
// Action Button
// =======================================================

Widget buildActionBtn({
  required BuildContext context,
  required String label,
  required IconData icon,
  required Color color,
  required VoidCallback onTap,
}) {
  final deviceType =
  AppResponsive.deviceType(context);

  double horizontalPadding;
  double verticalPadding;

  double radius;
  double fontSize;
  double iconSize;

  switch (deviceType) {
    case AppDeviceType.mobilePortrait:
      horizontalPadding = 12;
      verticalPadding = 8;

      radius = 11;
      fontSize = 11.5;
      iconSize = 17;
      break;

    case AppDeviceType.tabletPortrait:
      horizontalPadding = 16;
      verticalPadding = 10;

      radius = 13;
      fontSize = 13;
      iconSize = 19;
      break;

    case AppDeviceType.tabletLandscape:
      horizontalPadding = 14;
      verticalPadding = 8;

      radius = 11;
      fontSize = 12;
      iconSize = 18;
      break;
  }

  return Material(
    color:
    Colors.transparent,

    child: InkWell(
      onTap:
      onTap,

      borderRadius:
      BorderRadius.circular(
        radius,
      ),

      child: Container(
        padding:
        EdgeInsets.symmetric(
          horizontal:
          horizontalPadding,

          vertical:
          verticalPadding,
        ),

        decoration:
        BoxDecoration(
          color:
          color.withOpacity(
            0.07,
          ),

          borderRadius:
          BorderRadius.circular(
            radius,
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
              width: 7,
            ),

            Text(
              label,

              style:
              TextStyle(
                fontSize:
                fontSize,

                fontWeight:
                FontWeight
                    .w700,

                color:
                color,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

// =======================================================
// Animation
// =======================================================

Widget animatedEntry({
  required Widget child,
  required int delay,
}) {
  return TweenAnimationBuilder<double>(
    tween:
    Tween(
      begin: 0,
      end: 1,
    ),

    duration:
    const Duration(
      milliseconds: 600,
    ),

    curve:
    Curves.easeOutQuart,

    builder:
        (context, value, child) {
      return Opacity(
        opacity:
        value,

        child:
        Transform.translate(
          offset:
          Offset(
            0,
            30 * (1 - value),
          ),

          child:
          child,
        ),
      );
    },

    child:
    child,
  );
}