// ignore_for_file: must_be_immutable

import 'package:domina_app/app/di/di.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/resources/responsive/app_ui.dart';
import 'package:domina_app/presentation/resources/routes_manager.dart';
import 'package:domina_app/presentation/senior/manage_future/bloc/manage_future_bloc.dart';
import 'package:domina_app/presentation/senior/manage_future/widget/status_plan_widget.dart';
import 'package:domina_app/presentation/senior/plan_review/bloc/future_rep_bloc.dart';
import 'package:domina_app/presentation/uniti/basic/spec_grid_widget.dart';
import 'package:domina_app/presentation/uniti/search_field.dart';
import 'package:domina_app/presentation/uniti/stateWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FutureSpecializationsPage extends StatefulWidget {
  const FutureSpecializationsPage({
    super.key,
    required this.id,
    required this.repPlanId,
    required this.flag,
    required this.sampleCount,
    required this.repName,
    required this.repType,
    required this.placeId,
  });

  final String repName;
  final int id;
  final int repPlanId;
  final FlagModel flag;
  final int sampleCount;
  final RepType repType;
  final int placeId;

  @override
  State<FutureSpecializationsPage> createState() =>
      _FutureSpecializationsPageState();
}

class _FutureSpecializationsPageState
    extends State<FutureSpecializationsPage> {
  final TextEditingController searchController =
  TextEditingController();

  @override
  void initState() {
    super.initState();

    // =====================================================
    // نفس الحدث الأصلي
    // =====================================================
    BlocProvider.of<FutureRepBloc>(
      context,
    ).add(
      FutureSpEvent(
        widget.id,
        widget.repPlanId,
      ),
    );
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ui =
    AppUi.of(context);

    // =====================================================
    // نحافظ على سلوك Grid القديم تماماً
    //
    // Mobile Portrait  = 2
    // Mobile Landscape = 3
    // Tablet Portrait  = 3
    // Tablet Landscape = 4
    //
    // AppResponsive الحالي لا يملك mobileLandscape،
    // لذلك نحافظ عليه هنا فقط من أجل Grid.
    // =====================================================

    final bool isLandscape =
        MediaQuery.orientationOf(context) ==
            Orientation.landscape;

    final int crossAxisCount;

    if (ui.isTabletLandscape) {
      crossAxisCount = 4;
    } else if (ui.isTabletPortrait) {
      crossAxisCount = 3;
    } else {
      crossAxisCount =
      isLandscape
          ? 3
          : 2;
    }

    // =====================================================
    // Back behavior
    // نفس السلوك الأصلي تماماً
    // =====================================================

    Future<bool> onWillPop() async {
      BlocProvider.of<ManageFutureBloc>(
        context,
      ).add(
        AllSeniorRepFutureEvent(
          widget.placeId,
        ),
      );

      return true;
    }

    return WillPopScope(
      onWillPop:
      onWillPop,

      child: Scaffold(
        backgroundColor:
        const Color(
          0xFFF8FAFC,
        ),

        // =================================================
        // AppBar
        // =================================================
        appBar: AppBar(
          elevation: 0,
          scrolledUnderElevation: 0,
          surfaceTintColor:
          Colors.transparent,

          title: Text(
            'اختصاصات ${widget.repName}',

            maxLines:
            1,

            overflow:
            TextOverflow.ellipsis,
          ),
        ),

        // =================================================
        // Status FAB
        // =================================================
        floatingActionButton:
        BlocConsumer<
            FutureRepBloc,
            FutureRepState>(
          listener:
              (context, state) {
            // ===============================================
            // نفس السلوك الأصلي
            // ===============================================
            if (state
            is EditeStatusLoadingState) {
              loading(
                context,
              );
            } else if (state
            is EditeStatusFailureState) {
              error(
                context,
                state.failure.massage,
                state.failure.code,
              );
            } else if (state
            is EditeStatusState) {
              BlocProvider.of<
                  ManageFutureBloc>(
                context,
              ).add(
                AllSeniorRepFutureEvent(
                  widget.placeId,
                ),
              );

              success(
                context,
              );

              Navigator.pop(
                context,
              );
            }
          },

          builder:
              (context, state) {
            return FloatingActionButton(
              elevation:
              3,

              shape:
              RoundedRectangleBorder(
                borderRadius:
                BorderRadius.circular(
                  18,
                ),
              ),

              backgroundColor:
              ColorManager
                  .secondaryColor1,

              onPressed: () {
                // =============================================
                // نفس Bottom Sheet
                // =============================================
                showStatusBottomSheet(
                  context,
                  widget.repType.i,
                  widget.repPlanId,
                );
              },

              child: Icon(
                Icons.check_rounded,

                color:
                ColorManager.white,

                size:
                ui.iconSize,
              ),
            );
          },
        ),

        // =================================================
        // Body
        // =================================================
        body: SafeArea(
          top: false,

          child: Center(
            child: ConstrainedBox(
              constraints:
              BoxConstraints(
                // Grid page تحتاج مساحة أوسع بالLandscape
                maxWidth:
                ui.isTabletLandscape
                    ? ui.widePageMaxWidth
                    : ui.pageMaxWidth,
              ),

              child:
              SingleChildScrollView(
                physics:
                const BouncingScrollPhysics(),

                keyboardDismissBehavior:
                ScrollViewKeyboardDismissBehavior
                    .onDrag,

                padding:
                EdgeInsets.only(
                  bottom:
                  ui.pageBottomPadding +
                      70,
                ),

                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment
                      .stretch,

                  children: [
                    // =========================================
                    // Search
                    // =========================================
                    Padding(
                      padding:
                      EdgeInsets.fromLTRB(
                        ui.pagePadding,
                        ui.searchTopPadding,
                        ui.pagePadding,
                        ui.searchBottomPadding,
                      ),

                      child:
                      SearchField(
                        searchController:
                        searchController,

                        onPressed:
                            (value) {
                          // =====================================
                          // نفس Search Event
                          // =====================================
                          BlocProvider.of<
                              FutureRepBloc>(
                            context,
                          ).add(
                            FutureSearchSpecEvent(
                              value,
                            ),
                          );
                        },
                      ),
                    ),

                    // =========================================
                    // Specializations
                    // =========================================
                    BlocBuilder<
                        FutureRepBloc,
                        FutureRepState>(
                      builder:
                          (context, state) {
                        // =======================================
                        // نفس مصدر البيانات الأصلي
                        // =======================================
                        List<SpecDModel>
                        spModel =
                            context
                                .watch<
                                FutureRepBloc>()
                                .specialization;

                        // =======================================
                        // Success
                        // =======================================
                        if (state
                        is FutureSpRepState) {
                          spModel =
                              state.Specs;
                        }

                        // =======================================
                        // Loading
                        // =======================================
                        if (state
                        is FutureSpRepLoadingState) {
                          return _buildLoadingState(
                            context,
                          );
                        }

                        // =======================================
                        // Error
                        // =======================================
                        if (state
                        is FutureSpRepErrorState) {
                          return Padding(
                            padding:
                            EdgeInsets.symmetric(
                              horizontal:
                              ui.pagePadding,
                              vertical:
                              ui.sectionSpacing,
                            ),

                            child:
                            errorFullScreen(
                              context,

                              mes:
                              state
                                  .failure
                                  .massage,

                              func:
                                  () {
                                // =================================
                                // نفس Retry Event
                                // =================================
                                BlocProvider.of<
                                    FutureRepBloc>(
                                  context,
                                ).add(
                                  FutureSpEvent(
                                    widget.id,
                                    widget.repPlanId,
                                  ),
                                );
                              },
                            ),
                          );
                        }

                        // =======================================
                        // Grid
                        // =======================================
                        return Padding(
                          padding:
                          EdgeInsets.fromLTRB(
                            ui.pagePadding,
                            ui.listTopPadding,
                            ui.pagePadding,
                            ui.listBottomPadding,
                          ),

                          child:
                          SpecGridWidget(
                            items:
                            spModel,

                            crossAxisCount:
                            crossAxisCount,

                            onTap:
                                (model) {
                              // =================================
                              // 1. نفس التهيئة الأصلية
                              // =================================
                              iniFutureModule();

                              // =================================
                              // 2. نفس Event
                              // =================================
                              BlocProvider.of<
                                  FutureRepBloc>(
                                context,
                              ).add(
                                FutureRepPlanBrandSpEvent(
                                  RepSp(
                                    widget.repPlanId,
                                    model.id,
                                    widget.id,
                                  ),

                                  widget.sampleCount,
                                ),
                              );

                              // =================================
                              // 3. نفس Navigation + Arguments
                              // =================================
                              Navigator.pushNamed(
                                context,
                                Routes
                                    .RepPlanBrandSp,

                                arguments: {
                                  'title':
                                  model.title,

                                  'flag':
                                  widget
                                      .flag
                                      .flag,
                                },
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // =====================================================
  // Loading State
  // =====================================================

  Widget _buildLoadingState(
      BuildContext context,
      ) {
    final ui =
    AppUi.of(context);

    return Padding(
      padding:
      EdgeInsets.fromLTRB(
        ui.pagePadding,
        70,
        ui.pagePadding,
        ui.pageBottomPadding,
      ),

      child:
      loadingFullScreen(
        context,
      ),
    );
  }
}