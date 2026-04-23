import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/resources/values_manager.dart';
import 'package:domina_app/presentation/senior/report_visit_doctor/bloc/report_visit_doctor_bloc.dart';
import 'package:domina_app/presentation/senior/report_visit_doctor/widget/text_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
Widget stackInputDoctor({required int indexRep, required bool iscanedite}){
  return  BlocBuilder<ReportVisitDoctorBloc, ReportVisitDoctorState>(
    builder: (context, state) {
      bool num = BlocProvider.of<ReportVisitDoctorBloc>(context).num;
      bool isExpanded =
          BlocProvider.of<ReportVisitDoctorBloc>(context).isExpanded;
      RepVisitsModel doctorNoteModel =
          BlocProvider.of<ReportVisitDoctorBloc>(context)
              .doctorNoteModel;
      int index = BlocProvider.of<ReportVisitDoctorBloc>(context).index;

      if (state is DocIsExpandedNoteState) {
        isExpanded = true;
        index = state.index;
        doctorNoteModel = state.doctorNoteModel;
      }
      if (state is DocNoIsExpandedNoteState) {
        isExpanded = false;
      }
      return Stack(
        children: [
          if (isExpanded)
            GestureDetector(
              onTap: () {
                BlocProvider.of<ReportVisitDoctorBloc>(context)
                    .add(DocNoIsExpandedNoteEvent());
              },
              child: ModalBarrier(
                color: Colors.black.withOpacity(0.5),
                dismissible: true,
              ),
            ),
          isExpanded
              ? DraggableScrollableSheet(
            initialChildSize: 0.4,
            minChildSize: 0.1,
            maxChildSize: 1,
            builder: (context, scrollController) {
              return NotificationListener<
                  DraggableScrollableNotification>(
                onNotification: (notification) {
                  if (notification.extent == 1) {
                    BlocProvider.of<ReportVisitDoctorBloc>(
                        context)
                        .add(ExpandedBorder(true));
                  } else if (BlocProvider.of<
                      ReportVisitDoctorBloc>(context)
                      .num ==
                      true) {
                    BlocProvider.of<ReportVisitDoctorBloc>(
                        context)
                        .add(ExpandedBorder(false));
                  } else if (notification.extent <= 0.1) {
                    BlocProvider.of<ReportVisitDoctorBloc>(
                        context)
                        .add(DocNoIsExpandedNoteEvent());
                  }
                  // else {
                  //   BlocProvider.of<ReportVisitDoctorBloc>(context).add(ExpandedBorder(1));
                  // }
                  return true;
                },
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: ColorManager.secondaryColor3),
                    color: ColorManager.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(
                          ((num == true)) ? 0 : AppSize.s40),
                      topRight: Radius.circular(
                          ((num == true)) ? 0 : AppSize.s40),
                    ),
                  ),
                  child: SingleChildScrollView(
                    controller: scrollController,
                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: [
                        num == false
                            ? Center(
                          child: InkWell(
                            onTap: () {
                              BlocProvider.of<
                                  ReportVisitDoctorBloc>(
                                  context)
                                  .add(
                                  DocNoIsExpandedNoteEvent());
                            },
                            child: Container(
                              margin:
                              const EdgeInsets.all(16),
                              padding:  EdgeInsets
                                  .symmetric(
                                  vertical: AppPaddingH.p8),
                              child: Column(
                                children: List.generate(
                                  2,
                                      (index) => Container(
                                    width: 60,
                                    height: 3,
                                    margin: const EdgeInsets
                                        .symmetric(
                                        vertical: 3),
                                    decoration:
                                    BoxDecoration(
                                      color: ColorManager
                                          .secondaryColor1,
                                      borderRadius:
                                      BorderRadius
                                          .circular(2),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                            : const SizedBox(),
                        Padding(
                          padding:  EdgeInsets.all(
                              AppPaddingH.p20),
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.center,
                            children: [
                              const SizedBox(height: 20),
                              TextInfo(
                                title: "اسم الدكتور",
                                supTitle:
                                doctorNoteModel.docTitle,
                              ),
                              TextInfo(
                                title: "العنوان",
                                supTitle:
                                doctorNoteModel.placeTitle,
                              ),
                              TextInfo(
                                title: "الاختصاص",
                                supTitle: doctorNoteModel.spTitle,
                              ),
                              TextInfo(
                                title: "التقييم",
                                supTitle: doctorNoteModel.rate,
                              ),
                              TextInfo(
                                title: "التاريخ",
                                supTitle:
                                doctorNoteModel.visitDate,
                              ),
                              TextInfo(
                                title: "الأهداف",
                                supTitle: doctorNoteModel.target,
                              ),
                              TextInfo(
                                title: "ملاحظات المكتب العلمي",
                                supTitle: doctorNoteModel.note,
                              ),
                              TextInfo(
                                title: "ملاحظات إضافية",
                                supTitle: doctorNoteModel.special,
                              ),
                              TextInfo(
                                title: "ملاحظات مستودع قاسيون",
                                supTitle: doctorNoteModel.issue,
                              ),
                              doctorNoteModel.samples.isNotEmpty
                                  ? Column(
                                crossAxisAlignment:
                                CrossAxisAlignment
                                    .start,
                                children: [
                                  Text(
                                    "المستحضرات: ",
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelLarge,
                                    textAlign:
                                    TextAlign.center,
                                  ),
                                  const SizedBox(height: 8),
                                  ListView.builder(
                                    shrinkWrap: true,
                                    physics:
                                    const NeverScrollableScrollPhysics(),
                                    itemCount:
                                    doctorNoteModel
                                        .samples.length,
                                    itemBuilder:
                                        (context, index) {
                                      return Padding(
                                        padding:
                                        const EdgeInsets
                                            .symmetric(
                                            vertical: 5,
                                            horizontal:
                                            5),
                                        child: Container(
                                          alignment: Alignment
                                              .bottomRight,
                                          padding:
                                          const EdgeInsets
                                              .all(10),
                                          decoration:
                                          BoxDecoration(
                                            border: Border.all(
                                                color: ColorManager
                                                    .secondaryColor7),
                                            borderRadius:
                                            BorderRadius
                                                .circular(
                                                8),
                                          ),
                                          child: Text(
                                            doctorNoteModel
                                                .samples[
                                            index],
                                            style: Theme.of(
                                                context)
                                                .textTheme
                                                .bodySmall,
                                            textAlign:
                                            TextAlign
                                                .center,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              )
                                  : const SizedBox(),
                              if (iscanedite) ...[
                                Align(
                                  alignment: Alignment.bottomLeft,
                                  child: IconButton(
                                    onPressed: state
                                    is AsReadLoadingState
                                        ? null
                                        : () {
                                      BlocProvider.of<
                                          ReportVisitDoctorBloc>(
                                          context)
                                          .add(
                                        ChangeReadDocNoteEvent(
                                            repVisitsModel:
                                            doctorNoteModel,
                                            index: indexRep,
                                            indexBook:
                                            index),
                                      );
                                    },
                                    icon: Icon(
                                      size: 30,
                                      Icons.book_outlined,
                                      color: doctorNoteModel.flag
                                          ? ColorManager
                                          .secondaryColor4
                                          : ColorManager
                                          .secondaryColor,
                                    ),
                                  ),
                                ),
                              ]
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          )
              : const SizedBox(),
        ],
      );
    },
  );
}
Widget stackInputHospital({required int indexRep, required bool iscanedite}){
  return    BlocBuilder<ReportVisitDoctorBloc, ReportVisitDoctorState>(
    builder: (context, state) {
      bool num = BlocProvider.of<ReportVisitDoctorBloc>(context).num;
      bool isExpanded =
          BlocProvider.of<ReportVisitDoctorBloc>(context).isExpanded;
      RepVisitsModel doctorNoteModel =
          BlocProvider.of<ReportVisitDoctorBloc>(context)
              .doctorNoteModel;
      int index = BlocProvider.of<ReportVisitDoctorBloc>(context).index;

      if (state is DocIsExpandedNoteState) {
        isExpanded = true;
        index = state.index;
        doctorNoteModel = state.doctorNoteModel;
      }
      if (state is DocNoIsExpandedNoteState) {
        isExpanded = false;
      }
      return Stack(
        children: [
          if (isExpanded)
            GestureDetector(
              onTap: () {
                BlocProvider.of<ReportVisitDoctorBloc>(context)
                    .add(DocNoIsExpandedNoteEvent());
              },
              child: ModalBarrier(
                color: Colors.black.withOpacity(0.5),
                dismissible: true,
              ),
            ),
          isExpanded
              ? DraggableScrollableSheet(
            initialChildSize: 0.4,
            minChildSize: 0.1,
            maxChildSize: 1,
            builder: (context, scrollController) {
              return NotificationListener<
                  DraggableScrollableNotification>(
                onNotification: (notification) {
                  if (notification.extent == 1) {
                    BlocProvider.of<ReportVisitDoctorBloc>(
                        context)
                        .add(ExpandedBorder(true));
                  } else if (BlocProvider.of<
                      ReportVisitDoctorBloc>(context)
                      .num ==
                      true) {
                    BlocProvider.of<ReportVisitDoctorBloc>(
                        context)
                        .add(ExpandedBorder(false));
                  } else if (notification.extent <= 0.1) {
                    BlocProvider.of<ReportVisitDoctorBloc>(
                        context)
                        .add(DocNoIsExpandedNoteEvent());
                  }
                  // else {
                  //   BlocProvider.of<ReportVisitDoctorBloc>(context).add(ExpandedBorder(1));
                  // }
                  return true;
                },
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: ColorManager.secondaryColor3),
                    color: ColorManager.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(
                          ((num == true)) ? 0 : AppSize.s40),
                      topRight: Radius.circular(
                          ((num == true)) ? 0 : AppSize.s40),
                    ),
                  ),
                  child: SingleChildScrollView(
                    controller: scrollController,
                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: [
                        num == false
                            ? Center(
                          child: InkWell(
                            onTap: () {
                              BlocProvider.of<
                                  ReportVisitDoctorBloc>(
                                  context)
                                  .add(
                                  DocNoIsExpandedNoteEvent());
                            },
                            child: Container(
                              margin:
                              const EdgeInsets.all(16),
                              padding:  EdgeInsets
                                  .symmetric(
                                  vertical: AppPaddingH.p8),
                              child: Column(
                                children: List.generate(
                                  2,
                                      (index) => Container(
                                    width: 60,
                                    height: 3,
                                    margin: const EdgeInsets
                                        .symmetric(
                                        vertical: 3),
                                    decoration:
                                    BoxDecoration(
                                      color: ColorManager
                                          .secondaryColor1,
                                      borderRadius:
                                      BorderRadius
                                          .circular(2),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                            : const SizedBox(),
                        Padding(
                          padding:  EdgeInsets.all(
                              AppPaddingH.p20),
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.center,
                            children: [
                              const SizedBox(height: 20),
                              TextInfo(
                                title: "اسم المشفى",
                                supTitle:
                                doctorNoteModel.docTitle,
                              ),
                              TextInfo(
                                title: "العنوان",
                                supTitle:
                                doctorNoteModel.placeTitle,
                              ),
                              TextInfo(
                                title: "الاختصاص",
                                supTitle: doctorNoteModel.spTitle,
                              ),
                              TextInfo(
                                title: "التاريخ",
                                supTitle:
                                doctorNoteModel.visitDate,
                              ),
                              TextInfo(
                                title: "ملاحظات المكتب العلمي",
                                supTitle: doctorNoteModel.note,
                              ),
                              TextInfo(
                                title: "ملاحظات إضافية",
                                supTitle: doctorNoteModel.special,
                              ),
                              TextInfo(
                                title: "ملاحظات مستودع قاسيون",
                                supTitle: doctorNoteModel.issue,
                              ),
                              doctorNoteModel.samples.isNotEmpty
                                  ? Column(
                                crossAxisAlignment:
                                CrossAxisAlignment
                                    .start,
                                children: [
                                  Text(
                                    "المستحضرات: ",
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelLarge,
                                    textAlign:
                                    TextAlign.center,
                                  ),
                                  const SizedBox(height: 8),
                                  ListView.builder(
                                    shrinkWrap: true,
                                    physics:
                                    const NeverScrollableScrollPhysics(),
                                    itemCount:
                                    doctorNoteModel
                                        .samples.length,
                                    itemBuilder:
                                        (context, index) {
                                      return Padding(
                                        padding:
                                        const EdgeInsets
                                            .symmetric(
                                            vertical: 5,
                                            horizontal:
                                            5),
                                        child: Container(
                                          alignment: Alignment
                                              .bottomRight,
                                          padding:
                                          const EdgeInsets
                                              .all(10),
                                          decoration:
                                          BoxDecoration(
                                            border: Border.all(
                                                color: ColorManager
                                                    .secondaryColor7),
                                            borderRadius:
                                            BorderRadius
                                                .circular(
                                                8),
                                          ),
                                          child: Text(
                                            doctorNoteModel
                                                .samples[
                                            index],
                                            style: Theme.of(
                                                context)
                                                .textTheme
                                                .bodySmall,
                                            textAlign:
                                            TextAlign
                                                .center,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              )
                                  : const SizedBox(),
                              if (iscanedite) ...[
                                Align(
                                  alignment: Alignment.bottomLeft,
                                  child: IconButton(
                                    onPressed: state
                                    is AsReadLoadingState
                                        ? null
                                        : () {
                                      BlocProvider.of<
                                          ReportVisitDoctorBloc>(
                                          context)
                                          .add(
                                        ChangeReadHosNoteEvent(
                                          index: indexRep,
                                          indexBook: index,
                                          repVisitsModel:
                                          doctorNoteModel,
                                        ),
                                      );
                                    },
                                    icon: Icon(
                                      size: 30,
                                      Icons.book_outlined,
                                      color: doctorNoteModel.flag
                                          ? ColorManager
                                          .secondaryColor4
                                          : ColorManager
                                          .secondaryColor,
                                    ),
                                  ),
                                ),
                              ]
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          )
              : const SizedBox(),
        ],
      );
    },
  );
}

///////////////////////Global


// أجزاء التصميم المساعدة (Helpers)

Widget buildIconButton({required IconData icon, VoidCallback? onPressed, bool isLoading = false}) {
  return Container(
    decoration: BoxDecoration(
      color: const Color(0xFFF1F5F9),
      borderRadius: BorderRadius.circular(10.r),
    ),
    child: IconButton(
      constraints: const BoxConstraints(),
      padding: const EdgeInsets.all(8),
      icon: isLoading
          ? SizedBox(width: 20.w, height: 20.h, child: const CircularProgressIndicator(strokeWidth: 2))
          : Icon(icon, size: 20.sp, color: const Color(0xFF1E3A8A)),
      onPressed: onPressed,
    ),
  );
}

Widget buildSmallInfoBox(String title, String value, IconData icon, {bool isStar = false}) {
  return Expanded(
    child: Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(15.r),
      ),
      child: Column(

        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(fontSize: 12.sp, color: Colors.grey)),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Flexible(
                child: Text(
                  value,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF1E3A8A)),
                ),
              ),
              SizedBox(width: 5.w),
              Icon(icon, size: 16.sp, color: isStar ? Colors.orange : const Color(0xFF3B82F6)),
            ],
          )
        ],
      ),
    ),
  );
}

Widget buildDetailBox(String title, Widget content) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(15.w),
    decoration: BoxDecoration(
      color: const Color(0xFFF8FAFC),
      borderRadius: BorderRadius.circular(15.r),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold, color: Color(0xFF1E3A8A))),
        SizedBox(height: 5.h),
        content,
      ],
    ),
  );
}

Widget buildBulletItem(String text) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 2.h),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [


        const CircleAvatar(radius: 3, backgroundColor: Colors.blue),
        SizedBox(width: 8.w),
        Flexible(
          child: Text(
            text,
            textAlign: TextAlign.right,
            style: TextStyle(fontSize: 13.sp, color: const Color(0xFF1E3A8A)),
          ),
        ),
      ],
    ),
  );
}
Widget buildTotalReportsCard(int length) {
  return Padding(
    padding:  EdgeInsets.symmetric(vertical: 8.0,horizontal: 10.w),
    child: Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30.r),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,

            children: [
              Container(
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  color: const Color(0xFFF1F5F9),
                  borderRadius: BorderRadius.circular(15.r),
                ),
                child: const Icon(Icons.description_outlined, color: Color(0xFF1E3A8A)),
              ),
              SizedBox(width: 12.w,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'إجمالي التقارير',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF1E3A8A)),
                  ),
                  const Text('لهذا الشهر', style: TextStyle(color: Colors.grey)),
                ],
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            decoration: BoxDecoration(
              color: const Color(0xFFDBEAFE),
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Text(
              "${length}",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF2563EB)),
            ),
          )
        ],
      ),
    ),
  );
}
Widget buildActionBtn({
  required BuildContext context,
  required String label,
  required IconData icon,
  required Color color,
  required VoidCallback onTap,
}) {
  return InkWell(
    onTap: onTap,
    borderRadius: BorderRadius.circular(12.r),
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08), // خلفية باهتة جداً
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: color.withOpacity(0.2), width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w700,
              color: color,
            ),
          ),
          SizedBox(width: 6.w),
          Icon(icon, size: 18.sp, color: color),
        ],
      ),
    ),
  );
}
// ويدجيت مسؤولة عن تحريك العناصر (Fade + Slide)
Widget animatedEntry({required Widget child, required int delay}) {
  return TweenAnimationBuilder<double>(
    tween: Tween(begin: 0.0, end: 1.0),
    duration: const Duration(milliseconds: 600),
    curve: Curves.easeOutQuart,
    // تأخير الأنيميشن بناءً على القيمة المرسلة
    builder: (context, value, child) {
      return Opacity(
        opacity: value,
        child: Transform.translate(
          offset: Offset(0, 30 * (1 - value)), // يتحرك من أسفل (30) إلى موقعه الأصلي (0)
          child: child,
        ),
      );
    },
    // الـ Future.delayed هنا فقط لضمان بدء التدرج الزمني
    // ولكن الأفضل استخدام التدرج المباشر في الـ duration أو استخدام TweenAnimationBuilder بسيط
    child: child,
  );
}
