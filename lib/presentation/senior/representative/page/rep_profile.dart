import 'package:domina_app/app/di.dart';
import 'package:domina_app/app/user_info.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/resources/routes_manager.dart';
import 'package:domina_app/presentation/senior/active_plan/bloc/bloc/active_plan_bloc.dart';
import 'package:domina_app/presentation/senior/active_plan/pages/active_plan.dart';
import 'package:domina_app/presentation/senior/report_Inventory/bloc/report_inventory_bloc.dart';
import 'package:domina_app/presentation/senior/report_Inventory/page/report_inventory.dart';
import 'package:domina_app/presentation/senior/report_visit_doctor/bloc/report_visit_doctor_bloc.dart';
import 'package:domina_app/presentation/senior/report_visit_doctor/page/report_visit_doctor.dart';
import 'package:domina_app/presentation/senior/report_visit_doctor/page/report_visit_hospital.dart';
import 'package:domina_app/presentation/senior/representative/bloc/senior_prof_bloc.dart';
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
      onPopInvoked: (didPop) {
        // if (didPop) {
        //   context.read<SeniorRepsBloc>().add(AllSeniorRepEvent(
        //
        //   ));
        // }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("ملف المندوب",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.sp,
                  color: const Color(0xFF1F4E79))),
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

              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    SizedBox(height: 25.h),
                    _buildHeroHeader(rep),
                    AnimationLimiter(
                      child: Column(
                        children: AnimationConfiguration.toStaggeredList(
                          duration: const Duration(milliseconds: 500),
                          childAnimationBuilder: (widget) => SlideAnimation(
                            verticalOffset: 40.0,
                            child: FadeInAnimation(child: widget),
                          ),
                          children: [
                            SizedBox(height: 25.h),
                            _buildStatsGrid(rep),
                            SizedBox(height: 25.h),
                            _buildQuickActions(context),
                            SizedBox(height: 30.h),
                            _buildDetailsList(
                                context, rep, currentRepName, currentRepPlan,rep.mobile),
                            SizedBox(height: 25.h),
                            _buildCoverageSection(context),
                            SizedBox(height: 50.h),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }

  Widget _buildHeroHeader(dynamic rep) {
    return Hero(
      tag: 'rep_card_${rep.id}',
      child: Container(
        width: double.infinity,
        // تقليل الهوامش الجانبية ليلتصق بالأعلى بشكل أفضل مثل الصور
        margin: EdgeInsets.symmetric(horizontal: 15.w),
        padding: EdgeInsets.symmetric(vertical: 40.h, horizontal: 20.w),
        decoration: BoxDecoration(
          // gradient: const LinearGradient(
          //   colors: [ Color(0xFF3B7DBF)],
          //   begin: Alignment.topLeft,
          //   end: Alignment.bottomRight,
          // ),
          color: Color(0xFF164683),

          // تعديل الحواف لتكون دائرية من الأسفل فقط لتعطي طابع الـ Header الحديث
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
            // الدائرة التي تحتوي على الحرف الأول (تصميم زجاجي شفاف)
            Container(
              width: 100.r,
              height: 100.r,
              decoration: BoxDecoration(
                  //  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(0.2),
                  border: Border.all(
                      color: Colors.white.withOpacity(0.3), width: 1.5),
                  borderRadius: BorderRadius.all(Radius.circular(45))),
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
            // اسم المندوب
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
            // العنوان أو النص الفرعي
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

  Widget _buildStatsGrid(dynamic rep) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: GridView.count(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 2,
        mainAxisSpacing: 15.h,
        crossAxisSpacing: 15.w,
        childAspectRatio: 1.5,
        children: [
          _buildStatCard("إجمالي الزيارات", rep.totalVisit.toString(),
              const Color(0xFF1F4E79)),
          _buildStatCard(
              "المحققة", rep.visitDon.toString(), const Color(0xFF2D947A)),
          _buildStatCard(
              "المتبقية", rep.visitNoteYet.toString(), const Color(0xFFE67E22)),
          _buildStatCard(
              "الوصفات", rep.recipesCount.toString(), const Color(0xFF8E44AD)),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String val, Color color) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25.r),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 15,
              offset: const Offset(0, 8))
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(title,
              style: TextStyle(
                  fontSize: 11.sp,
                  color: Colors.grey[500],
                  fontWeight: FontWeight.bold)),
          SizedBox(height: 6.h),
          Text(val,
              style: TextStyle(
                  fontSize: 22.sp, fontWeight: FontWeight.w900, color: color)),
        ],
      ),
    );
  }

  Widget _buildQuickActions(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w),
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
          _buildIconBtn(context, FontAwesomeIcons.tag, "الإختصاص",
              const Color(0xFFFF9F43), () {
            context.read<SeniorProfBloc>().add(SenAllSpecEvent(id));
            Navigator.pushNamed(context, Routes.seniorSpec);
          }),
          _buildIconBtn(context, FontAwesomeIcons.locationDot, "المناطق",
              const Color(0xFF45AAF2), () {
            context.read<SeniorProfBloc>().add(SenAllPlaceEvent(id));
            Navigator.pushNamed(context, Routes.seniorPlaces);
          }),
          _buildIconBtn(context, FontAwesomeIcons.userDoctor, "الأطباء",
              const Color(0xFFEB4D4B), () {
            context.read<SeniorProfBloc>().add(SenAllDoctorEvent(id));
            Navigator.pushNamed(context, Routes.seniorDoc);
          }),
          _buildIconBtn(context, FontAwesomeIcons.hospitalUser, "المشافي",
              const Color(0xFFE3D909), () {
            context.read<SeniorProfBloc>().add(SenAllHospitalEvent(id));
            Navigator.pushNamed(context, Routes.seniorHos);
          }),
          _buildIconBtn(context, FontAwesomeIcons.hospital, "الأصناف",
              const Color(0xFF26DE81), () {
            context.read<SeniorProfBloc>().add(SenAllBrandEvent(repPlanId));
            Navigator.pushNamed(context, Routes.allBrand);
          }),
        ],
      ),
    );
  }

  Widget _buildIconBtn(BuildContext context, FaIconData icon, String label,
      Color color, VoidCallback tap) {
    return InkWell(
      onTap: tap,
      borderRadius: BorderRadius.circular(20.r),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(14.r),
            decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20.r)),
            child: FaIcon(icon, color: color, size: 20.sp),
          ),
          SizedBox(height: 8.h),
          Text(label,
              style: TextStyle(
                  fontSize: 11.sp,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF4B6584))),
        ],
      ),
    );
  }

  Widget _buildCoverageSection(BuildContext context) {
    return _buildSectionLayout("إحصائيات التغطية", [
      InteractiveActionTile(
          title: "الأطباء الذين تمت زيارتهم",
          icon: Icons.check_circle_outline,
          color: const Color(0xFF2D947A),
          onTap: () {
            context.read<SeniorProfBloc>().add(VisitDocEvent(id,repPlanId));
            Navigator.pushNamed(context, Routes.senVisitDoctor);
          }),
      InteractiveActionTile(
          title: "الأطباء الذين لم تتم زيارتهم",
          icon: Icons.cancel_outlined,
          color: const Color(0xFFE74C3C),
          onTap: () {
            context.read<SeniorProfBloc>().add(NoVisitDocEvent(id,repPlanId));
            Navigator.pushNamed(context, Routes.noVisitDoctor);
          }),
      InteractiveActionTile(
          title: "زيارات الأطباء المتبقية",
          icon: Icons.hourglass_empty_rounded,
          color: const Color(0xFFF39C12),
          onTap: () {
            context.read<SeniorProfBloc>().add(RemainingVisitsDocEvent(id,repPlanId));
            Navigator.pushNamed(context, Routes.remainingVisitsDoctor);
          }),
      InteractiveActionTile(
          title: "تقرير توزيع العينات (الجرد)",
          icon: FontAwesomeIcons.clipboardList,
          color: const Color(0xFF1F4E79),
          onTap: () {
            initSeniorReportInventoryModule();
            Navigator.push(context, MaterialPageRoute(builder: (c) {
              context.read<ReportInventoryBloc>().add(SenAllInventoryEvent(id,repPlanId));
              return ReportInventory();
            }));
          }),
    ]);
  }

  Widget _buildDetailsList(
      BuildContext context, dynamic rep, String name, int plan,String phone) {
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
                        phone:phone,
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
                        phone:phone,
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
            initActivePlanModule();
            Navigator.push(
                context, MaterialPageRoute(builder: (c) => ActivePlanPage()));
            context.read<ActivePlanBloc>().add(GetActivePlanEvent(plan));
          }),
    ]);
  }

  Widget _buildSectionLayout(String title, List<Widget> items) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(right: 5.w, bottom: 15.h),
            child: Text(title,
                style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w800,
                    color: const Color(0xFF2C3E50))),
          ),
          ...items,
        ],
      ),
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
    return GestureDetector(
      onTapDown: (_) => setState(() => isPressed = true),
      onTapUp: (_) => setState(() => isPressed = false),
      onTapCancel: () => setState(() => isPressed = false),
      onTap: widget.onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
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
