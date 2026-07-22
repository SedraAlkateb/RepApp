import 'package:domina_app/app/di.dart';
import 'package:domina_app/presentation/resources/routes_manager.dart';
import 'package:domina_app/presentation/senior/report_Inventory/bloc/report_inventory_bloc.dart';
import 'package:domina_app/presentation/senior/report_Inventory/page/report_inventory.dart';
import 'package:domina_app/presentation/senior/representative/bloc/senior_prof_bloc.dart';
import 'package:domina_app/presentation/uniti/stateWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class ReportFinishedPlanUserPage extends StatefulWidget {
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
  State<ReportFinishedPlanUserPage> createState() => _ReportFinishedPlanUserPageState();
}

class _ReportFinishedPlanUserPageState extends State<ReportFinishedPlanUserPage> {
  @override
  void initState() {
    context.read<SeniorProfBloc>().add(getInfoRepEvent(widget.id,widget.repPlanId));
    super.initState();
  }
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
          title: Text("ملف المندوب ${widget.name}",
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
        body:BlocBuilder<SeniorProfBloc, SeniorProfState>(
            buildWhen: (previous, current) =>
            current is RepInfoState || current is RepInfoLoadingState,
            builder: (context, state) {
              if (state is RepInfoLoadingState)
                return loadingFullScreen(context);
              if (state is RepInfoErrorState) return errorFullScreen(context);

              if (state is RepInfoState) {
                final rep = state.infoRep;
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
                            childAnimationBuilder: (widget) =>
                                SlideAnimation(
                                  verticalOffset: 40.0,
                                  child: FadeInAnimation(child: widget),
                                ),
                            children: [
                              SizedBox(height: 25.h),
                              _buildStatsGrid(rep),
                              SizedBox(height: 25.h),
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
                );
              }
              return SizedBox();
            }
)
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

  Widget _buildStatsGrid(dynamic rep) { // يفضل استبدال dynamic بنوع الكلاس الصريح InfoRep
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: GridView.count(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 2,
        mainAxisSpacing: 15.h,
        crossAxisSpacing: 15.w,
        childAspectRatio: 1.3, // تعديل النسبة لتناسب التصميم الجديد ومنع الـ Overflow
        children: [
          // --- إجمالي الزيارات الكلية والوصفات ---
          _buildStatCard(
            "إجمالي الزيارات",
            rep.totalVisit.toString(),
            const Color(0xFF1F4E79),
            icon: Icons.assignment_outlined,
          ),
          _buildStatCard(
            "إجمالي الوصفات",
            rep.recipesCount,
            const Color(0xFF8E44AD),
            icon: Icons.receipt_long_outlined,
          ),

          // --- زيارات الأطباء (محقق ومتبقي) ---
          _buildStatCard(
            "زيارات الأطباء المحققة",
            rep.visitDonDoc,
            const Color(0xFF2D947A),
            icon: Icons.person_pin_outlined,
          ),
          _buildStatCard(
            "زيارات الأطباء المتبقية",
            rep.totDocVisit,
            const Color(0xFFE67E22),
            icon: Icons.person_search_outlined,
          ),

          // --- زيارات المستشفيات (محقق ومتبقي) ---
          _buildStatCard(
            "زيارات المشافي المحققة",
            rep.visitDonHos,
            const Color(0xFF2D947A),
            icon: Icons.local_hospital_outlined,
          ),
          _buildStatCard(
            "زيارات المشافي المتبقية",
            rep.totHosVisit,
            const Color(0xFFE67E22),
            icon: Icons.local_hospital_sharp,
          ),

          // --- كليات المحقق والمتبقي القديمة (اختياري إذا أردت الإبقاء عليها) ---
          _buildStatCard(
            "إجمالي المحققة",
            rep.visitDon.toString(),
            const Color(0xFF1E88E5),
            icon: Icons.check_circle_outline,
          ),
          _buildStatCard(
            "إجمالي المتبقية",
            rep.visitNoteYet.toString(),
            const Color(0xFFD32F2F),
            icon: Icons.hourglass_empty_outlined,
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String val, Color color, {required IconData icon}) {
    return Container(
      padding: EdgeInsets.all(12.w), // تقليل البادينغ قليلاً ليعطي مساحة مريحة للنصوص الطويلة
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 12,
            offset: const Offset(0, 6),
          )
        ],
      ),
      child: Row( // استخدام Row لوضع الأيقونة في طرف والبيانات في طرف
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start, // محاذاة النصوص لليمين (أو اليسار حسب اتجاه التطبيق)
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 11.sp,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  val,
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w900,
                    color: color,
                  ),
                ),
              ],
            ),
          ),
          // الأيقونة التوضيحية الدقيقة خلف النص
          Container(
            padding: EdgeInsets.all(6.r),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              size: 20.r,
              color: color,
            ),
          ),
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
            context.read<SeniorProfBloc>().add(VisitDocEvent(widget.id,widget.repPlanId));
            Navigator.pushNamed(context, Routes.senVisitDoctor);
          }),
      InteractiveActionTile(
          title: "الأطباء الذين لم تتم زيارتهم",
          icon: Icons.cancel_outlined,
          color: const Color(0xFFE74C3C),
          onTap: () {
            context.read<SeniorProfBloc>().add(NoVisitDocEvent(widget.id,widget.repPlanId));
            Navigator.pushNamed(context, Routes.noVisitDoctor);
          }),
      InteractiveActionTile(
          title: "زيارات الأطباء المتبقية",
          icon: Icons.hourglass_empty_rounded,
          color: const Color(0xFFF39C12),
          onTap: () {
            context.read<SeniorProfBloc>().add(RemainingVisitsDocEvent(widget.id,widget.repPlanId));
            Navigator.pushNamed(context, Routes.remainingVisitsDoctor);
          }),
      InteractiveActionTile(
          title: "تقرير توزيع العينات (الجرد)",
          icon: FontAwesomeIcons.clipboardList,
          color: const Color(0xFF1F4E79),
          onTap: () {
            initSeniorReportInventoryModule();
            Navigator.push(context, MaterialPageRoute(builder: (c) {
              context.read<ReportInventoryBloc>().add(SenAllInventoryEvent(widget.id,widget.repPlanId));
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
