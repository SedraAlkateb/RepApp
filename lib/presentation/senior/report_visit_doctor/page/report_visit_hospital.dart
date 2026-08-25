import 'package:domina_app/app/user_info.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/resources/responsive/app_responsive.dart';
import 'package:domina_app/presentation/senior/report_visit_doctor/bloc/report_visit_doctor_bloc.dart';
import 'package:domina_app/presentation/senior/report_visit_doctor/widget/visit_detail_card.dart';
import 'package:domina_app/presentation/senior/report_visit_doctor/widget/who_read_dialog.dart';
import 'package:domina_app/presentation/uniti/num_list.dart';
import 'package:domina_app/presentation/uniti/search_field.dart';
import 'package:domina_app/presentation/uniti/share_watsapp.dart';
import 'package:domina_app/presentation/uniti/stateWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReportVisitHospital extends StatelessWidget {
  ReportVisitHospital({
    super.key,
    required this.userId,
    required this.repId,
    required this.indexRep,
    required this.repName,
    required this.phone,
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
    final deviceType =
    AppResponsive.deviceType(context);

    // =====================================================
    // Responsive Values
    // =====================================================
    double pageMaxWidth;

    double horizontalPadding;

    double headerTopPadding;
    double headerBottomPadding;

    double titleFontSize;
    double subtitleFontSize;

    double searchBottomSpacing;

    double actionsTopSpacing;
    double actionsBottomSpacing;

    double inputReservedSpace;

    switch (deviceType) {
    // =================================================
    // Mobile
    // =================================================

      case AppDeviceType.mobilePortrait:
        pageMaxWidth = 600;

        horizontalPadding = 16;

        headerTopPadding = 18;
        headerBottomPadding = 16;

        titleFontSize = 20;
        subtitleFontSize = 12.5;

        searchBottomSpacing = 14;

        actionsTopSpacing = 8;
        actionsBottomSpacing = 14;

        inputReservedSpace =
        iscanedite ? 100 : 28;
        break;

    // =================================================
    // Tablet Portrait
    // =================================================
      case AppDeviceType.tabletPortrait:
        pageMaxWidth = 760;

        horizontalPadding = 28;

        headerTopPadding = 24;
        headerBottomPadding = 20;

        titleFontSize = 24;
        subtitleFontSize = 14;

        searchBottomSpacing = 18;

        actionsTopSpacing = 10;
        actionsBottomSpacing = 18;

        inputReservedSpace =
        iscanedite ? 110 : 34;
        break;

    // =================================================
    // Tablet Landscape
    // =================================================
      case AppDeviceType.tabletLandscape:
        pageMaxWidth = 900;

        horizontalPadding = 32;

        headerTopPadding = 20;
        headerBottomPadding = 16;

        titleFontSize = 23;
        subtitleFontSize = 13.5;

        searchBottomSpacing = 14;

        actionsTopSpacing = 8;
        actionsBottomSpacing = 16;

        inputReservedSpace =
        iscanedite ? 100 : 30;
        break;
    }

    // =====================================================
    // Page Content
    //
    // نفس المحتوى سواء الصفحة مستقلة أو داخل TabBarView
    // =====================================================

    final Widget pageContent = SafeArea(
      top: false,
      child: Stack(
        alignment:
        Alignment.bottomCenter,
        children: [
          // =================================================
          // Main Content
          // =================================================
          Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: pageMaxWidth,
              ),
              child: CustomScrollView(
                keyboardDismissBehavior:
                ScrollViewKeyboardDismissBehavior
                    .onDrag,
                physics:
                const BouncingScrollPhysics(),
                slivers: [
                  // ===========================================
                  // Header
                  // ===========================================
                  SliverPadding(
                    padding:
                    EdgeInsets.fromLTRB(
                      horizontalPadding,
                      headerTopPadding,
                      horizontalPadding,
                      headerBottomPadding,
                    ),
                    sliver:
                    SliverToBoxAdapter(
                      child: Column(
                        crossAxisAlignment:
                        CrossAxisAlignment
                            .start,
                        children: [
                          animatedEntry(
                            delay: 0,
                            child: Text(
                              'تقارير الزيارات للمشافي',
                              style: TextStyle(
                                fontSize:
                                titleFontSize,
                                fontWeight:
                                FontWeight
                                    .w800,
                                color:
                                const Color(
                                  0xFF0F172A,
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(
                            height: 5,
                          ),

                          animatedEntry(
                            delay: 100,
                            child: Text(
                              'مراجعة تفاصيل الزيارات الميدانية للمشافي للمندوب',
                              style: TextStyle(
                                fontSize:
                                subtitleFontSize,
                                color:
                                const Color(
                                  0xFF64748B,
                                ),
                                height: 1.4,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // =================================
                  // Search
                  // =================================
                  SliverPadding(
                    padding:
                    EdgeInsets.fromLTRB(
                      horizontalPadding,
                      headerTopPadding,
                      horizontalPadding,
                      headerBottomPadding,
                    ),
                    sliver:
                    SliverToBoxAdapter(
                      child:   animatedEntry(
                        delay: 200,
                        child:
                        SearchField(
                          searchController:
                          searchNoteDoctorController,
                          onPressed:
                              (value) {
                            BlocProvider.of<
                                ReportVisitDoctorBloc>(
                              context,
                            ).add(
                              SenSearchNoteVisitHospitalEvent(
                                value,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),


                  // ===========================================
                  // Bloc Content
                  // ===========================================
                  BlocConsumer<
                      ReportVisitDoctorBloc,
                      ReportVisitDoctorState>(
                    // =========================================
                    // Listener
                    //
                    // أي event جانبي يصير هون
                    // مو داخل builder
                    // =========================================
                    listener:
                        (context, state) {
                      // =======================================
                      // Error Toast / Dialog
                      // =======================================
                      if (state
                      is AsReadErrorState) {
                        error(
                          context,
                          state.failure.massage,
                          state.failure.code,
                        );
                      }

                      // =======================================
                      // Refresh After Read All
                      // =======================================
                      if (state
                      is AllReadSucState) {
                        BlocProvider.of<
                            ReportVisitDoctorBloc>(
                          context,
                        ).add(
                          AllReportVisitHospitalEvent(
                            VisitRepSen(
                              repId,
                              userId,
                            ),
                            iscanedite,
                          ),
                        );
                      }
                    },

                    // =========================================
                    // Builder
                    // =========================================
                    builder:
                        (context, state) {
                      // =======================================
                      // Default Data
                      // =======================================
                      List<RepVisitsModel>
                      doctorNoteModel =
                          context
                              .watch<
                              ReportVisitDoctorBloc>()
                              .repVisitsSearch;

                      // =======================================
                      // Updated Read State
                      // =======================================
                      if (state
                      is SenVisitDoctorAsReadState) {
                        doctorNoteModel =
                            state.doctorNoteModel;
                      }

                      // =======================================
                      // Success
                      // =======================================
                      if (state
                      is AllReportVisitHospitalsState) {
                        doctorNoteModel =
                            state.repVisitsModel;
                      }

                      // =======================================
                      // Loading
                      // =======================================
                      if (state
                      is AllReportVisitHospitalLoadingState ||
                          state
                          is AllReadLoadingState) {
                        return SliverFillRemaining(
                          hasScrollBody: false,
                          child:
                          loadingFullScreen(
                            context,
                          ),
                        );
                      }

                      // =======================================
                      // Empty
                      // =======================================
                      if (state
                      is AllReportVisitHospitalEmptyState ||
                          doctorNoteModel
                              .isEmpty) {
                        return SliverFillRemaining(
                          hasScrollBody: false,
                          child:
                          emptyFullScreen(
                            context,
                          ),
                        );
                      }

                      // =======================================
                      // Error
                      // =======================================
                      if (state
                      is AllReportVisitHospitalErrorState ||
                          state
                          is AllReadErrorState) {
                        return SliverFillRemaining(
                          hasScrollBody: false,
                          child:
                          errorFullScreen(
                            context,
                            func: () {
                              BlocProvider.of<
                                  ReportVisitDoctorBloc>(
                                context,
                              ).add(
                                AllReportVisitHospitalEvent(
                                  VisitRepSen(
                                    repId,
                                    userId,
                                  ),
                                  iscanedite,
                                ),
                              );
                            },
                          ),
                        );
                      }

                      // =======================================
                      // Main Data
                      // =======================================
                      return SliverPadding(
                        padding:
                        EdgeInsets.symmetric(
                          horizontal:
                          horizontalPadding,
                        ),
                        sliver:
                        SliverList(
                          delegate:
                          SliverChildListDelegate(
                            [

                              SizedBox(
                                height:
                                searchBottomSpacing,
                              ),

                              // =================================
                              // Total Reports
                              // =================================
                              animatedEntry(
                                delay: 300,
                                child:
                                buildTotalReportsCard(
                                  doctorNoteModel
                                      .length,
                                  'إجمالي التقارير',
                                  'لهذا الشهر',
                                ),
                              ),

                              // =================================
                              // Read All Actions
                              // =================================
                              if (iscanedite)
                                animatedEntry(
                                  delay: 400,
                                  child:
                                  Padding(
                                    padding:
                                    EdgeInsets.only(
                                      top:
                                      actionsTopSpacing,
                                      bottom:
                                      actionsBottomSpacing,
                                    ),
                                    child:
                                    Wrap(
                                      spacing: 10,
                                      runSpacing:
                                      10,
                                      children: [
                                        // =========================
                                        // Read All
                                        // =========================
                                        buildActionBtn(
                                          context:
                                          context,
                                          label:
                                          'قراءة الكل',
                                          icon: Icons
                                              .bookmarks_rounded,
                                          color:
                                          ColorManager
                                              .primary1,
                                          onTap:
                                              () {
                                            BlocProvider.of<
                                                ReportVisitDoctorBloc>(
                                              context,
                                            ).add(
                                              AllReadDocNoteEvent(
                                                readAll:
                                                ReadAll(
                                                  repPlan,
                                                  UserInfo
                                                      .repId,

                                                  // Hospital
                                                  2,

                                                  // Read
                                                  1,
                                                ),
                                              ),
                                            );
                                          },
                                        ),

                                        // =========================
                                        // Unread All
                                        // =========================
                                        buildActionBtn(
                                          context:
                                          context,
                                          label:
                                          'إلغاء قراءة الكل',
                                          icon: Icons
                                              .bookmark_remove_outlined,
                                          color:
                                          const Color(
                                            0xFFEF4444,
                                          ),
                                          onTap:
                                              () {
                                            BlocProvider.of<
                                                ReportVisitDoctorBloc>(
                                              context,
                                            ).add(
                                              AllReadDocNoteEvent(
                                                readAll:
                                                ReadAll(
                                                  repPlan,
                                                  UserInfo
                                                      .repId,

                                                  // Hospital
                                                  2,

                                                  // Unread
                                                  0,
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              else
                                const SizedBox(
                                  height: 4,
                                ),

                              // =================================
                              // Cards
                              // =================================
                              ...doctorNoteModel
                                  .asMap()
                                  .entries
                                  .map(
                                    (entry) {
                                  final int index =
                                      entry.key;

                                  final model =
                                      entry.value;

                                  return animatedEntry(
                                    delay:
                                    500 +
                                        (index *
                                            100),
                                    child:
                                    _buildHospitalVisitCard(
                                      doctorNoteModel:
                                      model,
                                      index:
                                      index,
                                      indexRep:
                                      indexRep,
                                      iscanedite:
                                      iscanedite,
                                      context:
                                      context,
                                    ),
                                  );
                                },
                              ),

                              // =================================
                              // Space For Bottom Sheet
                              // =================================
                              SizedBox(
                                height:
                                inputReservedSpace,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),

          // =================================================
          // Hospital Bottom Sheet
          // =================================================
          stackInputHospital(
            indexRep: indexRep,
            iscanedite: iscanedite,
          ),
        ],
      ),
    );

    // =====================================================
    // داخل DoctorsHospitalsReports
    //
    // ما بدنا Scaffold داخل Scaffold
    // =====================================================
    if (!iscanedite) {
      return ColoredBox(
        color:
        const Color(
          0xFFF8FAFC,
        ),
        child:
        pageContent,
      );
    }

    // =====================================================
    // الصفحة مفتوحة بشكل مستقل
    //
    // هون بدنا Scaffold + AppBar
    // =====================================================
    return Scaffold(
      backgroundColor:
      const Color(
        0xFFF8FAFC,
      ),

      resizeToAvoidBottomInset:
      true,

      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation:
        0,
        surfaceTintColor:
        Colors.transparent,

        leading: IconButton(
          icon: Icon(
            Icons
                .arrow_back_ios_new_rounded,
            size: deviceType ==
                AppDeviceType
                    .mobilePortrait
                ? 22
                : 24,
            color:
            ColorManager
                .secondaryColor1,
          ),
          onPressed: () {
            BlocProvider.of<
                ReportVisitDoctorBloc>(
              context,
            ).add(
              DocNoIsExpandedNoteEvent(),
            );

            Navigator.pop(
              context,
            );
          },
        ),

        title: Text(
          repName,
          maxLines: 1,
          overflow:
          TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: deviceType ==
                AppDeviceType
                    .mobilePortrait
                ? 18
                : 20,
            fontWeight:
            FontWeight.w700,
          ),
        ),
      ),

      body: pageContent,
    );
  }

  // =====================================================
  // Hospital Visit Card
  // =====================================================

  Widget _buildHospitalVisitCard({
    required dynamic doctorNoteModel,
    required int index,
    required int indexRep,
    required bool iscanedite,
    required BuildContext context,
  }) {
    final deviceType =
    AppResponsive.deviceType(context);

    double cardRadius;
    double cardPadding;
    double cardBottomSpacing;

    double sideBarWidth;

    double hospitalIconBoxSize;
    double hospitalIconSize;
    double hospitalIconRadius;
    double hospitalIconSpacing;

    double nameFontSize;
    double dateFontSize;

    double specializationFontSize;
    double infoIconSize;

    double sectionSpacing;

    double noteFontSize;

    switch (deviceType) {
    // =================================================
    // Mobile
    // =================================================
      case AppDeviceType.mobilePortrait:
        cardRadius = 18;
        cardPadding = 15;
        cardBottomSpacing = 12;

        sideBarWidth = 4;

        hospitalIconBoxSize = 42;
        hospitalIconSize = 21;
        hospitalIconRadius = 11;
        hospitalIconSpacing = 11;

        nameFontSize = 16;
        dateFontSize = 10.5;

        specializationFontSize = 12;
        infoIconSize = 15;

        sectionSpacing = 12;

        noteFontSize = 15;
        break;

    // =================================================
    // Tablet Portrait
    // =================================================
      case AppDeviceType.tabletPortrait:
        cardRadius = 20;
        cardPadding = 20;
        cardBottomSpacing = 14;

        sideBarWidth = 5;

        hospitalIconBoxSize = 50;
        hospitalIconSize = 25;
        hospitalIconRadius = 14;
        hospitalIconSpacing = 15;

        nameFontSize = 19;
        dateFontSize = 12;

        specializationFontSize = 14;
        infoIconSize = 17;

        sectionSpacing = 15;

        noteFontSize = 15.5;
        break;

    // =================================================
    // Tablet Landscape
    // =================================================
      case AppDeviceType.tabletLandscape:
        cardRadius = 18;
        cardPadding = 18;
        cardBottomSpacing = 12;

        sideBarWidth = 5;

        hospitalIconBoxSize = 46;
        hospitalIconSize = 23;
        hospitalIconRadius = 12;
        hospitalIconSpacing = 13;

        nameFontSize = 18;
        dateFontSize = 11.5;

        specializationFontSize = 13;
        infoIconSize = 16;

        sectionSpacing = 13;

        noteFontSize = 15;
        break;
    }

    final Color statusColor =
    doctorNoteModel.flag
        ? ColorManager.secondaryColor2
        : const Color(
      0xFF1E3A8A,
    );

    return Padding(
      padding: EdgeInsets.only(
        bottom: cardBottomSpacing,
      ),
      child: Material(
        color:
        Colors.transparent,
        child: InkWell(
          borderRadius:
          BorderRadius.circular(
            cardRadius,
          ),

          // =================================================
          // Open Details
          // =================================================
          onTap: () {
            BlocProvider.of<
                ReportVisitDoctorBloc>(
              context,
            ).add(
              DocIsExpandedNoteEvent(
                doctorNoteModel,
                index,
              ),
            );
          },

          child: Container(
            decoration:
            BoxDecoration(
              color:
              Colors.white,

              borderRadius:
              BorderRadius.circular(
                cardRadius,
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
                  color: Colors.black
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

            clipBehavior:
            Clip.antiAlias,

            // =================================================
            // Stack For Side Status Bar
            // =================================================
            child: Stack(
              children: [
                // ===============================================
                // Card Content
                // ===============================================
                Padding(
                  padding:
                  EdgeInsets.fromLTRB(
                    cardPadding,
                    cardPadding,
                    cardPadding +
                        sideBarWidth,
                    cardPadding,
                  ),
                  child: Column(
                    mainAxisSize:
                    MainAxisSize.min,
                    crossAxisAlignment:
                    CrossAxisAlignment
                        .stretch,
                    children: [
                      // =========================================
                      // Hospital Header
                      // =========================================
                      Row(
                        crossAxisAlignment:
                        CrossAxisAlignment
                            .start,
                        children: [
                          // =====================================
                          // Hospital Icon
                          // =====================================
                          Container(
                            width:
                            hospitalIconBoxSize,
                            height:
                            hospitalIconBoxSize,
                            alignment:
                            Alignment
                                .center,
                            decoration:
                            BoxDecoration(
                              color:
                              const Color(
                                0xFFE0F2F1,
                              ),
                              borderRadius:
                              BorderRadius
                                  .circular(
                                hospitalIconRadius,
                              ),
                            ),
                            child:
                            Icon(
                              Icons
                                  .local_hospital_outlined,
                              size:
                              hospitalIconSize,
                              color:
                              const Color(
                                0xFF00897B,
                              ),
                            ),
                          ),

                          SizedBox(
                            width:
                            hospitalIconSpacing,
                          ),

                          // =====================================
                          // Hospital Name
                          // =====================================
                          Expanded(
                            child:
                            Text(
                              doctorNoteModel
                                  .docTitle,
                              maxLines:
                              2,
                              overflow:
                              TextOverflow
                                  .ellipsis,
                              style:
                              TextStyle(
                                fontSize:
                                nameFontSize,
                                fontWeight:
                                FontWeight
                                    .w700,
                                color:
                                const Color(
                                  0xFF1E3A8A,
                                ),
                                height:
                                1.25,
                              ),
                            ),
                          ),

                          const SizedBox(
                            width: 10,
                          ),

                          // =====================================
                          // Visit Date
                          // =====================================
                          Container(
                            padding:
                            const EdgeInsets
                                .symmetric(
                              horizontal:
                              8,
                              vertical:
                              5,
                            ),
                            decoration:
                            BoxDecoration(
                              color:
                              const Color(
                                0xFFF8FAFC,
                              ),
                              borderRadius:
                              BorderRadius
                                  .circular(
                                9,
                              ),
                              border:
                              Border.all(
                                color:
                                const Color(
                                  0xFFE2E8F0,
                                ),
                              ),
                            ),
                            child:
                            Row(
                              mainAxisSize:
                              MainAxisSize
                                  .min,
                              children: [
                                Icon(
                                  Icons
                                      .calendar_month_outlined,
                                  size:
                                  infoIconSize,
                                  color:
                                  const Color(
                                    0xFF94A3B8,
                                  ),
                                ),

                                const SizedBox(
                                  width:
                                  5,
                                ),

                                Text(
                                  doctorNoteModel
                                      .visitDate,
                                  maxLines:
                                  1,
                                  style:
                                  TextStyle(
                                    fontSize:
                                    dateFontSize,
                                    color:
                                    const Color(
                                      0xFF64748B,
                                    ),
                                    fontWeight:
                                    FontWeight
                                        .w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      SizedBox(
                        height:
                        sectionSpacing,
                      ),

                      // =========================================
                      // Specialization + Actions
                      // =========================================
                      if (deviceType ==
                          AppDeviceType
                              .mobilePortrait)
                        Column(
                          crossAxisAlignment:
                          CrossAxisAlignment
                              .stretch,
                          children: [
                            _buildHospitalSpecialization(
                              doctorNoteModel:
                              doctorNoteModel,
                              fontSize:
                              specializationFontSize,
                              iconSize:
                              infoIconSize,
                            ),

                            if (iscanedite) ...[
                              const SizedBox(
                                height:
                                10,
                              ),

                              Align(
                                alignment:
                                Alignment
                                    .centerLeft,
                                child:
                                _buildHospitalActions(
                                  context:
                                  context,
                                  doctorNoteModel:
                                  doctorNoteModel,
                                  index:
                                  index,
                                  indexRep:
                                  indexRep,
                                ),
                              ),
                            ],
                          ],
                        )
                      else
                        Row(
                          children: [
                            Expanded(
                              child:
                              _buildHospitalSpecialization(
                                doctorNoteModel:
                                doctorNoteModel,
                                fontSize:
                                specializationFontSize,
                                iconSize:
                                infoIconSize,
                              ),
                            ),

                            if (iscanedite) ...[
                              const SizedBox(
                                width:
                                12,
                              ),

                              _buildHospitalActions(
                                context:
                                context,
                                doctorNoteModel:
                                doctorNoteModel,
                                index:
                                index,
                                indexRep:
                                indexRep,
                              ),
                            ],
                          ],
                        ),

                      SizedBox(
                        height:
                        sectionSpacing,
                      ),

                      // =========================================
                      // Divider
                      // =========================================
                      Container(
                        height: 1,
                        color:
                        const Color(
                          0xFFF1F5F9,
                        ),
                      ),

                      SizedBox(
                        height:
                        sectionSpacing,
                      ),

                      // =========================================
                      // Place + Rate
                      // =========================================
                      Row(
                        children: [
                          buildSmallInfoBox(
                            'الموقع',
                            doctorNoteModel
                                .placeTitle,
                            Icons
                                .location_on_outlined,
                          ),

                          const SizedBox(
                            width: 10,
                          ),

                          buildSmallInfoBox(
                            'التقييم',
                            doctorNoteModel
                                .rate ??
                                "0.0",
                            Icons.star,
                            isStar:
                            true,
                          ),
                        ],
                      ),

                      SizedBox(
                        height:
                        sectionSpacing,
                      ),

                      // =========================================
                      // Scientific Note
                      // =========================================
                      buildDetailBox(
                        'ملاحظة المكتب العلمي',
                        Text(
                          doctorNoteModel
                              .note
                              .isEmpty
                              ? "لا توجد ملاحظات"
                              : doctorNoteModel
                              .note,
                          textAlign:
                          TextAlign.right,
                          style:
                          TextStyle(
                            color:
                            const Color(
                              0xFF1E3A8A,
                            ),
                            fontSize:
                            noteFontSize,
                            height:
                            1.5,
                          ),
                        ),
                      ),

                      // =========================================
                      // Samples
                      // =========================================
                      if (doctorNoteModel
                          .samples
                          .isNotEmpty) ...[
                        SizedBox(
                          height:
                          sectionSpacing,
                        ),

                        buildDetailBox(
                          'المستحضرات الموزعة',
                          Column(
                            crossAxisAlignment:
                            CrossAxisAlignment
                                .start,
                            children:
                            doctorNoteModel
                                .samples
                                .map<Widget>(
                                  (sample) {
                                return buildBulletItem(
                                  sample,
                                );
                              },
                            ).toList(),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),

                // ===============================================
                // Status Side Bar
                // ===============================================
                Positioned(
                  top: 0,
                  bottom: 0,
                  right: 0,
                  child: Container(
                    width:
                    sideBarWidth,
                    color:
                    statusColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // =====================================================
  // Hospital Specialization
  // =====================================================

  Widget _buildHospitalSpecialization({
    required dynamic doctorNoteModel,
    required double fontSize,
    required double iconSize,
  }) {
    return Row(
      mainAxisSize:
      MainAxisSize.min,
      children: [
        Container(
          width:
          iconSize + 12,
          height:
          iconSize + 12,
          alignment:
          Alignment.center,
          decoration:
          BoxDecoration(
            color:
            const Color(
              0xFFEFF6FF,
            ),
            borderRadius:
            BorderRadius.circular(
              8,
            ),
          ),
          child: Icon(
            Icons
                .local_offer_outlined,
            size:
            iconSize,
            color:
            const Color(
              0xFF3B82F6,
            ),
          ),
        ),

        const SizedBox(
          width: 7,
        ),

        Flexible(
          child: Text(
            doctorNoteModel
                .spTitle,
            maxLines: 1,
            overflow:
            TextOverflow.ellipsis,
            style: TextStyle(
              color:
              const Color(
                0xFF3B82F6,
              ),
              fontWeight:
              FontWeight.w600,
              fontSize:
              fontSize,
            ),
          ),
        ),
      ],
    );
  }

  // =====================================================
  // Hospital Actions
  // =====================================================

  Widget _buildHospitalActions({
    required BuildContext context,
    required dynamic doctorNoteModel,
    required int index,
    required int indexRep,
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
}