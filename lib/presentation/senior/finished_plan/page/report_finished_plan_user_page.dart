import 'package:domina_app/app/di.dart';
import 'package:domina_app/presentation/resources/routes_manager.dart';
import 'package:domina_app/presentation/senior/report_Inventory/bloc/report_inventory_bloc.dart';
import 'package:domina_app/presentation/senior/report_Inventory/page/report_inventory.dart';
import 'package:domina_app/presentation/senior/representative/bloc/senior_prof_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class ReportFinishedPlanUserPage extends StatelessWidget {
  final int id;
  final int repPlanId;
  final String name;

  const ReportFinishedPlanUserPage({
    super.key,
    required this.id,
    required this.repPlanId,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
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
          title: Text("ملف المندوب $name",
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
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              // SizedBox(height: 25.h),
              // _buildHeroHeader(rep),
              AnimationLimiter(
                child: Column(
                  children: AnimationConfiguration.toStaggeredList(
                    duration: const Duration(milliseconds: 500),
                    childAnimationBuilder: (widget) => SlideAnimation(
                      verticalOffset: 40.0,
                      child: FadeInAnimation(child: widget),
                    ),
                    children: [
                      // SizedBox(height: 25.h),
                      // _buildStatsGrid(rep),
                      SizedBox(height: 25.h),
                      //  _buildQuickActions(context),
                      // SizedBox(height: 25.h),
                      _buildCoverageSection(context),
                      SizedBox(height: 50.h),
                    ],
                  ),
                ),
              ),
            ],
          ),
        )
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
