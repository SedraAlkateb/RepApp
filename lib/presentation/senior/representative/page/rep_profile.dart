import 'package:domina_app/app/di/di.dart';
import 'package:domina_app/app/user_info.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/resources/routes_manager.dart';
import 'package:domina_app/presentation/senior/report_Inventory/bloc/report_inventory_bloc.dart';
import 'package:domina_app/presentation/senior/report_Inventory/page/report_inventory.dart';
import 'package:domina_app/presentation/senior/report_visit_doctor/bloc/report_visit_doctor_bloc.dart';
import 'package:domina_app/presentation/senior/report_visit_doctor/page/report_visit_doctor.dart';
import 'package:domina_app/presentation/senior/report_visit_doctor/page/report_visit_hospital.dart';
import 'package:domina_app/presentation/senior/representative/bloc/senior_prof_bloc.dart';
import 'package:domina_app/presentation/senior/representative/page/no_visit_doctor.dart';
import 'package:domina_app/presentation/senior/representative/page/no_visit_hos.dart';
import 'package:domina_app/presentation/senior/representative/page/remaining_visits.dart';
import 'package:domina_app/presentation/senior/representative/page/remaining_visits_hos.dart';
import 'package:domina_app/presentation/senior/representative/page/sen_visit_doctor.dart';
import 'package:domina_app/presentation/senior/representative/page/sen_visit_hospital.dart';
import 'package:domina_app/presentation/senior/representative/widget/rep_profile_widget/build_stats_grid_widget.dart';
import 'package:domina_app/presentation/uniti/stateWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class RepProfile extends StatelessWidget {
  final int id;
  final int repPlanId;
  final int index;

  const RepProfile({
    super.key,
    required this.id,
    required this.repPlanId,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    String currentRepName = "";
    int currentRepPlan = 0;

    return PopScope(
      canPop: true,
      onPopInvoked: (didPop) {},
      child: Scaffold(
        appBar: AppBar(
          title: Text("ملف المندوب",),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded,
                color: Color(0xFF1F4E79)),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: BlocBuilder<SeniorProfBloc, SeniorProfState>(
          buildWhen: (previous, current) =>
              current is RepInfoState || current is RepInfoLoadingState,
          builder: (context, state) {
            if (state is RepInfoLoadingState) return loadingFullScreen(context);
            if (state is RepInfoErrorState) return errorFullScreen(context);

            if (state is RepInfoState) {
              final rep = state.infoRep;
              currentRepName = rep.name;
              currentRepPlan = rep.repPlanId;

              return OrientationBuilder(
                builder: (context, orientation) {
                  // إذا كان الاتجاه أفقياً (Landscape / Tablet Wide)
                  if (orientation == Orientation.landscape) {
                    return _buildTabletLandscapeLayout(
                        context, rep, currentRepName, currentRepPlan);
                  }

                  // الوضع الرأسي الحالي (كما هو بدون تغيير)
                  return _buildPortraitLayout(
                      context, rep, currentRepName, currentRepPlan);
                },
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }

  // =========================================================
  // 1. التصميم الخاص بالتابلت بالوضع الأفقي (Landscape Layout)
  // =========================================================
  Widget _buildTabletLandscapeLayout(BuildContext context, InfoRep rep,
      String currentRepName, int currentRepPlan) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // القسم الأيسر: الهيدر والأزرار السريعة الثابتة
          Expanded(
            flex: 4,
            child: _buildHeroHeaderTablet(rep, context),
          ),

          SizedBox(width: 15.w),

          // القسم الأيمن: الإحصائيات، التغطية والتقارير التفصيلية
          Expanded(
            flex: 6,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: AnimationLimiter(
                child: Column(
                  children: AnimationConfiguration.toStaggeredList(
                    duration: const Duration(milliseconds: 500),
                    childAnimationBuilder: (widget) => SlideAnimation(
                      horizontalOffset: 50.0,
                      child: FadeInAnimation(child: widget),
                    ),
                    children: [
                      buildStatsGridTablet(rep),
                      SizedBox(height: 20.h),
                      buildQuickActions(context),
                      SizedBox(height: 20.h),
                      _buildCoverageSection(context),
                      SizedBox(height: 20.h),
                      _buildDetailsList(context, rep, currentRepName,
                          currentRepPlan, rep.mobile),
                      SizedBox(height: 30.h),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }


  Widget buildQuickActions(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: 10.h, right: 5.w),
          child: Text(
            "معلومات شخصية",
            style: TextStyle(
                fontSize: 15.sp,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF2C3E50)),
          ),
        ),
        Container(
          // margin: EdgeInsets.symmetric(horizontal: 20.w),
          padding: EdgeInsets.symmetric(vertical: 20.h),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30.r),
              boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 20)
              ]),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              buildIconBtn(context, FontAwesomeIcons.tag, "الإختصاص",
                  const Color(0xFFFF9F43), () {
                context.read<SeniorProfBloc>().add(SenAllSpecEvent(id));
                Navigator.pushNamed(context, Routes.seniorSpec);
              }),
              buildIconBtn(context, FontAwesomeIcons.locationDot, "المناطق",
                  const Color(0xFF45AAF2), () {
                context.read<SeniorProfBloc>().add(SenAllPlaceEvent(id));
                Navigator.pushNamed(context, Routes.seniorPlaces);
              }),
              buildIconBtn(context, FontAwesomeIcons.userDoctor, "الأطباء",
                  const Color(0xFFEB4D4B), () {
                context.read<SeniorProfBloc>().add(SenAllDoctorEvent(id));
                Navigator.pushNamed(context, Routes.seniorDoc);
              }),
              buildIconBtn(context, FontAwesomeIcons.hospitalUser, "المشافي",
                  const Color(0xFFE3D909), () {
                context.read<SeniorProfBloc>().add(SenAllHospitalEvent(id));
                Navigator.pushNamed(context, Routes.seniorHos);
              }),
              buildIconBtn(context, FontAwesomeIcons.hospital, "الأصناف",
                  const Color(0xFF26DE81), () {
                context.read<SeniorProfBloc>().add(SenAllBrandEvent(repPlanId));
                Navigator.pushNamed(context, Routes.allBrand);
              }),
            ],
          ),
        ),
      ],
    );
  }

  // الهيدر المحسّن للتابلت بالعرض
  Widget _buildHeroHeaderTablet(InfoRep rep, BuildContext context) {
    return Hero(
      tag: 'rep_card_${rep.id}',
      child: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.symmetric(vertical: 40.h, horizontal: 20.w),
        decoration: BoxDecoration(
          color: const Color(0xFF164683),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(50.r),
            bottomRight: Radius.circular(50.r),
            topLeft: Radius.circular(50.r),
            topRight: Radius.circular(50.r),
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF1F4E79).withOpacity(0.3),
              blurRadius: 5,
              offset: const Offset(0, 2),
            )
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 100.r,
              height: 100.r,
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  border: Border.all(
                      color: Colors.white.withOpacity(0.3), width: 1.5),
                  borderRadius: const BorderRadius.all(Radius.circular(30))),
              alignment: Alignment.center,
              child: Text(
                rep.name.isNotEmpty ? rep.name.substring(0, 1) : "",
                style: TextStyle(
                  fontSize: 26.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1.2,
                ),
              ),
            ),
            SizedBox(height: 20.h),
            Text(
              rep.name,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24.sp,
                color: Colors.white,
                fontWeight: FontWeight.bold,
                shadows: [
                  Shadow(
                    color: Colors.black.withOpacity(0.2),
                    offset: const Offset(0, 2),
                    blurRadius: 4,
                  ),
                ],
              ),
            ),
            if (rep.address.isNotEmpty) ...[
              SizedBox(height: 20.h),
              Text(
                rep.address,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.white.withOpacity(0.9),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  // =========================================================
  // 2. التصميم الأصلي كما هو بدون تعديل للوضع الرأسي (Portrait)
  // =========================================================
  Widget _buildPortraitLayout(BuildContext context, InfoRep rep,
      String currentRepName, int currentRepPlan) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          SizedBox(height: 25.h),
          _buildHeroHeader(rep),
          AnimationLimiter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                children: AnimationConfiguration.toStaggeredList(
                  duration: const Duration(milliseconds: 500),
                  childAnimationBuilder: (widget) => SlideAnimation(
                    verticalOffset: 40.0,
                    child: FadeInAnimation(child: widget),
                  ),
                  children: [
                    SizedBox(height: 25.h),
                    buildStatsGrid(context, rep),
                    SizedBox(height: 25.h),
                    buildQuickActions(context),
                    SizedBox(height: 30.h),
                    _buildDetailsList(context, rep, currentRepName,
                        currentRepPlan, rep.mobile),
                    SizedBox(height: 25.h),
                    _buildCoverageSection(context),
                    SizedBox(height: 50.h),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // بقية المكونات الأساسية للـ Mobile Portrait (نفس الكود الخاص بك دون أي تعديل)
  Widget _buildHeroHeader(dynamic rep) {
    return Hero(
      tag: 'rep_card_${rep.id}',
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.symmetric(horizontal: 15.w),
        padding: EdgeInsets.symmetric(vertical: 40.h, horizontal: 20.w),
        decoration: BoxDecoration(
          color: const Color(0xFF164683),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(50.r),
            bottomRight: Radius.circular(50.r),
            topLeft: Radius.circular(35.r),
            topRight: Radius.circular(35.r),
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF1F4E79).withOpacity(0.3),
              blurRadius: 5,
              offset: const Offset(0, 2),
            )
          ],
        ),
        child: Column(
          children: [
            Container(
              width: 100.r,
              height: 100.r,
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  border: Border.all(
                      color: Colors.white.withOpacity(0.3), width: 1.5),
                  borderRadius: const BorderRadius.all(Radius.circular(45))),
              alignment: Alignment.center,
              child: Text(
                rep.name.isNotEmpty ? rep.name.substring(0, 1) : "",
                style: TextStyle(
                  fontSize: 36.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1.2,
                ),
              ),
            ),
            SizedBox(height: 20.h),
            Text(
              rep.name,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24.sp,
                color: Colors.white,
                fontWeight: FontWeight.bold,
                shadows: [
                  Shadow(
                    color: Colors.black.withOpacity(0.2),
                    offset: const Offset(0, 2),
                    blurRadius: 4,
                  ),
                ],
              ),
            ),
            if (rep.address != null && rep.address.isNotEmpty) ...[
              SizedBox(height: 8.h),
              Text(
                rep.address,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.white.withOpacity(0.9),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildCoverageSection(BuildContext context) {
    return _buildSectionLayout("إحصائيات التغطية", [
      InteractiveActionTile(
          title: "لزيارات التي تمت مباشرتها",
          icon: Icons.check_circle_outline,
          color: const Color(0xFF2D947A),
          onTap: () {
            context.read<SeniorProfBloc>().add(VisitDocEvent(id, repPlanId));
            Navigator.pushNamed(
              context,
              Routes.senVisit,
              arguments: {
                'onTapDoctor': () => context
                    .read<SeniorProfBloc>()
                    .add(VisitDocEvent(id, repPlanId)),
                'onTapHospital': () => context
                    .read<SeniorProfBloc>()
                    .add(VisitHosEvent(id, repPlanId)),
                'title': "الزيارات التي تمت مباشرتها",
                'doctor': SenVisitDoctor(),
                'hospital': SenVisitHospital(),
              },
            );
          }),
      InteractiveActionTile(
          title: "الزيارات التي لم تتم بعد",
          icon: Icons.cancel_outlined,
          color: const Color(0xFFE74C3C),
          onTap: () {
            context.read<SeniorProfBloc>().add(NoVisitDocEvent(id, repPlanId));
            Navigator.pushNamed(
              context,
              Routes.senVisit,
              arguments: {
                'onTapDoctor': () => context
                    .read<SeniorProfBloc>()
                    .add(NoVisitDocEvent(id, repPlanId)),
                'onTapHospital': () => context
                    .read<SeniorProfBloc>()
                    .add(NoVisitHosEvent(id, repPlanId)),
                'title': "الزيارات التي لم تتم بعد",
                'doctor': NoVisitDoctor(),
                'hospital': NoVisitHos(),
              },
            );
          }),
      InteractiveActionTile(
          title: "الزيارات التي تمت ولم تكتمل",
          icon: Icons.hourglass_empty_rounded,
          color: const Color(0xFFF39C12),
          onTap: () {
            context
                .read<SeniorProfBloc>()
                .add(RemainingVisitsDocEvent(id, repPlanId));
            Navigator.pushNamed(
              context,
              Routes.senVisit,
              arguments: {
                'onTapDoctor': () => context
                    .read<SeniorProfBloc>()
                    .add(RemainingVisitsDocEvent(id, repPlanId)),
                'onTapHospital': () => context
                    .read<SeniorProfBloc>()
                    .add(RemainingVisitsHosEvent(id, repPlanId)),
                'title': "الزيارات التي تمت ولم تكتمل",
                'doctor': RemainingVisits(),
                'hospital': RemainingVisitsHos(),
              },
            );
          }),
      InteractiveActionTile(
          title: "تقرير توزيع العينات (الجرد)",
          icon: FontAwesomeIcons.clipboardList,
          color: const Color(0xFF1F4E79),
          onTap: () {
            initSeniorReportInventoryModule();
            Navigator.push(context, MaterialPageRoute(builder: (c) {
              context
                  .read<ReportInventoryBloc>()
                  .add(SenAllInventoryEvent(id, repPlanId));
              return ReportInventory();
            }));
          }),
    ]);
  }

  Widget _buildDetailsList(
      BuildContext context, dynamic rep, String name, int plan, String phone) {
    return _buildSectionLayout("التقارير التفصيلية", [
      InteractiveActionTile(
          title: "تقرير زيارات الأطباء",
          icon: FontAwesomeIcons.fileMedical,
          color: const Color(0xFF1F4E79),
          onTap: () {
            initReportVisitDoctorModule();
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (c) => ReportVisitDoctorPage(
                        iscanedite: true,
                        repId: id,
                        userId: UserInfo.repId,
                        repName: name,
                        phone: phone,
                        indexRep: index,
                        repPlan: plan)));
            context.read<ReportVisitDoctorBloc>().add(AllReportVisitDoctorEvent(
                VisitRepSen(id, UserInfo.repId), false));
          }),
      InteractiveActionTile(
          title: "تقرير زيارات المشافي",
          icon: FontAwesomeIcons.hospitalUser,
          color: const Color(0xFF1F4E79),
          onTap: () {
            initReportVisitDoctorModule();
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (c) => ReportVisitHospital(
                        iscanedite: true,
                        repId: id,
                        userId: UserInfo.repId,
                        repName: name,
                        phone: phone,
                        indexRep: index,
                        repPlan: plan)));
            context.read<ReportVisitDoctorBloc>().add(
                AllReportVisitHospitalEvent(
                    VisitRepSen(id, UserInfo.repId), false));
          }),
      InteractiveActionTile(
          title: "سجل الوصفات الطبية",
          icon: FontAwesomeIcons.receipt,
          color: const Color(0xFF1F4E79),
          onTap: () {
            Navigator.pushNamed(context, Routes.allRecipe);
            context.read<SeniorProfBloc>().add(AllReciEvent(id));
          }),
      InteractiveActionTile(
          title: "الخطة الشهرية الفعالة",
          icon: FontAwesomeIcons.calendarCheck,
          color: const Color(0xFF1F4E79),
          onTap: () {
            Navigator.pushNamed(context, Routes.activePlanPage,
                arguments: plan);
          }),
    ]);
  }

  Widget _buildSectionLayout(String title, List<Widget> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(right: 5.w, bottom: 12.h, top: 10.h),
          child: Text(title,
              style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF2C3E50))),
        ),
        ...items,
      ],
    );
  }
}

class InteractiveActionTile extends StatefulWidget {
  final String title;
  final dynamic icon;
  final Color color;
  final VoidCallback onTap;

  const InteractiveActionTile(
      {super.key,
      required this.title,
      required this.icon,
      required this.color,
      required this.onTap});

  @override
  State<InteractiveActionTile> createState() => _InteractiveActionTileState();
}

class _InteractiveActionTileState extends State<InteractiveActionTile> {
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final bool isLandscape = mediaQuery.orientation == Orientation.landscape ;
    return GestureDetector(
      onTapDown: (_) => setState(() => isPressed = true),
      onTapUp: (_) => setState(() => isPressed = false),
      onTapCancel: () => setState(() => isPressed = false),
      onTap: widget.onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: EdgeInsets.only(bottom: 12.h),
        padding: isLandscape
            ? EdgeInsets.symmetric(horizontal: 12.w, vertical: 25.h)
            : EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        decoration: BoxDecoration(
          color: isPressed ? widget.color.withOpacity(0.02) : Colors.white,
          borderRadius: BorderRadius.circular(22.r),
          border: Border.all(
              color: isPressed
                  ? widget.color.withOpacity(0.3)
                  : Colors.black.withOpacity(0.04),
              width: 1.2),
          boxShadow: [
            BoxShadow(
              color: isPressed
                  ? widget.color.withOpacity(0.1)
                  : Colors.black.withOpacity(0.02),
              blurRadius: isPressed ? 10 : 15,
              offset: const Offset(0, 5),
            )
          ],
        ),
        child: Row(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: EdgeInsets.all(10.r),
              decoration: BoxDecoration(
                color:
                    isPressed ? widget.color : widget.color.withOpacity(0.08),
                borderRadius: BorderRadius.circular(15.r),
              ),
              child: widget.icon is IconData
                  ? Icon(widget.icon,
                      color: isPressed ? Colors.white : widget.color,
                      size: 18.sp)
                  : FaIcon(widget.icon as FaIconData,
                      color: isPressed ? Colors.white : widget.color,
                      size: 16.sp),
            ),
            SizedBox(width: 15.w),
            Text(widget.title,
                style: TextStyle(
                    fontSize: 13.5.sp,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF34495E))),
            const Spacer(),
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 200),
              style:
                  TextStyle(color: isPressed ? widget.color : Colors.grey[300]),
              child: Icon(Icons.arrow_forward_ios_rounded, size: 14.sp),
            ),
          ],
        ),
      ),
    );
  }
}
