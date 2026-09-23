// ignore_for_file: deprecated_member_use

import 'package:domina_app/app/user_info.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/resources/responsive/app_responsive.dart';
import 'package:domina_app/presentation/resources/responsive/app_ui.dart';
import 'package:domina_app/presentation/senior/all_city/bloc/bloc/all_city_bloc.dart';
import 'package:domina_app/presentation/senior/places/widget/city_filter_search_widget.dart';
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
    this.spId,
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

    _tabController.addListener(_onTabChanged);
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

    _search(searchController.text);
  }

  // ===========================================================
  // Search
  // ===========================================================
  int? _lastLoadedCityId;

  void _search(String value) {
    if (!_baseDataLoaded) {
      return;
    }

    context.read<SeniorProfBloc>().add(
      SearchDocHosEvent(
        content: value,
        tabIndex: _tabController.index,
        doctors: _allDoctors,
        hospitals: _allHospitals,
      ),
    );
  }

  void _loadSelectedCity({bool force = false}) {
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
    searchController.clear();

    context.read<SeniorProfBloc>().add(
      DocHosEvent(
        UserInfo.repId,
        spId: widget.spId,
        placeId: widget.placeId,
        cityId: BlocProvider.of<AllCityBloc>(context).selectedCityId,
      ),
    );
  }

  // ===========================================================
  // Dispose
  // ===========================================================

  @override
  void dispose() {
    _tabController.removeListener(_onTabChanged);
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
      listener: (context, state) {
        if (state is GetAllCityState) {
          _loadSelectedCity();
        }
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFF8FAFC),
        appBar: header(context, ui),
        body: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                ),
                // تم التعديل هنا: استخدام Align بوضع topCenter بدلاً من Center لتثبيت المحتوى في الأعلى
                child: Align(
                  alignment: Alignment.topCenter,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: pageMaxWidth,
                    ),
                    child: SafeArea(
                      top: false,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
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
                          BlocBuilder<SeniorProfBloc, SeniorProfState>(
                            buildWhen: (previous, current) =>
                            current is DocHosLoadingState ||
                                current is DocHosState ||
                                current is DocHosErrorState,
                            builder: (context, state) {
                              if (state is DocHosLoadingState) {
                                _baseDataLoaded = false;
                                return Padding(
                                  padding: EdgeInsets.only(top: ui.sectionSpacing * 2),
                                  child: loadingFullScreen(context),
                                );
                              }
                              if (state is DocHosErrorState) {
                                return Padding(
                                  padding: EdgeInsets.only(top: ui.sectionSpacing * 2),
                                  child: errorFullScreen(context),
                                );
                              }
                              if (state is DocHosState) {
                                if (!_baseDataLoaded) {
                                  _allDoctors =
                                  List<DoctorSenModel>.from(state.doctors);
                                  _allHospitals =
                                  List<HospitalSpModel>.from(state.hospitals);
                                  _baseDataLoaded = true;
                                }
                                return AnimatedBuilder(
                                  animation: _tabController,
                                  builder: (context, child) {
                                    if (_tabController.index == 0) {
                                      return _DoctorsSection(doctors: state.doctors);
                                    } else {
                                      return _HospitalsSection(hospitals: state.hospitals);
                                    }
                                  },
                                );
                              }
                              return const SizedBox.shrink();
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

// ============================================================================
// Doctors Section
// ============================================================================

class _DoctorsSection extends StatelessWidget {
  const _DoctorsSection({
    required this.doctors,
  });

  final List<DoctorSenModel> doctors;

  @override
  Widget build(BuildContext context) {
    final ui = AppUi.of(context);

    if (doctors.isEmpty) {
      return Padding(
        padding: EdgeInsets.only(top: ui.sectionSpacing * 2),
        child: emptyFullScreen(context),
      );
    }

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(
            ui.pagePadding,
            ui.listTopPadding,
            ui.pagePadding,
            ui.sectionSpacing,
          ),
          child: buildTotalReportsCard(
            doctors.length,
            'قائمة الأطباء المسجلين',
            '',
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(
            ui.pagePadding,
            0,
            ui.pagePadding,
            ui.listBottomPadding,
          ),
          child: ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: doctors.length,
            itemBuilder: (context, index) {
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
// Hospitals Section
// ============================================================================

class _HospitalsSection extends StatelessWidget {
  const _HospitalsSection({
    required this.hospitals,
  });

  final List<HospitalSpModel> hospitals;

  @override
  Widget build(BuildContext context) {
    final ui = AppUi.of(context);

    if (hospitals.isEmpty) {
      return Padding(
        padding: EdgeInsets.only(top: ui.sectionSpacing * 2),
        child: emptyFullScreen(context),
      );
    }

    final Map<int, List<HospitalSpModel>> groupedByHospitalId = {};
    for (final hospital in hospitals) {
      groupedByHospitalId
          .putIfAbsent(hospital.hospitalId, () => [])
          .add(hospital);
    }
    final List<List<HospitalSpModel>> hospitalGroups =
        groupedByHospitalId.values.toList();

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(
            ui.pagePadding,
            ui.listTopPadding,
            ui.pagePadding,
            ui.sectionSpacing,
          ),
          child: buildTotalReportsCard(
            hospitalGroups.length,
            'قائمة المشافي المسجلة',
            '',
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(
            ui.pagePadding,
            0,
            ui.pagePadding,
            ui.listBottomPadding,
          ),
          child: ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: hospitalGroups.length,
            itemBuilder: (context, index) {
              return HospitalCardWidget(
                hospitalGroup: hospitalGroups[index],
              );
            },
          ),
        ),
      ],
    );
  }
}