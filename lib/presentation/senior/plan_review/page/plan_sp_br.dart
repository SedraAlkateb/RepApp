import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/resources/responsive/app_ui.dart';
import 'package:domina_app/presentation/senior/all_city/bloc/bloc/all_city_bloc.dart';
import 'package:domina_app/presentation/senior/manage_future/bloc/manage_future_bloc.dart';
import 'package:domina_app/presentation/senior/manage_future/widget/status_plan_widget.dart';
import 'package:domina_app/presentation/senior/plan_review/bloc/future_rep_bloc.dart';
import 'package:domina_app/presentation/senior/plan_review/page/future_spec.dart';
import 'package:domina_app/presentation/senior/plan_review/page/show_plan_brand.dart';
import 'package:domina_app/presentation/uniti/stateWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PlanSpBr extends StatelessWidget {
  const PlanSpBr({
    super.key,
    required this.id,
    required this.repPlanId,
    required this.flag,
    required this.sampleCount,
    required this.repName,
    required this.repType,
  });

  final String repName;
  final int id;
  final int repPlanId;
  final FlagModel flag;
  final int sampleCount;
  final RepType repType;

  @override
  Widget build(BuildContext context) {
    final ui = AppUi.of(context);

    return DefaultTabController(
      length: 2,

      child: Scaffold(
        backgroundColor: const Color(
          0xFFF8FAFC,
        ),
        floatingActionButton: BlocConsumer<FutureRepBloc, FutureRepState>(
          listener: (context, state) {
            // ===============================================
            // نفس السلوك الأصلي
            // ===============================================
            if (state is EditeStatusLoadingState) {
              loading(
                context,
              );
            } else if (state is EditeStatusFailureState) {
              error(
                context,
                state.failure.massage,
                state.failure.code,
              );
            } else if (state is EditeStatusState) {
              BlocProvider.of<ManageFutureBloc>(
                context,
              ).add(
                AllSeniorRepFutureEvent(
                    cityId: context.read<AllCityBloc>().selectedCityId),
              );

              success(
                context,
              );

              Navigator.pop(
                context,
              );
            }
          },
          builder: (context, state) {
            return FloatingActionButton(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  18,
                ),
              ),
              backgroundColor: ColorManager.secondaryColor1,
              onPressed: () {
                // =============================================
                // نفس Bottom Sheet
                // =============================================
                showStatusBottomSheet(
                  context,
                  repType.i,
                  repPlanId,
                );
              },
              child: Icon(
                Icons.check_rounded,
                color: ColorManager.white,
                size: ui.iconSize,
              ),
            );
          },
        ),

        body: NestedScrollView(
          physics: const BouncingScrollPhysics(),

          headerSliverBuilder: (
              context,
              innerBoxIsScrolled,
              ) {
            return [
              // =====================================================
              // AppBar
              // =====================================================
              SliverAppBar(
                pinned: true,
                floating: true,
                snap: true,

                elevation: 0,
                scrolledUnderElevation: 0,
                surfaceTintColor: Colors.transparent,

                backgroundColor: Colors.white,

                leading: IconButton(
                  tooltip: 'رجوع',

                  icon: Icon(
                    Icons.arrow_back_rounded,
                    color:
                    ColorManager.medicalPrimary,
                  ),

                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),

                titleSpacing: 0,

                title: Text(
                  'تدقيق خطة ${repName}',

                  maxLines: 1,
                  overflow:
                  TextOverflow.ellipsis,

                  style: TextStyle(
                    color:
                    ColorManager.medicalPrimary,

                    fontWeight:
                    FontWeight.w700,

                    fontSize:
                    ui.isMobile
                        ? 18
                        : 21,
                  ),
                ),
              ),

              // =====================================================
              // TabBar
              // =====================================================
              SliverToBoxAdapter(
                child: Center(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth:
                      ui.pageMaxWidth,
                    ),

                    child: Padding(
                      padding:
                      EdgeInsets.fromLTRB(
                        ui.pagePadding,
                        ui.searchTopPadding,
                        ui.pagePadding,
                        ui.searchBottomPadding,
                      ),

                      child: _buildTabBar(
                        context,
                        ui,
                      ),
                    ),
                  ),
                ),
              ),
            ];
          },

          // =======================================================
          // Pages
          // =======================================================
          body:  TabBarView(
            physics:
            NeverScrollableScrollPhysics(),

            children: [
              FutureSpecializationsPage(id: id,
                  repPlanId: repPlanId,
                  flag: flag,
                  sampleCount: sampleCount,
                repType: repType),
              ShowPlanBrand(planId: repPlanId),
            ],
          ),
        ),
      ),
    );
  }

  // =============================================================
  // TabBar
  // =============================================================

  Widget _buildTabBar(
      BuildContext context,
      AppUi ui,
      ) {
    return Container(
      padding: const EdgeInsets.all(
        4,
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

      child: TabBar(
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

        // =========================================================
        // Colors
        // =========================================================
        labelColor: Colors.white,

        unselectedLabelColor:
        const Color(
          0xFF64748B,
        ),

        // =========================================================
        // Text
        // =========================================================
        labelStyle: TextStyle(
          fontSize:
          ui.isMobile
              ? 15
              : 17,

          fontWeight:
          FontWeight.w700,
        ),

        unselectedLabelStyle:
        TextStyle(
          fontSize:
          ui.isMobile
              ? 15
              : 17,

          fontWeight:
          FontWeight.w600,
        ),

        // =========================================================
        // Indicator
        // =========================================================
        indicator: BoxDecoration(
          color:
          ColorManager.medicalPrimary,

          borderRadius:
          BorderRadius.circular(
            ui.smallRadius + 2,
          ),

          boxShadow: [
            BoxShadow(
              color:
              ColorManager
                  .medicalPrimary
                  .withOpacity(
                0.16,
              ),

              blurRadius: 8,

              offset: const Offset(
                0,
                3,
              ),
            ),
          ],
        ),

        // =========================================================
        // نفس السلوك الأصلي تماماً
        // =========================================================
        tabs: [
          _buildTab(
            ui: ui,
            icon:
            Icons.folder_special_outlined,
            title:
            'الاختصاصات',
          ),

          _buildTab(
            ui: ui,
            icon:
            Icons.medication_outlined,
            title:
            'الاصناف',
          ),
        ],
      ),
    );
  }

  // =============================================================
  // Tab Item
  // =============================================================

  Widget _buildTab({
    required AppUi ui,
    required IconData icon,
    required String title,
  }) {
    return Tab(
      height:
      ui.isMobile
          ? 50
          : 56,

      child: Padding(
        padding:
        EdgeInsets.symmetric(
          horizontal:
          ui.mediumSpacing,
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
                  ? 21
                  : 23,
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
      ),
    );
  }
}