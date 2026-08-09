import 'package:domina_app/app/di/di.dart';
import 'package:domina_app/app/user_info.dart';
import 'package:domina_app/presentation/drawer/pages/drawer_launcher.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/resources/routes_manager.dart';
import 'package:domina_app/presentation/resources/values_manager.dart';
import 'package:domina_app/presentation/senior/admin/widget/interactive_admin_card.dart';
import 'package:domina_app/presentation/senior/admin/widget/square_interactive_card.dart';
import 'package:domina_app/presentation/senior/general_reports/bloc/bloc/general_reports_bloc.dart';
import 'package:domina_app/presentation/senior/representative/bloc/senior_prof_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AdminDashboardPage extends StatelessWidget {
  const AdminDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: OrientationBuilder(
        builder: (context, orientation) {
          final bool isLandscape = orientation == Orientation.landscape;

          // تجهيز قائمة الكروت مع تمرير حالة isLandscape
          final List<Widget> adminCards = [
            InteractiveAdminCard(
              icon: Icons.bar_chart_rounded,
              title: 'إدارة تقارير المندوبين',
              subtitle: 'متابعة أداء المندوبين والزيارات اليومية',
              iconColor: ColorManager.primaryBlue,
              isLandscape: isLandscape,
              onTap: () {
                if (UserInfo.repType.i == 4 || UserInfo.repType.i == 5) {
                  Navigator.pushNamed(context, Routes.allCitySupervisor);
                } else {
                  Navigator.pushNamed(context, Routes.AllRepSenior);
                }
              },
            ),
            if (UserInfo.repType.i == 4 || UserInfo.repType.i == 5)
              InteractiveAdminCard(
                icon: Icons.assignment_outlined,
                title: 'إدارة التقارير العامة الخاصة بالسينيور',
                subtitle: 'متابعة أداء المشرفين في مراقبة مندوبينهم',
                iconColor: Colors.purple,
                isLandscape: isLandscape,
                onTap: () {
                  Navigator.pushNamed(context, Routes.allCitySeniors);
                },
              ),
            if (UserInfo.repType.i == 4)
              InteractiveAdminCard(
                icon: Icons.assignment_outlined,
                title: 'إدارة التقارير العامة الخاصة بالتيم ليدر',
                subtitle: 'متابعة أداء المشرفين في مراقبة مندوبينهم',
                iconColor: Colors.purple,
                isLandscape: isLandscape,
                onTap: () {
                  Navigator.pushNamed(context, Routes.teamLeader);
                  BlocProvider.of<GeneralReportsBloc>(context)
                      .add(const TeamLeaderAndCityEvent());
                },
              ),
          ];

          return Scaffold(
            drawer: const DrawerPage(),
            backgroundColor: ColorManager.bgGrey,
            appBar: AppBar(
              leading: Builder(
                builder: (BuildContext context) {
                  return Center(
                    child: IconButton(
                      icon: Icon(
                        size: isLandscape ? 24.sp : AppSize.s30,
                        Icons.menu,
                        color: ColorManager.secondaryColor,
                      ),
                      onPressed: () {
                        Scaffold.of(context).openDrawer();
                      },
                    ),
                  );
                },
              ),
              title: const Text('لوحة التحكم الإدارية'),
            ),
            body: Directionality(
              textDirection: TextDirection.rtl,
              child: CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: [
                  // 1. قسم الترحيب والترويسة
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: isLandscape ? 32.w : 24.w,
                        vertical: isLandscape ? 14.h : 30.h,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'مرحباً بك مجدداً',
                            style: TextStyle(
                              fontSize: isLandscape ? 20.sp : 28.sp,
                              fontWeight: FontWeight.bold,
                              color: ColorManager.medicalPrimary,
                            ),
                          ),
                          SizedBox(height: isLandscape ? 4.h : 8.h),
                          Text(
                            'اختر القسم الذي ترغب في إدارته اليوم',
                            style: TextStyle(
                              fontSize: isLandscape ? 13.sp : 16.sp,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // 2. كروت لوحة التحكم
                  SliverPadding(
                    padding: EdgeInsets.symmetric(
                      horizontal: isLandscape ? 32.w : 20.w,
                    ),
                    sliver: SliverToBoxAdapter(
                      child: Column(
                        children: [
                          // التبديل بين التنسيق الأفقي (في اللاندسكيب) والتنسيق الطولي (في البورتريت)
                          if (isLandscape) ...[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: adminCards.map((card) {
                                return SizedBox(
                                  width: 140.w,
                                  height: 300.h,
                                  child: card,
                                );
                              }).toList(),
                            ),
                            SizedBox(height: 12.h),
                          ] else ...[
                            ...adminCards,
                            SizedBox(height: 14.h),
                          ],

                          // كروت الخطط الحالية والمنتهية
                          Row(
                            children: [
                              Expanded(
                                child: SquareInteractiveCard(
                                  icon: Icons.calendar_today_outlined,
                                  title: 'الخطط الحالية',
                                  subtitle: 'متابعة النشاط',
                                  iconColor: Colors.green,
                                  onTap: () {
                                    initSeniorProfModule();
                                    context
                                        .read<SeniorProfBloc>()
                                        .add(SenAllPlaceEvent(UserInfo.repId));
                                    Navigator.pushNamed(
                                      context,
                                      Routes.seniorFuturePlaces,
                                    );
                                  },
                                  isLandscape: isLandscape,
                                ),
                              ),
                              SizedBox(width: isLandscape ? 12.h : 16.w),
                              Expanded(
                                child: SquareInteractiveCard(
                                  icon: Icons.history_rounded,
                                  title: 'الخطط المنتهية',
                                  subtitle: 'أرشيف الخطط',
                                  iconColor: Colors.grey,
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
                    child: SizedBox(height: isLandscape ? 15.h : 30.h),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}