// ignore_for_file: must_be_immutable, file_names

import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/resources/responsive/app_responsive.dart';
import 'package:domina_app/presentation/senior/general_reports/pages/doctors-hospitals-reports.dart';
import 'package:domina_app/presentation/senior/places/bloc/senior_reps_bloc.dart';
import 'package:domina_app/presentation/uniti/search_field.dart';
import 'package:domina_app/presentation/uniti/stateWidget.dart';
import 'package:domina_app/presentation/uniti/unread_visit_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class AllRepSeniorGenerlReports extends StatefulWidget {
  final int cityId;
  final String cityname;
  final int repId;
  final String? seniorName;

  const AllRepSeniorGenerlReports({
    super.key,
    required this.cityId,
    required this.cityname,
    required this.repId,
    this.seniorName,
  });

  @override
  State<AllRepSeniorGenerlReports> createState() =>
      _AllRepSeniorGenerlReportsState();
}

class _AllRepSeniorGenerlReportsState
    extends State<AllRepSeniorGenerlReports> {
  final TextEditingController _searchController =
  TextEditingController();

  final RefreshController _refreshController =
  RefreshController(
    initialRefresh: false,
  );

  @override
  void dispose() {
    _searchController.dispose();
    _refreshController.dispose();
    super.dispose();
  }

  // =====================================================
  // منطق التحديث السليم (إرسال الحدث والانتظار للـ Bloc)
  // =====================================================
  void _onRefresh() {
    BlocProvider.of<SeniorRepsBloc>(context).add(
      AllSeniorRepEvent(
        widget.cityId,
        widget.repId,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final deviceType =
    AppResponsive.deviceType(context);

    double pageMaxWidth;
    double headerHorizontalPadding;
    double headerTopPadding;
    double searchHorizontalPadding;
    double searchVerticalPadding;
    double listHorizontalPadding;
    double cardBottomSpacing;
    double bottomSafeSpacing;
    double headerTitleFontSize;
    double headerSubtitleFontSize;
    double cardRadius;

    switch (deviceType) {
      case AppDeviceType.mobilePortrait:
        pageMaxWidth = 600;
        headerHorizontalPadding = 25;
        headerTopPadding = 20;
        searchHorizontalPadding = 15;
        searchVerticalPadding = 15;
        listHorizontalPadding = 20;
        cardBottomSpacing = 15;
        bottomSafeSpacing = 50;
        headerTitleFontSize = 22;
        headerSubtitleFontSize = 12;
        cardRadius = 15;
        break;

      case AppDeviceType.tabletPortrait:
        pageMaxWidth = 760;
        headerHorizontalPadding = 30;
        headerTopPadding = 24;
        searchHorizontalPadding = 24;
        searchVerticalPadding = 18;
        listHorizontalPadding = 28;
        cardBottomSpacing = 18;
        bottomSafeSpacing = 60;
        headerTitleFontSize = 26;
        headerSubtitleFontSize = 14;
        cardRadius = 18;
        break;

      case AppDeviceType.tabletLandscape:
        pageMaxWidth = 900;
        headerHorizontalPadding = 32;
        headerTopPadding = 20;
        searchHorizontalPadding = 28;
        searchVerticalPadding = 16;
        listHorizontalPadding = 32;
        cardBottomSpacing = 18;
        bottomSafeSpacing = 50;
        headerTitleFontSize = 26;
        headerSubtitleFontSize = 14;
        cardRadius = 18;
        break;
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: Text(
          widget.seniorName != null
              ? "تقارير مندوبين ${widget.seniorName} "
              : ' تقارير المندوبين (${widget.cityname}) ',
        ),
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        // استخدام BlocListener لإنهاء حركة التحديث فور وصول الرد من الـ Bloc
        child: BlocListener<SeniorRepsBloc, SeniorRepsState>(
          listener: (context, state) {
            if (state is AllSeniorRepState ||
                state is AllSeniorRepErrorState) {
              if (_refreshController.isRefresh) {
                _refreshController.refreshCompleted();
              }
            }
          },
          child: SmartRefresher(
            controller: _refreshController,
            onRefresh: _onRefresh,
            enablePullDown: true,
            header: const WaterDropHeader(),
            child: CustomScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              slivers: [
                // =====================================
                // 1. Header
                // =====================================
                SliverToBoxAdapter(
                  child: Center(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: pageMaxWidth,
                      ),
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(
                          headerHorizontalPadding,
                          headerTopPadding,
                          headerHorizontalPadding,
                          0,
                        ),
                        child: _buildHeader(
                          titleFontSize: headerTitleFontSize,
                          subtitleFontSize: headerSubtitleFontSize,
                        ),
                      ),
                    ),
                  ),
                ),

                // =====================================
                // 2. Search Field
                // =====================================
                SliverToBoxAdapter(
                  child: Center(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: pageMaxWidth,
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: searchHorizontalPadding,
                          vertical: searchVerticalPadding,
                        ),
                        child: SearchField(
                          searchController: _searchController,
                          onPressed: (value) {
                            context
                                .read<SeniorRepsBloc>()
                                .add(
                              SenSearchRepEvent(value),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),

                // =====================================
                // 3. Reps List & States
                // =====================================
                _buildRepsContent(
                  pageMaxWidth: pageMaxWidth,
                  listHorizontalPadding: listHorizontalPadding,
                  cardBottomSpacing: cardBottomSpacing,
                  cardRadius: cardRadius,
                ),

                // =====================================
                // 4. Bottom Safe Space
                // =====================================
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: bottomSafeSpacing,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // =====================================================
  // Header Widget Builder
  // =====================================================

  Widget _buildHeader({
    required double titleFontSize,
    required double subtitleFontSize,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                'إدارة التقارير',
                style: TextStyle(
                  fontSize: titleFontSize,
                  fontWeight: FontWeight.bold,
                  color: ColorManager.medicalPrimary,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Container(
              height: 4,
              width: 35,
              decoration: BoxDecoration(
                color: const Color(0xFF42A5F5),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ],
        ),
        const SizedBox(height: 2),
        Text(
          'استعراض تقارير المندوبين ومراقبة السينيور',
          style: TextStyle(
            fontSize: subtitleFontSize,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  // =====================================================
  // Reps Content Builder (Handles Loading, Error, Empty, Data)
  // =====================================================

  Widget _buildRepsContent({
    required double pageMaxWidth,
    required double listHorizontalPadding,
    required double cardBottomSpacing,
    required double cardRadius,
  }) {
    return BlocBuilder<SeniorRepsBloc, SeniorRepsState>(
      builder: (context, state) {
        List<AllRepresentative> list =
            context.watch<SeniorRepsBloc>().allRepresentative;

        // =========================================
        // Loading State
        // =========================================
        if (state is AllSeniorRepLoadingState) {
          return SliverToBoxAdapter(
            child: Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: pageMaxWidth,
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 40,
                    horizontal: listHorizontalPadding,
                  ),
                  child: Center(
                    child: loadingShimmer(
                      context,
                      5,
                      100,
                      20,
                      BorderRadius.circular(cardRadius),
                    ),
                  ),
                ),
              ),
            ),
          );
        }

        // =========================================
        // Error State
        // =========================================
        if (state is AllSeniorRepErrorState) {
          return SliverFillRemaining(
            hasScrollBody: false,
            child: Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: pageMaxWidth,
                ),
                child: errorFullScreen(
                  context,
                  func: _onRefresh,
                ),
              ),
            ),
          );
        }

        // =========================================
        // Data State
        // =========================================
        if (state is AllSeniorRepState) {
          list = state.representatives;
        }

        // =========================================
        // Empty State
        // =========================================
        if (list.isEmpty) {
          return SliverFillRemaining(
            hasScrollBody: false,
            child: Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: pageMaxWidth,
                ),
                child: emptyFullScreen(context),
              ),
            ),
          );
        }

        // =========================================
        // Data List State
        // =========================================
        return SliverToBoxAdapter(
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: pageMaxWidth,
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: listHorizontalPadding,
                ),
                child: AnimationLimiter(
                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.stretch,
                    children: list.asMap().entries.map((entry) {
                      final index = entry.key;
                      final rep = entry.value;

                      return AnimationConfiguration
                          .staggeredList(
                        position: index,
                        duration: const Duration(
                          milliseconds: 500,
                        ),
                        child: SlideAnimation(
                          verticalOffset: 50,
                          child: FadeInAnimation(
                            child: Padding(
                              padding: EdgeInsets.only(
                                bottom: cardBottomSpacing,
                              ),
                              child: _buildRepReportCard(
                                rep,
                                index,
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  // =====================================================
  // Rep Card Widget Builder
  // =====================================================

  Widget _buildRepReportCard(
      AllRepresentative rep,
      int index,
      ) {
    return PersonProgressCard(
      name: rep.name,
      unreadCount: rep.number,
      totalCount: rep.totalVisit ?? 0,
      progressTitle: "الزيارات",
      remainingTitle: "غير المقروءة",
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              return DoctorsHospitalsReports(
                repName: rep.name,
                indexRep: index,
                senId: widget.repId,
                repId: rep.id,
                phone: rep.number.toString(),
              );
            },
          ),
        );
      },
    );
  }
}