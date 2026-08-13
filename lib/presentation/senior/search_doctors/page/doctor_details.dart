import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/resources/responsive/app_ui.dart';
import 'package:domina_app/presentation/resources/routes_manager.dart';
import 'package:domina_app/presentation/senior/search_doctors/bloc/search_doctors_bloc.dart';
import 'package:domina_app/presentation/senior/search_doctors/widgets/info_row_item.dart';
import 'package:domina_app/presentation/uniti/search_field.dart';
import 'package:domina_app/presentation/uniti/stateWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DoctorDetails extends StatefulWidget {
  const DoctorDetails({
    super.key,
    required this.doctorModel,
  });

  final doctorsModel doctorModel;

  @override
  State<DoctorDetails> createState() =>
      _DoctorDetailsState();
}

class _DoctorDetailsState
    extends State<DoctorDetails>
    with AutomaticKeepAliveClientMixin {
  final TextEditingController searchNoteDoctorController =
  TextEditingController();

  @override
  void dispose() {
    searchNoteDoctorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final ui = AppUi.of(context);

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),

      body: BlocBuilder<
          SearchDoctorsBloc,
          SearchDoctorsState>(
        // =====================================================
        // نفس حالات البناء الأصلية
        // =====================================================
        buildWhen: (
            previous,
            current,
            ) {
          return current is FutureDocDoctorsState ||
              current is FutureDocDoctorsErrorState ||
              current is FutureDocDoctorsLoadingState ||
              current is FutureDocDoctorsEmptyState;
        },

        builder: (
            context,
            state,
            ) {
          // ===================================================
          // Error
          // ===================================================
          if (state is FutureDocDoctorsErrorState) {
            return _buildStatePage(
              context,
              child: errorFullScreen(
                context,
                mes: state.failure.massage,
                func: () {},
              ),
            );
          }

          // ===================================================
          // Loading
          // ===================================================
          if (state is FutureDocDoctorsLoadingState) {
            return _buildStatePage(
              context,
              child: loadingFullScreen(
                context,
              ),
            );
          }

          // ===================================================
          // Empty
          // ===================================================
          if (state is FutureDocDoctorsEmptyState) {
            return _buildStatePage(
              context,
              child: emptyFullScreen(
                context,
              ),
            );
          }

          // ===================================================
          // Success
          // ===================================================
          if (state is FutureDocDoctorsState) {
            final String cleanName =
            widget.doctorModel.name.trim();

            final String firstLetter =
            cleanName.isNotEmpty
                ? cleanName[0].toUpperCase()
                : "?";

            return CustomScrollView(
              physics: const BouncingScrollPhysics(),

              keyboardDismissBehavior:
              ScrollViewKeyboardDismissBehavior
                  .onDrag,

              slivers: [
                // ===============================================
                // AppBar
                // ===============================================
                _buildDoctorAppBar(
                  context,
                ),

                // ===============================================
                // Doctor Information
                // ===============================================
                _buildDoctorProfileSection(
                  context,
                  firstLetter,
                ),

                // ===============================================
                // Search
                // ===============================================
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(
                      ui.pagePadding,
                      ui.searchTopPadding,
                      ui.pagePadding,
                      ui.searchBottomPadding,
                    ),
                    child: Center(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          maxWidth: ui.pageMaxWidth,
                        ),
                        child: SearchField(
                          searchController:
                          searchNoteDoctorController,
                          onPressed: (value) {
                            BlocProvider.of<SearchDoctorsBloc>(
                              context,
                            ).add(
                              SearchNoteDoctorEvent(
                                value,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                // ===============================================
                // Reports
                // ===============================================
                SliverPadding(
                  padding:
                  EdgeInsets.fromLTRB(
                    ui.pagePadding,
                    ui.listTopPadding,
                    ui.pagePadding,
                    ui.listBottomPadding,
                  ),

                  sliver:
                  SliverList(
                    delegate:
                    SliverChildBuilderDelegate(
                          (
                          context,
                          index,
                          ) {
                        final report =
                        state
                            .doctordetails[
                        index];

                        return Center(
                          child:
                          ConstrainedBox(
                            constraints:
                            BoxConstraints(
                              maxWidth:
                              ui.pageMaxWidth,
                            ),

                            child:
                            _buildReportCard(
                              context,

                              repName:
                              report.repName,

                              visitDate:
                              report.visitDate,

                              note:
                              report.note
                                  .toString(),
                            ),
                          ),
                        );
                      },

                      childCount:
                      state
                          .doctordetails
                          .length,
                    ),
                  ),
                ),
              ],
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  // =======================================================
  // AppBar
  // =======================================================

  SliverAppBar _buildDoctorAppBar(
      BuildContext context,
      ) {
    final ui = AppUi.of(context);

    return SliverAppBar(
      pinned: true,

      elevation: 0,
      scrolledUnderElevation: 0,

      backgroundColor: Colors.white,
      surfaceTintColor: Colors.transparent,

      leading: IconButton(
        tooltip: "رجوع",

        onPressed: () {
          Navigator.pop(
            context,
          );
        },

        icon: Icon(
          Icons.arrow_back_ios_new_rounded,
          color: ColorManager.medicalPrimary,
          size: ui.iconSize,
        ),
      ),

      title: Text(
        "تقارير الطبيب",

        maxLines: 1,

        overflow:
        TextOverflow.ellipsis,

        style: TextStyle(
          color:
          ColorManager.medicalPrimary,

          fontSize:
          ui.cardTitleSize,

          fontWeight:
          FontWeight.w700,
        ),
      ),

      bottom: const PreferredSize(
        preferredSize:
        Size.fromHeight(1),

        child: Divider(
          height: 1,
          thickness: 1,
          color: Color(
            0xFFF1F5F9,
          ),
        ),
      ),
    );
  }

  // =======================================================
  // Doctor Profile
  // =======================================================

  Widget _buildDoctorProfileSection(
      BuildContext context,
      String firstLetter,
      ) {
    final ui = AppUi.of(context);

    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          ui.pagePadding,
          ui.pageTopPadding,
          ui.pagePadding,
          ui.smallSpacing,
        ),
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: ui.pageMaxWidth,
            ),
            child: LayoutBuilder(
              builder: (
                  context,
                  constraints,
                  ) {
                if (constraints.maxWidth >= 600) {
                  return _buildWideDoctorProfile(
                    context,
                    firstLetter,
                  );
                }

                return _buildCompactDoctorProfile(
                  context,
                  firstLetter,
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  // =======================================================
  // Portrait Doctor Profile
  // =======================================================

  Widget _buildCompactDoctorProfile(
      BuildContext context,
      String firstLetter,
      ) {
    final ui = AppUi.of(context);

    return Container(
      width: double.infinity,

      padding: EdgeInsets.all(
        ui.cardPadding,
      ),

      decoration:
      _doctorProfileDecoration(
        ui,
      ),

      child: Column(
        children: [
          // =================================================
          // Avatar
          // =================================================
          _buildDoctorAvatar(
            context,
            firstLetter,
          ),

          SizedBox(
            height:
            ui.mediumSpacing,
          ),

          // =================================================
          // Name
          // =================================================
          _buildDoctorName(
            context,
            textAlign:
            TextAlign.center,
          ),

          SizedBox(
            height:
            ui.sectionSpacing,
          ),

          // =================================================
          // Details
          // =================================================
          Wrap(
            alignment:
            WrapAlignment.center,

            spacing:
            ui.smallSpacing,

            runSpacing:
            ui.smallSpacing,

            children: [
              _buildDoctorInfoChip(
                context,

                icon:
                Icons
                    .medical_services_outlined,

                label:
                widget
                    .doctorModel
                    .spTitle,
              ),

              _buildDoctorInfoChip(
                context,

                icon:
                Icons
                    .location_on_outlined,

                label:
                widget
                    .doctorModel
                    .placeTitle,
              ),
            ],
          ),
        ],
      ),
    );
  }

  // =======================================================
  // Wide / Landscape Doctor Profile
  // =======================================================

  Widget _buildWideDoctorProfile(
      BuildContext context,
      String firstLetter,
      ) {
    final ui = AppUi.of(context);

    return Container(
      width: double.infinity,

      padding: EdgeInsets.all(
        ui.cardPadding,
      ),

      decoration:
      _doctorProfileDecoration(
        ui,
      ),

      child: Row(
        crossAxisAlignment:
        CrossAxisAlignment.center,

        children: [
          // =================================================
          // Avatar
          // =================================================
          _buildDoctorAvatar(
            context,
            firstLetter,
            compact: true,
          ),

          SizedBox(
            width:
            ui.sectionSpacing,
          ),

          // =================================================
          // Doctor name
          // =================================================
          Expanded(
            flex: 4,

            child:
            _buildDoctorName(
              context,

              textAlign:
              TextAlign.start,
            ),
          ),

          SizedBox(
            width:
            ui.largeSpacing,
          ),

          // =================================================
          // Divider
          // =================================================
          Container(
            width: 1,
            height: 54,

            color: Colors.white
                .withOpacity(
              0.20,
            ),
          ),

          SizedBox(
            width:
            ui.largeSpacing,
          ),

          // =================================================
          // Details
          // =================================================
          Expanded(
            flex: 5,

            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment
                  .stretch,

              children: [
                _buildDoctorInfoTile(
                  context,

                  icon:
                  Icons
                      .medical_services_outlined,

                  label:
                  widget
                      .doctorModel
                      .spTitle,
                ),

                SizedBox(
                  height:
                  ui.smallSpacing,
                ),

                _buildDoctorInfoTile(
                  context,

                  icon:
                  Icons
                      .location_on_outlined,

                  label:
                  widget
                      .doctorModel
                      .placeTitle,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // =======================================================
  // Doctor Blue Container Decoration
  // =======================================================

  BoxDecoration _doctorProfileDecoration(
      AppUi ui,
      ) {
    return BoxDecoration(
      // =====================================================
      // مثل التصميم القديم: معلومات الطبيب بالأزرق
      // =====================================================
      color:
      ColorManager.medicalPrimary,

      borderRadius:
      BorderRadius.circular(
        ui.cardRadius,
      ),

      boxShadow: [
        BoxShadow(
          color:
          ColorManager.medicalPrimary
              .withOpacity(
            0.16,
          ),

          blurRadius: 14,

          offset:
          const Offset(
            0,
            5,
          ),
        ),
      ],
    );
  }

  // =======================================================
  // Doctor Avatar
  // =======================================================

  Widget _buildDoctorAvatar(
      BuildContext context,
      String firstLetter, {
        bool compact = false,
      }) {
    final ui = AppUi.of(context);

    final double size =
    compact
        ? ui.iconBoxSize + 8
        : ui.iconBoxSize + 18;

    return Material(
      color: Colors.transparent,

      child: InkWell(
        onTap:
        _openDoctorInfo,

        borderRadius:
        BorderRadius.circular(
          ui.cardRadius,
        ),

        child: Container(
          width: size,
          height: size,

          alignment:
          Alignment.center,

          decoration:
          BoxDecoration(
            color:
            Colors.white.withOpacity(
              0.14,
            ),

            borderRadius:
            BorderRadius.circular(
              ui.cardRadius,
            ),

            border:
            Border.all(
              color:
              Colors.white
                  .withOpacity(
                0.25,
              ),

              width:
              1.5,
            ),
          ),

          child: Text(
            firstLetter,

            style:
            TextStyle(
              color:
              Colors.white,

              fontSize:
              ui.pageTitleSize +
                  5,

              fontWeight:
              FontWeight.w800,
            ),
          ),
        ),
      ),
    );
  }

  // =======================================================
  // Doctor Name
  // =======================================================

  Widget _buildDoctorName(
      BuildContext context, {
        required TextAlign textAlign,
      }) {
    final ui = AppUi.of(context);

    return Material(
      color: Colors.transparent,

      child: InkWell(
        onTap:
        _openDoctorInfo,

        borderRadius:
        BorderRadius.circular(
          ui.smallRadius,
        ),

        child: Padding(
          padding:
          EdgeInsets.symmetric(
            vertical:
            ui.smallSpacing,
          ),

          child: Text(
            widget.doctorModel.name,

            maxLines: 2,

            overflow:
            TextOverflow.ellipsis,

            textAlign:
            textAlign,

            style:
            TextStyle(
              color:
              Colors.white,

              fontSize:
              ui.pageTitleSize,

              fontWeight:
              FontWeight.w700,

              height:
              1.25,
            ),
          ),
        ),
      ),
    );
  }

  // =======================================================
  // Portrait Info Chip
  // =======================================================

  Widget _buildDoctorInfoChip(
      BuildContext context, {
        required IconData icon,
        required String label,
      }) {
    final ui = AppUi.of(context);

    return Container(
      constraints:
      BoxConstraints(
        maxWidth:
        ui.isMobile
            ? 280
            : 360,
      ),

      padding:
      EdgeInsets.symmetric(
        horizontal:
        ui.mediumSpacing,

        vertical:
        ui.smallSpacing,
      ),

      decoration:
      BoxDecoration(
        color:
        Colors.white
            .withOpacity(
          0.12,
        ),

        borderRadius:
        BorderRadius.circular(
          ui.smallRadius,
        ),

        border:
        Border.all(
          color:
          Colors.white
              .withOpacity(
            0.18,
          ),
        ),
      ),

      child: Row(
        mainAxisSize:
        MainAxisSize.min,

        children: [
          Icon(
            icon,

            size:
            ui.smallIconSize,

            color:
            Colors.white,
          ),

          SizedBox(
            width:
            ui.smallSpacing,
          ),

          Flexible(
            child: Text(
              label,

              maxLines: 1,

              overflow:
              TextOverflow.ellipsis,

              style:
              TextStyle(
                color:
                Colors.white,

                fontSize:
                ui.smallTextSize,

                fontWeight:
                FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // =======================================================
  // Landscape Info Tile
  // =======================================================

  Widget _buildDoctorInfoTile(
      BuildContext context, {
        required IconData icon,
        required String label,
      }) {
    final ui = AppUi.of(context);

    return Row(
      children: [
        Container(
          width:
          ui.smallIconSize + 14,

          height:
          ui.smallIconSize + 14,

          alignment:
          Alignment.center,

          decoration:
          BoxDecoration(
            color:
            Colors.white
                .withOpacity(
              0.12,
            ),

            borderRadius:
            BorderRadius.circular(
              ui.smallRadius,
            ),
          ),

          child: Icon(
            icon,

            size:
            ui.smallIconSize,

            color:
            Colors.white,
          ),
        ),

        SizedBox(
          width:
          ui.mediumSpacing,
        ),

        Expanded(
          child: Text(
            label,

            maxLines: 1,

            overflow:
            TextOverflow.ellipsis,

            style:
            TextStyle(
              color:
              Colors.white
                  .withOpacity(
                0.92,
              ),

              fontSize:
              ui.bodyTextSize,

              fontWeight:
              FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  // =======================================================
  // Open Doctor Info
  // =======================================================

  void _openDoctorInfo() {
    // =====================================================
    // نفس السلوك ونفس الترتيب الأصلي
    // =====================================================

    BlocProvider.of<
        SearchDoctorsBloc>(
      context,
    ).add(
      DoctorInfoEvent(
        widget.doctorModel.id,
      ),
    );

    Navigator.pushNamed(
      context,
      Routes.doctorInfo,
    );
  }

  // =======================================================
  // Report Card
  // =======================================================

  Widget _buildReportCard(
      BuildContext context, {
        required String repName,
        required String visitDate,
        required String note,
      }) {
    final ui = AppUi.of(context);

    final String displayedNote =
    note.isNotEmpty
        ? note
        : "لا توجد ملاحظات مسجلة.";

    return Padding(
      padding:
      EdgeInsets.only(
        bottom:
        ui.cardSpacing,
      ),

      child: Container(
        width:
        double.infinity,

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

        child: Padding(
          padding:
          EdgeInsets.all(
            ui.cardPadding,
          ),

          child: Column(
            crossAxisAlignment:
            CrossAxisAlignment
                .stretch,

            children: [
              // =================================================
              // Representative + Date
              // =================================================
              _buildReportMeta(
                context,

                repName:
                repName,

                visitDate:
                visitDate,
              ),

              SizedBox(
                height:
                ui.sectionSpacing,
              ),

              // =================================================
              // Note
              // =================================================
              Container(
                width:
                double.infinity,

                padding:
                EdgeInsets.all(
                  ui.cardPadding -
                      3,
                ),

                decoration:
                BoxDecoration(
                  color:
                  const Color(
                    0xFFF8FAFC,
                  ),

                  borderRadius:
                  BorderRadius.circular(
                    ui.smallRadius +
                        2,
                  ),

                  border:
                  Border.all(
                    color:
                    const Color(
                      0xFFF1F5F9,
                    ),
                  ),
                ),

                child:
                Column(
                  crossAxisAlignment:
                  CrossAxisAlignment
                      .start,

                  children: [
                    Row(
                      children: [
                        Container(
                          width:
                          ui.smallIconSize +
                              14,

                          height:
                          ui.smallIconSize +
                              14,

                          alignment:
                          Alignment.center,

                          decoration:
                          BoxDecoration(
                            color:
                            ColorManager
                                .secondaryColor1
                                .withOpacity(
                              0.07,
                            ),

                            borderRadius:
                            BorderRadius.circular(
                              ui.smallRadius,
                            ),
                          ),

                          child:
                          Icon(
                            Icons
                                .rate_review_outlined,

                            color:
                            ColorManager
                                .secondaryColor1,

                            size:
                            ui.smallIconSize,
                          ),
                        ),

                        SizedBox(
                          width:
                          ui.mediumSpacing,
                        ),

                        Expanded(
                          child:
                          Text(
                            "ملاحظات المكتب العلمي",

                            style:
                            TextStyle(
                              fontSize:
                              ui.bodyTextSize,

                              fontWeight:
                              FontWeight.w700,

                              color:
                              ColorManager
                                  .secondaryColor1,
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(
                      height:
                      ui.mediumSpacing,
                    ),

                    Text(
                      displayedNote,

                      style:
                      TextStyle(
                        fontSize:
                        ui.bodyTextSize,

                        color:
                        const Color(
                          0xFF475569,
                        ),

                        fontWeight:
                        FontWeight.w500,

                        height:
                        1.5,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // =======================================================
  // Report Metadata
  // =======================================================

  Widget _buildReportMeta(
      BuildContext context, {
        required String repName,
        required String visitDate,
      }) {
    final ui = AppUi.of(context);

    return LayoutBuilder(
      builder: (
          context,
          constraints,
          ) {
        // =================================================
        // Narrow screens
        // =================================================
        if (constraints.maxWidth <
            390) {
          return Column(
            crossAxisAlignment:
            CrossAxisAlignment
                .stretch,

            children: [
              InfoRowItem(
                icon:
                Icons
                    .person_outline_rounded,

                value:
                repName,
              ),

              SizedBox(
                height:
                ui.smallSpacing,
              ),

              InfoRowItem(
                icon:
                Icons
                    .calendar_month_outlined,

                value:
                visitDate,
              ),
            ],
          );
        }

        // =================================================
        // Wide screens
        // =================================================
        return Row(
          children: [
            Expanded(
              child:
              InfoRowItem(
                icon:
                Icons
                    .person_outline_rounded,

                value:
                repName,
              ),
            ),

            SizedBox(
              width:
              ui.sectionSpacing,
            ),

            Expanded(
              child:
              InfoRowItem(
                icon:
                Icons
                    .calendar_month_outlined,

                value:
                visitDate,
              ),
            ),
          ],
        );
      },
    );
  }

  // =======================================================
  // Loading / Error / Empty
  // =======================================================

  Widget _buildStatePage(
      BuildContext context, {
        required Widget child,
      }) {
    final ui = AppUi.of(context);

    return CustomScrollView(
      physics:
      const BouncingScrollPhysics(),

      slivers: [
        SliverFillRemaining(
          hasScrollBody:
          false,

          child: Center(
            child:
            ConstrainedBox(
              constraints:
              BoxConstraints(
                maxWidth:
                ui.pageMaxWidth,
              ),

              child:
              Padding(
                padding:
                EdgeInsets.all(
                  ui.pagePadding,
                ),

                child:
                child,
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}