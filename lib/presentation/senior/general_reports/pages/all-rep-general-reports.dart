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
  // نفس منطق التحديث
  // =====================================================
  void _onRefresh() {
    BlocProvider.of<SeniorRepsBloc>(context).add(
      AllSeniorRepEvent(
        widget.cityId,
        widget.repId,
      ),
    );

    _refreshController.refreshCompleted();
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

    double cardPadding;
    double cardRadius;

    double avatarSize;
    double avatarIconSize;
    double avatarSpacing;

    double repNameFontSize;
    double repInfoFontSize;

    double arrowSize;

    switch (deviceType) {
    // ===========================================
    // Mobile
    // ===========================================
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

        cardPadding = 10;
        cardRadius = 15;

        avatarSize = 50;
        avatarIconSize = 24;
        avatarSpacing = 10;

        repNameFontSize = 16;
        repInfoFontSize = 10;

        arrowSize = 16;
        break;

    // ===========================================
    // Tablet Portrait
    // ===========================================
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

        cardPadding = 16;
        cardRadius = 18;

        avatarSize = 58;
        avatarIconSize = 28;
        avatarSpacing = 14;

        repNameFontSize = 19;
        repInfoFontSize = 12;

        arrowSize = 19;
        break;

    // ===========================================
    // Tablet Landscape
    // ===========================================
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

        cardPadding = 16;
        cardRadius = 18;

        avatarSize = 58;
        avatarIconSize = 28;
        avatarSpacing = 14;

        repNameFontSize = 19;
        repInfoFontSize = 12;

        arrowSize = 19;
        break;
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),

      appBar: AppBar(
        title: Text(
          widget.seniorName!=null?
              "تقارير مندوبين ${widget.seniorName} ":
          ' تقارير المندوبين (${widget.cityname}) ',
        ),
      ),

      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: pageMaxWidth,
            ),
            child: SmartRefresher(
              controller: _refreshController,
              onRefresh: _onRefresh,
              enablePullDown: true,
              header: const WaterDropHeader(),

              child: CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: [
                  // =====================================
                  // Header
                  // =====================================
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(
                        headerHorizontalPadding,
                        headerTopPadding,
                        headerHorizontalPadding,
                        0,
                      ),
                      child: _buildHeader(
                        titleFontSize:
                        headerTitleFontSize,
                        subtitleFontSize:
                        headerSubtitleFontSize,
                      ),
                    ),
                  ),

                  // =====================================
                  // Search
                  // =====================================
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal:
                        searchHorizontalPadding,
                        vertical:
                        searchVerticalPadding,
                      ),
                      child: SearchField(
                        searchController:
                        _searchController,

                        // نفس السلوك
                        onPressed: (value) {
                          context
                              .read<SeniorRepsBloc>()
                              .add(
                            SenSearchRepEvent(
                              value,
                            ),
                          );
                        },
                      ),
                    ),
                  ),

                  // =====================================
                  // Reps List
                  // =====================================
                  SliverPadding(
                    padding: EdgeInsets.symmetric(
                      horizontal:
                      listHorizontalPadding,
                    ),
                    sliver: _buildRepsList(
                      cardBottomSpacing:
                      cardBottomSpacing,
                      cardPadding: cardPadding,
                      cardRadius: cardRadius,
                      avatarSize: avatarSize,
                      avatarIconSize:
                      avatarIconSize,
                      avatarSpacing:
                      avatarSpacing,
                      repNameFontSize:
                      repNameFontSize,
                      repInfoFontSize:
                      repInfoFontSize,
                      arrowSize: arrowSize,
                    ),
                  ),

                  // =====================================
                  // Bottom safe space
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
      ),
    );
  }

  // =====================================================
  // Header
  // =====================================================

  Widget _buildHeader({
    required double titleFontSize,
    required double subtitleFontSize,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment:
          MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                'إدارة التقارير',
                style: TextStyle(
                  fontSize: titleFontSize,
                  fontWeight: FontWeight.bold,
                  color:
                  ColorManager.medicalPrimary,
                ),
              ),
            ),

            const SizedBox(
              width: 12,
            ),

            Container(
              height: 4,
              width: 35,
              decoration: BoxDecoration(
                color: const Color(0xFF42A5F5),
                borderRadius:
                BorderRadius.circular(10),
              ),
            ),
          ],
        ),

        const SizedBox(
          height: 2,
        ),

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
  // Reps List
  // =====================================================

  Widget _buildRepsList({
    required double cardBottomSpacing,
    required double cardPadding,
    required double cardRadius,
    required double avatarSize,
    required double avatarIconSize,
    required double avatarSpacing,
    required double repNameFontSize,
    required double repInfoFontSize,
    required double arrowSize,
  }) {
    return BlocBuilder<SeniorRepsBloc, SeniorRepsState>(
      builder: (context, state) {
        List<AllRepresentative> list = context
            .watch<SeniorRepsBloc>()
            .allRepresentative;

        // =========================================
        // Loading
        // =========================================
        if (state is AllSeniorRepLoadingState) {
          return SliverToBoxAdapter(
            child: Center(
              child: loadingShimmer(
                context,
                5,
                100,
                20,
                BorderRadius.circular(
                  cardRadius,
                ),
              ),
            ),
          );
        }

        // =========================================
        // Error
        // =========================================
        if (state is AllSeniorRepErrorState) {
          return SliverToBoxAdapter(
            child: errorFullScreen(
              context,
              func: _onRefresh,
            ),
          );
        }

        // =========================================
        // Data
        // =========================================
        if (state is AllSeniorRepState) {
          list = state.representatives;
        }

        // =========================================
        // Empty
        // =========================================
        if (list.isEmpty) {
          return SliverFillRemaining(
            hasScrollBody: false,
            child: emptyFullScreen(
              context,
            ),
          );
        }

        // =========================================
        // List
        // =========================================
        return AnimationLimiter(
          child: SliverList(
            delegate: SliverChildBuilderDelegate(
                  (context, index) {
                final rep = list[index];

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
                          bottom:
                          cardBottomSpacing,
                        ),
                        child: _buildRepReportCard(
                          rep,
                          index,

                        ),
                      ),
                    ),
                  ),
                );
              },
              childCount: list.length,
            ),
          ),
        );
      },
    );
  }

  // =====================================================
  // Rep Card
  // =====================================================

  Widget _buildRepReportCard(
      AllRepresentative rep,
      int index,
      ) {
    return PersonProgressCard(
      // =====================================================
      // Representative
      // =====================================================
      name: rep.name,

      // =====================================================
      // number = عدد الزيارات غير المقروءة
      // =====================================================
      unreadCount: rep.number,

      // =====================================================
      // إجمالي الزيارات
      // =====================================================
      totalCount: rep.totalVisit ?? 0,

      // =====================================================
      // UI Labels
      // =====================================================
      progressTitle: "الزيارات",

      remainingTitle: "غير المقروءة",

      // =====================================================
      // نفس onTap الأصلي تماماً
      // =====================================================
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