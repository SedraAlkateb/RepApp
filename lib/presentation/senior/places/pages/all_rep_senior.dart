import 'package:domina_app/app/di/di.dart';
import 'package:domina_app/app/user_info.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/drawer/pages/drawer_launcher.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/resources/responsive/app_responsive.dart';
import 'package:domina_app/presentation/senior/places/bloc/senior_reps_bloc.dart';
import 'package:domina_app/presentation/senior/places/widget/rep_card_widget.dart';
import 'package:domina_app/presentation/senior/representative/bloc/senior_prof_bloc.dart';
import 'package:domina_app/presentation/senior/representative/page/rep_profile.dart';
import 'package:domina_app/presentation/uniti/search_field.dart';
import 'package:domina_app/presentation/uniti/stateWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class AllRepSenior extends StatefulWidget {
  final int cityId;
  final String cityname;
  final int repId;

  const AllRepSenior({
    super.key,
    required this.cityId,
    required this.cityname,
    required this.repId,
  });

  @override
  State<AllRepSenior> createState() => _AllRepSeniorState();
}

class _AllRepSeniorState extends State<AllRepSenior> {
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
    context.read<SeniorRepsBloc>().add(
      AllSeniorRepEvent(
        widget.cityId,
        widget.repId,
      ),
    );

    _refreshController.refreshCompleted();
  }

  @override
  void initState() {
    context.read<SeniorRepsBloc>().add(
      AllSeniorRepEvent(
        widget.cityId,
        widget.repId,
      ),
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final deviceType = AppResponsive.deviceType(context);

    double pageMaxWidth;

    double headerHorizontalPadding;
    double headerTopPadding;

    double searchHorizontalPadding;
    double searchVerticalPadding;

    double listHorizontalPadding;
    double cardBottomSpacing;
    double bottomSpacing;

    double headerTitleFontSize;
    double headerSubtitleFontSize;

    double appBarIconSize;

    switch (deviceType) {
      case AppDeviceType.mobilePortrait:
        pageMaxWidth = 600;

        headerHorizontalPadding = 20;
        headerTopPadding = 22;

        searchHorizontalPadding = 20;
        searchVerticalPadding = 14;

        listHorizontalPadding = 20;
        cardBottomSpacing = 14;
        bottomSpacing = 40;

        headerTitleFontSize = 23;
        headerSubtitleFontSize = 13;

        appBarIconSize = 28;
        break;

      case AppDeviceType.tabletPortrait:
        pageMaxWidth = 760;

        headerHorizontalPadding = 28;
        headerTopPadding = 26;

        searchHorizontalPadding = 28;
        searchVerticalPadding = 16;

        listHorizontalPadding = 28;
        cardBottomSpacing = 16;
        bottomSpacing = 50;

        headerTitleFontSize = 26;
        headerSubtitleFontSize = 14;

        appBarIconSize = 30;
        break;

      case AppDeviceType.tabletLandscape:
        pageMaxWidth = 900;

        headerHorizontalPadding = 32;
        headerTopPadding = 20;

        searchHorizontalPadding = 32;
        searchVerticalPadding = 14;

        listHorizontalPadding = 32;
        cardBottomSpacing = 16;
        bottomSpacing = 40;

        headerTitleFontSize = 26;
        headerSubtitleFontSize = 14;

        appBarIconSize = 28;
        break;
    }
    return Scaffold(
      // =================================================
      // نفس شرط الـ Drawer
      // =================================================
      drawer: UserInfo.repType.i == 6
          ? const DrawerPage()
          : null,

      backgroundColor: const Color(0xFFF8FAFC),

      appBar: AppBar(
        title: Text(
          'تقارير المندوبين (${widget.cityname})',
        ),

        leading: Builder(
          builder: (BuildContext context) {
            return Center(
              child: UserInfo.repType.i == 6
                  ? IconButton(
                icon: Icon(
                  Icons.menu,
                  size: appBarIconSize,
                  color:
                  ColorManager.secondaryColor,
                ),
                onPressed: () {
                  Scaffold.of(context)
                      .openDrawer();
                },
              )
                  : IconButton(
                icon: Icon(
                  Icons.arrow_back_ios_new,
                  size: appBarIconSize,
                  color:
                  ColorManager.secondaryColor,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            );
          },
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
                physics:
                const BouncingScrollPhysics(),
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

                        // نفس البحث
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
                  // Representatives
                  // =====================================
                  SliverPadding(
                    padding: EdgeInsets.symmetric(
                      horizontal:
                      listHorizontalPadding,
                    ),
                    sliver: _buildRepsList(
                      cardBottomSpacing:
                      cardBottomSpacing,
                    ),
                  ),

                  // =====================================
                  // Bottom spacing
                  // =====================================
                  SliverToBoxAdapter(
                    child: SizedBox(
                      height: bottomSpacing,
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                'إدارة المندوبين',
                style: TextStyle(
                  fontSize: titleFontSize,
                  fontWeight: FontWeight.bold,
                  color: ColorManager.medicalPrimary,
                ),
              ),
            ),

            const SizedBox(width: 16),

            Container(
              width: 40,
              height: 5,
              decoration: BoxDecoration(
                color: const Color(0xFF42A5F5),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ],
        ),

        const SizedBox(height: 5),

        Text(
          'اختر مندوباً لمراجعة الأداء والتقارير',
          style: TextStyle(
            fontSize: subtitleFontSize,
            color: Colors.grey.shade600,
          ),
        ),
      ],
    );
  }

  // =====================================================
  // Representatives List
  // =====================================================

  Widget _buildRepsList({
    required double cardBottomSpacing,
  }) {
    return BlocBuilder<SeniorRepsBloc, SeniorRepsState>(
      builder: (context, state) {
        // نفس القائمة الموجودة داخل Bloc
        List<AllRepresentative> list =
            context
                .read<SeniorRepsBloc>()
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
                BorderRadius.circular(20),
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
        // Success
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
        return SliverList(
          delegate: SliverChildBuilderDelegate(
                (context, index) {
              final rep = list[index];

              return Padding(
                padding: EdgeInsets.only(
                  bottom: cardBottomSpacing,
                ),
                child: RepresentativeCard(
                  allRepresentative: rep,

                  // =================================
                  // نفس السلوك الأصلي تماماً
                  // =================================
                  onTap: () {
                    // 1. تهيئة موديل البروفايل
                    initSeniorProfModule();

                    // 2. إرسال الحدث
                    context
                        .read<SeniorProfBloc>()
                        .add(
                      getInfoRepEvent(
                        rep.id,
                        rep.activePlan,
                      ),
                    );

                    // 3. الانتقال للبروفايل
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) =>
                            RepProfile(
                              index: index,
                              repPlanId:
                              rep.activePlan,
                              id: rep.id,

                            ),
                      ),
                    );
                  },
                ),
              );
            },
            childCount: list.length,
          ),
        );
      },
    );
  }
}