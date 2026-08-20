// ignore_for_file: deprecated_member_use

import 'package:domina_app/app/di/di.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/resources/responsive/app_ui.dart';
import 'package:domina_app/presentation/resources/routes_manager.dart';
import 'package:domina_app/presentation/visits/bloc/visit_bloc.dart';
import 'package:domina_app/presentation/visits/widget/Doctor_visit_usert.dart';
import 'package:domina_app/presentation/visits/widget/hospital_visit_user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VisitsPage extends StatelessWidget {
  const VisitsPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final ui = AppUi.of(context);

    final double contentMaxWidth =
    ui.isTabletLandscape
        ? 760
        : ui.pageMaxWidth;

    return DefaultTabController(
      length: 2,

      child: Scaffold(
        backgroundColor: const Color(
          0xFFF8FAFC,
        ),

        body: NestedScrollView(
          headerSliverBuilder: (
              context,
              innerBoxIsScrolled,
              ) {
            return [
              // =================================================
              // AppBar
              // =================================================
              SliverAppBar(
                elevation: 0,
                scrolledUnderElevation: 0,
                surfaceTintColor:
                Colors.transparent,

                pinned: true,
                floating: true,
                snap: true,

                backgroundColor:
                Colors.white,

                leading: IconButton(
                  tooltip: 'رجوع',

                  onPressed: () {
                    Navigator.pop(
                      context,
                    );
                  },

                  icon: Icon(
                    Icons.arrow_back_rounded,

                    size:
                    ui.isMobile
                        ? 24
                        : 27,

                    color:
                    ColorManager
                        .medicalPrimary,
                  ),
                ),

                title: Text(
                  'سجل الزيارات',

                  maxLines: 1,

                  overflow:
                  TextOverflow.ellipsis,

                  style: TextStyle(
                    fontSize:
                    ui.isMobile
                        ? 18
                        : 21,

                    fontWeight:
                    FontWeight.w700,

                    color:
                    ColorManager
                        .medicalPrimary,
                  ),
                ),
              ),

              // =================================================
              // Tabs
              // =================================================
              SliverToBoxAdapter(
                child: Center(
                  child: ConstrainedBox(
                    constraints:
                    BoxConstraints(
                      maxWidth:
                      contentMaxWidth,
                    ),

                    child: Padding(
                      padding:
                      EdgeInsets.fromLTRB(
                        ui.pagePadding,
                        ui.searchTopPadding,
                        ui.pagePadding,
                        ui.searchBottomPadding,
                      ),

                      child: Container(
                        height:
                        ui.isMobile
                            ? 56
                            : 60,

                        padding:
                        const EdgeInsets.all(
                          4,
                        ),

                        decoration:
                        BoxDecoration(
                          color:
                          Colors.white,

                          borderRadius:
                          BorderRadius.circular(
                            16,
                          ),

                          border: Border.all(
                            color:
                            const Color(
                              0xFFE2E8F0,
                            ),
                          ),

                          boxShadow: [
                            BoxShadow(
                              color:
                              Colors.black
                                  .withOpacity(
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

                        child: TabBar(
                          padding:
                          EdgeInsets.zero,

                          labelPadding:
                          EdgeInsets.zero,

                          dividerColor:
                          Colors.transparent,

                          indicatorSize:
                          TabBarIndicatorSize
                              .tab,

                          labelColor:
                          Colors.white,

                          unselectedLabelColor:
                          const Color(
                            0xFF64748B,
                          ),

                          labelStyle:
                          TextStyle(
                            fontSize:
                            ui.isMobile
                                ? 14.5
                                : 16,

                            fontWeight:
                            FontWeight.w700,
                          ),

                          unselectedLabelStyle:
                          TextStyle(
                            fontSize:
                            ui.isMobile
                                ? 14.5
                                : 16,

                            fontWeight:
                            FontWeight.w500,
                          ),

                          indicator:
                          BoxDecoration(
                            color:
                            ColorManager
                                .medicalPrimary,

                            borderRadius:
                            BorderRadius.circular(
                              12,
                            ),
                          ),

                          // =====================================
                          // نفس السلوك الأصلي
                          // =====================================
                          onTap: (value) {
                            if (value == 0) {
                              context
                                  .read<
                                  VisitBloc>()
                                  .add(
                                VisitDoctorEvent(),
                              );
                            } else {
                              context
                                  .read<
                                  VisitBloc>()
                                  .add(
                                VisitHospitalEvent(),
                              );
                            }
                          },

                          tabs: const [
                            Tab(
                              child:
                              _VisitTabItem(
                                icon: Icons
                                    .groups_outlined,

                                title:
                                'الأطباء',
                              ),
                            ),

                            Tab(
                              child:
                              _VisitTabItem(
                                icon: Icons
                                    .local_hospital_outlined,

                                title:
                                'المشافي',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ];
          },

          // =====================================================
          // Tab Content
          // =====================================================
          body: Center(
            child: ConstrainedBox(
              constraints:
              BoxConstraints(
                maxWidth:
                contentMaxWidth,
              ),

              child: TabBarView(
                physics:
                const NeverScrollableScrollPhysics(),

                children: [
                  DoctorVisitUser(),
                  HospitalVisitUser(),
                ],
              ),
            ),
          ),
        ),

        // =======================================================
        // Sync FAB
        // نفس السلوك الأصلي
        // =======================================================
        floatingActionButton:
        FloatingActionButton(
          onPressed: () {
            initAsyncInModule();

            WidgetsBinding.instance
                .addPostFrameCallback(
                  (_) {
                Navigator.pushNamed(
                  context,
                  Routes.asyncIn,
                );
              },
            );
          },

          backgroundColor:
          ColorManager.medicalPrimary,

          foregroundColor:
          Colors.white,

          elevation: 3,

          child: Icon(
            Icons
                .wifi_protected_setup_outlined,

            size:
            ui.isMobile
                ? 24
                : 27,
          ),
        ),

        floatingActionButtonLocation:
        FloatingActionButtonLocation
            .startFloat,
      ),
    );
  }
}

// ============================================================================
// Tab Item
// ============================================================================

class _VisitTabItem
    extends StatelessWidget {
  const _VisitTabItem({
    required this.icon,
    required this.title,
  });

  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    final ui = AppUi.of(context);

    return Row(
      mainAxisAlignment:
      MainAxisAlignment.center,

      mainAxisSize:
      MainAxisSize.min,

      children: [
        Icon(
          icon,

          size:
          ui.isMobile
              ? 20
              : 22,
        ),

        SizedBox(
          width:
          ui.smallSpacing,
        ),

        Flexible(
          child: Text(
            title,

            maxLines: 1,

            overflow:
            TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}