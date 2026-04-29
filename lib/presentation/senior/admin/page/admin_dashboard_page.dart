import 'package:domina_app/app/di.dart';
import 'package:domina_app/app/user_info.dart';
import 'package:domina_app/presentation/drawer/pages/drawer_launcher.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/resources/routes_manager.dart';
import 'package:domina_app/presentation/resources/values_manager.dart';
import 'package:domina_app/presentation/senior/admin/widget/interactive_admin_card.dart';
import 'package:domina_app/presentation/senior/admin/widget/square_interactive_card.dart';
import 'package:domina_app/presentation/senior/all_city/bloc/bloc/all_city_bloc.dart';
import 'package:domina_app/presentation/senior/general_reports/bloc/bloc/general_reports_bloc.dart';
import 'package:domina_app/presentation/senior/general_reports/pages/senior-by-cityid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AdminDashboardPage extends StatelessWidget {
  const AdminDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerPage(),
      backgroundColor: ColorManager.bgGrey,
      appBar: AppBar(
        leading: Builder(
          builder: (BuildContext context) {
            return Center(
              child: IconButton(
                icon: Icon(
                  size: AppSize.s30,
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
        title: Text(
          'لوحة التحكم الإدارية',
          //   style: TextStyle(color: ColorManager.primaryText, fontWeight: FontWeight.bold, fontSize: 20.sp),
        ),
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 30.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('مرحباً بك مجدداً',
                        style: TextStyle(
                            fontSize: 28.sp,
                            fontWeight: FontWeight.bold,
                            color: ColorManager.medicalPrimary)),
                    SizedBox(height: 8.h),
                    Text('اختر القسم الذي ترغب في إدارته اليوم',
                        style: TextStyle(
                            fontSize: 16.sp, color: Colors.grey[600])),
                  ],
                ),
              ),
            ),

            // 2. الكروت (جزء من السكرول)
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  InteractiveAdminCard(
                    icon: Icons.bar_chart_rounded,
                    title: 'إدارة تقارير المندوبين',
                    subtitle: 'متابعة أداء المندوبين والزيارات اليومية',
                    iconColor: ColorManager.primaryBlue,
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        Routes.AllRepSenior,
                      );
                    },
                  ),
                  UserInfo.repType == "4"?
                  InteractiveAdminCard(
                    icon: Icons.assignment_outlined,
                    title: 'إدارة التقارير العامة الخاصة بالسينيور',
                    subtitle: 'متابعة أداء المشرفين في مراقبة مندوبينهم',
                    iconColor: Colors.purple,
                    onTap: () {

                      Navigator.pushNamed(context, Routes.allCitySeniors);
                      BlocProvider.of<GeneralReportsBloc>(context).add(GetSeniorByCityIdEvent(UserInfo.cityId));
                    },
                  ):SizedBox(),
                  UserInfo.repType == "5"?
                  InteractiveAdminCard(
                    icon: Icons.assignment_outlined,
                    title: 'إدارة التقارير العامة الخاصة بالسينيور',
                    subtitle: 'متابعة أداء المشرفين في مراقبة مندوبينهم',
                    iconColor: Colors.purple,
                    onTap: () {
                      initGeneralReportsModule();
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) => SeniorByCityId(
                          cityname: UserInfo.cityTitle,
                          cityid: UserInfo.cityId,
                        ),
                      ));
                      BlocProvider.of<GeneralReportsBloc>(context).add(GetSeniorByCityIdEvent(UserInfo.cityId));
                    },
                  ):SizedBox(),
                  UserInfo.repType == "4"?
                  InteractiveAdminCard(
                    icon: Icons.assignment_outlined,
                    title: 'إدارة التقارير العامة الخاصة بالتيم ليدر',
                    subtitle: 'متابعة أداء المشرفين في مراقبة مندوبينهم',
                    iconColor: Colors.purple,
                    onTap: () {

                      Navigator.pushNamed(
                        context,
                        Routes.teamLeader,

                      );
                      BlocProvider.of<GeneralReportsBloc>(context)
                          .add(const TeamLeaderAndCityEvent());
                    },
                  ):SizedBox(),
                  SizedBox(height: 10.h),
                  Row(
                    children: [
                      SquareInteractiveCard(
                        icon: Icons.calendar_today_outlined,
                        title: 'الخطط الحالية',
                        subtitle: 'متابعة النشاط',
                        iconColor: Colors.green,
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            Routes.allRepWithFuture,
                          );
                        },
                      ),
                      SizedBox(width: 16.w),
                      SquareInteractiveCard(
                        icon: Icons.history_rounded,
                        title: 'الخطط المنتهية',
                        subtitle: 'أرشيف الخطط',
                        iconColor: Colors.grey,
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            Routes.createOrder,
                          );
                        },
                      ),
                    ],
                  ),
                ]),
              ),
            ),

            // 3. ملخص الأداء العام (أصبح الآن داخل السكرول)
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
                child: _buildPerformanceSummaryCard(),
              ),
            ),

            SliverToBoxAdapter(child: SizedBox(height: 30.h)),
          ],
        ),
      ),
    );
  }

  Widget _buildPerformanceSummaryCard() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: ColorManager.darkBlueCard,
        borderRadius: BorderRadius.circular(
            25.r), // دائرية بالكامل لأنها ليست ملتصقة بالأسفل
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 15,
              offset: const Offset(0, 10))
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                'ملخص الأداء العام',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(width: 10.w),
              Icon(Icons.analytics_outlined, color: Colors.white, size: 24.sp),
            ],
          ),
          SizedBox(height: 20.h),
          Container(height: 0.8, color: Colors.white24),
          SizedBox(height: 20.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildStatItem('الإنجاز', '82%'),
              _buildStatItem('الوصفات', '45'),
              _buildStatItem('الزيارات', '124'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Column(
      children: [
        Text(value,
            style: TextStyle(
                color: Colors.white,
                fontSize: 22.sp,
                fontWeight: FontWeight.bold)),
        Text(label, style: TextStyle(color: Colors.white70, fontSize: 13.sp)),
      ],
    );
  }
}
