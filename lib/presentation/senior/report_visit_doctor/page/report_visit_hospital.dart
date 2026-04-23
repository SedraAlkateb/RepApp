import 'package:domina_app/app/user_info.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/resources/values_manager.dart';
import 'package:domina_app/presentation/senior/report_visit_doctor/bloc/report_visit_doctor_bloc.dart';
import 'package:domina_app/presentation/senior/report_visit_doctor/widget/visit_detail_card.dart';
import 'package:domina_app/presentation/senior/report_visit_doctor/widget/who_read_dialog.dart';
import 'package:domina_app/presentation/uniti/search_field.dart';
import 'package:domina_app/presentation/uniti/stateWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReportVisitHospital extends StatelessWidget {
  ReportVisitHospital({
    super.key,
    required this.userId,
    required this.repId,
    required this.indexRep,
    required this.repName,
    required this.repPlan,
    required this.iscanedite,
  });

  final int userId;
  final int repId;
  final String repName;
  final int indexRep;
  final int repPlan;
  final bool iscanedite;

  final TextEditingController searchNoteDoctorController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ReportVisitDoctorBloc>(context).clear();
    return Scaffold(
      appBar: iscanedite == true
          ? AppBar(
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Icon(
                size: AppSize.s30,
                Icons.arrow_back_sharp,
                color: ColorManager.secondaryColor1,
              ),
              onPressed: () {
                BlocProvider.of<ReportVisitDoctorBloc>(context).add(DocNoIsExpandedNoteEvent());
                Navigator.pop(context);
              },
            );
          },
        ),
        title: Text(repName),
      )
          : null,
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20.h),
                        // أنيميشن للهيدر
                        animatedEntry(
                          delay: 0,
                          child: const Text(
                            'تقارير الزيارات للمشافي',
                            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF0F172A)),
                          ),
                        ),
                        animatedEntry(
                          delay: 100,
                          child: const Text(
                            'مراجعة تفاصيل الزيارات للمشافي الميدانية للمندوب',
                            style: TextStyle(fontSize: 14, color: Color(0xFF64748B)),
                          ),
                        ),
                        SizedBox(height: 20.h),
                      ],
                    ),
                  ),
                ),
                BlocConsumer<ReportVisitDoctorBloc, ReportVisitDoctorState>(
                  listener: (context, state) {
                    if (state is AsReadErrorState) {
                      error(context, state.failure.massage, state.failure.code);
                    }
                  },
                  builder: (context, state) {
                    List<RepVisitsModel> doctorNoteModel = context.watch<ReportVisitDoctorBloc>().repVisitsSearch;

                    if (state is AllReportVisitHospitalEmptyState) {
                      return SliverList(delegate: SliverChildListDelegate([const SizedBox(height: 100), emptyFullScreen(context)]));
                    }
                    if (state is SenVisitDoctorAsReadState) doctorNoteModel = state.doctorNoteModel;
                    if (state is AllReportVisitHospitalsState) doctorNoteModel = state.repVisitsModel;

                    // حالات التحميل والخطأ بقيت كما هي
                    if (state is AllReportVisitHospitalLoadingState || state is AllReadLoadingState) {
                      return SliverList(delegate: SliverChildListDelegate([loadingFullScreen(context)]));
                    }
                    if (state is AllReportVisitHospitalErrorState || state is AllReadErrorState) {
                      return SliverList(delegate: SliverChildListDelegate([errorFullScreen(context, func: () {
                        BlocProvider.of<ReportVisitDoctorBloc>(context).add(AllReportVisitHospitalEvent(VisitRepSen(repId, userId), iscanedite));
                      })]));
                    }
                    if (state is AllReadSucState) {
                      BlocProvider.of<ReportVisitDoctorBloc>(context).add(AllReportVisitHospitalEvent(VisitRepSen(repId, userId), iscanedite));
                    }

                    return SliverList(
                      delegate: SliverChildListDelegate([
                        animatedEntry(
                          delay: 200,
                          child: SearchField(
                            searchController: searchNoteDoctorController,
                            onPressed: (value) {
                              BlocProvider.of<ReportVisitDoctorBloc>(context).add(SenSearchNoteVisitHospitalEvent(value));
                            },
                          ),
                        ),
                        animatedEntry(delay: 300, child: buildTotalReportsCard(doctorNoteModel.length)),

                        animatedEntry(
                          delay: 400,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                            child: Row(
                              children: [
                                if (iscanedite) ...[
                                  buildActionBtn(
                                    context: context,
                                    label: 'حجز الكل',
                                    icon: Icons.bookmarks_rounded,
                                    color: const Color(0xFF1E3A8A),
                                    onTap: () {
                                      BlocProvider.of<ReportVisitDoctorBloc>(context).add(AllReadDocNoteEvent(readAll: ReadAll(repPlan, UserInfo.repId, 2, 1)));
                                    },
                                  ),
                                  SizedBox(width: 12.w),
                                  buildActionBtn(
                                    context: context,
                                    label: 'إلغاء حجز الكل',
                                    icon: Icons.bookmark_remove_outlined,
                                    color: const Color(0xFFEF4444),
                                    onTap: () {
                                      BlocProvider.of<ReportVisitDoctorBloc>(context).add(AllReadDocNoteEvent(readAll: ReadAll(repPlan, UserInfo.repId, 2, 0)));
                                    },
                                  ),
                                ]
                              ],
                            ),
                          ),
                        ),

                        // قائمة البطاقات مع أنيميشن متدرج
                        ...doctorNoteModel.asMap().entries.map((entry) {
                          final index = entry.key;
                          final model = entry.value;

                          return animatedEntry(
                            delay: 500 + (index * 100), // كل عنصر يتأخر 100 ملي ثانية عن الذي قبله
                            child: _buildHospitalVisitCard(
                              doctorNoteModel: model,
                              index: index,
                              indexRep: indexRep,
                              iscanedite: iscanedite,
                              context: context,
                            ),
                          );
                        }),
                        SizedBox(height: 100.h),
                      ]),
                    );
                  },
                ),
              ],
            ),
          ),
          stackInputHospital(indexRep: indexRep, iscanedite: iscanedite)
        ],
      ),
    );
  }

  // دالة البطاقة الأصلية بقيت كما هي
  Widget _buildHospitalVisitCard({
    required dynamic doctorNoteModel,
    required int index,
    required int indexRep,
    required bool iscanedite,
    required BuildContext context,
  }) {
    return InkWell(
      onTap: () {
        BlocProvider.of<ReportVisitDoctorBloc>(context).add(DocIsExpandedNoteEvent(doctorNoteModel, index));
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(35.r),
          border: Border(
            right: BorderSide(
              color: doctorNoteModel.flag ? ColorManager.secondaryColor2 : const Color(0xFF1E3A8A),
              width: 8.w,
            ),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.02),
              blurRadius: 10,
              offset: const Offset(0, 5),
            )
          ],
        ),
        padding: EdgeInsets.all(20.w),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    doctorNoteModel.docTitle,
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF1E3A8A),
                    ),
                  ),
                ),
                Row(
                  children: [
                    Text(doctorNoteModel.visitDate, style: const TextStyle(color: Colors.grey, fontSize: 12)),
                    SizedBox(width: 5.w),
                    const Icon(Icons.calendar_month_outlined, size: 16, color: Colors.grey),
                  ],
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(doctorNoteModel.spTitle, style: const TextStyle(color: Color(0xFF3B82F6), fontWeight: FontWeight.bold)),
                    SizedBox(width: 5.w),
                    const Icon(Icons.local_offer_outlined, size: 16, color: Color(0xFF3B82F6)),
                  ],
                ),
                if (iscanedite)
                  BlocBuilder<ReportVisitDoctorBloc, ReportVisitDoctorState>(
                    builder: (context, state) {
                      return Row(
                        children: [
                          buildIconButton(
                            icon: Icons.visibility,
                            onPressed: () {
                              whoReadDialog(context);
                              BlocProvider.of<ReportVisitDoctorBloc>(context).add(WhoAllReadEvent(doctorNoteModel.visitId, "2"));
                            },
                          ),
                          SizedBox(width: 8.w),
                          buildIconButton(
                            icon: Icons.book_outlined,
                            isLoading: state is AsReadLoadingState,
                            onPressed: () {
                              BlocProvider.of<ReportVisitDoctorBloc>(context).add(ChangeReadHosNoteEvent(index: indexRep, indexBook: index, repVisitsModel: doctorNoteModel));
                            },
                          ),
                        ],
                      );
                    },
                  )
              ],
            ),
            SizedBox(height: 15.h),
            Row(
              children: [
                buildSmallInfoBox('الموقع', doctorNoteModel.placeTitle, Icons.location_on_outlined),
                SizedBox(width: 10.w),
                buildSmallInfoBox('التقييم', doctorNoteModel.rate ?? "0.0", Icons.star, isStar: true),
              ],
            ),
            SizedBox(height: 15.h),
            buildDetailBox(
              'ملاحظة المكتب العلمي',
              Text(
                doctorNoteModel.note.isEmpty ? "لا توجد ملاحظات" : doctorNoteModel.note,
                textAlign: TextAlign.right,
                style: const TextStyle(color: Color(0xFF1E3A8A), fontSize: 13),
              ),
            ),
            if (doctorNoteModel.samples.isNotEmpty) ...[
              SizedBox(height: 15.h),
              buildDetailBox(
                'المستحضرات الموزعة',
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: doctorNoteModel.samples.map<Widget>((sample) {
                    return buildBulletItem(sample);
                  }).toList(),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}