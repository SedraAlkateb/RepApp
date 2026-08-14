import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/doctors/widget/html_info.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/resources/responsive/app_ui.dart';
import 'package:domina_app/presentation/senior/search_doctors/bloc/search_doctors_bloc.dart';
import 'package:domina_app/presentation/senior/search_doctors/widgets/detail_row.dart';
import 'package:domina_app/presentation/uniti/stateWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DoctorInfo extends StatelessWidget {
  const DoctorInfo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final ui = AppUi.of(context);

    return Scaffold(
      backgroundColor: const Color(
        0xFFF8FAFC,
      ),

      // =====================================================
      // AppBar
      // =====================================================
      appBar: AppBar(
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
          "معلومات الطبيب",
          style: TextStyle(
            color: ColorManager.medicalPrimary,
            fontSize: ui.cardTitleSize,
            fontWeight: FontWeight.w700,
          ),
        ),

        centerTitle: false,

        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Divider(
            height: 1,
            thickness: 1,
            color: Color(
              0xFFF1F5F9,
            ),
          ),
        ),
      ),

      // =====================================================
      // Bloc
      // =====================================================
      body: BlocBuilder<
          SearchDoctorsBloc,
          SearchDoctorsState>(
        builder: (
            context,
            state,
            ) {
          // ===================================================
          // Loading
          // ===================================================
          if (state is DoctorInfoLoadingState) {
            return _buildStatePage(
              context,
              child: loadingFullScreen(
                context,
              ),
            );
          }

          // ===================================================
          // Error
          // ===================================================
          if (state is DoctorInfoErrorState) {
            return _buildStatePage(
              context,
              child: errorFullScreen(
                context,
              ),
            );
          }

          // ===================================================
          // Success
          // ===================================================
          if (state is DoctorInfoState) {
            final DoctorModel doctor =
                state.doctor;

            final String cleanName =
            doctor.title.trim();

            final String firstLetter =
            cleanName.isNotEmpty
                ? cleanName[0].toUpperCase()
                : "?";

            return CustomScrollView(
              physics:
              const BouncingScrollPhysics(),

              slivers: [
                // ===============================================
                // Doctor Profile
                // ===============================================
                _buildDoctorProfile(
                  context,
                  doctor,
                  firstLetter,
                ),

                // ===============================================
                // Doctor Details
                // ===============================================
                SliverToBoxAdapter(
                  child: Padding(
                    padding:
                    EdgeInsets.fromLTRB(
                      ui.pagePadding,
                      ui.sectionSpacing,
                      ui.pagePadding,
                      ui.pageBottomPadding,
                    ),

                    child: Center(
                      child: ConstrainedBox(
                        constraints:
                        BoxConstraints(
                          maxWidth:
                          ui.pageMaxWidth,
                        ),

                        child:
                        _buildDetailsCard(
                          context,
                          doctor,
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
  // Doctor Profile Wrapper
  // =======================================================

  Widget _buildDoctorProfile(
      BuildContext context,
      DoctorModel doctor,
      String firstLetter,
      ) {
    final ui = AppUi.of(context);

    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          ui.pagePadding,
          ui.pageTopPadding,
          ui.pagePadding,
          0,
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
                // =============================================
                // Tablet / Landscape
                // =============================================
                if (constraints.maxWidth >= 600) {
                  return _buildWideProfile(
                    context,
                    doctor,
                    firstLetter,
                  );
                }

                // =============================================
                // Mobile
                // =============================================
                return _buildCompactProfile(
                  context,
                  doctor,
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
  // Mobile Profile
  // =======================================================

  Widget _buildCompactProfile(
      BuildContext context,
      DoctorModel doctor,
      String firstLetter,
      ) {
    final ui = AppUi.of(context);

    return Container(
      width: double.infinity,

      padding: EdgeInsets.all(
        ui.cardPadding,
      ),

      decoration:
      _profileDecoration(ui),

      child: Column(
        children: [
          // =================================================
          // Avatar
          // =================================================
          _buildAvatar(
            context,
            firstLetter,
          ),

          SizedBox(
            height:
            ui.mediumSpacing,
          ),

          // =================================================
          // Doctor Name
          // =================================================
          Text(
            doctor.title,

            maxLines: 2,

            overflow:
            TextOverflow.ellipsis,

            textAlign:
            TextAlign.center,

            style: TextStyle(
              color: Colors.white,
              fontSize:
              ui.pageTitleSize,
              fontWeight:
              FontWeight.w700,
              height: 1.25,
            ),
          ),

          SizedBox(
            height:
            ui.sectionSpacing,
          ),

          // =================================================
          // Specialization
          // =================================================
          _buildProfileInfoChip(
            context,
            icon:
            Icons
                .medical_services_outlined,
            value:
            doctor.spTitle,
          ),
        ],
      ),
    );
  }

  // =======================================================
  // Tablet / Landscape Profile
  // =======================================================

  Widget _buildWideProfile(
      BuildContext context,
      DoctorModel doctor,
      String firstLetter,
      ) {
    final ui = AppUi.of(context);

    return Container(
      width: double.infinity,

      padding: EdgeInsets.all(
        ui.cardPadding,
      ),

      decoration:
      _profileDecoration(ui),

      child: Row(
        crossAxisAlignment:
        CrossAxisAlignment.center,

        children: [
          // =================================================
          // Avatar
          // =================================================
          _buildAvatar(
            context,
            firstLetter,
            compact: true,
          ),

          SizedBox(
            width:
            ui.sectionSpacing,
          ),

          // =================================================
          // Name
          // =================================================
          Expanded(
            flex: 5,

            child: Text(
              doctor.title,

              maxLines: 2,

              overflow:
              TextOverflow.ellipsis,

              style: TextStyle(
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

          SizedBox(
            width:
            ui.largeSpacing,
          ),

          Container(
            width: 1,
            height: 52,
            color: Colors.white.withOpacity(
              0.20,
            ),
          ),

          SizedBox(
            width:
            ui.largeSpacing,
          ),

          // =================================================
          // Specialization
          // =================================================
          Expanded(
            flex: 4,

            child:
            _buildProfileInfoTile(
              context,

              icon:
              Icons
                  .medical_services_outlined,

              value:
              doctor.spTitle,
            ),
          ),
        ],
      ),
    );
  }

  // =======================================================
  // Profile Decoration
  // =======================================================

  BoxDecoration _profileDecoration(
      AppUi ui,
      ) {
    return BoxDecoration(
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

          blurRadius:
          14,

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
  // Avatar
  // =======================================================

  Widget _buildAvatar(
      BuildContext context,
      String firstLetter, {
        bool compact = false,
      }) {
    final ui = AppUi.of(context);

    final double size =
    compact
        ? ui.iconBoxSize + 8
        : ui.iconBoxSize + 18;

    return Container(
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
          Colors.white.withOpacity(
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
          ui.pageTitleSize + 5,

          fontWeight:
          FontWeight.w800,
        ),
      ),
    );
  }

  // =======================================================
  // Mobile Specialization Chip
  // =======================================================

  Widget _buildProfileInfoChip(
      BuildContext context, {
        required IconData icon,
        required String value,
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
              value,

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
  // Tablet Specialization Tile
  // =======================================================

  Widget _buildProfileInfoTile(
      BuildContext context, {
        required IconData icon,
        required String value,
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

            color:
            Colors.white,

            size:
            ui.smallIconSize,
          ),
        ),

        SizedBox(
          width:
          ui.mediumSpacing,
        ),

        Expanded(
          child: Text(
            value,

            maxLines: 2,

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
  // Details Card
  // =======================================================

  Widget _buildDetailsCard(
      BuildContext context,
      DoctorModel doctor,
      ) {
    final ui = AppUi.of(context);

    return Container(
      width: double.infinity,

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
            Colors.black.withOpacity(
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
          CrossAxisAlignment.stretch,

          children: [
            // =================================================
            // Section Title
            // =================================================
            Row(
              children: [
                Container(
                  width:
                  ui.iconBoxSize,

                  height:
                  ui.iconBoxSize,

                  alignment:
                  Alignment.center,

                  decoration:
                  BoxDecoration(
                    color:
                    ColorManager
                        .medicalPrimary
                        .withOpacity(
                      0.07,
                    ),

                    borderRadius:
                    BorderRadius.circular(
                      ui.smallRadius +
                          2,
                    ),
                  ),

                  child:
                  Icon(
                    Icons
                        .badge_outlined,

                    color:
                    ColorManager
                        .medicalPrimary,

                    size:
                    ui.iconSize,
                  ),
                ),

                SizedBox(
                  width:
                  ui.sectionSpacing,
                ),

                Expanded(
                  child:
                  Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,

                    children: [
                      Text(
                        "التفاصيل",

                        style:
                        TextStyle(
                          color:
                          const Color(
                            0xFF1E293B,
                          ),

                          fontSize:
                          ui.cardTitleSize,

                          fontWeight:
                          FontWeight.w700,
                        ),
                      ),

                      SizedBox(
                        height:
                        ui.smallSpacing /
                            2,
                      ),

                      Text(
                        "معلومات الطبيب الأساسية",

                        style:
                        TextStyle(
                          color:
                          const Color(
                            0xFF94A3B8,
                          ),

                          fontSize:
                          ui.smallTextSize,

                          fontWeight:
                          FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            SizedBox(
              height:
              ui.sectionSpacing,
            ),

            const Divider(
              height: 1,
              thickness: 1,
              color: Color(
                0xFFF1F5F9,
              ),
            ),

            SizedBox(
              height:
              ui.smallSpacing,
            ),

            // =================================================
            // Place
            // =================================================
            buildDetailRow(
              context,
              Icons.place_outlined,
              'المنطقة',
              doctor.placeTitle,
            ),

            _buildDivider(),

            // =================================================
            // Address
            // =================================================
            buildDetailRow(
              context,
              Icons.location_city_outlined,
              'العنوان',
              doctor.address,
            ),

            _buildDivider(),

            // =================================================
            // Visits
            // =================================================
            buildDetailRow(
              context,
              Icons.visibility_outlined,
              'عدد الزيارات',
              '${doctor.visits}',
            ),

            _buildDivider(),

            // =================================================
            // Rate
            // =================================================
            buildDetailRow(
              context,
              Icons.star_outline_rounded,
              'التصنيف',
              '${doctor.rate}',
            ),

            // =================================================
            // Notes
            // نفس الشرط الأصلي
            // =================================================
            if (doctor.note != null &&
                doctor.note!.isNotEmpty) ...[
              _buildDivider(),

              buildHtmlDetailRow(
                context,
                Icons.note_alt_outlined,
                'ملاحظات',
                doctor.note ?? '',
              ),
            ],

            // =================================================
            // Work Hours
            // نفس الشرط الأصلي
            // =================================================
            if (doctor.workHours != null &&
                doctor.workHours!.isNotEmpty &&
                doctor.workHours != " ") ...[
              _buildDivider(),

              buildHtmlDetailRow(
                context,
                Icons.schedule_outlined,
                'أوقات العمل',
                doctor.workHours ?? '',
              ),
            ],
          ],
        ),
      ),
    );
  }

  // =======================================================
  // Detail Divider
  // =======================================================

  Widget _buildDivider() {
    return const Divider(
      height: 1,
      thickness: 1,
      color: Color(
        0xFFF1F5F9,
      ),
    );
  }

  // =======================================================
  // Loading / Error
  // =======================================================

  Widget _buildStatePage(
      BuildContext context, {
        required Widget child,
      }) {
    final ui = AppUi.of(context);

    return Center(
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
    );
  }
}