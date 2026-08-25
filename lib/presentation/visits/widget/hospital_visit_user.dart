// ignore_for_file: deprecated_member_use

import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/plase_visit/widget/build_card_buttom.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/resources/responsive/app_ui.dart';
import 'package:domina_app/presentation/resources/routes_manager.dart';
import 'package:domina_app/presentation/uniti/search_field.dart';
import 'package:domina_app/presentation/uniti/stateWidget.dart';
import 'package:domina_app/presentation/visits/bloc/visit_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HospitalVisitUser extends StatefulWidget {
  const HospitalVisitUser({
    super.key,
  });

  @override
  State<HospitalVisitUser> createState() =>
      _HospitalVisitUserState();
}

class _HospitalVisitUserState
    extends State<HospitalVisitUser>
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
          // =====================================================
          Padding(
            padding: EdgeInsets.fromLTRB(
              ui.pagePadding,
              ui.searchTopPadding,
              ui.pagePadding,
              ui.searchBottomPadding,
            ),
            child: SearchField(
              searchController: searchController,
              onPressed: (value) {
                context.read<VisitBloc>().add(
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
                VisitBloc,
                VisitState>(
              listener: (
                  context,
                  state,
                  ) {
                if (state is VisitHospitalErrorState) {
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
                List<VisitHospitalAndHospital>
                hospitals =
                    context
                        .watch<VisitBloc>()
                        .hospitals;

                // ===============================================
                // All Hospitals
                // ===============================================
                if (state is VisitHospitalState) {
                  hospitals =
                      state.hospitals;
                }

                // ===============================================
                // Search
                // ===============================================
                if (state is SearchVisitHospitalState) {
                  hospitals =
                      state.hospitals;
                }

                // ===============================================
                // Empty
                // السيرش بيضل ظاهر لأنه خارج الـ Expanded
                // ===============================================
                if (state is EmptyVisitHospitalState ||
                    hospitals.isEmpty) {
                  return emptyFullScreen(
                    context,
                  );
                }

                // ===============================================
                // List
                // ===============================================
                return ListView.builder(
                  physics:
                  const BouncingScrollPhysics(),

                  keyboardDismissBehavior:
                  ScrollViewKeyboardDismissBehavior
                      .onDrag,

                  padding: EdgeInsets.fromLTRB(
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
                    final item =
                    hospitals[index];

                    return _HospitalVisitUserCard(
                      item: item,
                      ui: ui,

                      onDetails: () {
                        Navigator.pushNamed(
                          context,
                          Routes.infoVisitHospital,
                          arguments: item,
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
// Hospital Visit User Card
// ============================================================================

class _HospitalVisitUserCard
    extends StatelessWidget {
  const _HospitalVisitUserCard({
    required this.item,
    required this.ui,
    required this.onDetails,
  });

  final VisitHospitalAndHospital item;
  final AppUi ui;
  final VoidCallback onDetails;

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
        crossAxisAlignment:
        CrossAxisAlignment.start,

        children: [
          // =====================================================
          // Header
          // =====================================================
          Row(
            crossAxisAlignment:
            CrossAxisAlignment.center,

            children: [
              Container(
                width: ui.iconBoxSize,
                height: ui.iconBoxSize,

                alignment: Alignment.center,

                decoration: BoxDecoration(
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
                  Icons.local_hospital_outlined,

                  size: ui.iconSize,

                  color:
                  ColorManager.medicalPrimary,
                ),
              ),

              SizedBox(
                width: ui.mediumSpacing,
              ),

              Expanded(
                child: Row(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,

                  children: [
                    Expanded(
                      child: Text(
                        item.hospitalModel.title,

                        maxLines: 2,

                        overflow:
                        TextOverflow.ellipsis,

                        style: TextStyle(
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

                    SizedBox(
                      width:
                      ui.smallSpacing,
                    ),

                    Flexible(
                      flex: 0,
                      child:
                      _buildSpecializationBadge(
                        item.specModel.title,
                      ),
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
          // Place + Address
          // =====================================================
          Container(
            width: double.infinity,

            padding: EdgeInsets.symmetric(
              horizontal: ui.mediumSpacing,
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
                  Icons.location_on_outlined,

                  size:
                  ui.smallIconSize + 1,

                  color: const Color(
                    0xFF94A3B8,
                  ),
                ),

                SizedBox(
                  width: ui.smallSpacing,
                ),

                Expanded(
                  child: Text(
                    '${item.hospitalModel.placeTitle} - '
                        '${item.hospitalModel.address}',

                    maxLines: 3,

                    overflow:
                    TextOverflow.ellipsis,

                    style: TextStyle(
                      color: const Color(
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
          // Date + Details
          // =====================================================
          Row(
            crossAxisAlignment:
            CrossAxisAlignment.center,

            children: [
              Flexible(
                child: Row(
                  mainAxisSize:
                  MainAxisSize.min,

                  children: [
                    Icon(
                      Icons.access_time_rounded,

                      size:
                      ui.smallIconSize + 1,

                      color: const Color(
                        0xFF94A3B8,
                      ),
                    ),

                    SizedBox(
                      width:
                      ui.smallSpacing,
                    ),

                    Flexible(
                      child: Text(
                        item.visitHospitalModel.data,

                        maxLines: 1,

                        overflow:
                        TextOverflow
                            .ellipsis,

                        style: TextStyle(
                          color: const Color(
                            0xFF64748B,
                          ),

                          fontWeight:
                          FontWeight.w600,

                          fontSize:
                          ui.bodyTextSize,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(
                width: ui.mediumSpacing,
              ),

              const Spacer(),

              InkWell(
                borderRadius:
                BorderRadius.circular(
                  ui.smallRadius,
                ),

                onTap: onDetails,

                child: buildCardButton(
                  context,
                  'عرض التفاصيل',
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
        color: ColorManager.medicalPrimary
            .withOpacity(
          0.08,
        ),

        borderRadius:
        BorderRadius.circular(
          ui.smallRadius,
        ),
      ),

      child: Text(
        specialization,

        maxLines: 1,

        overflow:
        TextOverflow.ellipsis,

        style: TextStyle(
          color:
          ColorManager.medicalPrimary,

          fontSize: ui.smallTextSize,

          fontWeight:
          FontWeight.w600,
        ),
      ),
    );
  }
}