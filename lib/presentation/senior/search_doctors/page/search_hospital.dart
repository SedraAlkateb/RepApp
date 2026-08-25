// ignore_for_file: must_be_immutable

import 'package:domina_app/app/user_info.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/resources/responsive/app_ui.dart';
import 'package:domina_app/presentation/senior/all_city/bloc/bloc/all_city_bloc.dart';
import 'package:domina_app/presentation/senior/places/widget/city_filter_widget.dart';
import 'package:domina_app/presentation/senior/search_doctors/bloc/search_doctors_bloc.dart';
import 'package:domina_app/presentation/senior/search_doctors/page/hospital_details.dart';
import 'package:domina_app/presentation/uniti/stateWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchHospital extends StatefulWidget {
  const SearchHospital({
    super.key,
  });

  @override
  State<SearchHospital> createState() => _SearchHospitalState();
}

class _SearchHospitalState extends State<SearchHospital>
    with AutomaticKeepAliveClientMixin {
  final TextEditingController searchController = TextEditingController();

  // آخر محافظة تم تحميلها لمنع التكرار
  int? _lastLoadedCityId;

  // ===========================================================
  // Init
  // ===========================================================

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadSelectedCity();
    });
  }

  // ===========================================================
  // Load Current City
  // ===========================================================

  void _loadSelectedCity({
    bool force = false,
  }) {
    if (!mounted) return;

    final cityBloc = context.read<AllCityBloc>();
    final int? cityId = cityBloc.selectedCityId;

    if (cityId == null || cityId < 0) return;

    if (!force && _lastLoadedCityId == cityId) return;

    _lastLoadedCityId = cityId;

    // مسح حقل البحث عند تغيير المحافظة
    searchController.clear();

    // جلب بيانات المشافي فور تغيير المحافظة
    _triggerSearch();
  }

  // ===========================================================
  // Trigger Search Event
  // ===========================================================

  void _triggerSearch() {
    final cityBloc = context.read<AllCityBloc>();
    final int? cityId = cityBloc.selectedCityId;

    if (cityId == null) return;

    context.read<SearchDoctorsBloc>().add(
      FutureSearchHosEvent(
        cityId,
        searchController.text.trim(),
        UserInfo.repId,
      ),
    );
  }

  // ===========================================================
  // Dispose
  // ===========================================================

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  // ===========================================================
  // Build
  // ===========================================================

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final ui = AppUi.of(context);

    return BlocListener<AllCityBloc, AllCityState>(
      listener: (context, state) {
        if (state is GetAllCityState) {
          _loadSelectedCity();
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        body: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: ui.pageMaxWidth,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // =================================================
                // Search Field + City Filter + Search Button
                // =================================================
                Padding(
                  padding: EdgeInsets.fromLTRB(
                    ui.pagePadding,
                    ui.searchTopPadding,
                    ui.pagePadding,
                    ui.searchBottomPadding,
                  ),
                  child: Row(
                    children: [
                      // فلتر المحافظة وحقل النص
                      Expanded(
                        child: SearchWithCityFilter(
                          searchController: searchController,
                          onSearch: (value) {
                            // تم التعطيل للبحث المباشر عند الضغط على الزر فقط
                          },
                        ),
                      ),

                      SizedBox(width: ui.smallSpacing),

                      // زر البحث المباشر
                      Material(
                        color: ColorManager.medicalPrimary,
                        borderRadius: BorderRadius.circular(ui.smallRadius + 4),
                        child: InkWell(
                          borderRadius:
                          BorderRadius.circular(ui.smallRadius + 4),
                          onTap: _triggerSearch,
                          child: Container(
                            height: 48,
                            width: 48,
                            alignment: Alignment.center,
                            child: const Icon(
                              Icons.search_rounded,
                              color: Colors.white,
                              size: 24,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // =================================================
                // Results Content
                // =================================================
                Expanded(
                  child: _buildResultList(context),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ===========================================================
  // Results Content Logic
  // ===========================================================

  Widget _buildResultList(BuildContext context) {
    final ui = AppUi.of(context);
    final cityBloc = context.watch<AllCityBloc>();
    final cityState = cityBloc.state;

    // Loading State للمحافظات
    if (cityState is AllCityLoadingState) {
      return loadingFullScreen(context);
    }

    // Error State للمحافظات
    if (cityState is AllCityErrorState) {
      return errorFullScreen(
        context,
        mes: cityState.failure.massage,
        func: () {
          context.read<AllCityBloc>().add(
            const GetAllCityEvent(),
          );
        },
      );
    }

    // No Cities State
    if (cityBloc.selectedCityId == null) {
      return emptyFullScreen(
        context,
        message: 'لا توجد محافظات متاحة',
      );
    }

    return BlocBuilder<SearchDoctorsBloc, SearchDoctorsState>(
      buildWhen: (previous, current) {
        return current is FutureSearchHospitalsErrorState ||
            current is FutureSearchHospitalsLoadingState ||
            current is FutureSearchHospitalsState ||
            current is FutureSearchHospitalsEmptyState;
      },
      builder: (context, state) {
        // Error
        if (state is FutureSearchHospitalsErrorState) {
          return CustomScrollView(
            physics: const BouncingScrollPhysics(),
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: Padding(
                  padding: EdgeInsets.all(ui.pagePadding),
                  child: errorFullScreen(
                    context,
                    mes: state.failure.massage,
                    func: () {
                      _loadSelectedCity(force: true);
                    },
                  ),
                ),
              ),
            ],
          );
        }

        // Loading
        if (state is FutureSearchHospitalsLoadingState) {
          return CustomScrollView(
            physics: const NeverScrollableScrollPhysics(),
            slivers: [
              SliverPadding(
                padding: EdgeInsets.fromLTRB(
                  ui.pagePadding,
                  ui.listTopPadding,
                  ui.pagePadding,
                  ui.listBottomPadding,
                ),
                sliver: SliverToBoxAdapter(
                  child: loadingShimmer(
                    context,
                    10,
                    100,
                    100,
                    BorderRadius.circular(ui.cardRadius),
                  ),
                ),
              ),
            ],
          );
        }

        // Empty
        if (state is FutureSearchHospitalsEmptyState) {
          return CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: Padding(
                  padding: EdgeInsets.all(ui.pagePadding),
                  child: emptyFullScreen(context),
                ),
              ),
            ],
          );
        }

        // Success
        if (state is FutureSearchHospitalsState) {
          return CustomScrollView(
            physics: const BouncingScrollPhysics(),
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            slivers: [
              SliverPadding(
                padding: EdgeInsets.fromLTRB(
                  ui.pagePadding,
                  ui.listTopPadding,
                  ui.pagePadding,
                  ui.listBottomPadding,
                ),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                        (context, index) {
                      final hospital = state.allSearch[index];

                      return _hospitalWidget(
                        context: context,
                        title: hospital.name,
                        function: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return HospitalDetails(
                                  searchHospitalModel: hospital,
                                );
                              },
                            ),
                          );

                          BlocProvider.of<SearchDoctorsBloc>(context).add(
                            FutureDocHospitalEvent(
                              int.parse(hospital.hosId),
                              int.parse(hospital.spId),
                            ),
                          );
                        },
                      );
                    },
                    childCount: state.allSearch.length,
                  ),
                ),
              ),
            ],
          );
        }

        // Default Initial State
        return CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: _buildInitialState(context),
            ),
          ],
        );
      },
    );
  }

  // ===========================================================
  // Initial State
  // ===========================================================

  Widget _buildInitialState(BuildContext context) {
    final ui = AppUi.of(context);

    return Center(
      child: Padding(
        padding: EdgeInsets.all(ui.pagePadding),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: ui.iconBoxSize + 24,
              height: ui.iconBoxSize + 24,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: ColorManager.medicalPrimary.withOpacity(0.07),
                borderRadius: BorderRadius.circular(ui.cardRadius),
              ),
              child: Icon(
                Icons.local_hospital_outlined,
                size: ui.iconSize + 12,
                color: ColorManager.medicalPrimary.withOpacity(0.75),
              ),
            ),
            SizedBox(height: ui.sectionSpacing),
            Text(
              "ابدأ البحث عن المشافي الآن",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: const Color(0xFF334155),
                fontSize: ui.cardTitleSize,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: ui.smallSpacing),
            Text(
              "اكتب اسم المشفى في حقل البحث واضغط بحث لعرض النتائج",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: const Color(0xFF94A3B8),
                fontSize: ui.smallTextSize,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ===========================================================
  // Hospital Card Widget
  // ===========================================================

  Widget _hospitalWidget({
    required BuildContext context,
    required String title,
    required VoidCallback function,
  }) {
    final ui = AppUi.of(context);

    return Padding(
      padding: EdgeInsets.only(bottom: ui.cardSpacing),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(ui.cardRadius),
          border: Border.all(color: const Color(0xFFE2E8F0)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.025),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.all(ui.cardPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: ui.iconBoxSize,
                    height: ui.iconBoxSize,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF59E0B).withOpacity(0.09),
                      borderRadius: BorderRadius.circular(ui.smallRadius + 2),
                    ),
                    child: Icon(
                      Icons.local_hospital_outlined,
                      color: const Color(0xFFF59E0B),
                      size: ui.iconSize,
                    ),
                  ),
                  SizedBox(width: ui.sectionSpacing),
                  Expanded(
                    child: Text(
                      title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: ui.cardTitleSize,
                        fontWeight: FontWeight.w700,
                        color: ColorManager.medicalPrimary,
                        height: 1.3,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: ui.sectionSpacing),
              const Divider(
                height: 1,
                thickness: 1,
                color: Color(0xFFF1F5F9),
              ),
              SizedBox(height: ui.sectionSpacing),
              Align(
                alignment: Alignment.centerLeft,
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: function,
                    borderRadius: BorderRadius.circular(ui.smallRadius + 2),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: ui.sectionSpacing,
                        vertical: ui.mediumSpacing,
                      ),
                      decoration: BoxDecoration(
                        color: ColorManager.medicalPrimary,
                        borderRadius: BorderRadius.circular(ui.smallRadius + 2),
                        boxShadow: [
                          BoxShadow(
                            color: ColorManager.medicalPrimary.withOpacity(0.12),
                            blurRadius: 8,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "عرض التقارير",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: ui.bodyTextSize,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(width: ui.smallSpacing),
                          Icon(
                            Icons.analytics_outlined,
                            color: Colors.white,
                            size: ui.smallIconSize + 2,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}