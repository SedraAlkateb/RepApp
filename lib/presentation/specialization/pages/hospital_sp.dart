// ignore_for_file: deprecated_member_use

import 'package:domina_app/presentation/Recipes/widget/hospital_recipe.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/resources/responsive/app_ui.dart';
import 'package:domina_app/presentation/specialization/bloc/specialization_bloc.dart';
import 'package:domina_app/presentation/uniti/num_list.dart';
import 'package:domina_app/presentation/uniti/stateWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HospitalSp extends StatefulWidget {
  const HospitalSp({
    super.key,
  });

  @override
  State<HospitalSp> createState() =>
      _HospitalSpState();
}

class _HospitalSpState
    extends State<HospitalSp> {
  @override
  Widget build(BuildContext context) {
    final ui = AppUi.of(context);

    // =========================================================
    // Single column page
    // =========================================================
    final double contentMaxWidth =
    ui.isTabletLandscape
        ? 760
        : ui.pageMaxWidth;

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

            child: BlocConsumer<
                SpecializationBloc,
                SpecializationState>(
              // =================================================
              // نفس Listener الأصلي
              // =================================================
              listener: (
                  context,
                  state,
                  ) {
                if (state
                is AllSpecDoctorErrorState) {
                  WidgetsBinding.instance
                      .addPostFrameCallback(
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
                if (state
                is AllHospitalSpState) {
                  final hospitals =
                      state.hospitals;

                  return CustomScrollView(
                    physics:
                    const BouncingScrollPhysics(),

                    keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior
                        .onDrag,

                    slivers: [
                      // =============================================
                      // Count / Header
                      // =============================================
                      SliverPadding(
                        padding:
                        EdgeInsets.fromLTRB(
                          ui.pagePadding,
                          ui.listTopPadding,
                          ui.pagePadding,
                          ui.sectionSpacing,
                        ),

                        sliver:
                        SliverToBoxAdapter(
                          child:
                          buildTotalReportsCard(
                            hospitals.length,
                            'قائمة المشافي المسجلة',
                            '',
                          ),
                        ),
                      ),

                      // =============================================
                      // Empty
                      // =============================================
                      if (hospitals.isEmpty)
                        SliverFillRemaining(
                          hasScrollBody:
                          false,

                          child:
                          emptyFullScreen(
                            context,
                          ),
                        )

                      // =============================================
                      // Hospitals
                      // =============================================
                      else
                        SliverPadding(
                          padding:
                          EdgeInsets.fromLTRB(
                            ui.pagePadding,
                            0,
                            ui.pagePadding,
                            ui.listBottomPadding,
                          ),

                          sliver:
                          SliverList.builder(
                            itemCount:
                            hospitals.length,

                            itemBuilder:
                                (
                                context,
                                index,
                                ) {
                              final hospital =
                              hospitals[index];

                              return _buildHospitalCard(
                                context,
                                ui,
                                hospital,
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
  // Hospital Card
  // ===========================================================

  Widget _buildHospitalCard(
      BuildContext context,
      AppUi ui,
      dynamic hospital,
      ) {
    final bool hasNote =
        hospital.note != null &&
            hospital.note
                .toString()
                .trim()
                .isNotEmpty;

    return Container(
      margin: EdgeInsets.only(
        bottom: ui.cardSpacing,
      ),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius:
        BorderRadius.circular(
          ui.cardRadius,
        ),

        border: Border.all(
          color: const Color(
            0xFFE2E8F0,
          ),
        ),

        boxShadow: [
          BoxShadow(
            color: Colors.black
                .withOpacity(
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
        borderRadius:
        BorderRadius.circular(
          ui.cardRadius,
        ),

        child: Material(
          color: Colors.white,

          child: Padding(
            padding: EdgeInsets.all(
              ui.cardPadding,
            ),

            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,

              children: [
                // ===============================================
                // Hospital Header
                // ===============================================
                Row(
                  crossAxisAlignment:
                  CrossAxisAlignment.center,

                  children: [
                    // ===========================================
                    // Icon
                    // ===========================================
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
                          0.08,
                        ),

                        borderRadius:
                        BorderRadius
                            .circular(
                          ui.smallRadius +
                              2,
                        ),
                      ),

                      child: Icon(
                        Icons
                            .local_hospital_outlined,

                        size:
                        ui.iconSize,

                        color:
                        ColorManager
                            .medicalPrimary,
                      ),
                    ),

                    SizedBox(
                      width:
                      ui.mediumSpacing,
                    ),

                    // ===========================================
                    // Name
                    // ===========================================
                    Expanded(
                      child: Text(
                        hospital.title
                            .toString(),

                        maxLines: 2,

                        overflow:
                        TextOverflow
                            .ellipsis,

                        style:
                        TextStyle(
                          fontSize:
                          ui.cardTitleSize,

                          fontWeight:
                          FontWeight.w700,

                          color:
                          ColorManager
                              .medicalPrimary,

                          height: 1.3,
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(
                  height:
                  ui.sectionSpacing,
                ),

                // ===============================================
                // Place
                // ===============================================
                _buildInfoTile(
                  ui: ui,

                  icon:
                  Icons.location_on_outlined,

                  text:
                  hospital.placeTitle
                      .toString(),
                ),

                // ===============================================
                // Note
                // نفس الشرط الأصلي
                // ===============================================
                if (hasNote) ...[
                  SizedBox(
                    height:
                    ui.smallSpacing,
                  ),

                  _buildNoteTile(
                    ui,
                    hospital.note
                        .toString(),
                  ),
                ],

                SizedBox(
                  height:
                  ui.sectionSpacing,
                ),

                const Divider(
                  height: 1,

                  thickness: 0.6,

                  color: Color(
                    0xFFE2E8F0,
                  ),
                ),

                SizedBox(
                  height:
                  ui.mediumSpacing,
                ),

                // ===============================================
                // Actions
                // نفس السلوك الأصلي
                // ===============================================
                Row(
                  children: [
                    PrescriptionHospitalMenuWidget(
                      hospitalId:
                      hospital.id,
                    ),

                    const Spacer(),

                    /*
                    InkWell(
                      onTap: () =>
                          Navigator.pushNamed(
                        context,
                        Routes.hospitalDetails,
                        arguments: hospital,
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
        horizontal:
        ui.mediumSpacing,
        vertical:
        ui.isMobile ? 10 : 11,
      ),

      decoration: BoxDecoration(
        color: const Color(
          0xFFF8FAFC,
        ),

        borderRadius:
        BorderRadius.circular(
          ui.smallRadius + 1,
        ),

        border: Border.all(
          color: const Color(
            0xFFE2E8F0,
          ),
        ),
      ),

      child: Row(
        crossAxisAlignment:
        CrossAxisAlignment.start,

        children: [
          Icon(
            icon,

            size:
            ui.smallIconSize + 1,

            color: const Color(
              0xFF64748B,
            ),
          ),

          SizedBox(
            width:
            ui.smallSpacing,
          ),

          Expanded(
            child: Text(
              text.trim().isEmpty
                  ? 'غير محدد'
                  : text,

              maxLines: 2,

              overflow:
              TextOverflow.ellipsis,

              style: TextStyle(
                fontSize:
                ui.bodyTextSize,

                fontWeight:
                FontWeight.w500,

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
  // Note
  // ===========================================================

  Widget _buildNoteTile(
      AppUi ui,
      String note,
      ) {
    return Container(
      width: double.infinity,

      padding: EdgeInsets.symmetric(
        horizontal:
        ui.mediumSpacing,
        vertical:
        ui.isMobile ? 10 : 11,
      ),

      decoration: BoxDecoration(
        color: const Color(
          0xFFFFFBEB,
        ),

        borderRadius:
        BorderRadius.circular(
          ui.smallRadius + 1,
        ),

        border: Border.all(
          color: const Color(
            0xFFFEF3C7,
          ),
        ),
      ),

      child: Row(
        crossAxisAlignment:
        CrossAxisAlignment.start,

        children: [
          Icon(
            Icons.note_alt_outlined,

            size:
            ui.smallIconSize + 1,

            color: const Color(
              0xFFD97706,
            ),
          ),

          SizedBox(
            width:
            ui.smallSpacing,
          ),

          Expanded(
            child: Text(
              note,

              style: TextStyle(
                fontSize:
                ui.bodyTextSize,

                color: const Color(
                  0xFF92400E,
                ),

                fontWeight:
                FontWeight.w500,

                height: 1.45,
              ),
            ),
          ),
        ],
      ),
    );
  }
}