// ignore_for_file: deprecated_member_use

import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/resources/responsive/app_ui.dart';
import 'package:domina_app/presentation/senior/places/widget/city_filter_widget.dart';
import 'package:domina_app/presentation/senior/representative/bloc/senior_prof_bloc.dart';
import 'package:domina_app/presentation/senior/representative/widget/doc_card.dart';
import 'package:domina_app/presentation/senior/representative/widget/hos_card.dart';
import 'package:domina_app/presentation/uniti/num_list.dart';
import 'package:domina_app/presentation/uniti/search_field.dart';
import 'package:domina_app/presentation/uniti/stateWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DocHosByPlaceOrSpPage extends StatefulWidget {
  const DocHosByPlaceOrSpPage({
    super.key,
    this.height = 54,
  });

  final double height;

  @override
  State<DocHosByPlaceOrSpPage> createState() =>
      _DocHosByPlaceOrSpPageState();
}

class _DocHosByPlaceOrSpPageState
    extends State<DocHosByPlaceOrSpPage>
    with SingleTickerProviderStateMixin {
  // ===========================================================
  // Controllers
  // ===========================================================

  final TextEditingController searchController =
  TextEditingController();

  late final TabController _tabController;

  // ===========================================================
  // Original Lists
  // هدول دائماً بيضلوا القوائم الأصلية
  // حتى ما يصير البحث على نتيجة بحث سابقة
  // ===========================================================

  List<DoctorSenModel> _allDoctors = [];
  List<HospitalSpModel> _allHospitals = [];

  bool _baseDataLoaded = false;

  int _lastTabIndex = 0;

  // ===========================================================
  // Init
  // ===========================================================

  @override
  void initState() {
    super.initState();

    _tabController = TabController(
      length: 2,
      vsync: this,
    );

    _tabController.addListener(
      _onTabChanged,
    );
  }

  // ===========================================================
  // Tab Changed
  // ===========================================================

  void _onTabChanged() {
    if (_tabController.indexIsChanging) {
      return;
    }

    if (_lastTabIndex ==
        _tabController.index) {
      return;
    }

    _lastTabIndex =
        _tabController.index;

    if (!_baseDataLoaded) {
      return;
    }

    // =========================================================
    // لما المستخدم ينتقل بين الأطباء والمشافي
    // نطبق نفس نص البحث على التاب الجديد
    // =========================================================
    _search(
      searchController.text,
    );
  }

  // ===========================================================
  // Search
  // ===========================================================

  void _search(
      String value,
      ) {
    if (!_baseDataLoaded) {
      return;
    }

    context.read<SeniorProfBloc>().add(
      SearchDocHosEvent(
        content: value,

        // 0 = Doctors
        // 1 = Hospitals
        tabIndex:
        _tabController.index,

        // دائماً القوائم الأصلية
        doctors:
        _allDoctors,

        hospitals:
        _allHospitals,
      ),
    );
  }

  // ===========================================================
  // Dispose
  // ===========================================================

  @override
  void dispose() {
    _tabController.removeListener(
      _onTabChanged,
    );

    _tabController.dispose();

    searchController.dispose();

    super.dispose();
  }

  // ===========================================================
  // Build
  // ===========================================================

  @override
  Widget build(BuildContext context) {
    final ui = AppUi.of(context);

    final double contentMaxWidth =
    ui.isTabletLandscape
        ? 760
        : ui.pageMaxWidth;

    return Scaffold(
      backgroundColor: const Color(
        0xFFF8FAFC,
      ),

      // =======================================================
      // AppBar
      // =======================================================
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor:
        Colors.transparent,
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
            ui.isMobile ? 24 : 27,
            color: ColorManager
                .medicalPrimary,
          ),
        ),

        title: Text(
          'أرشيف الأطباء والمشافي',

          maxLines: 1,

          overflow:
          TextOverflow.ellipsis,

          style: TextStyle(
            fontSize:
            ui.isMobile ? 18 : 21,

            fontWeight:
            FontWeight.w700,

            color: ColorManager
                .medicalPrimary,
          ),
        ),
      ),

      // =======================================================
      // Body
      // =======================================================
      body: SafeArea(
        top: false,

        child: Column(
          children: [
            // =========================================
            // Tabs
            // =========================================
            Padding(
              padding:
              EdgeInsets.fromLTRB(
                ui.pagePadding,
                ui.searchTopPadding,
                ui.pagePadding,
                ui.smallSpacing,
              ),

              child: SizedBox(
                height:
                widget.height,

                child:
                _DocHosTabBar(
                  height:
                  widget.height,

                  controller:
                  _tabController,
                ),
              ),
            ),

            // =========================================
            // Search
            //
            // دائماً ظاهر حتى لو النتيجة Empty
            // =========================================
            SliverPadding(
              padding:
              EdgeInsets.fromLTRB(
                ui.pagePadding,
                ui.searchTopPadding,
                ui.pagePadding,
                ui.searchBottomPadding,
              ),

              sliver:
              SliverToBoxAdapter(
                child:
                SearchWithCityFilter(
                  searchController:
                  searchController,

                  onSearch:
                      (value) {
                    _search(
                      value,
                    );
                  },
                ),
              ),
            ),


            // =========================================
            // Tabs Content
            // =========================================
            BlocBuilder<
                SeniorProfBloc,
                SeniorProfState>(
              buildWhen: (
                  previous,
                  current,
                  ) =>
              current
              is DocHosLoadingState ||
                  current
                  is DocHosState ||
                  current
                  is DocHosErrorState,

              builder: (
                  context,
                  state,
                  ) {
                // =================================================
                // Loading
                // =================================================
                if (state
                is DocHosLoadingState) {
                  // إذا عم نجيب بيانات جديدة
                  // منسمح بتخزين القائمة الأصلية الجديدة
                  _baseDataLoaded = false;

                  return Container(
                    child: loadingFullScreen(
                      context,
                    ),
                  );
                }

                // =================================================
                // Error
                // =================================================
                if (state
                is DocHosErrorState) {
                  return Container(
                    child: errorFullScreen(
                      context,
                    ),
                  );
                }

                // =================================================
                // Success
                // =================================================
                if (state is DocHosState) {
                  if (!_baseDataLoaded) {
                    _allDoctors =
                    List<DoctorSenModel>.from(
                      state.doctors,
                    );

                    _allHospitals =
                    List<HospitalSpModel>.from(
                      state.hospitals,
                    );

                    _baseDataLoaded = true;
                  }

                  return Expanded(
                    child: Center(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          maxWidth: contentMaxWidth,
                        ),

                        child: TabBarView(
                          controller: _tabController,

                          children: [
                            _DoctorsTab(
                              doctors: state.doctors,
                            ),

                            _HospitalsTab(
                              hospitals: state.hospitals,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================================
// Tab Bar
// ============================================================================

class _DocHosTabBar extends StatelessWidget {
  const _DocHosTabBar({
    required this.height,
    required this.controller,
  });

  final double height;
  final TabController controller;

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

        borderRadius:
        BorderRadius.circular(
          16,
        ),

        border: Border.all(
          color: const Color(
            0xFFE2E8F0,
          ),
        ),

        boxShadow: [
          BoxShadow(
            color: Colors.black
                .withOpacity(
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
        controller: controller,

        padding: EdgeInsets.zero,

        labelPadding:
        EdgeInsets.zero,

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
          color: ColorManager
              .medicalPrimary,

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
              title: 'الأطباء',
            ),
          ),

          Tab(
            child: _ArchiveTabItem(
              icon: Icons
                  .local_hospital_outlined,
              title: 'المشافي',
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// Doctors Tab
// ============================================================================

class _DoctorsTab extends StatelessWidget {
  const _DoctorsTab({
    required this.doctors,
  });

  final List<DoctorSenModel> doctors;

  @override
  Widget build(BuildContext context) {
    final ui = AppUi.of(context);

    // =========================================================
    // Empty
    //
    // السيرش ما بيروح لأنه موجود خارج هاد الـWidget
    // =========================================================
    if (doctors.isEmpty) {
      return emptyFullScreen(
        context,
      );
    }

    return CustomScrollView(
      physics:
      const BouncingScrollPhysics(),

      keyboardDismissBehavior:
      ScrollViewKeyboardDismissBehavior
          .onDrag,

      slivers: [
        // =====================================================
        // Count
        // =====================================================
        SliverPadding(
          padding:
          EdgeInsets.fromLTRB(
            ui.pagePadding,
            ui.listTopPadding,
            ui.pagePadding,
            ui.sectionSpacing,
          ),

          sliver:
          SliverToBoxAdapter(
            child:
            buildTotalReportsCard(
              doctors.length,
              'قائمة الأطباء المسجلين',
              '',
            ),
          ),
        ),

        // =====================================================
        // Doctors List
        // =====================================================
        SliverPadding(
          padding:
          EdgeInsets.fromLTRB(
            ui.pagePadding,
            0,
            ui.pagePadding,
            ui.listBottomPadding,
          ),

          sliver:
          SliverList.builder(
            itemCount:
            doctors.length,

            itemBuilder: (
                context,
                index,
                ) {
              return DoctorSenCardWidget(
                doctor:
                doctors[index],
              );
            },
          ),
        ),
      ],
    );
  }
}

// ============================================================================
// Hospitals Tab
// ============================================================================

class _HospitalsTab extends StatelessWidget {
  const _HospitalsTab({
    required this.hospitals,
  });

  final List<HospitalSpModel>
  hospitals;

  @override
  Widget build(BuildContext context) {
    final ui = AppUi.of(context);

    // =========================================================
    // Empty
    //
    // السيرش ما بيروح لأنه موجود خارج هاد الـWidget
    // =========================================================
    if (hospitals.isEmpty) {
      return emptyFullScreen(
        context,
      );
    }

    return CustomScrollView(
      physics:
      const BouncingScrollPhysics(),

      keyboardDismissBehavior:
      ScrollViewKeyboardDismissBehavior
          .onDrag,

      slivers: [
        // =====================================================
        // Count
        // =====================================================
        SliverPadding(
          padding:
          EdgeInsets.fromLTRB(
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

        // =====================================================
        // Hospitals List
        // =====================================================
        SliverPadding(
          padding:
          EdgeInsets.fromLTRB(
            ui.pagePadding,
            0,
            ui.pagePadding,
            ui.listBottomPadding,
          ),

          sliver:
          SliverList.builder(
            itemCount:
            hospitals.length,

            itemBuilder: (
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

// ============================================================================
// Tab Item
// ============================================================================

class _ArchiveTabItem
    extends StatelessWidget {
  const _ArchiveTabItem({
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
            TextOverflow
                .ellipsis,
          ),
        ),
      ],
    );
  }
}