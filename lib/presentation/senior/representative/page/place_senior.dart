import 'package:domina_app/app/user_info.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/resources/responsive/app_ui.dart';
import 'package:domina_app/presentation/resources/routes_manager.dart';
import 'package:domina_app/presentation/senior/all_city/bloc/bloc/all_city_bloc.dart';
import 'package:domina_app/presentation/senior/representative/bloc/senior_prof_bloc.dart';
import 'package:domina_app/presentation/uniti/search_field.dart';
import 'package:domina_app/presentation/uniti/stateWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PlaceSenior extends StatefulWidget {
  const PlaceSenior({
    super.key,
  });

  @override
  State<PlaceSenior> createState() =>
      _PlaceSeniorState();
}

class _PlaceSeniorState
    extends State<PlaceSenior> {
  final TextEditingController searchController =
  TextEditingController();

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ui = AppUi.of(context);

    final double contentMaxWidth =
    ui.isTabletLandscape
        ? 760
        : ui.pageMaxWidth;

    return Scaffold(
      backgroundColor: const Color(
        0xFFF8FAFC,
      ),

      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.white,

        title: Text(
          'المناطق المتاحة',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color:
            ColorManager.medicalPrimary,
          ),
        ),
      ),

      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: contentMaxWidth,
          ),

          child: Column(
            crossAxisAlignment:
            CrossAxisAlignment.start,

            children: [
              // =================================================
              // Header
              // =================================================
              _buildHeader(
                ui,
              ),

              // =================================================
              // Bloc Content
              // =================================================
              Expanded(
                child: BlocBuilder<
                    SeniorProfBloc,
                    SeniorProfState>(
                  buildWhen: (
                      previous,
                      current,
                      ) =>
                  current
                  is SenAllPlaceState ||
                      current
                      is SenAllPlaceLoadingState ||
                      current
                      is SenAllPlaceErrorState,

                  builder: (
                      context,
                      state,
                      ) {
                    // =============================================
                    // Loading
                    // =============================================
                    if (state
                    is SenAllPlaceLoadingState) {
                      return loadingFullScreen(
                        context,
                      );
                    }

                    // =============================================
                    // Error
                    // نفس السلوك
                    // =============================================
                    if (state
                    is SenAllPlaceErrorState) {
                      return errorFullScreen(
                        context,
                        func: () {
                          context
                              .read<
                              SeniorProfBloc>()
                              .add(
                            SenAllPlaceEvent(
                              203,
                            ),
                          );
                        },
                      );
                    }

                    // =============================================
                    // Data
                    // =============================================
                    if (state
                    is SenAllPlaceState) {
                      final List<PlaceModel>
                      placeModel =
                          state.places;

                      return Column(
                        children: [
                          // =========================================
                          // Search
                          // يبقى ظاهر حتى لو النتيجة فاضية
                          // =========================================
                          Padding(
                            padding:
                            EdgeInsets.fromLTRB(
                              ui.pagePadding,
                              ui.searchTopPadding,
                              ui.pagePadding,
                              ui.searchBottomPadding,
                            ),
                            child: SearchField(
                              searchController:
                              searchController,

                              onPressed:
                                  (value) {
                                // ===================================
                                // نفس Event البحث الأصلي
                                // ===================================
                                context
                                    .read<
                                    SeniorProfBloc>()
                                    .add(
                                  SearchSenAllPlaceEvent(
                                    value,
                                    state.places,
                                  ),
                                );
                              },
                            ),
                          ),

                          // =========================================
                          // List / Empty
                          // =========================================
                          Expanded(
                            child:
                            placeModel.isEmpty
                                ? emptyFullScreen(
                              context,
                            )
                                : ListView.builder(
                              keyboardDismissBehavior:
                              ScrollViewKeyboardDismissBehavior
                                  .onDrag,

                              physics:
                              const BouncingScrollPhysics(),

                              padding:
                              EdgeInsets.fromLTRB(
                                ui.pagePadding,
                                ui.listTopPadding,
                                ui.pagePadding,
                                ui.listBottomPadding,
                              ),

                              itemCount:
                              placeModel.length,

                              itemBuilder:
                                  (
                                  context,
                                  index,
                                  ) {
                                return _buildPlaceCard(
                                  context,
                                  ui,
                                  placeModel[index],
                                );
                              },
                            ),
                          ),
                        ],
                      );
                    }

                    return const SizedBox.shrink();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ===========================================================
  // Header
  // ===========================================================

  Widget _buildHeader(
      AppUi ui,
      ) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        ui.pagePadding,
        ui.headerTopPadding,
        ui.pagePadding,
        ui.headerBottomPadding,
      ),

      child: Row(
        crossAxisAlignment:
        CrossAxisAlignment.center,

        children: [
          Expanded(
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,

              children: [
                Text(
                  'دليل المناطق',

                  maxLines: 1,

                  overflow:
                  TextOverflow.ellipsis,

                  style: TextStyle(
                    fontSize:
                    ui.pageTitleSize,

                    fontWeight:
                    FontWeight.w800,

                    color: const Color(
                      0xFF1F4E79,
                    ),
                  ),
                ),

                SizedBox(
                  height:
                  ui.smallSpacing,
                ),

                Text(
                  'المناطق المتاحة لهذا المندوب',

                  maxLines: 2,

                  overflow:
                  TextOverflow.ellipsis,

                  style: TextStyle(
                    fontSize:
                    ui.pageSubtitleSize,

                    color: const Color(
                      0xFF64748B,
                    ),

                    fontWeight:
                    FontWeight.w500,

                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(
            width:
            ui.mediumSpacing,
          ),

          Container(
            width: 42,
            height: 5,

            decoration: BoxDecoration(
              color: ColorManager
                  .medicalPrimary,

              borderRadius:
              BorderRadius.circular(
                10,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ===========================================================
  // Place Card
  // ===========================================================

  Widget _buildPlaceCard(
      BuildContext context,
      AppUi ui,
      PlaceModel place,
      ) {
    final String totalVisits =
        place.totalVisit.toString() ;

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

          child: InkWell(
            // =================================================
            // نفس السلوك الأصلي
            // =================================================
            onTap: () {
              Navigator.pushNamed(
                context,
                Routes.docHos,
                arguments: {
                  'placeId': place.placeId,

                },
              );

              context
                  .read<SeniorProfBloc>()
                  .add(
                DocHosEvent(
                  UserInfo.repId,
                  placeId:
                  place.placeId,
                  cityId: BlocProvider.of<AllCityBloc>(context).selectedCityId
                ),
              );
            },

            child: Padding(
              padding: EdgeInsets.all(
                ui.cardPadding,
              ),

              child: Row(
                crossAxisAlignment:
                CrossAxisAlignment.center,

                children: [
                  // =============================================
                  // Place Icon
                  // =============================================
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
                      Icons.location_on_rounded,

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

                  // =============================================
                  // Place Data
                  // =============================================
                  Expanded(
                    child: Column(
                      mainAxisSize:
                      MainAxisSize.min,

                      crossAxisAlignment:
                      CrossAxisAlignment.start,

                      children: [
                        // =========================================
                        // Label
                        // =========================================
                        Text(
                          'اسم المنطقة',

                          style: TextStyle(
                            fontSize:
                            ui.smallTextSize,

                            color:
                            const Color(
                              0xFF94A3B8,
                            ),

                            fontWeight:
                            FontWeight.w500,
                          ),
                        ),

                        SizedBox(
                          height:
                          ui.smallSpacing /
                              2,
                        ),

                        // =========================================
                        // Place Name
                        // =========================================
                        Text(
                          place.title,

                          maxLines: 2,

                          overflow:
                          TextOverflow
                              .ellipsis,

                          style: TextStyle(
                            fontSize:
                            ui.cardTitleSize,

                            fontWeight:
                            FontWeight.w700,

                            color:
                            const Color(
                              0xFF334155,
                            ),

                            height: 1.3,
                          ),
                        ),

                        SizedBox(
                          height:
                          ui.smallSpacing,
                        ),

                        // =========================================
                        // Total Visits
                        // =========================================
                        Container(
                          padding:
                          EdgeInsets.symmetric(
                            horizontal:
                            ui.mediumSpacing,
                            vertical: 5,
                          ),

                          decoration:
                          BoxDecoration(
                            color:
                            const Color(
                              0xFFF0FDF4,
                            ),

                            borderRadius:
                            BorderRadius
                                .circular(
                              ui.smallRadius,
                            ),

                            border:
                            Border.all(
                              color:
                              const Color(
                                0xFFDCFCE7,
                              ),
                            ),
                          ),

                          child: Row(
                            mainAxisSize:
                            MainAxisSize.min,

                            children: [
                              Icon(
                                Icons
                                    .event_available_outlined,

                                size:
                                ui.smallIconSize,

                                color:
                                const Color(
                                  0xFF16A34A,
                                ),
                              ),

                              SizedBox(
                                width:
                                ui.smallSpacing,
                              ),

                              Flexible(
                                child: Text(
                                  'عدد الزيارات: $totalVisits',

                                  maxLines: 1,

                                  overflow:
                                  TextOverflow
                                      .ellipsis,

                                  style:
                                  TextStyle(
                                    fontSize: ui
                                        .smallTextSize,

                                    fontWeight:
                                    FontWeight
                                        .w600,

                                    color:
                                    const Color(
                                      0xFF15803D,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(
                    width:
                    ui.mediumSpacing,
                  ),

                  // =============================================
                  // Arrow
                  // =============================================
                  Container(
                    width:
                    ui.isMobile
                        ? 30
                        : 34,

                    height:
                    ui.isMobile
                        ? 30
                        : 34,

                    alignment:
                    Alignment.center,

                    decoration:
                    BoxDecoration(
                      color:
                      const Color(
                        0xFFF8FAFC,
                      ),

                      borderRadius:
                      BorderRadius.circular(
                        ui.smallRadius,
                      ),
                    ),

                    child: Icon(
                      Icons
                          .arrow_forward_ios_rounded,

                      size:
                      ui.smallIconSize,

                      color:
                      const Color(
                        0xFF94A3B8,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}