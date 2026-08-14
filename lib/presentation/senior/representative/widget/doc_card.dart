import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/resources/responsive/app_ui.dart';
import 'package:flutter/material.dart';

class DoctorSenCardWidget extends StatelessWidget {
  const DoctorSenCardWidget({
    super.key,
    required this.doctor,
  });

  final DoctorSenModel doctor;

  @override
  Widget build(BuildContext context) {
    final ui = AppUi.of(context);

    return Container(
      width: double.infinity,

      margin: EdgeInsets.only(
        bottom: ui.cardSpacing,
      ),

      padding: EdgeInsets.all(
        ui.cardPadding,
      ),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius: BorderRadius.circular(
          ui.cardRadius,
        ),

        border: Border.all(
          color: const Color(
            0xFFE2E8F0,
          ),
        ),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(
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

      child: Column(
        crossAxisAlignment:
        CrossAxisAlignment.start,

        children: [
          // =====================================================
          // Doctor Header
          // =====================================================
          Row(
            crossAxisAlignment:
            CrossAxisAlignment.center,

            children: [
              // =================================================
              // Doctor Icon
              // =================================================
              Container(
                width: ui.iconBoxSize,
                height: ui.iconBoxSize,

                alignment: Alignment.center,

                decoration: BoxDecoration(
                  color: ColorManager
                      .medicalPrimary
                      .withOpacity(
                    0.08,
                  ),

                  borderRadius:
                  BorderRadius.circular(
                    ui.smallRadius + 2,
                  ),
                ),

                child: Icon(
                  Icons.person_outline_rounded,

                  color:
                  ColorManager.medicalPrimary,

                  size: ui.iconSize,
                ),
              ),

              SizedBox(
                width: ui.mediumSpacing,
              ),

              // =================================================
              // Doctor Data
              // =================================================
              Expanded(
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,

                  children: [
                    // =============================================
                    // Name + Specialization
                    // =============================================
                    Row(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,

                      children: [
                        Expanded(
                          child: Text(
                            doctor.title ?? '',

                            maxLines: 2,

                            overflow:
                            TextOverflow.ellipsis,

                            style: TextStyle(
                              fontSize:
                              ui.cardTitleSize,

                              fontWeight:
                              FontWeight.w700,

                              color:
                              ColorManager
                                  .medicalPrimary,

                              height: 1.3,
                            ),
                          ),
                        ),

                        if (_hasValue(
                          doctor.spTitle,
                        )) ...[
                          SizedBox(
                            width:
                            ui.smallSpacing,
                          ),

                          Flexible(
                            flex: 0,

                            child: _buildBadge(
                              ui: ui,

                              text:
                              doctor.spTitle!,

                              backgroundColor:
                              ColorManager
                                  .medicalPrimary
                                  .withOpacity(
                                0.08,
                              ),

                              textColor:
                              ColorManager
                                  .medicalPrimary,
                            ),
                          ),
                        ],
                      ],
                    ),

                    // =============================================
                    // Rate
                    // =============================================
                    if (_hasValue(
                      doctor.rate,
                    )) ...[
                      SizedBox(
                        height:
                        ui.smallSpacing,
                      ),

                      Row(
                        mainAxisSize:
                        MainAxisSize.min,

                        children: [
                          Icon(
                            Icons
                                .star_rate_rounded,

                            size:
                            ui.smallIconSize,

                            color:
                            ColorManager
                                .medicalSecondary,
                          ),

                          SizedBox(
                            width:
                            ui.smallSpacing /
                                2,
                          ),

                          Flexible(
                            child: Text(
                              'التصنيف ${doctor.rate}',

                              maxLines: 1,

                              overflow:
                              TextOverflow
                                  .ellipsis,

                              style:
                              TextStyle(
                                fontSize: ui
                                    .smallTextSize,

                                color:
                                const Color(
                                  0xFF7C3AED,
                                ),

                                fontWeight:
                                FontWeight
                                    .w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),

          SizedBox(
            height: ui.sectionSpacing,
          ),

          // =====================================================
          // Place + Address
          // =====================================================
          Row(
            crossAxisAlignment:
            CrossAxisAlignment.start,

            children: [
              Expanded(
                child: _buildInfoTile(
                  ui: ui,

                  icon: Icons
                      .location_on_outlined,

                  text:
                  doctor.place ?? '',
                ),
              ),

              SizedBox(
                width: ui.smallSpacing,
              ),

              Expanded(
                child: _buildInfoTile(
                  ui: ui,

                  icon: Icons.map_outlined,

                  text:
                  doctor.address ?? '',
                ),
              ),
            ],
          ),

          SizedBox(
            height: ui.smallSpacing,
          ),

          // =====================================================
          // Visits
          // =====================================================
          _buildFullInfoTile(
            ui: ui,

            icon:
            Icons.event_available_outlined,

            text:
            'الزيارات: ${doctor.visit ?? '0'}',

            backgroundColor:
            const Color(
              0xFFF0FDF4,
            ),

            iconColor:
            const Color(
              0xFF16A34A,
            ),

            textColor:
            const Color(
              0xFF15803D,
            ),
          ),

          // =====================================================
          // Note
          // =====================================================
          if (_hasValue(
            doctor.note,
          )) ...[
            SizedBox(
              height:
              ui.sectionSpacing,
            ),

            _buildNoteSection(
              ui,
              doctor.note!,
            ),
          ],
        ],
      ),
    );
  }

  // ===========================================================
  // Badge
  // ===========================================================

  Widget _buildBadge({
    required AppUi ui,
    required String text,
    required Color backgroundColor,
    required Color textColor,
  }) {
    return Container(
      constraints: const BoxConstraints(
        maxWidth: 150,
      ),

      padding: EdgeInsets.symmetric(
        horizontal: ui.mediumSpacing,
        vertical: 5,
      ),

      decoration: BoxDecoration(
        color: backgroundColor,

        borderRadius:
        BorderRadius.circular(
          ui.smallRadius,
        ),
      ),

      child: Text(
        text,

        maxLines: 1,

        overflow:
        TextOverflow.ellipsis,

        style: TextStyle(
          fontSize:
          ui.smallTextSize,

          fontWeight:
          FontWeight.w600,

          color: textColor,
        ),
      ),
    );
  }

  // ===========================================================
  // Info Tile
  // ===========================================================

  Widget _buildInfoTile({
    required AppUi ui,
    required IconData icon,
    required String text,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal:
        ui.mediumSpacing,
        vertical: 9,
      ),

      decoration: BoxDecoration(
        color: const Color(
          0xFFF8FAFC,
        ),

        borderRadius:
        BorderRadius.circular(
          ui.smallRadius + 1,
        ),

        border: Border.all(
          color: const Color(
            0xFFE2E8F0,
          ),
        ),
      ),

      child: Row(
        crossAxisAlignment:
        CrossAxisAlignment.start,

        children: [
          Icon(
            icon,

            size:
            ui.smallIconSize,

            color: const Color(
              0xFF94A3B8,
            ),
          ),

          SizedBox(
            width:
            ui.smallSpacing,
          ),

          Expanded(
            child: Text(
              text.trim().isEmpty
                  ? 'غير محدد'
                  : text,

              maxLines: 2,

              overflow:
              TextOverflow
                  .ellipsis,

              style: TextStyle(
                fontSize:
                ui.smallTextSize,

                color: const Color(
                  0xFF475569,
                ),

                fontWeight:
                FontWeight.w500,

                height: 1.35,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ===========================================================
  // Full Info Tile
  // ===========================================================

  Widget _buildFullInfoTile({
    required AppUi ui,
    required IconData icon,
    required String text,
    required Color backgroundColor,
    required Color iconColor,
    required Color textColor,
  }) {
    return Container(
      width: double.infinity,

      padding: EdgeInsets.symmetric(
        horizontal:
        ui.mediumSpacing,
        vertical: 9,
      ),

      decoration: BoxDecoration(
        color: backgroundColor,

        borderRadius:
        BorderRadius.circular(
          ui.smallRadius + 1,
        ),
      ),

      child: Row(
        children: [
          Icon(
            icon,

            size:
            ui.smallIconSize + 1,

            color: iconColor,
          ),

          SizedBox(
            width:
            ui.smallSpacing,
          ),

          Expanded(
            child: Text(
              text,

              maxLines: 1,

              overflow:
              TextOverflow
                  .ellipsis,

              style: TextStyle(
                fontSize:
                ui.bodyTextSize,

                color: textColor,

                fontWeight:
                FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ===========================================================
  // Notes
  // ===========================================================

  Widget _buildNoteSection(
      AppUi ui,
      String note,
      ) {
    return Container(
      width: double.infinity,

      padding: EdgeInsets.all(
        ui.mediumSpacing + 2,
      ),

      decoration: BoxDecoration(
        color: const Color(
          0xFFFFFBEB,
        ),

        borderRadius:
        BorderRadius.circular(
          ui.smallRadius + 3,
        ),

        border: Border.all(
          color: const Color(
            0xFFFEF3C7,
          ),
        ),
      ),

      child: Row(
        crossAxisAlignment:
        CrossAxisAlignment.start,

        children: [
          Icon(
            Icons.info_outline_rounded,

            size:
            ui.smallIconSize + 2,

            color: const Color(
              0xFFD97706,
            ),
          ),

          SizedBox(
            width:
            ui.smallSpacing,
          ),

          Expanded(
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,

              children: [
                Text(
                  'توجيهات وملاحظات',

                  style: TextStyle(
                    fontSize:
                    ui.smallTextSize,

                    fontWeight:
                    FontWeight.w700,

                    color:
                    const Color(
                      0xFFB45309,
                    ),
                  ),
                ),

                SizedBox(
                  height:
                  ui.smallSpacing / 2,
                ),

                Text(
                  note,

                  style: TextStyle(
                    fontSize:
                    ui.bodyTextSize,

                    color:
                    const Color(
                      0xFF451A03,
                    ),

                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ===========================================================
  // Helper
  // ===========================================================

  bool _hasValue(
      String? value,
      ) {
    return value != null &&
        value.trim().isNotEmpty;
  }
}