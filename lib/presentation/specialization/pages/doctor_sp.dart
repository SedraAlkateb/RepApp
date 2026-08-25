// ignore_for_file: deprecated_member_use

import 'package:domina_app/presentation/Recipes/widget/doctor_recipe.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/resources/responsive/app_ui.dart';
import 'package:domina_app/presentation/specialization/bloc/specialization_bloc.dart';
import 'package:domina_app/presentation/uniti/num_list.dart';
import 'package:domina_app/presentation/uniti/stateWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DoctorSp extends StatefulWidget {
  const DoctorSp({
    super.key,
  });

  @override
  State<DoctorSp> createState() => _DoctorSpState();
}

class _DoctorSpState extends State<DoctorSp> {
  @override
  Widget build(BuildContext context) {
    final ui = AppUi.of(context);

    // =========================================================
    // صفحة قائمة بعمود واحد
    // =========================================================
    final double contentMaxWidth = ui.isTabletLandscape ? 760 : ui.pageMaxWidth;

    return Scaffold(
      backgroundColor: const Color(
        0xFFF8FAFC,
      ),
      body: SafeArea(
        top: false,
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: contentMaxWidth,
            ),
            child: BlocConsumer<SpecializationBloc, SpecializationState>(
              // =================================================
              // نفس listener الأصلي
              // =================================================
              listener: (
                context,
                state,
              ) {
                if (state is AllSpecDoctorErrorState) {
                  WidgetsBinding.instance.addPostFrameCallback(
                    (_) {
                      error(
                        context,
                        state.failure.massage,
                        state.failure.code,
                      );
                    },
                  );
                }
              },

              builder: (
                context,
                state,
              ) {
                // =================================================
                // نفس شرط العرض الأصلي
                // =================================================
                if (state is AllDoctorSpState) {
                  final doctors = state.doctors;

                  return CustomScrollView(
                    physics: const BouncingScrollPhysics(),
                    keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior.onDrag,
                    slivers: [
                      // =============================================
                      // Count / Header
                      // =============================================
                      SliverPadding(
                        padding: EdgeInsets.fromLTRB(
                          ui.pagePadding,
                          ui.listTopPadding,
                          ui.pagePadding,
                          ui.sectionSpacing,
                        ),
                        sliver: SliverToBoxAdapter(
                          child: buildTotalReportsCard(
                            doctors.length,
                            'قائمة الأطباء المسجلين',
                            '',
                          ),
                        ),
                      ),

                      // =============================================
                      // Empty
                      // =============================================
                      if (doctors.isEmpty)
                        SliverFillRemaining(
                          hasScrollBody: false,
                          child: emptyFullScreen(
                            context,
                          ),
                        )

                      // =============================================
                      // Doctors
                      // =============================================
                      else
                        SliverPadding(
                          padding: EdgeInsets.fromLTRB(
                            ui.pagePadding,
                            0,
                            ui.pagePadding,
                            ui.listBottomPadding,
                          ),
                          sliver: SliverList.builder(
                            itemCount: doctors.length,
                            itemBuilder: (
                              context,
                              index,
                            ) {
                              final doctor = doctors[index];

                              return _buildDoctorCard(
                                context,
                                ui,
                                doctor,
                              );
                            },
                          ),
                        ),
                    ],
                  );
                }

                // =================================================
                // نفس السلوك السابق لباقي الـStates
                // =================================================
                return const SizedBox.shrink();
              },
            ),
          ),
        ),
      ),
    );
  }

  // ===========================================================
  // Doctor Card
  // ===========================================================

  Widget _buildDoctorCard(
    BuildContext context,
    AppUi ui,
    dynamic doctor,
  ) {
    final String address = doctor.address?.toString().trim() ?? '';

    final String visits = doctor.visits?.toString().trim() ?? '0';

    return Container(
      margin: EdgeInsets.only(
        bottom: ui.cardSpacing,
      ),
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
              0.03,
            ),
            blurRadius: 12,
            offset: const Offset(
              0,
              4,
            ),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(
          ui.cardRadius,
        ),
        child: Material(
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.all(
              ui.cardPadding,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ===============================================
                // Doctor Header
                // ===============================================
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // ===========================================
                    // Icon
                    // ===========================================
                    Container(
                      width: ui.iconBoxSize,
                      height: ui.iconBoxSize,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: ColorManager.medicalPrimary.withOpacity(
                          0.08,
                        ),
                        borderRadius: BorderRadius.circular(
                          ui.smallRadius + 2,
                        ),
                      ),
                      child: Icon(
                        Icons.person_outline_rounded,
                        size: ui.iconSize,
                        color: ColorManager.medicalPrimary,
                      ),
                    ),

                    SizedBox(
                      width: ui.mediumSpacing,
                    ),

                    // ===========================================
                    // Name
                    // ===========================================
                    Expanded(
                      child: Text(
                        doctor.title.toString(),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: ui.cardTitleSize,
                          fontWeight: FontWeight.w700,
                          color: ColorManager.medicalPrimary,
                          height: 1.3,
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(
                  height: ui.sectionSpacing,
                ),

                // ===============================================
                // Address
                // ===============================================
                _buildInfoTile(
                  ui: ui,
                  icon: Icons.location_on_outlined,
                  text: address.isEmpty ? 'غير محدد' : address,
                ),

                SizedBox(
                  height: ui.smallSpacing,
                ),

                // ===============================================
                // Visits
                // ===============================================
                _buildVisitsTile(
                  ui,
                  visits,
                ),

                SizedBox(
                  height: ui.sectionSpacing,
                ),

                const Divider(
                  height: 1,
                  thickness: 0.6,
                  color: Color(
                    0xFFE2E8F0,
                  ),
                ),

                SizedBox(
                  height: ui.mediumSpacing,
                ),

                // ===============================================
                // Actions
                // نفس السلوك الأصلي
                // ===============================================
                Row(
                  children: [
                    PrescriptionMenuWidget(
                      doctorId: doctor.id,
                    ),
                    const Spacer(),

                    /*
                    InkWell(
                      onTap: () =>
                          Navigator.pushNamed(
                        context,
                        Routes.doctorDetails,
                        arguments: doctor,
                      ),
                      child: buildCardButton(
                        context,
                        "عرض التفاصيل",
                        ColorManager.medicalPrimary,
                        Colors.white,
                        Icons.directions_run,
                      ),
                    ),
                    */
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ===========================================================
  // Info Tile
  // ===========================================================

  Widget _buildInfoTile({
    required AppUi ui,
    required IconData icon,
    required String text,
  }) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: ui.mediumSpacing,
        vertical: ui.isMobile ? 10 : 11,
      ),
      decoration: BoxDecoration(
        color: const Color(
          0xFFF8FAFC,
        ),
        borderRadius: BorderRadius.circular(
          ui.smallRadius + 1,
        ),
        border: Border.all(
          color: const Color(
            0xFFE2E8F0,
          ),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            size: ui.smallIconSize + 1,
            color: const Color(
              0xFF64748B,
            ),
          ),
          SizedBox(
            width: ui.smallSpacing,
          ),
          Expanded(
            child: Text(
              text,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: ui.bodyTextSize,
                fontWeight: FontWeight.w500,
                color: const Color(
                  0xFF475569,
                ),
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ===========================================================
  // Visits Tile
  // ===========================================================

  Widget _buildVisitsTile(
    AppUi ui,
    String visits,
  ) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: ui.mediumSpacing,
        vertical: ui.isMobile ? 10 : 11,
      ),
      decoration: BoxDecoration(
        color: const Color(
          0xFFF0FDF4,
        ),
        borderRadius: BorderRadius.circular(
          ui.smallRadius + 1,
        ),
        border: Border.all(
          color: const Color(
            0xFFDCFCE7,
          ),
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.event_available_outlined,
            size: ui.smallIconSize + 1,
            color: const Color(
              0xFF16A34A,
            ),
          ),
          SizedBox(
            width: ui.smallSpacing,
          ),
          Expanded(
            child: Text(
              'عدد الزيارات: $visits',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: ui.bodyTextSize,
                fontWeight: FontWeight.w600,
                color: const Color(
                  0xFF15803D,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
