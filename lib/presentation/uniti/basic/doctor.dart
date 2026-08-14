// presentation/doctors/widget/doctor_card_item.dart

import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/Recipes/widget/doctor_recipe.dart';
import 'package:domina_app/presentation/plase_visit/widget/build_card_buttom.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/resources/responsive/app_ui.dart';
import 'package:domina_app/presentation/resources/routes_manager.dart';
import 'package:flutter/material.dart';

class DoctorCardItem extends StatelessWidget {
  const DoctorCardItem({
    super.key,
    required this.doctor,
  });

  final DoctorModel doctor;

  @override
  Widget build(BuildContext context) {
    final ui = AppUi.of(context);

    return Align(
      alignment: Alignment.topCenter,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: ui.pageMaxWidth,
        ),
        child: Container(
          width: double.infinity,
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
              // =================================================
              // Header
              // =================================================
              Row(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  // =============================================
                  // Specialization
                  // =============================================
                  if (doctor.spTitle
                      .trim()
                      .isNotEmpty) ...[
                    Flexible(
                      flex: 0,
                      child: Container(
                        padding:
                        EdgeInsets.symmetric(
                          horizontal:
                          ui.mediumSpacing,
                          vertical: 5,
                        ),
                        decoration:
                        BoxDecoration(
                          color: ColorManager
                              .medicalPrimary
                              .withOpacity(
                            0.08,
                          ),
                          borderRadius:
                          BorderRadius.circular(
                            ui.smallRadius,
                          ),
                        ),
                        child: Text(
                          doctor.spTitle,
                          maxLines: 1,
                          overflow:
                          TextOverflow.ellipsis,
                          style: TextStyle(
                            color: ColorManager
                                .medicalPrimary,
                            fontSize:
                            ui.smallTextSize,
                            fontWeight:
                            FontWeight.w600,
                          ),
                        ),
                      ),
                    ),

                    SizedBox(
                      width:
                      ui.mediumSpacing,
                    ),
                  ],

                  // =============================================
                  // Doctor Name
                  // =============================================
                  Expanded(
                    child: Text(
                      doctor.title,
                      textAlign:
                      TextAlign.end,
                      maxLines: 2,
                      overflow:
                      TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize:
                        ui.cardTitleSize,
                        fontWeight:
                        FontWeight.w700,
                        color: ColorManager
                            .medicalPrimary,
                        height: 1.35,
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(
                height:
                ui.mediumSpacing,
              ),

              // =================================================
              // Information
              // =================================================
              _buildInfoRow(
                ui: ui,
                icon:
                Icons.location_on_outlined,
                text:
                doctor.placeTitle,
              ),

              _buildInfoRow(
                ui: ui,
                icon:
                Icons.map_outlined,
                text:
                doctor.address,
              ),

              _buildInfoRow(
                ui: ui,
                icon:
                Icons.star_rate_outlined,
                text:
                doctor.rate ?? '',
                iconColor:
                ColorManager.medicalSecondary,
              ),

              SizedBox(
                height:
                ui.mediumSpacing,
              ),

              const Divider(
                height: 1,
                thickness: 1,
                color: Color(
                  0xFFE9EEF3,
                ),
              ),

              SizedBox(
                height:
                ui.mediumSpacing,
              ),

              // =================================================
              // Actions
              // =================================================
              Row(
                mainAxisAlignment:MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child:
                    PrescriptionMenuWidget(
                      doctorId:
                      doctor.id,
                    ),
                  ),

                  const Spacer(),

                  InkWell(
                    borderRadius:
                    BorderRadius.circular(
                      ui.smallRadius,
                    ),
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        Routes.doctorDetails,
                        arguments: doctor,
                      );
                    },
                    child: buildCardButton(
                      context,
                      'عرض التفاصيل',
                      ColorManager
                          .medicalPrimary,
                      Colors.white,
                      Icons.directions_run,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ===========================================================
  // Information Row
  // ===========================================================

  Widget _buildInfoRow({
    required AppUi ui,
    required IconData icon,
    required String text,
    Color iconColor =
    const Color(0xFF94A3B8),
  }) {
    final value = text.trim();

    if (value.isEmpty) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: EdgeInsets.symmetric(
        vertical:
        ui.smallSpacing / 2,
      ),
      child: Row(
        crossAxisAlignment:
        CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            size:
            ui.smallIconSize + 2,
            color: iconColor,
          ),

          SizedBox(
            width:
            ui.smallSpacing,
          ),

          Expanded(
            child: Text(
              value,
              maxLines: 3,
              overflow:
              TextOverflow.ellipsis,
              style: TextStyle(
                color: const Color(
                  0xFF475569,
                ),
                fontSize:
                ui.bodyTextSize,
                fontWeight:
                FontWeight.w500,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}