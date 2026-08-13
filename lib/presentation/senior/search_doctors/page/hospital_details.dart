import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/resources/responsive/app_ui.dart';
import 'package:domina_app/presentation/senior/search_doctors/bloc/search_doctors_bloc.dart';
import 'package:domina_app/presentation/senior/search_doctors/widgets/info_row_item.dart';
import 'package:domina_app/presentation/uniti/search_field.dart';
import 'package:domina_app/presentation/uniti/stateWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HospitalDetails extends StatefulWidget {
  const HospitalDetails({
    super.key,
    required this.searchHospitalModel,
  });

  final SearchHospitalModel searchHospitalModel;

  @override
  State<HospitalDetails> createState() =>
      _HospitalDetailsState();
}

class _HospitalDetailsState
    extends State<HospitalDetails>
    with AutomaticKeepAliveClientMixin {
  final TextEditingController searchNoteHospitalController =
  TextEditingController();

  @override
  void dispose() {
    searchNoteHospitalController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final ui = AppUi.of(context);

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: BlocBuilder<SearchDoctorsBloc, SearchDoctorsState>(
        // =====================================================
        // نفس buildWhen الأصلي
        // =====================================================
        buildWhen: (previous, current) =>
        current is FutureDocHospitalsState ||
            current is FutureDocHospitalsErrorState ||
            current is FutureDocHospitalsLoadingState ||
            current is FutureDocHospitalsEmptyState,

        builder: (context, state) {
          // ===================================================
          // Error
          // ===================================================
          if (state is FutureDocHospitalsErrorState) {
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
          if (state is FutureDocHospitalsLoadingState) {
            return _buildStatePage(
              context,
              child: loadingFullScreen(context),
            );
          }

          // ===================================================
          // Empty
          // ===================================================
          if (state is FutureDocHospitalsEmptyState) {
            return _buildStatePage(
              context,
              child: emptyFullScreen(context),
            );
          }

          // ===================================================
          // Success
          // ===================================================
          if (state is FutureDocHospitalsState) {
            final String cleanName =
            widget.searchHospitalModel.name.trim();

            return CustomScrollView(
              physics: const BouncingScrollPhysics(),
              keyboardDismissBehavior:
              ScrollViewKeyboardDismissBehavior.onDrag,

              slivers: [
                // ===============================================
                // AppBar
                // ===============================================
                _buildHospitalAppBar(context),

                // ===============================================
                // Hospital Profile
                // ===============================================
                _buildHospitalProfileSection(
                  context,
                  cleanName,
                ),

                // ===============================================
                // Search
                //
                // نفس عرض الكرت الأزرق والـList
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
                          searchNoteHospitalController,
                          onPressed: (value) {
                            // نفس Event الأصلي
                            BlocProvider.of<SearchDoctorsBloc>(
                              context,
                            ).add(
                              SearchNoteHosEvent(value),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),

                // ===============================================
                // Reports
                //
                // نفس Wrapper المستخدم للكرت الأزرق والبحث
                // ===============================================
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(
                      ui.pagePadding,
                      ui.listTopPadding,
                      ui.pagePadding,
                      ui.listBottomPadding,
                    ),
                    child: Center(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          maxWidth: ui.pageMaxWidth,
                        ),
                        child: ListView.builder(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          physics:
                          const NeverScrollableScrollPhysics(),
                          itemCount: state.allNote.length,
                          itemBuilder: (context, index) {
                            final report =
                            state.allNote[index];

                            return _buildReportCard(
                              context,
                              repName: report.name,
                              visitDate: report.visitDate,
                              note: report.note.toString(),
                            );
                          },
                        ),
                      ),
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

  SliverAppBar _buildHospitalAppBar(
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
          Navigator.pop(context);
        },
        icon: Icon(
          Icons.arrow_back_ios_new_rounded,
          color: ColorManager.medicalPrimary,
          size: ui.iconSize,
        ),
      ),

      title: Text(
        "تقارير المشفى",
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          color: ColorManager.medicalPrimary,
          fontSize: ui.cardTitleSize,
          fontWeight: FontWeight.w700,
        ),
      ),

      bottom: const PreferredSize(
        preferredSize: Size.fromHeight(1),
        child: Divider(
          height: 1,
          thickness: 1,
          color: Color(0xFFF1F5F9),
        ),
      ),
    );
  }

  // =======================================================
  // Hospital Profile Section
  // =======================================================

  Widget _buildHospitalProfileSection(
      BuildContext context,
      String firstLetter,
      ) {
    final ui = AppUi.of(context);

    return SliverToBoxAdapter(
      child: Padding(
        // مهم:
        // Padding خارج ConstrainedBox
        // حتى يكون نفس عرض البحث والـList
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
              builder: (context, constraints) {
                if (constraints.maxWidth >= 600) {
                  return _buildWideHospitalProfile(
                    context,
                    firstLetter,
                  );//
                }

                return _buildCompactHospitalProfile(
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
  // Mobile / Portrait
  // =======================================================

  Widget _buildCompactHospitalProfile(
      BuildContext context,
      String firstLetter,
      ) {
    final ui = AppUi.of(context);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(
        ui.cardPadding,
      ),
      decoration: _hospitalProfileDecoration(ui),
      child: Column(
        children: [
          // =================================================
          // Hospital Icon / Letter
          // =================================================
          _buildHospitalAvatar(
            context,
            firstLetter,
          ),

          SizedBox(
            height: ui.mediumSpacing,
          ),

          // =================================================
          // Hospital Name
          // =================================================
          _buildHospitalName(
            context,
            textAlign: TextAlign.center,
          ),

          SizedBox(
            height: ui.sectionSpacing,
          ),

          // =================================================
          // Small hospital label
          // =================================================
          _buildHospitalTypeChip(
            context,
          ),
        ],
      ),
    );
  }

  // =======================================================
  // Tablet / Wide
  // =======================================================

  Widget _buildWideHospitalProfile(
      BuildContext context,
      String firstLetter,
      ) {
    final ui = AppUi.of(context);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(
        ui.cardPadding,
      ),
      decoration: _hospitalProfileDecoration(ui),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // =================================================
          // Avatar
          // =================================================


          SizedBox(
            width: ui.sectionSpacing,
          ),

          // =================================================
          // Hospital Name
          // =================================================
          Expanded(
            child: _buildHospitalName(
              context,
              textAlign: TextAlign.start,
            ),
          ),

          SizedBox(
            width: ui.largeSpacing,
          ),

          Container(
            width: 1,
            height: 54,
            color: Colors.white.withOpacity(
              0.20,
            ),
          ),

          SizedBox(
            width: ui.largeSpacing,
          ),

          // =================================================
          // Hospital Type
          // =================================================
          _buildHospitalTypeTile(
            context,
          ),
        ],
      ),
    );
  }

  // =======================================================
  // Blue Hospital Container
  // =======================================================

  BoxDecoration _hospitalProfileDecoration(
      AppUi ui,
      ) {
    return BoxDecoration(
      // نفس الهوية الزرقاء لـ DoctorDetails
      color: ColorManager.medicalPrimary,

      borderRadius: BorderRadius.circular(
        ui.cardRadius,
      ),

      boxShadow: [
        BoxShadow(
          color: ColorManager.medicalPrimary.withOpacity(
            0.16,
          ),
          blurRadius: 14,
          offset: const Offset(
            0,
            5,
          ),
        ),
      ],
    );
  }

  // =======================================================
  // Hospital Avatar
  // =======================================================

  Widget _buildHospitalAvatar(
      BuildContext context,
      String firstLetter, {
        bool compact = false,
      }) {
    final ui = AppUi.of(context);

    final double size = compact
        ? ui.iconBoxSize + 8
        : ui.iconBoxSize + 18;

    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(
          0.14,
        ),
        borderRadius: BorderRadius.circular(
          ui.cardRadius,
        ),
        border: Border.all(
          color: Colors.white.withOpacity(
            0.25,
          ),
          width: 1.5,
        ),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Text(
            firstLetter,
            style: TextStyle(
              color: Colors.white,
              fontSize: ui.pageTitleSize + 5,
              fontWeight: FontWeight.w800,
            ),
          ),

          Positioned(
            right: 4,
            bottom: 4,
            child: Icon(
              Icons.local_hospital_rounded,
              size: ui.smallIconSize,
              color: Colors.white.withOpacity(
                0.65,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // =======================================================
  // Hospital Name
  // =======================================================

  Widget _buildHospitalName(
      BuildContext context, {
        required TextAlign textAlign,
      }) {
    final ui = AppUi.of(context);

    return Text(
      widget.searchHospitalModel.name,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      textAlign: textAlign,
      style: TextStyle(
        color: Colors.white,
        fontSize: ui.pageTitleSize,
        fontWeight: FontWeight.w700,
        height: 1.25,
      ),
    );
  }

  // =======================================================
  // Portrait Type Chip
  // =======================================================

  Widget _buildHospitalTypeChip(
      BuildContext context,
      ) {
    final ui = AppUi.of(context);

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: ui.mediumSpacing,
        vertical: ui.smallSpacing,
      ),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(
          0.12,
        ),
        borderRadius: BorderRadius.circular(
          ui.smallRadius,
        ),
        border: Border.all(
          color: Colors.white.withOpacity(
            0.18,
          ),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.local_hospital_outlined,
            color: Colors.white,
            size: ui.smallIconSize,
          ),

          SizedBox(
            width: ui.smallSpacing,
          ),

          Text(
            "مشفى",
            style: TextStyle(
              color: Colors.white,
              fontSize: ui.smallTextSize,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  // =======================================================
  // Landscape Type
  // =======================================================

  Widget _buildHospitalTypeTile(
      BuildContext context,
      ) {
    final ui = AppUi.of(context);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: ui.smallIconSize + 14,
          height: ui.smallIconSize + 14,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(
              0.12,
            ),
            borderRadius: BorderRadius.circular(
              ui.smallRadius,
            ),
          ),
          child: Icon(
            Icons.local_hospital_outlined,
            color: Colors.white,
            size: ui.smallIconSize,
          ),
        ),

        SizedBox(
          width: ui.mediumSpacing,
        ),

        Text(
          "مشفى",
          style: TextStyle(
            color: Colors.white.withOpacity(
              0.92,
            ),
            fontSize: ui.bodyTextSize,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
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

    // =====================================================
    // نفس شرط الملاحظة الأصلي تماماً
    // =====================================================
    final bool hasNote =
        note.trim().isNotEmpty &&
            note != "null";

    final String displayedNote = hasNote
        ? note
        : "لا توجد ملاحظات مسجلة.";

    return Padding(
      padding: EdgeInsets.only(
        bottom: ui.cardSpacing,
      ),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(
            ui.cardRadius,
          ),
          border: Border.all(
            color: const Color(
              0xFFE2E8F0,
            ),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(
                0.025,
              ),
              blurRadius: 12,
              offset: const Offset(
                0,
                4,
              ),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.all(
            ui.cardPadding,
          ),
          child: Column(
            crossAxisAlignment:
            CrossAxisAlignment.stretch,
            children: [
              // =================================================
              // Representative + Date
              // =================================================
              _buildReportMeta(
                context,
                repName: repName,
                visitDate: visitDate,
              ),

              SizedBox(
                height: ui.sectionSpacing,
              ),

              // =================================================
              // Scientific Office Note
              // =================================================
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(
                  ui.cardPadding - 3,
                ),
                decoration: BoxDecoration(
                  color: const Color(
                    0xFFF8FAFC,
                  ),
                  borderRadius:
                  BorderRadius.circular(
                    ui.smallRadius + 2,
                  ),
                  border: Border.all(
                    color: const Color(
                      0xFFF1F5F9,
                    ),
                  ),
                ),
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width:
                          ui.smallIconSize + 14,
                          height:
                          ui.smallIconSize + 14,
                          alignment:
                          Alignment.center,
                          decoration: BoxDecoration(
                            color: ColorManager
                                .secondaryColor1
                                .withOpacity(
                              0.07,
                            ),
                            borderRadius:
                            BorderRadius.circular(
                              ui.smallRadius,
                            ),
                          ),
                          child: Icon(
                            Icons
                                .rate_review_outlined,
                            color: ColorManager
                                .secondaryColor1,
                            size: ui.smallIconSize,
                          ),
                        ),

                        SizedBox(
                          width: ui.mediumSpacing,
                        ),

                        Expanded(
                          child: Text(
                            "ملاحظات المكتب العلمي",
                            style: TextStyle(
                              fontSize:
                              ui.bodyTextSize,
                              fontWeight:
                              FontWeight.w700,
                              color: ColorManager
                                  .secondaryColor1,
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(
                      height: ui.mediumSpacing,
                    ),

                    Text(
                      displayedNote,
                      style: TextStyle(
                        fontSize: ui.bodyTextSize,
                        color: const Color(
                          0xFF475569,
                        ),
                        fontWeight: FontWeight.w500,
                        height: 1.5,
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
        // Narrow Mobile
        // =================================================
        if (constraints.maxWidth < 390) {
          return Column(
            crossAxisAlignment:
            CrossAxisAlignment.stretch,
            children: [
              InfoRowItem(
                icon:
                Icons.person_outline_rounded,
                value: repName,
              ),

              SizedBox(
                height: ui.smallSpacing,
              ),

              InfoRowItem(
                icon:
                Icons.calendar_month_outlined,
                value: visitDate,
              ),
            ],
          );
        }

        // =================================================
        // Wide
        // =================================================
        return Row(
          children: [
            Expanded(
              flex: 5,
              child: InfoRowItem(
                icon:
                Icons.person_outline_rounded,
                value: repName,
              ),
            ),

            SizedBox(
              width: ui.sectionSpacing,
            ),

            Expanded(
              flex: 4,
              child: InfoRowItem(
                icon:
                Icons.calendar_month_outlined,
                value: visitDate,
              ),
            ),
          ],
        );
      },
    );
  }

  // =======================================================
  // Error / Loading / Empty
  // =======================================================

  Widget _buildStatePage(
      BuildContext context, {
        required Widget child,
      }) {
    final ui = AppUi.of(context);

    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        SliverFillRemaining(
          hasScrollBody: false,
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: ui.pageMaxWidth,
              ),
              child: Padding(
                padding: EdgeInsets.all(
                  ui.pagePadding,
                ),
                child: child,
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