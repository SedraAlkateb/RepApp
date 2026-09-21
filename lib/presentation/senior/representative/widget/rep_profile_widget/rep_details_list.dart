import 'package:domina_app/presentation/senior/representative/widget/rep_profile_widget/interactive_action_tile.dart';
import 'package:domina_app/presentation/senior/representative/widget/rep_profile_widget/rep_section_layout.dart';
import 'package:domina_app/app/di/di.dart';
import 'package:domina_app/app/user_info.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/resources/routes_manager.dart';
import 'package:domina_app/presentation/senior/report_visit_doctor/bloc/report_visit_doctor_bloc.dart';
import 'package:domina_app/presentation/senior/report_visit_doctor/page/report_visit_doctor.dart';
import 'package:domina_app/presentation/senior/report_visit_doctor/page/report_visit_hospital.dart';
import 'package:domina_app/presentation/senior/representative/bloc/senior_prof_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


// =====================================================
// Detailed Reports
//
// فقط Full Profile
// =====================================================

Widget buildDetailsList(
    BuildContext context,
    InfoRep rep,
    String name,
    int plan,
    String phone, {
  required int id,
}) {
  return buildSectionLayout(
    context,
    "التقارير التفصيلية",
    [
      InteractiveActionTile(
        title:
        "سجل الوصفات الطبية",

        icon:
        FontAwesomeIcons
            .receipt,

        color:
        const Color(
          0xFF7C3AED,
        ),

        onTap: () {
          Navigator.pushNamed(
            context,
            Routes.allRecipe,
          );

          context
              .read<
              SeniorProfBloc>()
              .add(
            AllReciEvent(
              id,
            ),
          );
        },
      ),

      // =================================================
      // Active Plan
      // =================================================
      InteractiveActionTile(
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
            plan,
          );
        },
      ),
    ],
  );
}

Widget buildDetailsListRep(
    BuildContext context,
    InfoRep rep,
    String name,
    int plan,
    String phone, {
  required int id,
  required int index,
}) {
  return buildSectionLayout(
    context,
    "التقارير التفصيلية",
    [
      // =================================================
      // Doctor Visit Reports
      // =================================================
      InteractiveActionTile(
        title:
        "تقرير زيارات الأطباء",

        icon:
        FontAwesomeIcons
            .fileMedical,

        color:
        const Color(
          0xFF1F4E79,
        ),

        onTap: () {
          initReportVisitDoctorModule();

          Navigator.push(
            context,

            MaterialPageRoute(
              builder:
                  (routeContext) =>
                  ReportVisitDoctorPage(
                    iscanedite:
                    true,

                    repId:
                    id,

                    userId:
                    UserInfo.repId,

                    repName:
                    name,

                    phone:
                    phone,

                    indexRep:
                    index,

                    repPlan:
                    plan,
                  ),
            ),
          );

          // =============================================
          // نفس ترتيب المنطق الأصلي
          // =============================================
          context
              .read<
              ReportVisitDoctorBloc>()
              .add(
            AllReportVisitDoctorEvent(
              VisitRepSen(
                id,
                UserInfo.repId,
              ),
              false,
            ),
          );
        },
      ),

      // =================================================
      // Hospital Visit Reports
      // =================================================
      InteractiveActionTile(
        title:
        "تقرير زيارات المشافي",

        icon:
        FontAwesomeIcons
            .hospitalUser,

        color:
        const Color(
          0xFF1F4E79,
        ),

        onTap: () {
          initReportVisitDoctorModule();

          Navigator.push(
            context,

            MaterialPageRoute(
              builder:
                  (routeContext) =>
                  ReportVisitHospital(
                    iscanedite:
                    true,

                    repId:
                    id,

                    userId:
                    UserInfo.repId,

                    repName:
                    name,

                    phone:
                    phone,

                    indexRep:
                    index,

                    repPlan:
                    plan,
                  ),
            ),
          );

          // =============================================
          // نفس ترتيب المنطق الأصلي
          // =============================================
          context
              .read<
              ReportVisitDoctorBloc>()
              .add(
            AllReportVisitHospitalEvent(
              VisitRepSen(
                id,
                UserInfo.repId,
              ),
              false,
            ),
          );
        },
      ),

      // =================================================
      // Recipes
      // =================================================
      InteractiveActionTile(
        title:
        "سجل الوصفات الطبية",

        icon:
        FontAwesomeIcons
            .receipt,

        color:
        const Color(
          0xFF7C3AED,
        ),

        onTap: () {
          Navigator.pushNamed(
            context,
            Routes.allRecipe,
          );

          context
              .read<
              SeniorProfBloc>()
              .add(
            AllReciEvent(
              id,
            ),
          );
        },
      ),

      // =================================================
      // Active Plan
      // =================================================
      InteractiveActionTile(
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
            plan,
          );
        },
      ),
    ],
  );
}
