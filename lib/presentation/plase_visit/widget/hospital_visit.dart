// ignore_for_file: deprecated_member_use

import 'package:domina_app/data/mapper/mapper.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/Recipes/widget/hospital_recipe.dart';
import 'package:domina_app/presentation/plase_visit/bloc/visit_place_bloc.dart';
import 'package:domina_app/presentation/plase_visit/widget/build_card_buttom.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/resources/responsive/app_ui.dart';
import 'package:domina_app/presentation/resources/routes_manager.dart';
import 'package:domina_app/presentation/uniti/search_field.dart';
import 'package:domina_app/presentation/uniti/stateWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HospitalVisit extends StatefulWidget {
  const HospitalVisit({
    super.key,
  });

  @override
  State<HospitalVisit> createState() =>
      _HospitalVisitState();
}

class _HospitalVisitState
    extends State<HospitalVisit>
    with AutomaticKeepAliveClientMixin {
  final TextEditingController searchController =
  TextEditingController();

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final ui = AppUi.of(context);

    return Scaffold(
      backgroundColor: const Color(
        0xFFF8FAFC,
      ),

      body: Column(
        children: [
          // =====================================================
          // Search
          // دائماً ظاهر حتى لو ما في نتائج
          // =====================================================
          Padding(
            padding: EdgeInsets.fromLTRB(
              ui.pagePadding,
              ui.searchTopPadding,
              ui.pagePadding,
              ui.searchBottomPadding,
            ),

            child: SearchField(
              searchController:
              searchController,

              onPressed: (value) {
                // =================================================
                // نفس سلوك البحث الأصلي
                // =================================================
                context
                    .read<VisitPlaceBloc>()
                    .add(
                  SearchHospitalVisitEvent(
                    value: value,
                  ),
                );
              },
            ),
          ),

          // =====================================================
          // Content
          // =====================================================
          Expanded(
            child: BlocConsumer<
                VisitPlaceBloc,
                VisitPlaceState>(
              // =================================================
              // نفس Listener الأصلي
              // =================================================
              listener: (
                  context,
                  state,
                  ) {
                if (state
                is AllHospitalByPlaceErrorState) {
                  WidgetsBinding
                      .instance
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

              // =================================================
              // نفس الحالات الأصلية
              // =================================================
              buildWhen: (
                  previous,
                  current,
                  ) =>
              current is EmptyState ||
                  current
                  is SearchVisitHospitalState ||
                  current
                  is AllHospitalByPlaceState,

              builder: (
                  context,
                  state,
                  ) {
                List<HospitalSpAllModel>
                hospitals =
                    context
                        .watch<VisitPlaceBloc>()
                        .hospitals;

                // ===============================================
                // Search Result
                // ===============================================
                if (state
                is SearchVisitHospitalState) {
                  hospitals =
                      state.hospitalVisit;
                }

                // ===============================================
                // All Hospitals
                // ===============================================
                if (state
                is AllHospitalByPlaceState) {
                  hospitals =
                      state.data;
                }

                // ===============================================
                // Empty
                //
                // السيرش بيضل ظاهر لأنه خارج الـ Expanded
                // ===============================================
                if (state is EmptyState ||
                    hospitals.isEmpty) {
                  return emptyFullScreen(
                    context,
                  );
                }

                // ===============================================
                // Hospitals List
                // ===============================================
                return ListView.builder(
                  physics:
                  const BouncingScrollPhysics(),

                  keyboardDismissBehavior:
                  ScrollViewKeyboardDismissBehavior
                      .onDrag,

                  padding:
                  EdgeInsets.fromLTRB(
                    ui.pagePadding,
                    ui.listTopPadding,
                    ui.pagePadding,
                    ui.listBottomPadding,
                  ),

                  itemCount:
                  hospitals.length,

                  itemBuilder: (
                      context,
                      index,
                      ) {
                    final hospital =
                    hospitals[index];

                    return _HospitalVisitCard(
                      hospital:
                      hospital,

                      ui: ui,

                      onVisit: () {
                        // =========================================
                        // نفس Navigation الأصلي
                        // =========================================
                        Navigator.pushNamed(
                          context,
                          Routes.visitHospital,
                          arguments:
                          hospital.toDomain(),
                        );
                      },
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
// Hospital Visit Card
// ============================================================================

class _HospitalVisitCard
    extends StatelessWidget {
  const _HospitalVisitCard({
    required this.hospital,
    required this.ui,
    required this.onVisit,
  });

  final HospitalSpAllModel hospital;
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
            color:
            Colors.black.withOpacity(
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
        crossAxisAlignment:
        CrossAxisAlignment.start,

        children: [
          // =====================================================
          // Hospital Header
          // =====================================================
          Row(
            crossAxisAlignment:
            CrossAxisAlignment.center,

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
                  color: ColorManager
                      .medicalPrimary
                      .withOpacity(
                    0.08,
                  ),

                  borderRadius:
                  BorderRadius.circular(
                    ui.smallRadius + 2,
                  ),
                ),

                child: Icon(
                  Icons
                      .local_hospital_outlined,

                  size:
                  ui.iconSize,

                  color: ColorManager
                      .medicalPrimary,
                ),
              ),

              SizedBox(
                width:
                ui.mediumSpacing,
              ),

              Expanded(
                child: Text(
                  hospital.title ?? '',

                  maxLines: 2,

                  overflow:
                  TextOverflow.ellipsis,

                  style: TextStyle(
                    fontSize:
                    ui.cardTitleSize,

                    fontWeight:
                    FontWeight.w700,

                    color: ColorManager
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

          // =====================================================
          // Address
          // =====================================================
          Container(
            width: double.infinity,

            padding:
            EdgeInsets.symmetric(
              horizontal:
              ui.mediumSpacing,
              vertical:
              ui.isMobile ? 10 : 11,
            ),

            decoration:
            BoxDecoration(
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
                  Icons
                      .location_on_outlined,

                  size:
                  ui.smallIconSize +
                      1,

                  color:
                  const Color(
                    0xFF94A3B8,
                  ),
                ),

                SizedBox(
                  width:
                  ui.smallSpacing,
                ),

                Expanded(
                  child: Text(
                    _addressText(
                      hospital.address,
                    ),

                    maxLines: 3,

                    overflow:
                    TextOverflow
                        .ellipsis,

                    style:
                    TextStyle(
                      color:
                      const Color(
                        0xFF64748B,
                      ),

                      fontSize:
                      ui.bodyTextSize,

                      fontWeight:
                      FontWeight.w500,

                      height: 1.4,
                    ),
                  ),
                ),
              ],
            ),
          ),

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
            ui.sectionSpacing,
          ),

          // =====================================================
          // Actions
          // =====================================================
          Row(
            crossAxisAlignment:
            CrossAxisAlignment.center,

            children: [
              // =================================================
              // Prescription
              // نفس السلوك الأصلي
              // =================================================
              Flexible(
                child:
                PrescriptionHospitalMenuWidget(
                  hospitalId:
                  hospital.id ??
                      hospital
                          .hospitalId,
                ),
              ),

              SizedBox(
                width:
                ui.mediumSpacing,
              ),

              const Spacer(),

              // =================================================
              // Start Visit
              // نفس السلوك الأصلي
              // =================================================
              InkWell(
                borderRadius:
                BorderRadius.circular(
                  ui.smallRadius,
                ),

                onTap:
                onVisit,

                child:
                buildCardButton(
                  context,
                  'بدء زيارة',
                  ColorManager
                      .medicalPrimary,
                  Colors.white,
                  Icons
                      .directions_run,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _addressText(
      String? address,
      ) {
    if (address == null ||
        address.trim().isEmpty) {
      return 'العنوان غير محدد';
    }

    return address;
  }
}