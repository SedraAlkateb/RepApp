import 'package:domina_app/app/di/di.dart';
import 'package:domina_app/app/user_info.dart';
import 'package:domina_app/presentation/drawer/pages/drawer_launcher.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/resources/responsive/app_responsive.dart';
import 'package:domina_app/presentation/resources/routes_manager.dart';
import 'package:domina_app/presentation/senior/admin/widget/interactive_admin_card.dart';
import 'package:domina_app/presentation/senior/admin/widget/square_interactive_card.dart';
import 'package:domina_app/presentation/senior/general_reports/bloc/bloc/general_reports_bloc.dart';
import 'package:domina_app/presentation/senior/manage_future/bloc/manage_future_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminDashboardPage extends StatelessWidget {
  const AdminDashboardPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final deviceType = AppResponsive.deviceType(context);

    // نحافظ على منطق landscape لأن الكروت تعتمد عليه
    final bool isLandscape =
        MediaQuery.orientationOf(context) == Orientation.landscape;

    double pageMaxWidth;

    double headerHorizontalPadding;
    double headerVerticalPadding;

    double contentHorizontalPadding;

    double welcomeFontSize;
    double descriptionFontSize;

    double headerSpacing;
    double sectionSpacing;
    double cardSpacing;
    double bottomSpacing;

    double menuIconSize;

    switch (deviceType) {
    // =====================================================
    // Mobile
    // =====================================================
      case AppDeviceType.mobilePortrait:
        pageMaxWidth = 600;

        headerHorizontalPadding = 24;
        headerVerticalPadding = 24;

        contentHorizontalPadding = 20;

        welcomeFontSize = 26;
        descriptionFontSize = 15;

        headerSpacing = 8;
        sectionSpacing = 14;
        cardSpacing = 14;
        bottomSpacing = 30;

        menuIconSize = 28;
        break;

    // =====================================================
    // Tablet Portrait
    // =====================================================
      case AppDeviceType.tabletPortrait:
        pageMaxWidth = 820;

        headerHorizontalPadding = 32;
        headerVerticalPadding = 28;

        contentHorizontalPadding = 28;

        welcomeFontSize = 30;
        descriptionFontSize = 17;

        headerSpacing = 10;
        sectionSpacing = 20;
        cardSpacing = 18;
        bottomSpacing = 36;

        menuIconSize = 30;
        break;

    // =====================================================
    // Tablet Landscape
    // =====================================================
      case AppDeviceType.tabletLandscape:
        pageMaxWidth = 1150;

        headerHorizontalPadding = 36;
        headerVerticalPadding = 18;

        contentHorizontalPadding = 32;

        welcomeFontSize = 26;
        descriptionFontSize = 16;

        headerSpacing = 6;
        sectionSpacing = 18;
        cardSpacing = 18;
        bottomSpacing = 24;

        menuIconSize = 26;
        break;
    }

    // =====================================================
    // نفس الكروت ونفس السلوك الأصلي تماماً
    // =====================================================
    final List<Widget> adminCards = [
      InteractiveAdminCard(
        icon: Icons.bar_chart_rounded,
        title: 'إدارة تقارير المندوبين',
        subtitle: 'متابعة أداء المندوبين والزيارات اليومية',
        iconColor: ColorManager.primaryBlue,
        isLandscape: isLandscape,
        onTap: () {
          if (UserInfo.repType.i == 4 ||
              UserInfo.repType.i == 5) {
            Navigator.pushNamed(
              context,
              Routes.allCitySupervisor,
            );
          } else {
            Navigator.pushNamed(
              context,
              Routes.AllRepSenior,
            );
          }
        },
      ),

      if (UserInfo.repType.i == 4 ||
          UserInfo.repType.i == 5)
        InteractiveAdminCard(
          icon: Icons.assignment_outlined,
          title: 'إدارة التقارير العامة الخاصة بالسينيور',
          subtitle: 'متابعة أداء السينيور في مراقبة مندوبينهم',
          iconColor: Colors.purple,
          isLandscape: isLandscape,
          onTap: () {
            Navigator.pushNamed(
              context,
              Routes.allCitySeniors,
            );
          },
        ),

      if (UserInfo.repType.i == 4)
        InteractiveAdminCard(
          icon: Icons.assignment_outlined,
          title: 'إدارة التقارير العامة الخاصة بالتيم ليدر',
          subtitle: 'متابعة أداء التيم ليدر في مراقبة مندوبينهم',
          iconColor: Colors.purple,
          isLandscape: isLandscape,
          onTap: () {
            // نفس الترتيب الأصلي
            Navigator.pushNamed(
              context,
              Routes.teamLeader,
            );

            BlocProvider.of<GeneralReportsBloc>(context).add(
              const TeamLeaderAndCityEvent(),
            );
          },
        ),
    ];

    return PopScope(
      canPop: false,
      child: Scaffold(
        drawer: const DrawerPage(),
        backgroundColor: ColorManager.bgGrey,

        // =================================================
        // AppBar
        // =================================================
        appBar: AppBar(
          leading: Builder(
            builder: (BuildContext context) {
              return Center(
                child: IconButton(
                  icon: Icon(
                    Icons.menu,
                    size: menuIconSize,
                    color: ColorManager.secondaryColor,
                  ),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                ),
              );
            },
          ),
          title: const Text(
            'لوحة التحكم الإدارية',
          ),
        ),

        // =================================================
        // Body
        // =================================================
        body: Directionality(
          textDirection: TextDirection.rtl,
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: pageMaxWidth,
              ),
              child: CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: [
                  // =========================================
                  // Welcome Header
                  // =========================================
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: headerHorizontalPadding,
                        vertical: headerVerticalPadding,
                      ),
                      child: Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        children: [
                          Text(
                            'مرحباً بك مجدداً',
                            style: TextStyle(
                              fontSize: welcomeFontSize,
                              fontWeight: FontWeight.bold,
                              color:
                              ColorManager.medicalPrimary,
                            ),
                          ),

                          SizedBox(
                            height: headerSpacing,
                          ),

                          Text(
                            'اختر القسم الذي ترغب في إدارته اليوم',
                            style: TextStyle(
                              fontSize:
                              descriptionFontSize,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // =========================================
                  // Dashboard Content
                  // =========================================
                  SliverPadding(
                    padding: EdgeInsets.symmetric(
                      horizontal: contentHorizontalPadding,
                    ),
                    sliver: SliverToBoxAdapter(
                      child: Column(
                        children: [
                          // =================================
                          // Admin cards
                          // =================================
                          _buildAdminCards(
                            adminCards: adminCards,
                            deviceType: deviceType,
                            isLandscape: isLandscape,
                            spacing: cardSpacing,
                          ),

                          SizedBox(
                            height: sectionSpacing,
                          ),

                          // =================================
                          // Current / Old plans
                          // =================================
                          Row(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: SquareInteractiveCard(
                                  icon: Icons
                                      .calendar_today_outlined,
                                  title: 'الخطة المستقبلية',
                                  subtitle: 'متابعة النشاط',
                                  iconColor: Colors.green,

                                  onTap: () {
                                    initSeniorManageFutureModule();

                                    BlocProvider.of<ManageFutureBloc>(
                                      context,
                                    ).add(
                                      AllSeniorRepFutureEvent(
                                      ),
                                    );

                                    Navigator.pushNamed(
                                      context,
                                      Routes.allRepWithFuture,
                                    );
                                  },

                                  isLandscape: isLandscape,
                                ),
                              ),

                              SizedBox(
                                width: cardSpacing,
                              ),

                              Expanded(
                                child: SquareInteractiveCard(
                                  icon: Icons.history_rounded,
                                  title: 'الخطط المنتهية',
                                  subtitle: 'أرشيف الخطط',
                                  iconColor: Colors.grey,

                                  // نفس السلوك الأصلي
                                  onTap: () {
                                    Navigator.pushNamed(
                                      context,
                                      Routes.cityPlan,
                                    );
                                  },

                                  isLandscape: isLandscape,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

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
  // Admin Cards Responsive Layout
  // =====================================================

  Widget _buildAdminCards({
    required List<Widget> adminCards,
    required AppDeviceType deviceType,
    required bool isLandscape,
    required double spacing,
  }) {
    // ==========================================
    // Tablet Landscape
    // ==========================================
    if (deviceType == AppDeviceType.tabletLandscape) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (int i = 0; i < adminCards.length; i++) ...[
            Expanded(
              child: SizedBox(
                height: 250,
                child: adminCards[i],
              ),
            ),

            if (i != adminCards.length - 1)
              SizedBox(
                width: spacing,
              ),
          ],
        ],
      );
    }

    // ==========================================
    // Mobile + Tablet Portrait
    // ==========================================
    return Column(
      children: [
        for (int i = 0; i < adminCards.length; i++) ...[
          adminCards[i],

          if (i != adminCards.length - 1)
            SizedBox(
              height: spacing,
            ),
        ],
      ],
    );
  }
}