import 'package:domina_app/app/di/di.dart';
import 'package:domina_app/app/user_info.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/resources/responsive/app_responsive.dart';
import 'package:domina_app/presentation/senior/report_visit_doctor/bloc/report_visit_doctor_bloc.dart';
import 'package:domina_app/presentation/senior/report_visit_doctor/page/report_visit_doctor.dart';
import 'package:domina_app/presentation/senior/report_visit_doctor/page/report_visit_hospital.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DoctorsHospitalsReports extends StatefulWidget {
  const DoctorsHospitalsReports({
    super.key,
    required this.repId,
    required this.senId,
    required this.indexRep,
    required this.repName,
    required this.phone,
  });

  final int repId;
  final int senId;
  final int indexRep;

  final String repName;
  final String phone;

  @override
  State<DoctorsHospitalsReports> createState() =>
      _DoctorsHospitalsReportsState();
}

class _DoctorsHospitalsReportsState
    extends State<DoctorsHospitalsReports> {
  @override
  void initState() {
    super.initState();

    // =====================================================
    // نفس ترتيب التهيئة الموجود عندك
    // =====================================================
    initReportVisitDoctorModule();

    // =====================================================
    // أول فتح للصفحة = تقارير الأطباء
    // نفس السلوك الأصلي
    // =====================================================
    context.read<ReportVisitDoctorBloc>().add(
      AllReportVisitDoctorEvent(
        VisitRepSen(
          widget.repId,
          widget.senId,
        ),
        true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final deviceType =
    AppResponsive.deviceType(context);

    double tabMaxWidth;

    double tabHorizontalPadding;
    double tabVerticalPadding;

    double tabContainerHeight;
    double tabInnerPadding;
    double tabRadius;
    double indicatorRadius;

    double tabIconSize;
    double tabFontSize;
    double tabGap;

    double appBarTitleFontSize;
    double backIconSize;

    switch (deviceType) {
    // =================================================
    // Mobile
    // =================================================
      case AppDeviceType.mobilePortrait:
        tabMaxWidth = 600;

        tabHorizontalPadding = 16;
        tabVerticalPadding = 10;

        tabContainerHeight = 58;
        tabInnerPadding = 4;

        tabRadius = 15;
        indicatorRadius = 11;

        tabIconSize = 19;
        tabFontSize = 13;
        tabGap = 7;

        appBarTitleFontSize = 18;
        backIconSize = 22;
        break;

    // =================================================
    // Tablet Portrait
    // =================================================
      case AppDeviceType.tabletPortrait:
        tabMaxWidth = 760;

        tabHorizontalPadding = 28;
        tabVerticalPadding = 12;

        tabContainerHeight = 66;
        tabInnerPadding = 5;

        tabRadius = 17;
        indicatorRadius = 12;

        tabIconSize = 22;
        tabFontSize = 15;
        tabGap = 9;

        appBarTitleFontSize = 20;
        backIconSize = 24;
        break;

    // =================================================
    // Tablet Landscape
    // =================================================
      case AppDeviceType.tabletLandscape:
        tabMaxWidth = 900;

        tabHorizontalPadding = 32;
        tabVerticalPadding = 10;

        tabContainerHeight = 62;
        tabInnerPadding = 4;

        tabRadius = 16;
        indicatorRadius = 11;

        tabIconSize = 21;
        tabFontSize = 14;
        tabGap = 8;

        appBarTitleFontSize = 20;
        backIconSize = 23;
        break;
    }

    final double tabHeaderHeight =
        tabContainerHeight +
            (tabVerticalPadding * 2);

    return DefaultTabController(
      length: 2,

      child: Scaffold(
        backgroundColor:
        const Color(
          0xFFF8FAFC,
        ),

        body: NestedScrollView(
          // ===================================================
          // Header
          // ===================================================
          headerSliverBuilder:
              (
              context,
              innerBoxIsScrolled,
              ) {
            return [
              // =================================================
              // AppBar
              // =================================================
              SliverAppBar(
                elevation: 0,

                scrolledUnderElevation:
                0,

                pinned: true,
                floating: true,
                snap: true,

                backgroundColor:
                Colors.white,

                surfaceTintColor:
                Colors.transparent,

                leading: IconButton(
                  icon: Icon(
                    Icons
                        .arrow_back_ios_new_rounded,

                    size:
                    backIconSize,

                    color:
                    const Color(
                      0xFF0D47A1,
                    ),
                  ),

                  onPressed: () {
                    Navigator.pop(
                      context,
                    );
                  },
                ),

                title: Text(
                  widget.repName,

                  maxLines: 1,

                  overflow:
                  TextOverflow.ellipsis,

                  style: TextStyle(
                    color:
                    const Color(
                      0xFF0D47A1,
                    ),

                    fontWeight:
                    FontWeight.w700,

                    fontSize:
                    appBarTitleFontSize,
                  ),
                ),
              ),

              // =================================================
              // Sticky TabBar
              // =================================================
              SliverPersistentHeader(
                pinned: true,

                delegate:
                _ReportsTabBarDelegate(
                  height:
                  tabHeaderHeight,

                  backgroundColor:
                  const Color(
                    0xFFF8FAFC,
                  ),

                  child: Center(
                    child: ConstrainedBox(
                      constraints:
                      BoxConstraints(
                        maxWidth:
                        tabMaxWidth,
                      ),

                      child: Padding(
                        padding:
                        EdgeInsets.symmetric(
                          horizontal:
                          tabHorizontalPadding,

                          vertical:
                          tabVerticalPadding,
                        ),

                        child: Container(
                          height:
                          tabContainerHeight,

                          padding:
                          EdgeInsets.all(
                            tabInnerPadding,
                          ),

                          decoration:
                          BoxDecoration(
                            color:
                            Colors.white,

                            borderRadius:
                            BorderRadius
                                .circular(
                              tabRadius,
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
                                color: Colors
                                    .black
                                    .withOpacity(
                                  0.025,
                                ),

                                blurRadius:
                                10,

                                offset:
                                const Offset(
                                  0,
                                  4,
                                ),
                              ),
                            ],
                          ),

                          child: TabBar(
                            labelPadding:
                            EdgeInsets.zero,

                            dividerColor:
                            Colors.transparent,

                            splashBorderRadius:
                            BorderRadius
                                .circular(
                              indicatorRadius,
                            ),

                            labelColor:
                            Colors.white,

                            unselectedLabelColor:
                            const Color(
                              0xFF64748B,
                            ),

                            labelStyle:
                            TextStyle(
                              fontWeight:
                              FontWeight
                                  .w700,

                              fontSize:
                              tabFontSize,

                              fontFamily:
                              'Cairo',
                            ),

                            unselectedLabelStyle:
                            TextStyle(
                              fontWeight:
                              FontWeight
                                  .w600,

                              fontSize:
                              tabFontSize,

                              fontFamily:
                              'Cairo',
                            ),

                            indicatorSize:
                            TabBarIndicatorSize
                                .tab,

                            indicator:
                            BoxDecoration(
                              color:
                              ColorManager
                                  .medicalPrimary,

                              borderRadius:
                              BorderRadius
                                  .circular(
                                indicatorRadius,
                              ),
                            ),

                            // =====================================
                            // نفس منطق التبديل
                            // =====================================
                            onTap: (value) {
                              if (value ==
                                  0) {
                                context
                                    .read<
                                    ReportVisitDoctorBloc>()
                                    .add(
                                  AllReportVisitDoctorEvent(
                                    VisitRepSen(
                                      widget
                                          .repId,

                                      widget
                                          .senId,
                                    ),

                                    true,
                                  ),
                                );
                              } else {
                                context
                                    .read<
                                    ReportVisitDoctorBloc>()
                                    .add(
                                  AllReportVisitHospitalEvent(
                                    VisitRepSen(
                                      widget
                                          .repId,

                                      widget
                                          .senId,
                                    ),

                                    true,
                                  ),
                                );
                              }
                            },

                            tabs: [
                              // ===================================
                              // Doctors
                              // ===================================
                              Tab(
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment
                                      .center,

                                  mainAxisSize:
                                  MainAxisSize
                                      .min,

                                  children: [
                                    Icon(
                                      Icons
                                          .groups_outlined,

                                      size:
                                      tabIconSize,
                                    ),

                                    SizedBox(
                                      width:
                                      tabGap,
                                    ),

                                    Text(
                                      'الأطباء',

                                      maxLines:
                                      1,

                                      style:
                                      TextStyle(
                                        fontSize:
                                        tabFontSize,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              // ===================================
                              // Hospitals
                              // ===================================
                              Tab(
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment
                                      .center,

                                  mainAxisSize:
                                  MainAxisSize
                                      .min,

                                  children: [
                                    Icon(
                                      Icons
                                          .local_hospital_outlined,

                                      size:
                                      tabIconSize,
                                    ),

                                    SizedBox(
                                      width:
                                      tabGap,
                                    ),

                                    Text(
                                      'المشافي',

                                      maxLines:
                                      1,

                                      style:
                                      TextStyle(
                                        fontSize:
                                        tabFontSize,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ];
          },

          // ===================================================
          // Tabs Content
          // ===================================================
          body: TabBarView(
            // نفس السلوك الأصلي
            physics:
            const NeverScrollableScrollPhysics(),

            children: [
              // =================================================
              // Doctor Reports
              // =================================================
              ReportVisitDoctorPage(
                userId:
                UserInfo.repId,

                repId:
                widget.repId,

                repName:
                widget.repName,

                indexRep:
                widget.indexRep,

                repPlan: 0,

                phone:
                widget.phone,

                iscanedite:
                false,
              ),

              // =================================================
              // Hospital Reports
              // =================================================
              ReportVisitHospital(
                userId:
                UserInfo.repId,

                repId:
                widget.repId,

                indexRep:
                widget.indexRep,

                repName:
                widget.repName,

                repPlan: 0,

                iscanedite:
                false,

                phone:
                widget.phone,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// =======================================================
// Persistent TabBar Delegate
// =======================================================

class _ReportsTabBarDelegate
    extends SliverPersistentHeaderDelegate {
  final double height;
  final Color backgroundColor;
  final Widget child;

  const _ReportsTabBarDelegate({
    required this.height,
    required this.backgroundColor,
    required this.child,
  });

  @override
  double get minExtent =>
      height;

  @override
  double get maxExtent =>
      height;

  @override
  Widget build(
      BuildContext context,
      double shrinkOffset,
      bool overlapsContent,
      ) {
    return ColoredBox(
      color:
      backgroundColor,

      child:
      child,
    );
  }

  @override
  bool shouldRebuild(
      covariant _ReportsTabBarDelegate
      oldDelegate,
      ) {
    return oldDelegate.height !=
        height ||
        oldDelegate.backgroundColor !=
            backgroundColor ||
        oldDelegate.child !=
            child;
  }
}