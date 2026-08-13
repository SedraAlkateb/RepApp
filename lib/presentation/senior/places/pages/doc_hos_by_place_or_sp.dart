import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/resources/responsive/app_ui.dart';
import 'package:domina_app/presentation/senior/representative/bloc/senior_prof_bloc.dart';
import 'package:domina_app/presentation/senior/representative/widget/doc_card.dart';
import 'package:domina_app/presentation/senior/representative/widget/hos_card.dart';
import 'package:domina_app/presentation/uniti/num_list.dart';
import 'package:domina_app/presentation/uniti/stateWidget.dart';


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DocHosByPlaceOrSpPage extends StatelessWidget {
  const DocHosByPlaceOrSpPage({
    super.key,
    this.height = 54,
  });
  final double height;

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
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
            ),
          ),
          title: const Text(
            'ارشيف الأطباء والمشافي',
            style: TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        body: BlocBuilder<
            SeniorProfBloc,
            SeniorProfState>(
          buildWhen: (previous, current) =>
          current is DocHosLoadingState ||
              current is DocHosState ||
              current is DocHosErrorState,

          builder: (context, state) {
            // =====================================================
            // Loading
            // =====================================================
            if (state is DocHosLoadingState) {
              return Center(
                child: loadingFullScreen(
                  context,
                ),
              );
            }

            // =====================================================
            // Error
            // =====================================================
            if (state is DocHosErrorState) {
              return Center(
                child: errorFullScreen(
                  context,
                ),
              );
            }

            // =====================================================
            // Success
            // =====================================================
            if (state is DocHosState) {
              return Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: contentMaxWidth,
                  ),
                  child: Column(
                    children: [
                      // =============================================
                      // Tabs
                      // =============================================
                      Padding(
                        padding: EdgeInsets.fromLTRB(
                          ui.pagePadding,
                          ui.searchTopPadding,
                          ui.pagePadding,
                          ui.searchBottomPadding,
                        ),
                        child: SizedBox(
                          height: height,
                          child: _DocHosTabBar(
                            height: height,
                          ),
                        ),
                      ),

                      // =============================================
                      // Tab Content
                      // =============================================
                      Expanded(
                        child: TabBarView(
                          children: [
                            // =======================================
                            // Doctors
                            // =======================================
                            _DoctorsTab(
                              doctors:
                              state.doctors,
                            ),

                            // =======================================
                            // Hospitals
                            // =======================================
                            _HospitalsTab(
                              hospitals:
                              state.hospitals,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}

// ================================================================
// Tab Bar
// ================================================================

class _DocHosTabBar extends StatelessWidget {
  const _DocHosTabBar({
    required this.height,
  });

  final double height;

  @override
  Widget build(BuildContext context) {
    final ui = AppUi.of(context);

    return Container(
      height: height,
      padding: const EdgeInsets.all(
        4,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(
          16,
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
      child: TabBar(
        padding: EdgeInsets.zero,
        labelPadding: EdgeInsets.zero,

        dividerColor:
        Colors.transparent,

        indicatorSize:
        TabBarIndicatorSize.tab,

        labelColor:
        Colors.white,

        unselectedLabelColor:
        const Color(
          0xFF64748B,
        ),

        labelStyle: TextStyle(
          fontWeight:
          FontWeight.w700,
          fontSize:
          ui.isMobile
              ? 15
              : 16,
        ),

        unselectedLabelStyle:
        TextStyle(
          fontWeight:
          FontWeight.w500,
          fontSize:
          ui.isMobile
              ? 15
              : 16,
        ),

        indicator: BoxDecoration(
          color:
          ColorManager.medicalPrimary,

          borderRadius:
          BorderRadius.circular(
            12,
          ),
        ),

        tabs: const [
          Tab(
            child: _ArchiveTabItem(
              icon:
              Icons.groups_outlined,
              title:
              'الأطباء',
            ),
          ),

          Tab(
            child: _ArchiveTabItem(
              icon:
              Icons.local_hospital_outlined,
              title:
              'المشافي',
            ),
          ),
        ],
      ),
    );
  }
}

// ================================================================
// Doctors Tab
// ================================================================

class _DoctorsTab extends StatelessWidget {
  const _DoctorsTab({
    required this.doctors,
  });

  final List<DoctorSenModel> doctors;

  @override
  Widget build(BuildContext context) {
    final ui = AppUi.of(context);

    // =============================================================
    // Empty
    // =============================================================
    if (doctors.isEmpty) {
      return Center(
        child: emptyFullScreen(
          context,
        ),
      );
    }

    return CustomScrollView(
      physics:
      const BouncingScrollPhysics(),

      keyboardDismissBehavior:
      ScrollViewKeyboardDismissBehavior
          .onDrag,

      slivers: [
        // =========================================================
        // Count
        // =========================================================
        SliverPadding(
          padding: EdgeInsets.fromLTRB(
            ui.pagePadding,
            ui.listTopPadding,
            ui.pagePadding,
            ui.sectionSpacing,
          ),
          sliver: SliverToBoxAdapter(
            child: buildTotalReportsCard(
              doctors.length,
              'قائمة الأطباء المسجلين',
              '',
            ),
          ),
        ),

        // =========================================================
        // Doctors List
        // =========================================================
        SliverPadding(
          padding: EdgeInsets.fromLTRB(
            ui.pagePadding,
            0,
            ui.pagePadding,
            ui.listBottomPadding,
          ),
          sliver: SliverList.builder(
            itemCount:
            doctors.length,

            itemBuilder:
                (
                context,
                index,
                ) {
              return Padding(
                padding:
                EdgeInsets.only(
                  bottom:
                  ui.cardSpacing,
                ),

                child:
                DoctorSenCardWidget(
                  doctor:
                  doctors[index],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

// ================================================================
// Hospitals Tab
// ================================================================

class _HospitalsTab extends StatelessWidget {
  const _HospitalsTab({
    required this.hospitals,
  });

  final List<HospitalSpModel>
  hospitals;

  @override
  Widget build(BuildContext context) {
    final ui = AppUi.of(context);

    // =============================================================
    // Empty
    // =============================================================
    if (hospitals.isEmpty) {
      return Center(
        child: emptyFullScreen(
          context,
        ),
      );
    }

    return CustomScrollView(
      physics:
      const BouncingScrollPhysics(),

      keyboardDismissBehavior:
      ScrollViewKeyboardDismissBehavior
          .onDrag,

      slivers: [
        // =========================================================
        // Count
        // =========================================================
        SliverPadding(
          padding: EdgeInsets.fromLTRB(
            ui.pagePadding,
            ui.listTopPadding,
            ui.pagePadding,
            ui.sectionSpacing,
          ),

          sliver:
          SliverToBoxAdapter(
            child:
            buildTotalReportsCard(
              hospitals.length,
              'قائمة المشافي المسجلة',
              '',
            ),
          ),
        ),

        // =========================================================
        // Hospital List
        // =========================================================
        SliverPadding(
          padding: EdgeInsets.fromLTRB(
            ui.pagePadding,
            0,
            ui.pagePadding,
            ui.listBottomPadding,
          ),

          sliver:
          SliverList.builder(
            itemCount:
            hospitals.length,

            itemBuilder:
                (
                context,
                index,
                ) {
              return HospitalCardWidget(
                hospital:
                hospitals[index],
              );
            },
          ),
        ),
      ],
    );
  }
}

// ================================================================
// Tab Item
// ================================================================

class _ArchiveTabItem
    extends StatelessWidget {
  const _ArchiveTabItem({
    required this.icon,
    required this.title,
  });

  final IconData icon;
  final String title;

  @override
  Widget build(
      BuildContext context,
      ) {
    final ui =
    AppUi.of(context);

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