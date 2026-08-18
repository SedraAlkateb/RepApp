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
    // نفس السلوك الموجود عندك
    BlocProvider.of<ReportVisitDoctorBloc>(
      context,
    ).clear();

    final deviceType =
    AppResponsive.deviceType(context);

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
        pageMaxWidth = 800;

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
        pageMaxWidth = 1100;

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

    return Scaffold(
      backgroundColor:
      const Color(0xFFF8FAFC),

      // ===================================================
      // مهم للكيبورد
      //
      // الـScaffold يصغر المساحة المتاحة عند ظهور
      // لوحة المفاتيح، وبالتالي input السفلي يطلع فوقها
      // ===================================================
      resizeToAvoidBottomInset: true,

      appBar: iscanedite
          ? AppBar(
        elevation: 0,
        surfaceTintColor:
        Colors.transparent,

        leading: Builder(
          builder:
              (BuildContext context) {
            return IconButton(
              icon: Icon(
                Icons
                    .arrow_back_ios_new_rounded,
                size: deviceType ==
                    AppDeviceType
                        .mobilePortrait
                    ? 22
                    : 24,
                color: ColorManager
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
      )
          : null,

      body: SafeArea(
        top: false,

        child: Stack(
          alignment:
          Alignment.bottomCenter,

          children: [
            // =================================================
            // Scrollable Content
            // =================================================
            Center(
              child: ConstrainedBox(
                constraints:
                BoxConstraints(
                  maxWidth:
                  pageMaxWidth,
                ),

                child:
                CustomScrollView(
                  keyboardDismissBehavior:
                  ScrollViewKeyboardDismissBehavior
                      .onDrag,

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
                            Text(
                              'تقارير الزيارات للأطباء',

                              style:
                              TextStyle(
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

                            const SizedBox(
                              height: 5,
                            ),

                            Text(
                              'مراجعة تفاصيل الزيارات الميدانية للأطباء للمندوب',

                              style:
                              TextStyle(
                                fontSize:
                                subtitleFontSize,

                                color:
                                const Color(
                                  0xFF64748B,
                                ),

                                height: 1.4,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // ===========================================
                    // Bloc Content
                    // ===========================================
                    BlocConsumer<
                        ReportVisitDoctorBloc,
                        ReportVisitDoctorState>(
                      listener:
                          (context, state) {
                        if (state
                        is AsReadErrorState) {
                          error(
                            context,
                            state.failure.massage,
                            state.failure.code,
                          );
                        }
                      },

                      builder:
                          (context, state) {
                        List<RepVisitsModel>
                        doctorNoteModel =
                            context
                                .watch<
                                ReportVisitDoctorBloc>()
                                .repVisitsSearch;

                        // =======================================
                        // Empty
                        // =======================================
                        if (state
                        is AllReportVisitDoctorEmptyState) {
                          return SliverFillRemaining(
                            hasScrollBody:
                            false,

                            child:
                            emptyFullScreen(
                              context,
                            ),
                          );
                        }

                        // =======================================
                        // Read State
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
                        is AllReportVisitDoctorsState) {
                          doctorNoteModel =
                              state.repVisitsModel;
                        }

                        // =======================================
                        // Loading
                        // =======================================
                        if (state
                        is AllReportVisitDoctorLoadingState) {
                          return SliverFillRemaining(
                            hasScrollBody:
                            false,

                            child:
                            loadingFullScreen(
                              context,
                            ),
                          );
                        }

                        if (state
                        is AllReadLoadingState) {
                          return SliverFillRemaining(
                            hasScrollBody:
                            false,

                            child:
                            loadingFullScreen(
                              context,
                            ),
                          );
                        }

                        // =======================================
                        // Refresh after Read All
                        // نفس السلوك الموجود عندك
                        // =======================================
                        if (state
                        is AllReadSucState) {
                          BlocProvider.of<
                              ReportVisitDoctorBloc>(
                            context,
                          ).add(
                            AllReportVisitDoctorEvent(
                              VisitRepSen(
                                repId,
                                UserInfo.repId,
                              ),
                              iscanedite,
                            ),
                          );
                        }

                        // =======================================
                        // Error
                        // =======================================
                        if (state
                        is AllReportVisitDoctorErrorState) {
                          return SliverFillRemaining(
                            hasScrollBody:
                            false,

                            child:
                            errorFullScreen(
                              context,
                              func: () {
                                BlocProvider.of<
                                    ReportVisitDoctorBloc>(
                                  context,
                                ).add(
                                  AllReportVisitDoctorEvent(
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

                        if (state
                        is AllReadErrorState) {
                          return SliverFillRemaining(
                            hasScrollBody:
                            false,

                            child:
                            errorFullScreen(
                              context,
                              func: () {
                                BlocProvider.of<
                                    ReportVisitDoctorBloc>(
                                  context,
                                ).add(
                                  AllReportVisitDoctorEvent(
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
                        // Data
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
                                // =================================
                                // Search
                                // =================================
                                SearchField(
                                  searchController:
                                  searchNoteDoctorController,

                                  onPressed:
                                      (value) {
                                    BlocProvider.of<
                                        ReportVisitDoctorBloc>(
                                      context,
                                    ).add(
                                      SenSearchNoteVisitDoctorEvent(
                                        value,
                                      ),
                                    );
                                  },
                                ),

                                SizedBox(
                                  height:
                                  searchBottomSpacing,
                                ),

                                // =================================
                                // Total
                                // =================================
                                buildTotalReportsCard(
                                  doctorNoteModel
                                      .length,
                                  'إجمالي التقارير',
                                  'لهذا الشهر',
                                ),

                                // =================================
                                // Read All Actions
                                // =================================
                                if (iscanedite)
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
                                      spacing:
                                      10,
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

                                          icon:
                                          Icons.bookmarks_rounded,

                                          color:
                                          const Color(
                                            0xFF1E3A8A,
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
                                                  UserInfo.repId,
                                                  1,
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

                                          icon:
                                          Icons.bookmark_remove_outlined,

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
                                                  UserInfo.repId,
                                                  1,
                                                  0,
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ],
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
                                    final index =
                                        entry.key;

                                    final doctorNote =
                                        entry.value;

                                    return _buildDoctorVisitCard(
                                      doctorNoteModel:
                                      doctorNote,

                                      index:
                                      index,

                                      indexRep:
                                      indexRep,

                                      iscanedite:
                                      iscanedite,

                                      context:
                                      context,
                                    );
                                  },
                                ),

                                // =================================
                                // Space for bottom input
                                //
                                // آخر كرت ما بيندفن تحت input
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
            // Bottom Input
            //
            // ظلينا محافظين عليه بنفس الاستدعاء
            // =================================================
            stackInputDoctor(
              indexRep: indexRep,
              iscanedite: iscanedite,
            ),
          ],
        ),
      ),
    );
  }

  // =====================================================
  // Doctor Visit Card
  // =====================================================

  Widget _buildDoctorVisitCard({
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

        nameFontSize = 16;
        dateFontSize = 10.5;

        specializationFontSize = 12;
        infoIconSize = 15;

        sectionSpacing = 12;

        noteFontSize = 14;
        break;

    // =================================================
    // Tablet Portrait
    // =================================================
      case AppDeviceType.tabletPortrait:
        cardRadius = 20;
        cardPadding = 20;
        cardBottomSpacing = 14;

        sideBarWidth = 5;

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
        : ColorManager.primary1;

    return Padding(
      padding: EdgeInsets.only(
        bottom: cardBottomSpacing,
      ),

      child: Material(
        color: Colors.transparent,

        child: InkWell(
          borderRadius:
          BorderRadius.circular(
            cardRadius,
          ),

          // =================================================
          // نفس السلوك
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
            decoration: BoxDecoration(
              color: Colors.white,

              borderRadius:
              BorderRadius.circular(
                cardRadius,
              ),

              // Border موحد حتى ما نرجع لمشكلة
              // borderRadius + border مختلف
              border: Border.all(
                color: const Color(
                  0xFFE2E8F0,
                ),
              ),

              boxShadow: [
                BoxShadow(
                  color:
                  Colors.black.withOpacity(
                    0.025,
                  ),

                  blurRadius: 12,

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
            // Stack للشريط الجانبي
            // بدون IntrinsicHeight
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
                      // Name + Date
                      // =========================================
                      Row(
                        crossAxisAlignment:
                        CrossAxisAlignment
                            .start,

                        children: [
                          // =====================================
                          // Doctor Name
                          // =====================================
                          Expanded(
                            child: Text(
                              doctorNoteModel
                                  .docTitle,

                              maxLines: 2,

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

                                height: 1.25,
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
                              horizontal: 8,
                              vertical: 5,
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

                            child: Row(
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
                                  width: 5,
                                ),

                                Text(
                                  doctorNoteModel
                                      .visitDate,

                                  maxLines: 1,

                                  style:
                                  TextStyle(
                                    color:
                                    const Color(
                                      0xFF64748B,
                                    ),

                                    fontSize:
                                    dateFontSize,

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
                            _buildSpecialization(
                              doctorNoteModel:
                              doctorNoteModel,

                              fontSize:
                              specializationFontSize,

                              iconSize:
                              infoIconSize,
                            ),

                            if (iscanedite) ...[
                              const SizedBox(
                                height: 10,
                              ),

                              Align(
                                alignment:
                                Alignment
                                    .centerLeft,

                                child:
                                _buildCardActions(
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
                              _buildSpecialization(
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
                                width: 12,
                              ),

                              _buildCardActions(
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
                      //
                      // نفس helpers الموجودة بالمشروع
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
                            isStar: true,
                          ),
                        ],
                      ),

                      SizedBox(
                        height:
                        sectionSpacing,
                      ),

                      // =========================================
                      // Scientific Office Note
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

                            height: 1.5,
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
                //
                // ما في border غير موحد
                // وما في infinite height
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
  // Specialization
  // =====================================================

  Widget _buildSpecialization({
    required dynamic doctorNoteModel,
    required double fontSize,
    required double iconSize,
  }) {
    return Row(
      mainAxisSize:
      MainAxisSize.min,

      children: [
        Container(
          width: iconSize + 12,
          height: iconSize + 12,

          alignment:
          Alignment.center,

          decoration:
          BoxDecoration(
            color: const Color(
              0xFFEFF6FF,
            ),

            borderRadius:
            BorderRadius.circular(
              8,
            ),
          ),

          child: Icon(
            Icons.local_offer_outlined,

            size: iconSize,

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
            doctorNoteModel.spTitle,

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
  // Card Actions
  //
  // نفس أحداث الكود الأصلي
  // =====================================================

  Widget _buildCardActions({
    required BuildContext context,
    required dynamic doctorNoteModel,
    required int index,
    required int indexRep,
  }) {
    return BlocBuilder<
        ReportVisitDoctorBloc,
        ReportVisitDoctorState>(
      builder: (context, state) {
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
                  context: context,

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
                    "2",
                    UserInfo.repType.i,
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
                  ChangeReadDocNoteEvent(
                    repVisitsModel:
                    doctorNoteModel,

                    index:
                    indexRep,

                    indexBook:
                    index,
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