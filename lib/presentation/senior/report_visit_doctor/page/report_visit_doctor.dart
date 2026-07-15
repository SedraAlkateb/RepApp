import 'package:domina_app/app/user_info.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/resources/values_manager.dart';
import 'package:domina_app/presentation/senior/report_visit_doctor/bloc/report_visit_doctor_bloc.dart';
import 'package:domina_app/presentation/senior/report_visit_doctor/widget/visit_detail_card.dart';
import 'package:domina_app/presentation/senior/report_visit_doctor/widget/who_read_dialog.dart';
import 'package:domina_app/presentation/uniti/search_field.dart';
import 'package:domina_app/presentation/uniti/share_watsapp.dart';
import 'package:domina_app/presentation/uniti/stateWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class ReportVisitDoctorPage extends StatelessWidget {
  ReportVisitDoctorPage({
    super.key,
    required this.userId,
    required this.repId,
    required this.repName,
    required this.phone,

    required this.indexRep,
    required this.repPlan,
    required this.iscanedite,
  });
  final int userId;
  final int repId;
  final String repName;
  final String phone;
  final int indexRep;
  final int repPlan;
  final bool iscanedite;

  final TextEditingController searchNoteDoctorController =
  TextEditingController();
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
                BlocProvider.of<ReportVisitDoctorBloc>(context)
                    .add(DocNoIsExpandedNoteEvent());
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
                         Text(
                          'تقارير الزيارات للأطباء',
                          style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold, color: Color(0xFF0F172A)),
                        ),
                         Text(
                          'مراجعة تفاصيل الزيارات للأطباء الميدانية للمندوب',
                          style: TextStyle(fontSize: 14.sp, color: Color(0xFF64748B)),
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
                    List<RepVisitsModel> doctorNoteModel =
                        context.watch<ReportVisitDoctorBloc>().repVisitsSearch;
                    if (state is AllReportVisitDoctorEmptyState) {
                      return SliverList(
                          delegate: SliverChildListDelegate([
                            const SizedBox(
                              height: 100,
                            ),
                            emptyFullScreen(context)
                          ]));
                    }
                    if (state is SenVisitDoctorAsReadState) {
                      doctorNoteModel = state.doctorNoteModel;
                    }
                    if (state is AllReportVisitDoctorsState) {
                      doctorNoteModel = state.repVisitsModel;
                    }
                    if (state is AllReportVisitDoctorLoadingState) {
                      return SliverList(
                        delegate: SliverChildListDelegate(
                            [loadingFullScreen(context)]),
                      );
                    }
                    if (state is AllReadLoadingState) {
                      return SliverList(
                        delegate: SliverChildListDelegate(
                            [loadingFullScreen(context)]),
                      );
                    }
                    if (state is AllReadSucState) {
                      BlocProvider.of<ReportVisitDoctorBloc>(context).add(
                          AllReportVisitDoctorEvent(
                              VisitRepSen(repId, UserInfo.repId),iscanedite));
                    }
                    if (state is AllReportVisitDoctorErrorState) {
                      return SliverList(
                        delegate: SliverChildListDelegate([
                          errorFullScreen(context, func: () {
                            BlocProvider.of<ReportVisitDoctorBloc>(context).add(
                                AllReportVisitDoctorEvent(
                                    VisitRepSen(repId, userId),iscanedite));
                          })
                        ]),
                      );
                    }
                    if (state is AllReadErrorState) {
                      return SliverList(
                        delegate: SliverChildListDelegate([
                          errorFullScreen(context, func: () {
                            BlocProvider.of<ReportVisitDoctorBloc>(context).add(
                                AllReportVisitDoctorEvent(
                                    VisitRepSen(repId, userId),iscanedite));
                          })
                        ]),
                      );
                    }
                    return SliverList(

                      delegate: SliverChildListDelegate([
                        SearchField(
                          searchController: searchNoteDoctorController,
                          onPressed: (value) {
                            BlocProvider.of<ReportVisitDoctorBloc>(context)
                                .add(SenSearchNoteVisitDoctorEvent(value));
                          },
                        ),
                    SizedBox(height: 20.h),
                        buildTotalReportsCard(doctorNoteModel.length),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start, // محاذاة لليسار في الواجهة العربية
                            children: [
                              if (iscanedite) ...[



                                // زر قراءة الكل
                                buildActionBtn(
                                  context: context,
                                  label: 'قراءة الكل',
                                  icon: Icons.bookmarks_rounded,
                                  color: const Color(0xFF1E3A8A), // اللون الأزرق الأساسي
                                  onTap: () {
                                    BlocProvider.of<ReportVisitDoctorBloc>(context).add(
                                        AllReadDocNoteEvent(
                                            readAll: ReadAll(repPlan, UserInfo.repId, 1, 1)));
                                  },
                                ),
                                SizedBox(width: 12.w),
                                // زر إلغاء قراءة الكل
                                buildActionBtn(
                                  context: context,
                                  label: 'إلغاء قراءة الكل',
                                  icon: Icons.bookmark_remove_outlined,
                                  color: const Color(0xFFEF4444), // لون أحمر هادئ للإلغاء
                                  onTap: () {
                                    BlocProvider.of<ReportVisitDoctorBloc>(context).add(
                                        AllReadDocNoteEvent(
                                            readAll: ReadAll(repPlan, UserInfo.repId, 1, 0)));
                                  },
                                ),
                              ]
                            ],
                          ),
                        ),
                        ...doctorNoteModel.asMap().entries.map((entry) {
                          final index = entry.key;
                          final doctorNoteModel = entry.value;
                          return _buildDoctorVisitCard(doctorNoteModel: doctorNoteModel, index: index, indexRep: indexRep, iscanedite: iscanedite, context: context);

                        }),
                      ]),
                    );
                  },
                ),
              ],
            ),
          ),
          stackInputDoctor(indexRep: indexRep, iscanedite: iscanedite)
        ],
      ),
    );
  }

// ملاحظة: استبدل doctorNoteModel بـ repVisitsModel حسب تسمية المتغير عندك
  Widget _buildDoctorVisitCard({
    required dynamic doctorNoteModel,
    required int index,
    required int indexRep,
    required bool iscanedite,
    required BuildContext context,
  }) {
    return InkWell(
      onTap: () {
        BlocProvider.of<ReportVisitDoctorBloc>(context)
            .add(DocIsExpandedNoteEvent(doctorNoteModel, index));
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(35.r),
          border: Border(
            // الخط الجانبي يتغير لونه بناءً على الـ flag (مقروء أو غير مقروء)
            right: BorderSide(
              color: doctorNoteModel.flag ? ColorManager.secondaryColor2 : ColorManager.primary1,
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
            // السطر الأول: التاريخ واسم الطبيب
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
                    Text(doctorNoteModel.visitDate, style: const TextStyle(color: Colors.grey)),
                    SizedBox(width: 5.w),
                    const Icon(Icons.calendar_month_outlined, size: 16, color: Colors.grey),
                  ],
                ),

              ],
            ),

            // السطر الثاني: أيقونات التحكم والتخصص
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      doctorNoteModel.spTitle,
                      style: const TextStyle(color: Color(0xFF3B82F6), fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 5.w),
                    const Icon(Icons.local_offer_outlined, size: 16, color: Color(0xFF3B82F6)),
                  ],
                ),
                // قسم أزرار التحكم (العين والكتاب)
                if (iscanedite)
                  BlocBuilder<ReportVisitDoctorBloc, ReportVisitDoctorState>(
                    builder: (context, state) {
                      return Row(
                        children: [
                          buildIconWatsAppButton(

                            onPressed: () {
                              shareReportToWhatsApp(
                                context: context,
                                doctorName: doctorNoteModel.docTitle,
                                specialty: doctorNoteModel.spTitle,
                                scientificOfficeNote: doctorNoteModel.note,
                                visitDate: doctorNoteModel.visitDate,

                                phoneNumber: phone, // رقم الجوال من قاعدة البيانات
                                repName: repName,
                              );
                            },
                          ),
                          SizedBox(width: 8.w),
                          buildIconButton(
                            false,
                            icon: Icons.visibility,
                            onPressed: () {
                              // دالة من يقرأ
                              whoReadDialog(context,BlocProvider.of<ReportVisitDoctorBloc>(context));
                              BlocProvider.of<ReportVisitDoctorBloc>(context)
                                  .add(WhoAllReadEvent(doctorNoteModel.visitId, "2"));
                            },
                          ),
                          SizedBox(width: 8.w),

                          buildIconButton(
                            doctorNoteModel.flag,
                            icon: Icons.book_outlined,
                            isLoading: state is AsReadLoadingState,
                            onPressed: () {
                              BlocProvider.of<ReportVisitDoctorBloc>(context).add(
                                ChangeReadDocNoteEvent(
                                  repVisitsModel: doctorNoteModel,
                                  index: indexRep,
                                  indexBook: index,
                                ),
                              );
                            },
                          ),
                        ],
                      );
                    },
                  )
                else
                  const SizedBox(), // فراغ إذا لم يكن مسموح التعديل


              ],
            ),

            SizedBox(height: 15.h),

            // الموقع والتقييم
            Row(
              children: [
                buildSmallInfoBox('الموقع', doctorNoteModel.placeTitle, Icons.location_on_outlined),
                SizedBox(width: 10.w),
                buildSmallInfoBox('التقييم', doctorNoteModel.rate, Icons.star, isStar: true),
              ],
            ),

            SizedBox(height: 15.h),

            // ملاحظة المكتب العلمي
            buildDetailBox(
              'ملاحظة المكتب العلمي',
              Text(
                doctorNoteModel.note.isEmpty ? "لا توجد" : doctorNoteModel.note,
                textAlign: TextAlign.right,
                style: const TextStyle(color: Color(0xFF1E3A8A)),
              ),
            ),

            if (doctorNoteModel.samples.isNotEmpty) ...[
              SizedBox(height: 15.h),
              // الأصناف الموزعة (المستحضرات)
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

