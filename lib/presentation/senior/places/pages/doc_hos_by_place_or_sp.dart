// ignore_for_file: deprecated_member_use

import 'package:domina_app/app/user_info.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/resources/responsive/app_responsive.dart';
import 'package:domina_app/presentation/resources/responsive/app_ui.dart';
import 'package:domina_app/presentation/senior/all_city/bloc/bloc/all_city_bloc.dart';
import 'package:domina_app/presentation/senior/places/widget/city_filter_widget.dart';
import 'package:domina_app/presentation/senior/places/widget/doc_hos_tab_bar_widget.dart';
import 'package:domina_app/presentation/senior/places/widget/header_sen_doc_hos.dart';
import 'package:domina_app/presentation/senior/representative/bloc/senior_prof_bloc.dart';
import 'package:domina_app/presentation/senior/representative/widget/doc_card.dart';
import 'package:domina_app/presentation/senior/representative/widget/hos_card.dart';
import 'package:domina_app/presentation/uniti/num_list.dart';
import 'package:domina_app/presentation/uniti/stateWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DocHosByPlaceOrSpPage extends StatefulWidget {
  const DocHosByPlaceOrSpPage({
    super.key,
    this.height = 54,
    this.placeId,
    this.spId
  });
  final double height;
  final int? placeId;
  final int? spId;

  @override
  State<DocHosByPlaceOrSpPage> createState() => _DocHosByPlaceOrSpPageState();
}

class _DocHosByPlaceOrSpPageState extends State<DocHosByPlaceOrSpPage>
    with SingleTickerProviderStateMixin {
  // ===========================================================
  // Controllers
  // ===========================================================

  final TextEditingController searchController = TextEditingController();

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

    if (_lastTabIndex == _tabController.index) {
      return;
    }

    _lastTabIndex = _tabController.index;

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
  int? _lastLoadedCityId;

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
            tabIndex: _tabController.index,

            // دائماً القوائم الأصلية
            doctors: _allDoctors,

            hospitals: _allHospitals,
          ),
        );
  }

  void _loadSelectedCity({
    bool force = false,
  }) {
    if (!mounted) {
      return;
    }

    final cityBloc = context.read<AllCityBloc>();

    final int? cityId = cityBloc.selectedCityId;

    if (cityId == null || cityId < 0) {
      return;
    }

    if (!force && _lastLoadedCityId == cityId) {
      return;
    }

    _lastLoadedCityId = cityId;

    // عند تغيير المحافظة
    // نظف البحث القديم
    searchController.clear();

    context.read<SeniorProfBloc>().add(
          DocHosEvent(UserInfo.repId,
              spId: widget.spId,
              placeId: widget.placeId,
              cityId: BlocProvider.of<AllCityBloc>(context).selectedCityId),
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

// Replace SliverPadding with Padding in the SafeArea body
  @override
  Widget build(BuildContext context) {
    final ui = AppUi.of(context);
    final deviceType = AppResponsive.deviceType(context);

    double pageMaxWidth;

    switch (deviceType) {
      case AppDeviceType.mobilePortrait:
        pageMaxWidth = 600;
        break;
      case AppDeviceType.tabletPortrait:
        pageMaxWidth = 760;
        break;

      case AppDeviceType.tabletLandscape:
        pageMaxWidth = 900;
        break;
    }

    return BlocListener<AllCityBloc, AllCityState>(
      listener: (
        context,
        state,
      ) {
        // =====================================================
        // أول تحميل أو تغيير المحافظة
        // =====================================================
        if (state is GetAllCityState) {
          _loadSelectedCity();
        }
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFF8FAFC),
        appBar: header(context,ui),
        body: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: pageMaxWidth,
            ),
            child: SafeArea(
              top: false,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                      ui.pagePadding,
                      ui.searchTopPadding,
                      ui.pagePadding,
                      ui.smallSpacing,
                    ),
                    child: SizedBox(
                      height: widget.height,
                      child: DocHosTabBar(
                        height: widget.height,
                        controller: _tabController,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                      ui.pagePadding,
                      ui.searchTopPadding,
                      ui.pagePadding,
                      ui.searchBottomPadding,
                    ),
                    child: SearchWithCityFilter(
                      searchController: searchController,
                      onSearch: (value) {
                        _search(value);
                      },
                    ),
                  ),
                  Expanded(
                    child: BlocBuilder<SeniorProfBloc, SeniorProfState>(
                      buildWhen: (previous, current) =>
                          current is DocHosLoadingState ||
                          current is DocHosState ||
                          current is DocHosErrorState,
                      builder: (context, state) {
                        if (state is DocHosLoadingState) {
                          _baseDataLoaded = false;
                          return loadingFullScreen(context);
                        }
                        if (state is DocHosErrorState) {
                          return errorFullScreen(context);
                        }
                        if (state is DocHosState) {
                          if (!_baseDataLoaded) {
                            _allDoctors = List<DoctorSenModel>.from(state.doctors);
                            _allHospitals =
                                List<HospitalSpModel>.from(state.hospitals);
                            _baseDataLoaded = true;
                          }
                          return TabBarView(
                            controller: _tabController,
                            children: [
                              _DoctorsTab(doctors: state.doctors),
                              _HospitalsTab(hospitals: state.hospitals),
                            ],
                          );
                        }
                        return const SizedBox.shrink();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
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
      physics: const BouncingScrollPhysics(),
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      slivers: [
        // =====================================================
        // Count
        // =====================================================
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

        // =====================================================
        // Doctors List
        // =====================================================
        SliverPadding(
          padding: EdgeInsets.fromLTRB(
            ui.pagePadding,
            0,
            ui.pagePadding,
            ui.listBottomPadding,
          ),
          sliver: SliverList.builder(
            itemCount: doctors.length,
            itemBuilder: (
              context,
              index,
            ) {
              return DoctorSenCardWidget(
                doctor: doctors[index],
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

  final List<HospitalSpModel> hospitals;

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
      physics: const BouncingScrollPhysics(),
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      slivers: [
        // =====================================================
        // Count
        // =====================================================
        SliverPadding(
          padding: EdgeInsets.fromLTRB(
            ui.pagePadding,
            ui.listTopPadding,
            ui.pagePadding,
            ui.sectionSpacing,
          ),
          sliver: SliverToBoxAdapter(
            child: buildTotalReportsCard(
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
          padding: EdgeInsets.fromLTRB(
            ui.pagePadding,
            0,
            ui.pagePadding,
            ui.listBottomPadding,
          ),
          sliver: SliverList.builder(
            itemCount: hospitals.length,
            itemBuilder: (
              context,
              index,
            ) {
              return HospitalCardWidget(
                hospital: hospitals[index],
              );
            },
          ),
        ),
      ],
    );
  }
}

