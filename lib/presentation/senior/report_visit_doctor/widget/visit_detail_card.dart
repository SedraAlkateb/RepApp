import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/resources/values_manager.dart';
import 'package:domina_app/presentation/senior/report_visit_doctor/bloc/report_visit_doctor_bloc.dart';
import 'package:domina_app/presentation/senior/report_visit_doctor/widget/text_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Widget stackInputDoctor({required int indexRep, required bool iscanedite}) {
  return BlocBuilder<ReportVisitDoctorBloc, ReportVisitDoctorState>(
    builder: (context, state) {
      bool num = BlocProvider.of<ReportVisitDoctorBloc>(context).num;
      bool isExpanded =
          BlocProvider.of<ReportVisitDoctorBloc>(context).isExpanded;
      RepVisitsModel doctorNoteModel =
          BlocProvider.of<ReportVisitDoctorBloc>(context).doctorNoteModel;
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
            maxChildSize: 1.0,
            builder: (context, scrollController) {
              return NotificationListener<
                  DraggableScrollableNotification>(
                onNotification: (notification) {
                  if (notification.extent == 1.0) {
                    BlocProvider.of<ReportVisitDoctorBloc>(context)
                        .add(ExpandedBorder(true));
                  } else if (BlocProvider.of<ReportVisitDoctorBloc>(
                      context)
                      .num ==
                      true) {
                    BlocProvider.of<ReportVisitDoctorBloc>(context)
                        .add(ExpandedBorder(false));
                  } else if (notification.extent <= 0.1) {
                    BlocProvider.of<ReportVisitDoctorBloc>(context)
                        .add(DocNoIsExpandedNoteEvent());
                  }
                  return true;
                },
                child: Container(

                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: ColorManager.white,
                    border: Border.all(
                      color: ColorManager.secondaryColor3.withOpacity(0.5),
                    ),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(num == true ? 0 : AppSize.s40),
                      topRight: Radius.circular(num == true ? 0 : AppSize.s40),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        blurRadius: 10,
                        offset: const Offset(0, -4),
                      ),
                    ],
                  ),
                  child: CustomScrollView(
                    controller: scrollController,
                    slivers: [
                      // مقبض السحب العلوي (Drag Handle)
                      SliverToBoxAdapter(
                        child: num == false
                            ? Center(
                          child: InkWell(
                            borderRadius: BorderRadius.circular(12),
                            onTap: () {
                              BlocProvider.of<
                                  ReportVisitDoctorBloc>(
                                  context)
                                  .add(DocNoIsExpandedNoteEvent());
                            },
                            child: Container(
                              margin: const EdgeInsets.symmetric(
                                  vertical: 12),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 4),
                              child: Container(
                                width: 48,
                                height: 5,
                                decoration: BoxDecoration(
                                  color: ColorManager
                                      .secondaryColor1
                                      .withOpacity(0.4),
                                  borderRadius:
                                  BorderRadius.circular(2.5),
                                ),
                              ),
                            ),
                          ),
                        )
                            : const SizedBox(height: 16),
                      ),

                      // محتوى الكارت الرئيسي للطبيب
                      SliverPadding(
                        padding: EdgeInsets.symmetric(
                          horizontal: AppPaddingH.p20,
                          vertical: 8,
                        ),
                        sliver: SliverToBoxAdapter(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // 1. رأس البطاقة: اسم الدكتور والتاريخ
                              Row(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      color: ColorManager.primary1
                                          .withOpacity(0.1),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      Icons.person_outline,
                                      color: ColorManager.primary1,
                                      size: 26,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          doctorNoteModel.docTitle.isNotEmpty
                                              ? doctorNoteModel.docTitle
                                              : "اسم الطبيب غير محدد",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium
                                              ?.copyWith(
                                            fontWeight:
                                            FontWeight.bold,
                                            color: const Color(
                                                0xFF0F172A),
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.calendar_today_outlined,
                                              size: 14,
                                              color: Colors.grey[600],
                                            ),
                                            const SizedBox(width: 4),
                                            Text(
                                              doctorNoteModel.visitDate,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall
                                                  ?.copyWith(
                                                color: Colors.grey[600],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),

                              const Padding(
                                padding:
                                EdgeInsets.symmetric(vertical: 16),
                                child: Divider(height: 1, thickness: 0.8),
                              ),

                              // 2. معلومات الطبيب الأساسية
                              TextInfo(
                                title: "العنوان",
                                supTitle: doctorNoteModel.placeTitle,
                                icon: Icons.location_on_outlined,
                              ),
                              TextInfo(
                                title: "الاختصاص",
                                supTitle: doctorNoteModel.spTitle,
                                icon: Icons.medical_services_outlined,
                              ),
                              TextInfo(
                                title: "التقييم",
                                supTitle: doctorNoteModel.rate,
                                icon: Icons.star_outline,
                              ),
                              TextInfo(
                                title: "الأهداف",
                                supTitle: doctorNoteModel.target,
                                icon: Icons.ads_click,
                              ),

                              // 3. قسم الملاحظات
                              _buildDocNoteCard(
                                context,
                                title: "ملاحظات المكتب العلمي",
                                content: doctorNoteModel.note,
                                accentColor: ColorManager.primary1,
                                icon: Icons.science_outlined,
                              ),
                              _buildDocNoteCard(
                                context,
                                title: "ملاحظات إضافية",
                                content: doctorNoteModel.special,
                                accentColor: Colors.amber[800]!,
                                icon: Icons.note_alt_outlined,
                              ),
                              _buildDocNoteCard(
                                context,
                                title: "ملاحظات مستودع قاسيون",
                                content: doctorNoteModel.issue,
                                accentColor: ColorManager.secondaryColor2,
                                icon: Icons.inventory_2_outlined,
                              ),

                              // 4. قسم المستحضرات (Samples)
                              if (doctorNoteModel.samples.isNotEmpty) ...[
                                const SizedBox(height: 12),
                                Text(
                                  "المستحضرات الموزعة:",
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelLarge
                                      ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: const Color(0xFF334155),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Wrap(
                                  spacing: 8,
                                  runSpacing: 8,
                                  children: doctorNoteModel.samples
                                      .map((sample) {
                                    return Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 12,
                                        vertical: 8,
                                      ),
                                      decoration: BoxDecoration(
                                        color: ColorManager.secondaryColor7
                                            .withOpacity(0.12),
                                        borderRadius:
                                        BorderRadius.circular(20),
                                        border: Border.all(
                                          color: ColorManager.secondaryColor7
                                              .withOpacity(0.4),
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(
                                            Icons.medication_outlined,
                                            size: 16,
                                            color: ColorManager.primary1,
                                          ),
                                          const SizedBox(width: 6),
                                          Text(
                                            sample,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall
                                                ?.copyWith(
                                              color: const Color(
                                                  0xFF1E293B),
                                              fontWeight:
                                              FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ],

                              const SizedBox(height: 16),

                              // 5. زر التفاعل الخاص بقراءة تقرير الطبيب
                              if (iscanedite) ...[
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                      borderRadius:
                                      BorderRadius.circular(10),
                                      onTap: state is AsReadLoadingState
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
                                            indexBook: index,
                                          ),
                                        );
                                      },
                                      child: Container(
                                        padding:
                                        const EdgeInsets.symmetric(
                                          horizontal: 14,
                                          vertical: 8,
                                        ),
                                        decoration: BoxDecoration(
                                          color: doctorNoteModel.flag
                                              ? ColorManager
                                              .secondaryColor2
                                              .withOpacity(0.1)
                                              : ColorManager.primary1
                                              .withOpacity(0.1),
                                          borderRadius:
                                          BorderRadius.circular(10),
                                          border: Border.all(
                                            color: doctorNoteModel.flag
                                                ? ColorManager
                                                .secondaryColor2
                                                : ColorManager.primary1,
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(
                                              doctorNoteModel.flag
                                                  ? Icons.bookmark
                                                  : Icons
                                                  .bookmark_border_outlined,
                                              size: 22,
                                              color: doctorNoteModel.flag
                                                  ? ColorManager
                                                  .secondaryColor2
                                                  : ColorManager.primary1,
                                            ),
                                            const SizedBox(width: 6),
                                            Text(
                                              doctorNoteModel.flag
                                                  ? "تم الاطلاع"
                                                  : "تعليم كمقروء",
                                              style: TextStyle(
                                                fontSize: 13,
                                                fontWeight:
                                                FontWeight.bold,
                                                color: doctorNoteModel.flag
                                                    ? ColorManager
                                                    .secondaryColor2
                                                    : ColorManager.primary1,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                              const SizedBox(height: 24),
                            ],
                          ),
                        ),
                      ),
                    ],
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

/// Helper Method لبناء كروت الملاحظات بشكل أنيق
Widget _buildDocNoteCard(
    BuildContext context, {
      required String title,
      required String? content,
      required Color accentColor,
      required IconData icon,
    }) {
  if (content == null || content.trim().isEmpty || content.trim() == ".") {
    return const SizedBox.shrink();
  }

  return Container(
    width: double.infinity,
    margin: const EdgeInsets.only(bottom: 12),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: accentColor.withOpacity(0.04),
      borderRadius: BorderRadius.circular(12),
      border: Border(
        right: BorderSide(color: accentColor, width: 4),
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 16, color: accentColor),
            const SizedBox(width: 6),
            Text(
              title,
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: accentColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Text(
          content,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: const Color(0xFF334155),
            height: 1.4,
          ),
        ),
      ],
    ),
  );
}//TODO
Widget stackInputHospital({required int indexRep, required bool iscanedite}) {
  return BlocBuilder<ReportVisitDoctorBloc, ReportVisitDoctorState>(
    builder: (context, state) {
      bool num = BlocProvider.of<ReportVisitDoctorBloc>(context).num;
      bool isExpanded =
          BlocProvider.of<ReportVisitDoctorBloc>(context).isExpanded;
      RepVisitsModel doctorNoteModel =
          BlocProvider.of<ReportVisitDoctorBloc>(context).doctorNoteModel;
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
                  maxChildSize: 1.0,
                  builder: (context, scrollController) {
                    return NotificationListener<
                        DraggableScrollableNotification>(
                      onNotification: (notification) {
                        if (notification.extent == 1.0) {
                          BlocProvider.of<ReportVisitDoctorBloc>(context)
                              .add(ExpandedBorder(true));
                        } else if (BlocProvider.of<ReportVisitDoctorBloc>(
                                    context)
                                .num ==
                            true) {
                          BlocProvider.of<ReportVisitDoctorBloc>(context)
                              .add(ExpandedBorder(false));
                        } else if (notification.extent <= 0.1) {
                          BlocProvider.of<ReportVisitDoctorBloc>(context)
                              .add(DocNoIsExpandedNoteEvent());
                        }
                        return true;
                      },
                      child: Container(
                       padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: ColorManager.white,
                          
                          border: Border.all(
                            
                            color:
                                ColorManager.secondaryColor3.withOpacity(0.5),
                          ),
                          borderRadius: BorderRadius.only(
                            topLeft:
                                Radius.circular(num == true ? 0 : AppSize.s40),
                            topRight:
                                Radius.circular(num == true ? 0 : AppSize.s40),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.08),
                              blurRadius: 10,
                              offset: const Offset(0, -4),
                            ),
                          ],
                        ),
                        child: CustomScrollView(
                          controller: scrollController,
                          slivers: [
                            // مقبض السحب العلوي (Drag Handle)
                            SliverToBoxAdapter(
                              child: num == false
                                  ? Center(
                                      child: InkWell(
                                        borderRadius: BorderRadius.circular(12),
                                        onTap: () {
                                          BlocProvider.of<
                                                      ReportVisitDoctorBloc>(
                                                  context)
                                              .add(DocNoIsExpandedNoteEvent());
                                        },
                                        child: Container(
                                          margin: const EdgeInsets.symmetric(
                                              vertical: 12),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 16, vertical: 4),
                                          child: Container(
                                            width: 48,
                                            height: 5,
                                            decoration: BoxDecoration(
                                              color: ColorManager
                                                  .secondaryColor1
                                                  .withOpacity(0.4),
                                              borderRadius:
                                                  BorderRadius.circular(2.5),
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  : const SizedBox(height: 16),
                            ),

                            // محتوى الكارت الرئيسي
                            SliverPadding(
                              padding: EdgeInsets.symmetric(
                                horizontal: AppPaddingH.p20,
                                vertical: 8,
                              ),
                              sliver: SliverToBoxAdapter(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // 1. رأس البطاقة: اسم المشفى، التاريخ، ونوع البطاقة
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.all(12),
                                          decoration: BoxDecoration(
                                            color: ColorManager.primary1
                                                .withOpacity(0.1),
                                            shape: BoxShape.circle,
                                          ),
                                          child: Icon(
                                            Icons.local_hospital_outlined,
                                            color: ColorManager.primary1,
                                            size: 26,
                                          ),
                                        ),
                                        const SizedBox(width: 12),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                doctorNoteModel
                                                        .docTitle.isNotEmpty
                                                    ? doctorNoteModel.docTitle
                                                    : "اسم المشفى غير محدد",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleMedium
                                                    ?.copyWith(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: const Color(
                                                          0xFF0F172A),
                                                    ),
                                              ),
                                              const SizedBox(height: 4),
                                              Row(
                                                children: [
                                                  Icon(
                                                    Icons
                                                        .calendar_today_outlined,
                                                    size: 14,
                                                    color: Colors.grey[600],
                                                  ),
                                                  const SizedBox(width: 4),
                                                  Text(
                                                    doctorNoteModel.visitDate,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodySmall
                                                        ?.copyWith(
                                                          color:
                                                              Colors.grey[600],
                                                        ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),

                                    const Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 16),
                                      child: Divider(height: 1, thickness: 0.8),
                                    ),

                                    // 2. تفاصيل الموقع والاختصاص (TextInfo المعدلة)
                                    TextInfo(
                                      title: "العنوان",
                                      supTitle: doctorNoteModel.placeTitle,
                                      icon: Icons.location_on_outlined,
                                    ),
                                    TextInfo(
                                      title: "الاختصاص",
                                      supTitle: doctorNoteModel.spTitle,
                                      icon: Icons.medical_services_outlined,
                                    ),

                                    // 3. قسم الملاحظات
                                    _buildNoteCard(
                                      context,
                                      title: "ملاحظات المكتب العلمي",
                                      content: doctorNoteModel.note,
                                      accentColor: ColorManager.primary1,
                                      icon: Icons.science_outlined,
                                    ),
                                    _buildNoteCard(
                                      context,
                                      title: "ملاحظات إضافية",
                                      content: doctorNoteModel.special,
                                      accentColor: Colors.amber[800]!,
                                      icon: Icons.note_alt_outlined,
                                    ),
                                    _buildNoteCard(
                                      context,
                                      title: "ملاحظات مستودع قاسيون",
                                      content: doctorNoteModel.issue,
                                      accentColor: ColorManager.secondaryColor2,
                                      icon: Icons.inventory_2_outlined,
                                    ),

                                    // 4. قسم المستحضرات (Samples)
                                    if (doctorNoteModel.samples.isNotEmpty) ...[
                                      const SizedBox(height: 12),
                                      Text(
                                        "المستحضرات الموزعة:",
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelLarge
                                            ?.copyWith(
                                              fontWeight: FontWeight.bold,
                                              color: const Color(0xFF334155),
                                            ),
                                      ),
                                      const SizedBox(height: 10),
                                      Wrap(
                                        spacing: 8,
                                        runSpacing: 8,
                                        children: doctorNoteModel.samples
                                            .map((sample) {
                                          return Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 12,
                                              vertical: 8,
                                            ),
                                            decoration: BoxDecoration(
                                              color: ColorManager
                                                  .secondaryColor7
                                                  .withOpacity(0.12),
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              border: Border.all(
                                                color: ColorManager
                                                    .secondaryColor7
                                                    .withOpacity(0.4),
                                              ),
                                            ),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Icon(
                                                  Icons.medication_outlined,
                                                  size: 16,
                                                  color: ColorManager.primary1,
                                                ),
                                                const SizedBox(width: 6),
                                                Text(
                                                  sample,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodySmall
                                                      ?.copyWith(
                                                        color: const Color(
                                                            0xFF1E293B),
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                ),
                                              ],
                                            ),
                                          );
                                        }).toList(),
                                      ),
                                    ],

                                    const SizedBox(height: 16),

                                    // 5. زر إجراء "تم القراءة" (Action Button)
                                    if (iscanedite) ...[
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Material(
                                          color: Colors.transparent,
                                          child: InkWell(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            onTap: state is AsReadLoadingState
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
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 14,
                                                vertical: 8,
                                              ),
                                              decoration: BoxDecoration(
                                                color: doctorNoteModel.flag
                                                    ? ColorManager
                                                        .secondaryColor2
                                                        .withOpacity(0.1)
                                                    : ColorManager.primary1
                                                        .withOpacity(0.1),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                border: Border.all(
                                                  color: doctorNoteModel.flag
                                                      ? ColorManager
                                                          .secondaryColor2
                                                      : ColorManager.primary1,
                                                ),
                                              ),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Icon(
                                                    doctorNoteModel.flag
                                                        ? Icons.bookmark
                                                        : Icons
                                                            .bookmark_border_outlined,
                                                    size: 22,
                                                    color: doctorNoteModel.flag
                                                        ? ColorManager
                                                            .secondaryColor2
                                                        : ColorManager.primary1,
                                                  ),
                                                  const SizedBox(width: 6),
                                                  Text(
                                                    doctorNoteModel.flag
                                                        ? "تم الاطلاع"
                                                        : "تعليم كمقروء",
                                                    style: TextStyle(
                                                      fontSize: 13,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: doctorNoteModel
                                                              .flag
                                                          ? ColorManager
                                                              .secondaryColor2
                                                          : ColorManager
                                                              .primary1,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                    const SizedBox(height: 24),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                )
              : const SizedBox()
        ],
      );
    },
  );
}

/// Helper Method لبناء بطاقات الملاحظات بشكل احترافي وموحد
Widget _buildNoteCard(
  BuildContext context, {
  required String title,
  required String? content,
  required Color accentColor,
  required IconData icon,
}) {
  if (content == null || content.trim().isEmpty || content.trim() == ".") {
    return const SizedBox.shrink();
  }

  return Container(
    width: double.infinity,
    margin: const EdgeInsets.only(bottom: 12),
    padding: EdgeInsets.all(12.w),
    decoration: BoxDecoration(
      color: accentColor.withOpacity(0.04),
      borderRadius: BorderRadius.circular(12),
      border: Border(
        right: BorderSide(color: accentColor, width: 4),
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 16, color: accentColor),
            const SizedBox(width: 6),
            Text(
              title,
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: accentColor,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Text(
          content,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: const Color(0xFF334155),
                height: 1.4,
              ),
        ),
      ],
    ),
  );
}
///////////////////////Global

// أجزاء التصميم المساعدة (Helpers)

Widget buildIconButton(bool flag,
    {required IconData icon, VoidCallback? onPressed, bool isLoading = false}) {
  return Container(
    decoration: BoxDecoration(
      color: const Color(0xFFF1F5F9),
      borderRadius: BorderRadius.circular(10.r),
    ),
    child: IconButton(
      constraints: const BoxConstraints(),
      padding: const EdgeInsets.all(8),
      icon: isLoading
          ? SizedBox(
              width: 20.w,
              height: 20.h,
              child: const CircularProgressIndicator(strokeWidth: 2))
          : Icon(icon,
              size: 20.sp,
              color:
                  flag ? ColorManager.secondaryColor2 : ColorManager.primary1),
      onPressed: onPressed,
    ),
  );
}

Widget buildIconWatsAppButton(
    {VoidCallback? onPressed, bool isLoading = false}) {
  return Container(
    decoration: BoxDecoration(
      color: const Color(0xFFF1F5F9),
      borderRadius: BorderRadius.circular(10.r),
    ),
    child: IconButton(
      constraints: const BoxConstraints(),
      padding: const EdgeInsets.all(8),
      icon: isLoading
          ? SizedBox(
              width: 20.w,
              height: 20.h,
              child: const CircularProgressIndicator(strokeWidth: 2))
          : FaIcon(FontAwesomeIcons.whatsapp,
              size: 20.sp, color: ColorManager.primary1),
      onPressed: onPressed,
    ),
  );
}

Widget buildSmallInfoBox(String title, String value, IconData icon,
    {bool isStar = false}) {
  return Expanded(
    child: Container(
      padding: EdgeInsets.all(8.w),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(15.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(icon,
              size: 16.sp,
              color: isStar ? Colors.orange : const Color(0xFF3B82F6)),
          SizedBox(width: 5.w),
          Flexible(
            child: Text(
              value,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                  fontWeight: FontWeight.bold, color: Color(0xFF1E3A8A)),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget buildDetailBox(String title, Widget content) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(10.w),
    decoration: BoxDecoration(
      color: const Color(0xFFF8FAFC),
      borderRadius: BorderRadius.circular(15.r),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1E3A8A))),
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
            style: TextStyle(fontSize: 12.sp, color: const Color(0xFF1E3A8A)),
          ),
        ),
      ],
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
          offset: Offset(
              0, 30 * (1 - value)), // يتحرك من أسفل (30) إلى موقعه الأصلي (0)
          child: child,
        ),
      );
    },
    // الـ Future.delayed هنا فقط لضمان بدء التدرج الزمني
    // ولكن الأفضل استخدام التدرج المباشر في الـ duration أو استخدام TweenAnimationBuilder بسيط
    child: child,
  );
}
