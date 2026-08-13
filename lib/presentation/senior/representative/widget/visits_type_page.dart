import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/resources/responsive/app_responsive.dart';
import 'package:flutter/material.dart';

class VisitsTypePage extends StatelessWidget {
  const VisitsTypePage({
    super.key,
    required this.title,
    required this.doctor,
    required this.hospital,
    required this.onTapDoctor,
    required this.onTapHospital,
  });

  final String title;

  final Widget doctor;
  final Widget hospital;

  final Function onTapDoctor;
  final Function onTapHospital;

  @override
  Widget build(BuildContext context) {
    final deviceType =
    AppResponsive.deviceType(context);

    double pageMaxWidth;

    double horizontalPadding;
    double tabHeight;
    double tabRadius;

    double tabFontSize;
    double tabIconSize;
    double tabIconSpacing;

    double tabOuterPadding;
    double tabInnerPadding;

    switch (deviceType) {
    // =================================================
    // Mobile
    // =================================================
      case AppDeviceType.mobilePortrait:
        pageMaxWidth = 600;

        horizontalPadding = 16;

        tabHeight = 54;
        tabRadius = 15;

        tabFontSize = 13.5;
        tabIconSize = 19;
        tabIconSpacing = 7;

        tabOuterPadding = 12;
        tabInnerPadding = 4;
        break;

    // =================================================
    // Tablet Portrait
    // =================================================
      case AppDeviceType.tabletPortrait:
        pageMaxWidth = 760;

        horizontalPadding = 28;

        tabHeight = 60;
        tabRadius = 17;

        tabFontSize = 15;
        tabIconSize = 21;
        tabIconSpacing = 9;

        tabOuterPadding = 16;
        tabInnerPadding = 5;
        break;

    // =================================================
    // Tablet Landscape
    // =================================================
      case AppDeviceType.tabletLandscape:
        pageMaxWidth = 900;

        horizontalPadding = 32;

        // Landscape نخليه compact
        tabHeight = 56;
        tabRadius = 16;

        tabFontSize = 14;
        tabIconSize = 20;
        tabIconSpacing = 8;

        tabOuterPadding = 14;
        tabInnerPadding = 4;
        break;
    }

    return DefaultTabController(
      length: 2,

      child: Scaffold(
        backgroundColor: const Color(
          0xFFF8FAFC,
        ),

        body: NestedScrollView(
          // =================================================
          // Header
          // =================================================
          headerSliverBuilder:
              (context, innerBoxIsScrolled) {
            return [
              // =================================================
              // AppBar
              // =================================================
              SliverAppBar(
                elevation: 0,

                backgroundColor:
                const Color(
                  0xFFF8FAFC,
                ),

                surfaceTintColor:
                Colors.transparent,

                // نفس السلوك الموجود عندك
                pinned: false,
                floating: true,
                snap: true,

                leading: IconButton(
                  icon: const Icon(
                    Icons
                        .arrow_back_ios_new_rounded,
                    color: Color(
                      0xFF1F4E79,
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(
                      context,
                    );
                  },
                ),

                title: Text(
                  title,
                  maxLines: 1,
                  overflow:
                  TextOverflow.ellipsis,
                  style: TextStyle(
                    color: const Color(
                      0xFF1F4E79,
                    ),
                    fontWeight:
                    FontWeight.w700,
                    fontSize:
                    deviceType ==
                        AppDeviceType
                            .mobilePortrait
                        ? 18
                        : 20,
                  ),
                ),
              ),

              // =================================================
              // TabBar
              //
              // مثبت أثناء السكرول حتى يبقى الانتقال
              // بين الأطباء والمشافي متاح دائماً
              // =================================================
              SliverPersistentHeader(
                pinned: true,

                delegate:
                _VisitsTabHeaderDelegate(
                  height:
                  tabHeight +
                      (tabOuterPadding *
                          2),

                  backgroundColor:
                  const Color(
                    0xFFF8FAFC,
                  ),

                  child: Center(
                    child:
                    ConstrainedBox(
                      constraints:
                      BoxConstraints(
                        maxWidth:
                        pageMaxWidth,
                      ),

                      child: Padding(
                        padding:
                        EdgeInsets.symmetric(
                          horizontal:
                          horizontalPadding,
                          vertical:
                          tabOuterPadding,
                        ),

                        child: Container(
                          height:
                          tabHeight,

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
                              color: Colors
                                  .black
                                  .withOpacity(
                                0.035,
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

                            dividerColor:
                            Colors
                                .transparent,

                            labelPadding:
                            EdgeInsets.zero,

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
                              tabFontSize,
                              fontWeight:
                              FontWeight
                                  .w700,
                            ),

                            unselectedLabelStyle:
                            TextStyle(
                              fontSize:
                              tabFontSize,
                              fontWeight:
                              FontWeight
                                  .w600,
                            ),

                            indicator:
                            BoxDecoration(
                              color:
                              ColorManager
                                  .medicalPrimary,

                              borderRadius:
                              BorderRadius
                                  .circular(
                                tabRadius -
                                    4,
                              ),
                            ),

                            // ===================================
                            // نفس السلوك الأصلي
                            // ===================================
                            onTap: (value) {
                              if (value ==
                                  0) {
                                onTapDoctor();
                              } else {
                                onTapHospital();
                              }
                            },

                            tabs: [
                              _buildTab(
                                icon: Icons
                                    .groups_outlined,
                                title:
                                'الأطباء',
                                iconSize:
                                tabIconSize,
                                spacing:
                                tabIconSpacing,
                              ),

                              _buildTab(
                                icon: Icons
                                    .local_hospital_outlined,
                                title:
                                'المشافي',
                                iconSize:
                                tabIconSize,
                                spacing:
                                tabIconSpacing,
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

          // =================================================
          // Content
          // =================================================
          body: TabBarView(
            // نفس السلوك
            physics:
            const NeverScrollableScrollPhysics(),

            children: [
              _buildResponsiveContent(
                maxWidth:
                pageMaxWidth,
                child: doctor,
              ),

              _buildResponsiveContent(
                maxWidth:
                pageMaxWidth,
                child: hospital,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // =====================================================
  // Tab
  // =====================================================

  Widget _buildTab({
    required IconData icon,
    required String title,
    required double iconSize,
    required double spacing,
  }) {
    return Tab(
      child: Row(
        mainAxisAlignment:
        MainAxisAlignment.center,
        mainAxisSize:
        MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: iconSize,
          ),

          SizedBox(
            width: spacing,
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
      ),
    );
  }

  // =====================================================
  // Tablet width protection
  // =====================================================

  Widget _buildResponsiveContent({
    required double maxWidth,
    required Widget child,
  }) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: maxWidth,
        ),
        child: child,
      ),
    );
  }
}

// =======================================================
// Sticky TabBar Header
// =======================================================

class _VisitsTabHeaderDelegate
    extends SliverPersistentHeaderDelegate {
  final double height;
  final Widget child;
  final Color backgroundColor;

  const _VisitsTabHeaderDelegate({
    required this.height,
    required this.child,
    required this.backgroundColor,
  });

  @override
  double get minExtent => height;

  @override
  double get maxExtent => height;

  @override
  Widget build(
      BuildContext context,
      double shrinkOffset,
      bool overlapsContent,
      ) {
    return Container(
      color: backgroundColor,
      child: child,
    );
  }

  @override
  bool shouldRebuild(
      covariant _VisitsTabHeaderDelegate
      oldDelegate,
      ) {
    return height !=
        oldDelegate.height ||
        child != oldDelegate.child ||
        backgroundColor !=
            oldDelegate
                .backgroundColor;
  }
}