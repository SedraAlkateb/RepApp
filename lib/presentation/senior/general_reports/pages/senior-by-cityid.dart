// ignore_for_file: must_be_immutable, file_names

import 'package:domina_app/app/di/di.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/resources/responsive/app_ui.dart';
import 'package:domina_app/presentation/senior/all_city/bloc/bloc/all_city_bloc.dart';
import 'package:domina_app/presentation/senior/general_reports/bloc/bloc/general_reports_bloc.dart';
import 'package:domina_app/presentation/senior/general_reports/pages/all-rep-general-reports.dart';
import 'package:domina_app/presentation/senior/places/bloc/senior_reps_bloc.dart';
import 'package:domina_app/presentation/senior/places/widget/city_filter_widget.dart';
import 'package:domina_app/presentation/uniti/stateWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class SeniorByCityId extends StatefulWidget {
  const SeniorByCityId({
    super.key,
  });

  @override
  State<SeniorByCityId> createState() =>
      _SeniorByCityIdState();
}

class _SeniorByCityIdState
    extends State<SeniorByCityId> {
  final TextEditingController _searchController =
  TextEditingController();

  String _searchQuery = '';

  // آخر محافظة تم تحميلها
  // لمنع تكرار نفس الطلب
  int? _lastLoadedCityId;

  // ===========================================================
  // Init
  // ===========================================================

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback(
          (_) {
        _loadSelectedCity();
      },
    );
  }

  // ===========================================================
  // Load Current City
  // ===========================================================

  void _loadSelectedCity({
    bool force = false,
  }) {
    if (!mounted) {
      return;
    }

    final cityBloc =
    context.read<AllCityBloc>();

    final int? cityId =
        cityBloc.selectedCityId;

    if (cityId == null ||
        cityId < 0) {
      return;
    }

    if (!force &&
        _lastLoadedCityId == cityId) {
      return;
    }

    _lastLoadedCityId = cityId;

    // عند تغيير المحافظة ننظف البحث السابق
    _searchController.clear();

    if (_searchQuery.isNotEmpty) {
      setState(() {
        _searchQuery = '';
      });
    }

    // =========================================================
    // تحميل السينيور حسب المحافظة المختارة
    // =========================================================
    context
        .read<GeneralReportsBloc>()
        .add(
      GetSeniorByCityIdEvent(
        cityId,
      ),
    );
  }

  // ===========================================================
  // Search
  // بحث محلي ضمن قائمة السينيور الحالية
  // ===========================================================

  void _onSearch(
      String value,
      ) {
    setState(() {
      _searchQuery =
          value.trim().toLowerCase();
    });
  }

  // ===========================================================
  // Dispose
  // ===========================================================

  @override
  void dispose() {
    _searchController.dispose();

    super.dispose();
  }

  // ===========================================================
  // Build
  // ===========================================================

  @override
  Widget build(
      BuildContext context,
      ) {
    final ui =
    AppUi.of(context);

    final cityBloc =
    context.watch<AllCityBloc>();

    final double contentMaxWidth =
    ui.isTabletLandscape
        ? 760
        : ui.pageMaxWidth;

    return BlocListener<
        AllCityBloc,
        AllCityState>(
      listener: (
          context,
          state,
          ) {
        // =====================================================
        // أول تحميل للمحافظات
        // أو تغيير المحافظة من الفلتر
        // =====================================================
        if (state is GetAllCityState) {
          _loadSelectedCity();
        }
      },

      child: Scaffold(
        backgroundColor:
        const Color(
          0xFFF8FAFC,
        ),

        // =====================================================
        // AppBar
        // =====================================================
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
              ui.isMobile
                  ? 24
                  : 27,

              color:
              ColorManager
                  .medicalPrimary,
            ),
          ),

          title: Text(
            cityBloc
                .selectedCityName
                .isEmpty
                ? 'السينيور'
                : 'السينيور (${cityBloc.selectedCityName})',

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
        ),

        // =====================================================
        // Body
        // =====================================================
        body: Directionality(
          textDirection:
          TextDirection.rtl,

          child: Center(
            child: ConstrainedBox(
              constraints:
              BoxConstraints(
                maxWidth:
                contentMaxWidth,
              ),

              child: CustomScrollView(
                physics:
                const BouncingScrollPhysics(),

                keyboardDismissBehavior:
                ScrollViewKeyboardDismissBehavior
                    .onDrag,

                slivers: [
                  // =============================================
                  // Header
                  // =============================================
                  SliverPadding(
                    padding:
                    EdgeInsets.fromLTRB(
                      ui.pagePadding,
                      ui.headerTopPadding,
                      ui.pagePadding,
                      ui.headerBottomPadding,
                    ),

                    sliver:
                    SliverToBoxAdapter(
                      child:
                      _buildHeader(
                        ui,
                        cityBloc
                            .selectedCityName,
                      ),
                    ),
                  ),

                  // =============================================
                  // Search + City Filter
                  // =============================================
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
                        _searchController,

                        onSearch:
                        _onSearch,
                      ),
                    ),
                  ),

                  // =============================================
                  // Content
                  // =============================================
                  ..._buildContent(
                    context,
                    ui,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ===========================================================
  // Header
  // ===========================================================

  Widget _buildHeader(
      AppUi ui,
      String cityName,
      ) {
    return Row(
      crossAxisAlignment:
      CrossAxisAlignment.center,

      children: [
        Expanded(
          child: Column(
            crossAxisAlignment:
            CrossAxisAlignment.start,

            children: [
              Text(
                'سينيور المنطقة',

                maxLines: 1,

                overflow:
                TextOverflow
                    .ellipsis,

                style: TextStyle(
                  fontSize:
                  ui.pageTitleSize,

                  fontWeight:
                  FontWeight.w800,

                  color:
                  ColorManager
                      .medicalPrimary,
                ),
              ),

              SizedBox(
                height:
                ui.smallSpacing,
              ),

              Text(
                cityName.isEmpty
                    ? 'قائمة السينيور المتاحين'
                    : 'قائمة السينيور المتاحين في $cityName',

                maxLines: 2,

                overflow:
                TextOverflow
                    .ellipsis,

                style: TextStyle(
                  color:
                  const Color(
                    0xFF64748B,
                  ),

                  fontSize:
                  ui.pageSubtitleSize,

                  fontWeight:
                  FontWeight.w500,

                  height: 1.4,
                ),
              ),
            ],
          ),
        ),

        SizedBox(
          width:
          ui.mediumSpacing,
        ),

        Container(
          width: 42,
          height: 5,

          decoration:
          BoxDecoration(
            color:
            ColorManager
                .medicalPrimary,

            borderRadius:
            BorderRadius.circular(
              10,
            ),
          ),
        ),
      ],
    );
  }

  // ===========================================================
  // Content
  // ===========================================================

  List<Widget> _buildContent(
      BuildContext context,
      AppUi ui,
      ) {
    final cityBloc =
    context.watch<AllCityBloc>();

    final cityState =
        cityBloc.state;

    // =========================================================
    // City Loading
    // =========================================================
    if (cityState
    is AllCityLoadingState) {
      return [
        SliverFillRemaining(
          hasScrollBody: false,

          child: loadingFullScreen(
            context,
          ),
        ),
      ];
    }

    // =========================================================
    // City Error
    // =========================================================
    if (cityState
    is AllCityErrorState) {
      return [
        SliverFillRemaining(
          hasScrollBody: false,

          child: errorFullScreen(
            context,

            mes:
            cityState
                .failure
                .massage,

            func: () {
              context
                  .read<AllCityBloc>()
                  .add(
                const GetAllCityEvent(),
              );
            },
          ),
        ),
      ];
    }

    // =========================================================
    // No Cities
    // =========================================================
    if (cityBloc.selectedCityId ==
        null) {
      return [
        SliverFillRemaining(
          hasScrollBody: false,

          child: emptyFullScreen(
            context,

            message:
            'لا توجد محافظات متاحة',
          ),
        ),
      ];
    }

    // =========================================================
    // General Reports Bloc
    // =========================================================
    return [
      BlocBuilder<
          GeneralReportsBloc,
          GeneralReportsState>(
        buildWhen: (
            previous,
            current,
            ) =>
        current
        is SeniorByCityIdLoadingState ||
            current
            is SeniorByCityIdState ||
            current
            is SeniorByCityIdErrorState ||
            current
            is SeniorByCityIdEmptyState,

        builder: (
            context,
            state,
            ) {
          // ===================================================
          // Loading
          // ===================================================
          if (state is SeniorByCityIdLoadingState) {
            return SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: ui.pagePadding,
                  vertical: ui.listTopPadding,
                ),
                child: loadingShimmer(
                  context,
                  10,
                  20,
                  20,
                  BorderRadius.circular(
                    ui.cardRadius,
                  ),
                ),
              ),
            );
          }
          // ===================================================
          // Error
          // ===================================================
          if (state
          is SeniorByCityIdErrorState) {
            return SliverFillRemaining(
              hasScrollBody: false,

              child:
              errorFullScreen(
                context,

                func: () {
                  _loadSelectedCity(
                    force: true,
                  );
                },
              ),
            );
          }

          // ===================================================
          // Data source
          // ===================================================
          List<SeniorCityModel> seniors =
              context
                  .read<
                  GeneralReportsBloc>()
                  .dataseniorsbycityid;

          if (state
          is SeniorByCityIdState) {
            seniors =
                state.data;
          }

          // ===================================================
          // Local Search
          // ===================================================
          if (_searchQuery.isNotEmpty) {
            seniors =
                seniors.where(
                      (
                      senior,
                      ) {
                    final name =
                    senior.rep_name
                        .toLowerCase();

                    return name.contains(
                      _searchQuery,
                    );
                  },
                ).toList();
          }

          // ===================================================
          // Empty
          //
          // السيرش والفلتر بيضلوا ظاهرين
          // ===================================================
          if (state
          is SeniorByCityIdEmptyState ||
              seniors.isEmpty) {
            return SliverFillRemaining(
              hasScrollBody: false,

              child:
              emptyFullScreen(
                context,
              ),
            );
          }

          // ===================================================
          // List
          // ===================================================
          return SliverPadding(
            padding:
            EdgeInsets.fromLTRB(
              ui.pagePadding,
              ui.listTopPadding,
              ui.pagePadding,
              ui.listBottomPadding,
            ),

            sliver: AnimationLimiter(
              child: SliverList(
                delegate:
                SliverChildBuilderDelegate(
                      (
                      context,
                      index,
                      ) {
                    final senior =
                    seniors[index];

                    return AnimationConfiguration
                        .staggeredList(
                      position:
                      index,

                      duration:
                      const Duration(
                        milliseconds:
                        500,
                      ),

                      delay:
                      const Duration(
                        milliseconds:
                        50,
                      ),

                      child:
                      SlideAnimation(
                        verticalOffset:
                        30,

                        child:
                        FadeInAnimation(
                          child:
                          _buildRepSmartCard(
                            context,
                            ui,
                            senior,
                          ),
                        ),
                      ),
                    );
                  },

                  childCount:
                  seniors.length,
                ),
              ),
            ),
          );
        },
      ),
    ];
  }

  // ===========================================================
  // Senior Card
  // ===========================================================

  Widget _buildRepSmartCard(
      BuildContext context,
      AppUi ui,
      SeniorCityModel senior,
      ) {
    return Container(
      margin: EdgeInsets.only(
        bottom:
        ui.cardSpacing,
      ),

      decoration: BoxDecoration(
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
              0.03,
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

      child: ClipRRect(
        borderRadius:
        BorderRadius.circular(
          ui.cardRadius,
        ),

        child: Material(
          color:
          Colors.white,

          child: InkWell(
            // =================================================
            // نفس السلوك الأصلي تماماً
            // =================================================
            onTap: () {
              initSeniorModule();

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (
                      context,
                      ) {
                    return AllRepSeniorGenerlReports(
                      cityname:
                      senior.city_name,

                      cityId:
                      int.parse(
                        senior.city_id,
                      ),

                      repId:
                      int.parse(
                        senior.rep_id,
                      ),

                      seniorName:
                      senior.rep_name,
                    );
                  },
                ),
              );

              print(
                'rep_id:${senior.rep_id}',
              );

              context
                  .read<
                  SeniorRepsBloc>()
                  .add(
                AllSeniorRepEvent(
                  int.parse(
                    senior.city_id,
                  ),
                  int.parse(
                    senior.rep_id,
                  ),
                ),
              );
            },

            child: Padding(
              padding:
              EdgeInsets.all(
                ui.cardPadding,
              ),

              child: Row(
                children: [
                  // =============================================
                  // Avatar
                  // =============================================
                  Container(
                    width:
                    ui.iconBoxSize +
                        6,

                    height:
                    ui.iconBoxSize +
                        6,

                    alignment:
                    Alignment.center,

                    decoration:
                    BoxDecoration(
                      color: ColorManager
                          .medicalPrimary
                          .withOpacity(
                        0.08,
                      ),

                      borderRadius:
                      BorderRadius
                          .circular(
                        ui.smallRadius +
                            3,
                      ),
                    ),

                    child: Icon(
                      Icons
                          .person_pin_rounded,

                      size:
                      ui.iconSize +
                          2,

                      color:
                      ColorManager
                          .medicalPrimary,
                    ),
                  ),

                  SizedBox(
                    width:
                    ui.mediumSpacing,
                  ),

                  // =============================================
                  // Senior Info
                  // =============================================
                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment
                          .start,

                      children: [
                        Text(
                          senior.rep_name,

                          maxLines: 1,

                          overflow:
                          TextOverflow
                              .ellipsis,

                          style:
                          TextStyle(
                            fontSize: ui
                                .cardTitleSize,

                            fontWeight:
                            FontWeight
                                .w700,

                            color:
                            ColorManager
                                .secondaryColor1,

                            height: 1.3,
                          ),
                        ),

                        SizedBox(
                          height:
                          ui.smallSpacing,
                        ),

                        Text(
                          'اضغط لاستعراض تقارير المندوبين',

                          maxLines: 2,

                          overflow:
                          TextOverflow
                              .ellipsis,

                          style:
                          TextStyle(
                            fontSize: ui
                                .smallTextSize,

                            color:
                            const Color(
                              0xFF94A3B8,
                            ),

                            fontWeight:
                            FontWeight
                                .w500,
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(
                    width:
                    ui.smallSpacing,
                  ),

                  Icon(
                    Icons
                        .arrow_forward_ios_rounded,

                    size:
                    ui.smallIconSize,

                    color:
                    const Color(
                      0xFF94A3B8,
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