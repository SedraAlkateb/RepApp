import 'package:domina_app/presentation/senior/representative/widget/rep_profile_widget/rep_section_layout.dart';
import 'package:domina_app/presentation/resources/responsive/app_ui.dart';
import 'package:domina_app/presentation/resources/routes_manager.dart';
import 'package:domina_app/presentation/senior/representative/bloc/senior_prof_bloc.dart';
import 'package:domina_app/presentation/senior/representative/widget/rep_profile_widget/build_stats_grid_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


// =====================================================
// Quick Actions
// =====================================================

Widget buildQuickActions(
    BuildContext context, {
  required int id,
  required int repPlanId,
}) {
  final ui =
  AppUi.of(context);

  return Column(
    crossAxisAlignment:
    CrossAxisAlignment.start,

    children: [
      buildSectionTitle(
        context,
        title:
        "معلومات شخصية",
      ),

      SizedBox(
        height:
        ui.sectionSpacing,
      ),

      Container(
        width:
        double.infinity,

        padding:
        EdgeInsets.all(
          ui.cardPadding,
        ),

        decoration:
        BoxDecoration(
          color:
          Colors.white,

          borderRadius:
          BorderRadius.circular(
            ui.cardRadius,
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

        child: Wrap(
          alignment:
          WrapAlignment
              .spaceAround,

          runAlignment:
          WrapAlignment.center,

          spacing:
          ui.sectionSpacingMobileZero,

          runSpacing:
          ui.sectionSpacingMobileZero,

          children: [
            // ===============================================
            // Specializations
            // ===============================================
            buildIconBtn(
              context,
              FontAwesomeIcons.tag,
              "الإختصاص",
              const Color(
                0xFFFF9F43,
              ),
                  () {
                context
                    .read<
                    SeniorProfBloc>()
                    .add(
                  SenAllSpecEvent(
                    id,
                  ),
                );

                Navigator.pushNamed(
                  context,
                  Routes.seniorSpec,
                    arguments: false
                );
              },
            ),

            // ===============================================
            // Places
            // ===============================================
            buildIconBtn(
              context,
              FontAwesomeIcons
                  .locationDot,
              "المناطق",
              const Color(
                0xFF45AAF2,
              ),
                  () {
                context
                    .read<
                    SeniorProfBloc>()
                    .add(
                  SenAllPlaceEvent(
                    id,
                  ),
                );

                Navigator.pushNamed(
                  context,
                  Routes.seniorPlaces,
                    arguments: false
                );
              },
            ),

            // ===============================================
            // Doctors
            // ===============================================
            buildIconBtn(
              context,
              FontAwesomeIcons
                  .userDoctor,
              "الأطباء",
              const Color(
                0xFFEB4D4B,
              ),
                  () {
                context
                    .read<
                    SeniorProfBloc>()
                    .add(
                  SenAllDoctorEvent(
                    id,
                  ),
                );

                Navigator.pushNamed(
                  context,
                  Routes.seniorDoc,
                );
              },
            ),

            // ===============================================
            // Hospitals
            // ===============================================
            buildIconBtn(
              context,
              FontAwesomeIcons
                  .hospitalUser,
              "المشافي",
              const Color(
                0xFFE3D909,
              ),
                  () {
                context
                    .read<
                    SeniorProfBloc>()
                    .add(
                  SenAllHospitalEvent(
                    id,
                  ),
                );

                Navigator.pushNamed(
                  context,
                  Routes.seniorHos,
                );
              },
            ),

            // ===============================================
            // Brands
            // ===============================================
            buildIconBtn(
              context,
              FontAwesomeIcons
                  .hospital,
              "الأصناف",
              const Color(
                0xFF26DE81,
              ),
                  () {
                context
                    .read<
                    SeniorProfBloc>()
                    .add(
                  SenAllBrandEvent(
                    repPlanId,false
                  ),
                );

                Navigator.pushNamed(
                  context,
                  Routes.allBrand,
                  arguments: false
                );
              },
            ),
          ],
        ),
      ),
    ],
  );
}
