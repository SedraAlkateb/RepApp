import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/senior/representative/bloc/senior_prof_bloc.dart';
import 'package:domina_app/presentation/uniti/circle_number_widget.dart';
import 'package:domina_app/presentation/uniti/search_field.dart';
import 'package:domina_app/presentation/uniti/stateWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
class NoVisitDoctor extends StatelessWidget {
  NoVisitDoctor({super.key});
  final TextEditingController searchNoteDoctorController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: const Text('أطباء لم يتم زيارتهم'),
      ),
      body: Column(
        children: [
          // حقل البحث
          Padding(
            padding: EdgeInsets.all(16.w),
            child: SearchField(
              searchController: searchNoteDoctorController,
              onPressed: (value) {
                BlocProvider.of<SeniorProfBloc>(context).add(SenSearchNoVisitDoctorEvent(value));
              },
            ),
          ),

          // القائمة
          Expanded(
            child: BlocBuilder<SeniorProfBloc, SeniorProfState>(
              builder: (context, state) {
                List<NoVisitDocModel> noVisitDoc = context.watch<SeniorProfBloc>().noVisitDoc;

                if (state is SenNoVisitDocLoadingState) return loadingFullScreen(context);
                if (state is SenNoVisitDocEmptyState || noVisitDoc.isEmpty) return emptyFullScreen(context);
                if (state is SenNoVisitDocErrorState) return errorFullScreen(context, func: () {
                  BlocProvider.of<SeniorProfBloc>(context).add(NoVisitDocEvent(156));
                });

                return ListView.builder(
                  padding: EdgeInsets.only(bottom: 20.h),
                  itemCount: noVisitDoc.length + 1,
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return Padding(
                        padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 12.h),
                        child: Row(
                          children: [
                            Text("عدد الأطباء:", style: TextStyle(fontSize: 14.sp, color: Colors.blueGrey)),
                            SizedBox(width: 8.w),
                            CircleNumberWidget(number: noVisitDoc.length),
                          ],
                        ),
                      );
                    }
                    return NoVisitDoctorCard(data: noVisitDoc[index - 1]);
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
class NoVisitDoctorCard extends StatelessWidget {
  final NoVisitDocModel data;

  const NoVisitDoctorCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    // إجمالي الزيارات المطلوبة
    final String totalRequired = data.visits ?? '0';

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
                // شريط جانبي بلون مختلف (مثلاً رمادي أو أزرق خفيف) ليدل على "لم يبدأ"
                Container(
                  width: 5.w,
                  color: Colors.blueGrey[200],
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(16.w),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // أيقونة المستخدم يمين
                            _buildProfileIcon(),
                            SizedBox(width: 12.w),
                            // بيانات الطبيب
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
                                  Row(
                                    children: [
                                      Text(data.spTitle, style: TextStyle(fontSize: 12.sp, color: Colors.grey[600])),
                                      SizedBox(width: 8.w),
                                      _buildRateBadge(data.rate),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            // عداد الزيارات المطلوبة (يسار)
                            Column(
                              children: [
                                Text("المطلوب", style: TextStyle(fontSize: 9.sp, color: Colors.grey)),
                                Text(
                                  totalRequired,
                                  style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold, color: Colors.blueGrey[700]),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 12.h),
                        // العنوان
                        _buildAddressRow(),
                        SizedBox(height: 10.h),
                        // شريط حالة (فارغ ليدل على عدم البدء)
                        _buildEmptyProgress(),
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

  Widget _buildEmptyProgress() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("لم يتم البدء بالزيارات بعد", style: TextStyle(fontSize: 10.sp, color: Colors.orange[700])),
        SizedBox(height: 4.h),
        ClipRRect(
          borderRadius: BorderRadius.circular(10.r),
          child: LinearProgressIndicator(
            value: 0, // 0 يعني لم يتم إنجاز شيء
            backgroundColor: const Color(0xFFF1F4F8),
            minHeight: 6.h,
          ),
        ),
      ],
    );
  }

  Widget _buildProfileIcon() {
    return Container(
      padding: EdgeInsets.all(8.w),
      decoration: BoxDecoration(color: const Color(0xFFF0F4F8), shape: BoxShape.circle),
      child: Icon(Icons.person_pin_rounded, color: const Color(0xFF90A4AE), size: 24.sp),
    );
  }

  Widget _buildRateBadge(String rate) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
      decoration: BoxDecoration(color: const Color(0xFFE8F5E9), borderRadius: BorderRadius.circular(5.r)),
      child: Text(rate, style: TextStyle(fontSize: 10.sp, color: Colors.green[700], fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildAddressRow() {
    return Row(
      children: [
        Icon(Icons.map_outlined, size: 14.sp, color: Colors.blue[300]),
        SizedBox(width: 6.w),
        Expanded(child: Text(data.address, style: TextStyle(fontSize: 12.sp, color: Colors.grey[600]))),
      ],
    );
  }
}

