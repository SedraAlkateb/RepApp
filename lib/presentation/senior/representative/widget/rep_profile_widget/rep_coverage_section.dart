import 'package:domina_app/presentation/senior/representative/widget/rep_profile_widget/interactive_action_tile.dart';
import 'package:domina_app/presentation/senior/representative/widget/rep_profile_widget/rep_section_layout.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/resources/routes_manager.dart';
import 'package:domina_app/presentation/senior/report_Inventory/bloc/report_inventory_bloc.dart';
import 'package:domina_app/presentation/senior/representative/bloc/senior_prof_bloc.dart';
import 'package:domina_app/presentation/senior/representative/page/no_visit_doctor.dart';
import 'package:domina_app/presentation/senior/representative/page/no_visit_hos.dart';
import 'package:domina_app/presentation/senior/representative/page/remaining_visits.dart';
import 'package:domina_app/presentation/senior/representative/page/remaining_visits_hos.dart';
import 'package:domina_app/presentation/senior/representative/page/sen_visit_doctor.dart';
import 'package:domina_app/presentation/senior/representative/page/sen_visit_hospital.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


// =====================================================
// Coverage Router
// =====================================================

Widget buildCoverageSection(
    BuildContext context
,InfoRep rep, {
  required bool isFinal,
  required int id,
  required int repPlanId,
}) {
  if((isFinal)&&(rep.repType!=5&&rep.repType!=6) ){
    return buildFullCoverageSection(id: id, repPlanId: repPlanId, 
      context,
    );
  }else if((isFinal)&&(rep.repType==5||rep.repType==6)){
    return   InteractiveActionTile(
      title:
      "الخطة الشهرية الفعالة",

      icon:
      FontAwesomeIcons
          .calendarCheck,

      color:
      const Color(
        0xFF2D947A,
      ),

      onTap: () {
        Navigator.pushNamed(
          context,
          Routes.activePlanPage,

          arguments:
          rep.repPlanId,
        );
      },
    );
  }
if(!isFinal&&(rep.repType==5||rep.repType==6)){
return SizedBox();
}
  return buildFullCoverageSection(id: id, repPlanId: repPlanId, 
    context,
  );
}


// =====================================================
// Full Profile Coverage
//
// Doctor + Hospital
// =====================================================

Widget buildFullCoverageSection(
    BuildContext context, {
  required int id,
  required int repPlanId,
}) {
  return buildSectionLayout(
    context,
    "إحصائيات التغطية",
    [
      // =================================================
      // Completed Visits
      // =================================================
      InteractiveActionTile(
        title:
        "الزيارات التي تمت",

        icon:
        Icons
            .check_circle_outline,

        color:
        const Color(
          0xFF2D947A,
        ),

        onTap: () {
          context
              .read<
              SeniorProfBloc>()
              .add(
            VisitDocEvent(
              id,
              repPlanId,
            ),
          );

          Navigator.pushNamed(
            context,
            Routes.senVisit,

            arguments: {
              'onTapDoctor': () {
                context
                    .read<
                    SeniorProfBloc>()
                    .add(
                  VisitDocEvent(
                    id,
                    repPlanId,
                  ),
                );
              },

              'onTapHospital': () {
                context
                    .read<
                    SeniorProfBloc>()
                    .add(
                  VisitHosEvent(
                    id,
                    repPlanId,
                  ),
                );
              },

              'title':
              "الزيارات التي تمت",

              'doctor':
              SenVisitDoctor(),

              'hospital':
              SenVisitHospital(),
            },
          );
        },
      ),

      // =================================================
      // Not Visited
      // =================================================
      InteractiveActionTile(
        title:
        "الزيارات التي لم تتم بعد",

        icon:
        Icons.cancel_outlined,

        color:
        const Color(
          0xFFE74C3C,
        ),

        onTap: () {
          context
              .read<
              SeniorProfBloc>()
              .add(
            NoVisitDocEvent(
              id,
              repPlanId,
            ),
          );

          Navigator.pushNamed(
            context,
            Routes.senVisit,

            arguments: {
              'onTapDoctor': () {
                context
                    .read<
                    SeniorProfBloc>()
                    .add(
                  NoVisitDocEvent(
                    id,
                    repPlanId,
                  ),
                );
              },

              'onTapHospital': () {
                context
                    .read<
                    SeniorProfBloc>()
                    .add(
                  NoVisitHosEvent(
                    id,
                    repPlanId,
                  ),
                );
              },

              'title':
              "الزيارات التي لم تتم بعد",

              'doctor':
              NoVisitDoctor(),

              'hospital':
              NoVisitHos(),
            },
          );
        },
      ),

      // =================================================
      // Remaining
      // =================================================
      InteractiveActionTile(
        title:
        "الزيارات التي تمت ولم تكتمل",

        icon:
        Icons
            .hourglass_empty_rounded,

        color:
        const Color(
          0xFFF39C12,
        ),

        onTap: () {
          context
              .read<
              SeniorProfBloc>()
              .add(
            RemainingVisitsDocEvent(
              id,
              repPlanId,
            ),
          );

          Navigator.pushNamed(
            context,
            Routes.senVisit,

            arguments: {
              'onTapDoctor': () {
                context
                    .read<
                    SeniorProfBloc>()
                    .add(
                  RemainingVisitsDocEvent(
                    id,
                    repPlanId,
                  ),
                );
              },

              'onTapHospital': () {
                context
                    .read<
                    SeniorProfBloc>()
                    .add(
                  RemainingVisitsHosEvent(
                    id,
                    repPlanId,
                  ),
                );
              },

              'title':
              "الزيارات التي تمت ولم تكتمل",

              'doctor':
              RemainingVisits(),

              'hospital':
              RemainingVisitsHos(),
            },
          );
        },
      ),

      // =================================================
      // Inventory
      // =================================================
      buildInventoryAction(id: id, repPlanId: repPlanId, 
        context,
      ),
    ],
  );
}


// =====================================================
// Inventory
//
// مشترك بين الملف الكامل والخطة المنتهية
// =====================================================

Widget buildInventoryAction(
    BuildContext context, {
  required int id,
  required int repPlanId,
}) {
  return InteractiveActionTile(
    title:
    "تقرير توزيع العينات (الجرد)",

    icon:
    FontAwesomeIcons
        .clipboardList,

    color:
    const Color(
      0xFF1F4E79,
    ),

    onTap: () {

      Navigator.pushNamed(
        context,
          Routes.inventory
      );

      context
          .read<
          ReportInventoryBloc>()
          .add(
        SenAllInventoryEvent(
          id,
          repPlanId,
        ),
      );
    },
  );
}
