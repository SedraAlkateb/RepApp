import 'package:domina_app/presentation/doctors/bloc/doctors_bloc.dart';
import 'package:domina_app/presentation/doctors/pages/doctor_page/doctors.dart';
import 'package:domina_app/presentation/doctors/pages/hospital_page/hospital.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/resources/responsive/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RecipeDH extends StatelessWidget {
  const RecipeDH({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final ui = AppUi.of(context);

    return DefaultTabController(
      length: 2,

      child: Scaffold(
        backgroundColor: const Color(
          0xFFF8FAFC,
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
                  'إنشاء وصفة',

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
              Doctors(),
              Hospital(),
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
        onTap: (value) {
          if (value == 0) {
            context
                .read<DoctorsBloc>()
                .add(
              AllDoctorEvent(),
            );
          } else {
            context
                .read<DoctorsBloc>()
                .add(
              AllHospitalEvent(),
            );
          }
        },

        tabs: [
          _buildTab(
            ui: ui,
            icon:
            Icons.groups_outlined,
            title:
            'الأطباء',
          ),

          _buildTab(
            ui: ui,
            icon:
            Icons.local_hospital_outlined,
            title:
            'المشافي',
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