// ignore_for_file: deprecated_member_use

import 'package:domina_app/app/user_info.dart';
import 'package:domina_app/presentation/brand_plan/pages/brand_plan_active_page.dart';
import 'package:domina_app/presentation/brand_plan/pages/spec_plan_page.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/resources/responsive/app_ui.dart';
import 'package:flutter/material.dart';

class BrandPlanPage extends StatelessWidget {
  const BrandPlanPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final ui = AppUi.of(context);

    // =========================================================
    // نفس الطباعة الموجودة سابقاً
    // =========================================================
    print(UserInfo.otherstatus);
    print(UserInfo.flag);

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

                title: Text(
                  'خطة المندوب',

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

                centerTitle: true,
              ),

              // =================================================
              // Tab Bar
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
                            ? 54
                            : 58,

                        padding:
                        const EdgeInsets.all(
                          4,
                        ),

                        decoration:
                        BoxDecoration(
                          color: Colors.white,

                          borderRadius:
                          BorderRadius.circular(
                            ui.cardRadius,
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

                              blurRadius: 12,

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
                            FontWeight
                                .w700,
                          ),

                          unselectedLabelStyle:
                          TextStyle(
                            fontSize:
                            ui.isMobile
                                ? 14.5
                                : 16,

                            fontWeight:
                            FontWeight
                                .w500,
                          ),

                          indicator:
                          BoxDecoration(
                            color:
                            ColorManager
                                .medicalPrimary,

                            borderRadius:
                            BorderRadius.circular(
                              ui.smallRadius +
                                  1,
                            ),
                          ),

                          tabs: const [
                            // =====================================
                            // Current Plan
                            // =====================================
                            Tab(
                              child:
                              _PlanTabItem(
                                icon: Icons
                                    .list_alt_outlined,

                                title:
                                'الخطة الحالية',
                              ),
                            ),

                            // =====================================
                            // Future Plan
                            // =====================================
                            Tab(
                              child:
                              _PlanTabItem(
                                icon: Icons
                                    .featured_play_list_outlined,

                                title:
                                'الخطة المستقبلية',
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
          // نفس السلوك الأصلي
          // =====================================================
          body:  TabBarView(
            physics:
            NeverScrollableScrollPhysics(),

            children: [
              BrandPlanActivePage(),
              SpecPlanPage(),
            ],
          ),
        ),
      ),
    );
  }
}

// ============================================================================
// Tab Item
// ============================================================================

class _PlanTabItem extends StatelessWidget {
  const _PlanTabItem({
    required this.icon,
    required this.title,
  });

  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    final ui = AppUi.of(context);

    return Padding(
      padding:
      EdgeInsets.symmetric(
        horizontal:
        ui.smallSpacing,
      ),

      child: Row(
        mainAxisAlignment:
        MainAxisAlignment.center,

        mainAxisSize:
        MainAxisSize.min,

        children: [
          Icon(
            icon,

            size:
            ui.isMobile
                ? 19
                : 21,
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
      ),
    );
  }
}