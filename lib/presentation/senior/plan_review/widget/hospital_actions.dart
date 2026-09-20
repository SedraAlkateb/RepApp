// =====================================================
import 'package:domina_app/app/user_info.dart';
import 'package:domina_app/presentation/senior/report_visit_doctor/bloc/report_visit_doctor_bloc.dart';
import 'package:domina_app/presentation/senior/report_visit_doctor/widget/visit_detail_card.dart';
import 'package:domina_app/presentation/senior/report_visit_doctor/widget/who_read_dialog.dart';
import 'package:domina_app/presentation/uniti/share_watsapp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


Widget buildHospitalActions({
  required BuildContext context,
  required dynamic doctorNoteModel,
  required int index,
  required int indexRep,
  required String phone,
  required String repName,

}) {
  return BlocBuilder<
      ReportVisitDoctorBloc,
      ReportVisitDoctorState>(
    builder:
        (context, state) {
      return Row(
        mainAxisSize:
        MainAxisSize.min,
        children: [
          // =============================================
          // WhatsApp
          // =============================================
          buildIconWatsAppButton(
            onPressed: () {
              shareReportToWhatsApp(
                context:
                context,

                doctorName:
                doctorNoteModel
                    .docTitle,

                specialty:
                doctorNoteModel
                    .spTitle,

                scientificOfficeNote:
                doctorNoteModel
                    .note,

                visitDate:
                doctorNoteModel
                    .visitDate,

                phoneNumber:
              phone,

                repName:
                repName,
              );
            },
          ),

          const SizedBox(
            width: 8,
          ),

          // =============================================
          // Who Read
          // =============================================
          buildIconButton(
            false,
            icon:
            Icons.visibility,
            onPressed: () {
              whoReadDialog(
                context,
                BlocProvider.of<
                    ReportVisitDoctorBloc>(
                  context,
                ),
              );

              BlocProvider.of<
                  ReportVisitDoctorBloc>(
                context,
              ).add(
                WhoAllReadEvent(
                  doctorNoteModel
                      .visitId,

                  // Hospital
                  "1",

                  UserInfo
                      .repType
                      .i,
                ),
              );
            },
          ),

          const SizedBox(
            width: 8,
          ),

          // =============================================
          // Read / Unread
          // =============================================
          buildIconButton(
            doctorNoteModel.flag,
            icon:
            Icons.book_outlined,
            isLoading:
            state
            is AsReadLoadingState,
            onPressed: () {
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
            },
          ),
        ],
      );
    },
  );
}