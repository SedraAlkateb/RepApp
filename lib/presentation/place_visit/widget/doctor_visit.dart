// ignore_for_file: deprecated_member_use

import 'package:domina_app/presentation/uniti/animation/pressable_effect.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/Recipes/widget/doctor_recipe.dart';
import 'package:domina_app/presentation/place_visit/bloc/visit_place_bloc.dart';
import 'package:domina_app/presentation/place_visit/widget/build_card_buttom.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/resources/responsive/app_ui.dart';
import 'package:domina_app/presentation/resources/routes_manager.dart';
import 'package:domina_app/presentation/uniti/search_field.dart';
import 'package:domina_app/presentation/uniti/stateWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DoctorVisit extends StatefulWidget {
  const DoctorVisit({
    super.key,
  });

  @override
  State<DoctorVisit> createState() => _DoctorVisitState();
}

class _DoctorVisitState extends State<DoctorVisit>
    with AutomaticKeepAliveClientMixin {
  final TextEditingController searchController = TextEditingController();

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final ui = AppUi.of(context);
    final double contentMaxWidth = ui.isTabletLandscape ? 760 : ui.pageMaxWidth;

    // ملاحظة: بدون ConstrainedBox خارجي حول القائمة، حتى يضل السكرول
    // بالماوس يشتغل فوق الفراغ الجانبي بالعرض؛ قيد contentMaxWidth يُطبَّق
    // داخلياً على السيرش وعلى كل بطاقة لحالها.
    return Scaffold(
      backgroundColor: const Color(
        0xFFF8FAFC,
      ),
      body: Column(
        children: [
          // =====================================================
          // Search
          // يبقى ظاهر حتى لو ما في نتائج
          // =====================================================
          Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: contentMaxWidth),
              child: Padding(
                padding: EdgeInsets.fromLTRB(
                  ui.pagePadding,
                  ui.searchTopPadding,
                  ui.pagePadding,
                  ui.searchBottomPadding,
                ),
                child: SearchField(
                  searchController: searchController,
                  onPressed: (value) {
                    // نفس السلوك الأصلي
                    context.read<VisitPlaceBloc>().add(
                          SearchDoctorVisitEvent(
                            value: value,
                          ),
                        );
                  },
                ),
              ),
            ),
          ),

          // =====================================================
          // Content
          // =====================================================
          Expanded(
            child: BlocConsumer<VisitPlaceBloc, VisitPlaceState>(
              listener: (
                context,
                state,
              ) {
                // نفس السلوك الأصلي
                if (state is AllDoctorByPlaceErrorState) {
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
                List<DoctorModel> doctors =
                    context.watch<VisitPlaceBloc>().doctors;

                // ===============================================
                // Search Result
                // ===============================================
                if (state is SearchVisitDoctorState) {
                  doctors = state.doctorVisit;
                }

                // ===============================================
                // All Doctors
                // ===============================================
                if (state is AllDoctorByPlaceState) {
                  doctors = state.data;
                }

                // ===============================================
                // Empty
                // السيرش ما بيروح لأنه برا هالـExpanded
                // ===============================================
                if (state is EmptyState || doctors.isEmpty) {
                  return emptyFullScreen(
                    context,
                  );
                }

                // ===============================================
                // Doctors List
                // ===============================================
                return ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  padding: EdgeInsets.fromLTRB(
                    ui.pagePadding,
                    ui.listTopPadding,
                    ui.pagePadding,
                    ui.listBottomPadding,
                  ),
                  itemCount: doctors.length,
                  itemBuilder: (
                    context,
                    index,
                  ) {
                    final doctor = doctors[index];

                    return Center(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(maxWidth: contentMaxWidth),
                        child: _DoctorVisitCard(
                          doctor: doctor,
                          ui: ui,
                          onVisit: () {
                            Navigator.pushNamed(
                              context,
                              Routes.visitDoctor,
                              arguments: doctor,
                            );
                          },
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

// ============================================================================
// Doctor Visit Card
// ============================================================================

class _DoctorVisitCard extends StatelessWidget {
  const _DoctorVisitCard({
    required this.doctor,
    required this.ui,
    required this.onVisit,
  });

  final DoctorModel doctor;
  final AppUi ui;
  final VoidCallback onVisit;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        bottom: ui.cardSpacing,
      ),
      padding: EdgeInsets.all(
        ui.cardPadding,
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // =====================================================
          // Header
          // =====================================================
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // ===============================================
              // Doctor Icon
              // ===============================================
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

              // ===============================================
              // Doctor Name + Specialization
              // ===============================================
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            doctor.title,
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
                        SizedBox(
                          width: ui.smallSpacing,
                        ),
                        Flexible(
                          flex: 0,
                          child: _buildSpecializationBadge(
                            doctor.spTitle,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),

          SizedBox(
            height: ui.sectionSpacing,
          ),

          // =====================================================
          // Visit Counter Badge
          // =====================================================
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: ui.mediumSpacing,
              vertical: 8,
            ),
            decoration: BoxDecoration(
              color: const Color(0xFFF1F5F9),
              borderRadius: BorderRadius.circular(ui.smallRadius),
              border: Border.all(
                color: const Color(0xFFCBD5E1),
                width: 0.8,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.assignment_turned_in_outlined,
                  size: ui.smallIconSize,
                  color: ColorManager.medicalPrimary,
                ),
                SizedBox(width: ui.smallSpacing),
                Text(
                  'عدد الزيارات: ',
                  style: TextStyle(
                    fontSize: ui.bodyTextSize,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF475569),
                  ),
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: '${doctor.visited ?? 0}',
                        style: TextStyle(
                          fontSize: ui.bodyTextSize,
                          fontWeight: FontWeight.bold,
                          color: ColorManager.medicalPrimary,
                        ),
                      ),
                      TextSpan(
                        text: ' / ${doctor.visits}',
                        style: TextStyle(
                          fontSize: ui.bodyTextSize,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF64748B),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          SizedBox(
            height: ui.sectionSpacing,
          ),

          // =====================================================
          // Address
          // =====================================================
          Container(
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
                  Icons.location_on_outlined,
                  size: ui.smallIconSize + 1,
                  color: const Color(
                    0xFF94A3B8,
                  ),
                ),
                SizedBox(
                  width: ui.smallSpacing,
                ),
                Expanded(
                  child: Text(
                    doctor.address,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: const Color(
                        0xFF64748B,
                      ),
                      fontSize: ui.bodyTextSize,
                      fontWeight: FontWeight.w500,
                      height: 1.4,
                    ),
                  ),
                ),
              ],
            ),
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
            height: ui.sectionSpacing,
          ),

          // =====================================================
          // Actions
          // =====================================================
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // ===============================================
              // Prescription
              // نفس السلوك الأصلي
              // ===============================================
              Flexible(
                child: PrescriptionMenuWidget(
                  doctorId: doctor.id,
                ),
              ),

              SizedBox(
                width: ui.mediumSpacing,
              ),

              const Spacer(),

              // ===============================================
              // Start Visit
              // ===============================================
              AppInkWell(
                borderRadius: BorderRadius.circular(
                  ui.smallRadius,
                ),
                onTap: onVisit,
                child: buildCardButton(
                  context,
                  'بدء زيارة',
                  ColorManager.medicalPrimary,
                  Colors.white,
                  Icons.directions_run,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ===========================================================
  // Specialization Badge
  // ===========================================================

  Widget _buildSpecializationBadge(
    String specialization,
  ) {
    return Container(
      constraints: const BoxConstraints(
        maxWidth: 150,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: ui.mediumSpacing,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        color: ColorManager.medicalPrimary.withOpacity(
          0.08,
        ),
        borderRadius: BorderRadius.circular(
          ui.smallRadius,
        ),
      ),
      child: Text(
        specialization,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          color: ColorManager.medicalPrimary,
          fontSize: ui.smallTextSize,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
