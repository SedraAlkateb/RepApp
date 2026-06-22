import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/senior/representative/bloc/senior_prof_bloc.dart';
import 'package:domina_app/presentation/uniti/circle_number_widget.dart';
import 'package:domina_app/presentation/uniti/search_field.dart';
import 'package:domina_app/presentation/uniti/stateWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class SenVisitDoctor extends StatelessWidget {
  SenVisitDoctor({super.key});
  final TextEditingController searchteDoctorController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FBFF),
      appBar: AppBar(
        title: const Text('سجل الأطباء الذين تمت زيارتهم'),
      ),
      body: Column(
        children: [
          // 1. حقل البحث
          Padding(
            padding: EdgeInsets.all(16.w),
            child: SearchField(
              searchController: searchteDoctorController,
              onPressed: (value) {
                BlocProvider.of<SeniorProfBloc>(context).add(SenSearchVisitDoctorEvent(value));
              },
            ),
          ),

          // 2. القائمة
          Expanded(
            child: BlocBuilder<SeniorProfBloc, SeniorProfState>(
              builder: (context, state) {
                List<NoVisitDocModel> visitDoc = context.watch<SeniorProfBloc>().visitDoc;

                if (state is SenVisitDocLoadingState) return loadingFullScreen(context);
                if (state is SenVisitDocEmptyState || visitDoc.isEmpty) return emptyFullScreen(context);
                if (state is SenVisitDocErrorState) return errorFullScreen(context, func: () {
                  BlocProvider.of<SeniorProfBloc>(context).add(VisitDocEvent(156,state.planId));
                });

                return ListView.builder(
                  padding: EdgeInsets.only(bottom: 20.h),
                  itemCount: visitDoc.length + 1,
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 10.h),
                        child: Row(
                          children: [
                            Text("إجمالي الزيارات الناجحة:", style: TextStyle(fontSize: 14.sp, color: Colors.blueGrey[600])),
                            SizedBox(width: 8.w),
                            CircleNumberWidget(number: visitDoc.length),
                          ],
                        ),
                      );
                    }
                    return VisitedDoctorCard(data: visitDoc[index - 1]);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class VisitedDoctorCard extends StatelessWidget {
  final NoVisitDocModel data;

  const VisitedDoctorCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    // 🔹 الحسابات:
    final int total = int.tryParse(data.visits ?? '0') ?? 0; // الإجمالي (مثلاً 3)
    final int remaining = data.remainingVisits ?? 0; // المتبقي (مثلاً 1)

    // الزيارات التي تمت فعلياً
    final int done = (total - remaining).clamp(0, total); // النتيجة (2)

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20.r),
          child: IntrinsicHeight(
            child: Row(
              children: [
                // شريط جانبي أخضر ليدل على الزيارات التي تمت
                Container(
                  width: 5.w,
                  color: Colors.green[400],
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(16.w),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildProfileIcon(),
                            SizedBox(width: 12.w),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    data.docTitle,
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.bold,
                                      color: const Color(0xFF0D47A1),
                                    ),
                                  ),
                                  Text(
                                    data.spTitle,
                                    style: TextStyle(fontSize: 12.sp, color: Colors.grey[600]),
                                  ),
                                ],
                              ),
                            ),
                            // عرض الزيارات التي تمت (تمت زيارتها)
                            Column(
                              children: [
                                Text("تمت زيارته", style: TextStyle(fontSize: 10.sp, color: Colors.green[700])),
                                Text(
                                  "$done",
                                  style: TextStyle(
                                    fontSize: 24.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green[800],
                                  ),
                                ),
                                Text("من أصل $total", style: TextStyle(fontSize: 9.sp, color: Colors.grey)),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 12.h),
                        _buildAddressRow(),
                        SizedBox(height: 12.h),
                        // شريط الإنجاز الفعلي
                        _buildProgressBar(done, total),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProgressBar(int done, int total) {
    double percent = total == 0 ? 0 : done / total;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10.r),
          child: LinearProgressIndicator(
            value: percent,
            backgroundColor: Colors.green[50]!,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.green[400]!),
            minHeight: 8.h,
          ),
        ),
      ],
    );
  }

  Widget _buildProfileIcon() {
    return Container(
      padding: EdgeInsets.all(8.w),
      decoration: BoxDecoration(color: const Color(0xFFF0F4F8), shape: BoxShape.circle),
      child: Icon(Icons.check_circle_outline, color: Colors.green[400], size: 24.sp),
    );
  }

  Widget _buildAddressRow() {
    return Row(
      children: [
        Icon(Icons.location_on_outlined, size: 14.sp, color: Colors.blue[300]),
        SizedBox(width: 6.w),
        Expanded(
          child: Text(
            data.address,
            style: TextStyle(fontSize: 11.sp, color: Colors.grey[600]),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}