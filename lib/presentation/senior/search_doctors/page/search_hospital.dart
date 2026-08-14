import 'package:domina_app/app/user_info.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/resources/responsive/app_ui.dart';
import 'package:domina_app/presentation/senior/search_doctors/bloc/search_doctors_bloc.dart';
import 'package:domina_app/presentation/senior/search_doctors/page/hospital_details.dart';
import 'package:domina_app/presentation/senior/search_doctors/widgets/search_do_hos_widget.dart';
import 'package:domina_app/presentation/uniti/stateWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchHospital extends StatefulWidget {
  const SearchHospital({
    super.key,
  });

  @override
  State<SearchHospital> createState() =>
      _SearchHospitalState();
}

class _SearchHospitalState
    extends State<SearchHospital>
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
      backgroundColor: Colors.transparent,

      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: ui.pageMaxWidth,
          ),

          child: Column(
            crossAxisAlignment:
            CrossAxisAlignment.stretch,

            children: [
              // =================================================
              // Search Header
              // نفس الـWidget والسلوك الأصلي
              // =================================================
              buildHeaderSection(
                searchController,
                context,
              ),

              // =================================================
              // Results
              // =================================================
              Expanded(
                child: _buildResultList(
                  context,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // =====================================================
  // Results
  // =====================================================

  Widget _buildResultList(
      BuildContext context,
      ) {
    final ui = AppUi.of(context);

    return BlocBuilder<
        SearchDoctorsBloc,
        SearchDoctorsState>(
      // =================================================
      // نفس buildWhen الأصلي تماماً
      // =================================================
      buildWhen: (
          previous,
          current,
          ) {
        return current
        is FutureSearchHospitalsErrorState ||
            current
            is FutureSearchHospitalsLoadingState ||
            current
            is FutureSearchHospitalsState ||
            current
            is FutureSearchHospitalsEmptyState;
      },

      builder: (
          context,
          state,
          ) {
        // =================================================
        // Error
        // =================================================
        if (state
        is FutureSearchHospitalsErrorState) {
          return CustomScrollView(
            physics:
            const BouncingScrollPhysics(),

            keyboardDismissBehavior:
            ScrollViewKeyboardDismissBehavior
                .onDrag,

            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,

                child: Padding(
                  padding: EdgeInsets.all(
                    ui.pagePadding,
                  ),

                  child: errorFullScreen(
                    context,

                    mes:
                    state.failure.massage,

                    func: () {
                      // =========================================
                      // نفس Retry Event الأصلي
                      // =========================================
                      BlocProvider.of<
                          SearchDoctorsBloc>(
                        context,
                      ).add(
                        FutureSearchHosEvent(
                            UserInfo.cityId  ,
                            searchController
                                .text,
                            UserInfo.repId
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          );
        }

        // =================================================
        // Loading
        // =================================================
        if (state
        is FutureSearchHospitalsLoadingState) {
          return CustomScrollView(
            physics:
            const NeverScrollableScrollPhysics(),

            slivers: [
              SliverPadding(
                padding: EdgeInsets.fromLTRB(
                  ui.pagePadding,
                  ui.listTopPadding,
                  ui.pagePadding,
                  ui.listBottomPadding,
                ),

                sliver:
                SliverToBoxAdapter(
                  child: loadingShimmer(
                    context,

                    // نفس العدد الأصلي
                    10,

                    // نفس المقاسات الأصلية
                    100,
                    100,

                    BorderRadius.circular(
                      ui.cardRadius,
                    ),
                  ),
                ),
              ),
            ],
          );
        }

        // =================================================
        // Empty
        // =================================================
        if (state
        is FutureSearchHospitalsEmptyState) {
          return CustomScrollView(
            physics:
            const BouncingScrollPhysics(),

            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,

                child: Padding(
                  padding: EdgeInsets.all(
                    ui.pagePadding,
                  ),

                  child: emptyFullScreen(
                    context,
                  ),
                ),
              ),
            ],
          );
        }

        // =================================================
        // Success
        // =================================================
        if (state
        is FutureSearchHospitalsState) {
          return CustomScrollView(
            physics:
            const BouncingScrollPhysics(),

            keyboardDismissBehavior:
            ScrollViewKeyboardDismissBehavior
                .onDrag,

            slivers: [
              SliverPadding(
                padding: EdgeInsets.fromLTRB(
                  ui.pagePadding,
                  ui.listTopPadding,
                  ui.pagePadding,
                  ui.listBottomPadding,
                ),

                sliver: SliverList(
                  delegate:
                  SliverChildBuilderDelegate(
                        (
                        context,
                        index,
                        ) {
                      final hospital =
                      state.allSearch[index];

                      return _hospitalWidget(
                        context: context,

                        title:
                        hospital.name,

                        function: () {
                          // =========================================
                          // مهم:
                          // نفس ترتيب السلوك الأصلي
                          //
                          // 1. Navigation
                          // 2. Bloc Event
                          // =========================================

                          Navigator.push(
                            context,

                            MaterialPageRoute(
                              builder:
                                  (context) {
                                return HospitalDetails(
                                  searchHospitalModel:
                                  hospital,
                                );
                              },
                            ),
                          );

                          BlocProvider.of<
                              SearchDoctorsBloc>(
                            context,
                          ).add(
                            FutureDocHospitalEvent(
                              int.parse(
                                hospital.hosId,
                              ),
                              int.parse(
                                hospital.spId,
                              ),
                            ),
                          );
                        },
                      );
                    },

                    childCount:
                    state.allSearch.length,
                  ),
                ),
              ),
            ],
          );
        }

        // =================================================
        // Default
        // قبل بدء البحث
        // =================================================
        return CustomScrollView(
          physics:
          const BouncingScrollPhysics(),

          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,

              child: _buildInitialState(
                context,
              ),
            ),
          ],
        );
      },
    );
  }

  // =====================================================
  // Initial State
  // =====================================================

  Widget _buildInitialState(
      BuildContext context,
      ) {
    final ui = AppUi.of(context);

    return Center(
      child: Padding(
        padding: EdgeInsets.all(
          ui.pagePadding,
        ),

        child: Column(
          mainAxisSize:
          MainAxisSize.min,

          children: [
            // =================================================
            // Icon
            // =================================================
            Container(
              width:
              ui.iconBoxSize + 24,

              height:
              ui.iconBoxSize + 24,

              alignment:
              Alignment.center,

              decoration: BoxDecoration(
                color: ColorManager
                    .medicalPrimary
                    .withOpacity(
                  0.07,
                ),

                borderRadius:
                BorderRadius.circular(
                  ui.cardRadius,
                ),
              ),

              child: Icon(
                Icons
                    .local_hospital_outlined,

                size:
                ui.iconSize + 12,

                color: ColorManager
                    .medicalPrimary
                    .withOpacity(
                  0.75,
                ),
              ),
            ),

            SizedBox(
              height:
              ui.sectionSpacing,
            ),

            Text(
              "ابدأ البحث عن المشافي الآن",

              textAlign:
              TextAlign.center,

              style: TextStyle(
                color: const Color(
                  0xFF334155,
                ),

                fontSize:
                ui.cardTitleSize,

                fontWeight:
                FontWeight.w700,
              ),
            ),

            SizedBox(
              height:
              ui.smallSpacing,
            ),

            Text(
              "اكتب اسم المشفى في حقل البحث لعرض النتائج",

              textAlign:
              TextAlign.center,

              style: TextStyle(
                color: const Color(
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
    );
  }

  // =====================================================
  // Hospital Card
  // =====================================================

  Widget _hospitalWidget({
    required BuildContext context,
    required String title,
    required VoidCallback function,
  }) {
    final ui = AppUi.of(context);

    return Padding(
      padding: EdgeInsets.only(
        bottom: ui.cardSpacing,
      ),

      child: Container(
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
              // Header
              // =================================================
              Row(
                crossAxisAlignment:
                CrossAxisAlignment.center,

                children: [
                  // ===============================================
                  // Hospital Icon
                  // ===============================================
                  Container(
                    width: ui.iconBoxSize,
                    height: ui.iconBoxSize,

                    alignment:
                    Alignment.center,

                    decoration: BoxDecoration(
                      color: const Color(
                        0xFFF59E0B,
                      ).withOpacity(
                        0.09,
                      ),

                      borderRadius:
                      BorderRadius.circular(
                        ui.smallRadius + 2,
                      ),
                    ),

                    child: Icon(
                      Icons
                          .local_hospital_outlined,

                      color: const Color(
                        0xFFF59E0B,
                      ),

                      size: ui.iconSize,
                    ),
                  ),

                  SizedBox(
                    width:
                    ui.sectionSpacing,
                  ),

                  // ===============================================
                  // Hospital Name
                  // ===============================================
                  Expanded(
                    child: Text(
                      title,

                      maxLines: 2,

                      overflow:
                      TextOverflow.ellipsis,

                      textAlign:
                      TextAlign.start,

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
                ui.sectionSpacing,
              ),

              // =================================================
              // Reports Action
              // =================================================
              Align(
                alignment:
                Alignment.centerLeft,

                child: Material(
                  color:
                  Colors.transparent,

                  child: InkWell(
                    onTap: function,

                    borderRadius:
                    BorderRadius.circular(
                      ui.smallRadius + 2,
                    ),

                    child: Container(
                      padding:
                      EdgeInsets.symmetric(
                        horizontal:
                        ui.sectionSpacing,

                        vertical:
                        ui.mediumSpacing,
                      ),

                      decoration:
                      BoxDecoration(
                        color:
                        ColorManager
                            .medicalPrimary,

                        borderRadius:
                        BorderRadius.circular(
                          ui.smallRadius + 2,
                        ),

                        boxShadow: [
                          BoxShadow(
                            color: ColorManager
                                .medicalPrimary
                                .withOpacity(
                              0.12,
                            ),
                            blurRadius: 8,
                            offset:
                            const Offset(
                              0,
                              3,
                            ),
                          ),
                        ],
                      ),

                      child: Row(
                        mainAxisSize:
                        MainAxisSize.min,

                        children: [
                          Text(
                            "عرض التقارير",

                            style: TextStyle(
                              color:
                              Colors.white,

                              fontSize:
                              ui.bodyTextSize,

                              fontWeight:
                              FontWeight.w600,
                            ),
                          ),

                          SizedBox(
                            width:
                            ui.smallSpacing,
                          ),

                          Icon(
                            Icons
                                .analytics_outlined,

                            color:
                            Colors.white,

                            size:
                            ui.smallIconSize +
                                2,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}