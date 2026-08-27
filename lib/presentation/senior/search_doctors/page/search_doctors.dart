// ignore_for_file: must_be_immutable

import 'package:domina_app/app/user_info.dart';
import 'package:domina_app/presentation/doctors/widget/doctor_widget.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/resources/responsive/app_ui.dart';
import 'package:domina_app/presentation/senior/all_city/bloc/bloc/all_city_bloc.dart';
import 'package:domina_app/presentation/senior/places/widget/city_filter_search_widget.dart';
import 'package:domina_app/presentation/senior/search_doctors/bloc/search_doctors_bloc.dart';
import 'package:domina_app/presentation/senior/search_doctors/page/doctor_details.dart';
import 'package:domina_app/presentation/uniti/stateWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchDoctors extends StatefulWidget {
  const SearchDoctors({
    super.key,
  });

  @override
  State<SearchDoctors> createState() => _SearchDoctorsState();
}

class _SearchDoctorsState extends State<SearchDoctors>
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

    // مسح خانة البحث القديمة عند تغيير المحافظة
    searchController.clear();

    // جلب الأطباء للمحافظة المختارة
    _triggerSearch();
  }

  // ===========================================================
  // Execute Search Event
  // ===========================================================

  void _triggerSearch() {
    final cityBloc = context.read<AllCityBloc>();
    context.read<SearchDoctorsBloc>().add(
          FutureSearchDocEvent(
            searchController.text.trim(),
            UserInfo.repId,
            cityId: cityBloc.selectedCityId,
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
                      // الفلتر وحقل البحث
                      Expanded(
                        child: SearchWithCityFilter(
                          searchController: searchController,
                          onSearch: (value) {
                            // تم إلغاء البحث التلقائي بناءً على طلبك
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
                // Content
                // =================================================
                Expanded(
                  child: _buildContent(context, ui),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ===========================================================
  // Content Logic (City State + Search Doctors Bloc)
  // ===========================================================

  Widget _buildContent(BuildContext context, AppUi ui) {
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

    // Search Doctors Bloc Body
    return BlocBuilder<SearchDoctorsBloc, SearchDoctorsState>(
      buildWhen: (previous, current) {
        return current is FutureSearchDoctorsErrorState ||
            current is FutureSearchDoctorsLoadingState ||
            current is FutureSearchDoctorsState ||
            current is FutureSearchDoctorsEmptyState;
      },
      builder: (context, state) {
        // Error
        if (state is FutureSearchDoctorsErrorState) {
          return CustomScrollView(
            physics: const BouncingScrollPhysics(),
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            slivers: [
              SliverPadding(
                padding: EdgeInsets.symmetric(
                  horizontal: ui.pagePadding,
                ),
                sliver: SliverToBoxAdapter(
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
        if (state is FutureSearchDoctorsLoadingState) {
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
                    20,
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
        if (state is FutureSearchDoctorsEmptyState) {
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
        if (state is FutureSearchDoctorsState) {
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
                      final doctor = state.representative[index];

                      return doctorWidget(
                        text: "عرض التقارير",
                        spTitle: doctor.spTitle,
                        title: doctor.name,
                        placeTitle: doctor.placeTitle,
                        id: doctor.id,
                        context: context,
                        function: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return DoctorDetails(
                                  doctorModel: doctor,
                                );
                              },
                            ),
                          );

                          BlocProvider.of<SearchDoctorsBloc>(context).add(
                            FutureDocDoctorsEvent(doctor.id),
                          );
                        },
                      );
                    },
                    childCount: state.representative.length,
                  ),
                ),
              ),
            ],
          );
        }

        // Default Empty
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
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
