import 'package:domina_app/app/user_info.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/resources/responsive/app_ui.dart';
import 'package:domina_app/presentation/senior/plan_management/bloc/plan_management_bloc.dart';
import 'package:domina_app/presentation/senior/plan_management/page/create_plan_brand_page.dart';
import 'package:domina_app/presentation/senior/plan_management/page/view_active_plan_brand_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PlanHelpGoalTap extends StatefulWidget {
  const PlanHelpGoalTap({
    super.key,
  });

  @override
  State<PlanHelpGoalTap> createState() =>
      _PlanHelpGoalTapState();
}

class _PlanHelpGoalTapState
    extends State<PlanHelpGoalTap> {
  @override
  void initState() {
    super.initState();

    // =====================================================
    // نفس السلوك الأصلي
    // جلب معلومات المندوب عند فتح الواجهة
    // =====================================================
    context
        .read<PlanManagementBloc>()
        .add(
      GetRepInfoEvent(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ui =
    AppUi.of(context);

    return DefaultTabController(
      length: 2,

      child: Scaffold(
        backgroundColor:
        const Color(
          0xFFF8FAFC,
        ),

        body: NestedScrollView(
          physics:
          const BouncingScrollPhysics(),

          headerSliverBuilder:
              (
              context,
              innerBoxIsScrolled,
              ) {
            return [
              // =================================================
              // App Bar
              // =================================================
              SliverAppBar(
                pinned:
                true,

                floating:
                true,

                snap:
                true,

                elevation:
                0,

                scrolledUnderElevation:
                0,

                surfaceTintColor:
                Colors.transparent,

                backgroundColor:
                Colors.white,

                leading:
                IconButton(
                  tooltip:
                  'رجوع',

                  icon:
                  Icon(
                    Icons
                        .arrow_back_rounded,

                    color:
                    ColorManager
                        .medicalPrimary,
                  ),

                  onPressed:
                      () {
                    Navigator.pop(
                      context,
                    );
                  },
                ),

                titleSpacing:
                0,

                title:
                Padding(
                  padding:
                  EdgeInsets.only(
                    right:
                    ui.smallSpacing,
                  ),

                  child:
                  Text(
                    "إدارة خطة ${UserInfo.name}",

                    maxLines:
                    1,

                    overflow:
                    TextOverflow
                        .ellipsis,

                    style:
                    TextStyle(
                      color:
                      ColorManager
                          .medicalPrimary,

                      fontWeight:
                      FontWeight.w700,

                      fontSize:
                      ui.cardTitleSize,
                    ),
                  ),
                ),
              ),

              // =================================================
              // Tabs
              // =================================================
              SliverToBoxAdapter(
                child:
                Center(
                  child:
                  ConstrainedBox(
                    constraints:
                    BoxConstraints(
                      maxWidth:
                      ui.pageMaxWidth,
                    ),

                    child:
                    Padding(
                      padding:
                      EdgeInsets.fromLTRB(
                        ui.pagePadding,
                        ui.searchTopPadding,
                        ui.pagePadding,
                        ui.searchBottomPadding,
                      ),

                      child:
                      _buildTabBar(
                        context,
                        ui,
                      ),
                    ),
                  ),
                ),
              ),
            ];
          },

          // =====================================================
          // Pages
          // =====================================================
          body:
          const TabBarView(
            physics:
            NeverScrollableScrollPhysics(),

            children: [
              CreatePlanBrandPage(),
              ViewActivePlanBrandPage(),
            ],
          ),
        ),
      ),
    );
  }

  // ===========================================================
  // Tab Bar
  // ===========================================================

  Widget _buildTabBar(
      BuildContext context,
      AppUi ui,
      ) {
    return Container(
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
          ui.cardRadius,
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

      child:
      TabBar(
        dividerColor:
        Colors.transparent,

        indicatorSize:
        TabBarIndicatorSize.tab,

        labelPadding:
        EdgeInsets.zero,

        overlayColor:
        WidgetStateProperty.all(
          Colors.transparent,
        ),

        labelColor:
        Colors.white,

        unselectedLabelColor:
        const Color(
          0xFF64748B,
        ),

        labelStyle: TextStyle(
          fontSize: ui.isMobile
              ? 15
              : 17,
          fontWeight: FontWeight.w700,
        ),

        unselectedLabelStyle: TextStyle(
          fontSize: ui.isMobile
              ? 15
              : 17,
          fontWeight: FontWeight.w600,
        ),


        indicator:
        BoxDecoration(
          color:
          ColorManager
              .medicalPrimary,

          borderRadius:
          BorderRadius.circular(
            ui.smallRadius +
                2,
          ),

          boxShadow: [
            BoxShadow(
              color:
              ColorManager
                  .medicalPrimary
                  .withOpacity(
                0.16,
              ),

              blurRadius:
              8,

              offset:
              const Offset(
                0,
                3,
              ),
            ),
          ],
        ),

        // =====================================================
        // نفس Bloc Events الأصلية تماماً
        // =====================================================
        onTap:
            (value) {
          if (value == 0) {
            context
                .read<
                PlanManagementBloc>()
                .add(
              RepPlanBrandSpEvent(
                RepSp(
                  UserInfo.otherPlanId ??
                      -1,

                  38,

                  UserInfo.repId,
                ),
              ),
            );
          } else {
            context
                .read<
                PlanManagementBloc>()
                .add(
              RepActivePlanBrandEvent(),
            );
          }
        },

        tabs: [
          _buildTab(
            ui: ui,
            icon:
            Icons
                .edit_note_rounded,
            title:
            'خطة مستقبلية',
          ),

          _buildTab(
            ui: ui,
            icon:
            Icons
                .visibility_outlined,
            title:
            'خطة فعالة',
          ),
        ],
      ),
    );
  }

  // ===========================================================
  // Single Tab
  // ===========================================================

  Widget _buildTab({
    required AppUi ui,
    required IconData icon,
    required String title,
  }) {
    return Tab(
      height:
      ui.isMobile
          ? 46
          : 50,

      child:
      Padding(
        padding:
        EdgeInsets.symmetric(
          horizontal:
          ui.smallSpacing,
        ),

        child:
        Row(
          mainAxisAlignment:
          MainAxisAlignment.center,

          mainAxisSize:
          MainAxisSize.min,

          children: [
            Icon(
              icon,

              size:
              ui.smallIconSize +
                  2,
            ),

            SizedBox(
              width:
              ui.smallSpacing,
            ),

            Flexible(
              child:
              Text(
                title,

                maxLines:
                1,

                overflow:
                TextOverflow
                    .ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}