import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/senior/representative/bloc/senior_prof_bloc.dart';
import 'package:domina_app/presentation/uniti/search_field.dart';
import 'package:domina_app/presentation/uniti/stateWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class DoctorSenior extends StatelessWidget {
  DoctorSenior({super.key});
  final TextEditingController searchDocController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: const Text('الأطباء'),
      ),
      // استخدم Column مع Expanded بدلاً من SingleChildScrollView
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            child: SearchField(
              searchController: searchDocController,
              onPressed: (value) {
                BlocProvider.of<SeniorProfBloc>(context)
                    .add(SenSearchDoctorEvent(value));
              },
            ),
          ),
          Expanded(
            child: BlocBuilder<SeniorProfBloc, SeniorProfState>(
              // أضفنا الحالات التي يجب أن يحدث فيها إعادة بناء للواجهة
              buildWhen: (previous, current) =>
              current is SenAllDoctorsState ||
                  current is SenAllDoctorEmptyState ||
                  current is SenAllDoctorLoadingState ||
                  current is SenAllDoctorErrorState,
              builder: (context, state) {

                // 1. تحديد أي قائمة سنعرض (المفلترة من السيرش أم الكاملة)
                List<DoctorModel> doctorsList = [];

                if (state is SenAllDoctorsState) {
                  doctorsList = state.doctor; // القائمة المفلترة القادمة من البحث
                } else {
                  // القائمة الكاملة الموجودة في الـ Bloc (نستخدم read وليس watch هنا)
                  doctorsList = context.read<SeniorProfBloc>().doctor;
                }

                // 2. حالات الواجهة
                if (state is SenAllDoctorLoadingState) return loadingFullScreen(context);
                if (state is SenAllDoctorEmptyState || doctorsList.isEmpty) return emptyFullScreen(context);
                if (state is SenAllDoctorErrorState) return errorFullScreen(context);

                // 3. عرض النتائج
                return ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                  itemCount: doctorsList.length,
                  itemBuilder: (context, index) {
                    return AdminRepDoctorCard(doctor: doctorsList[index]);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}class AdminRepDoctorCard extends StatelessWidget {
  final DoctorModel doctor;

  const AdminRepDoctorCard({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.h, horizontal: 4.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(25.r),
        child: IntrinsicHeight(
          child: Row(
            children: [

              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(16.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header: الاسم، التخصص، والأيقونة
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          SizedBox(width: 10.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  doctor.title,
                                  style: TextStyle(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.bold,
                                    color: const Color(0xFF0D47A1),
                                  ),
                                ),
                                Text(
                                  doctor.spTitle,
                                  style: TextStyle(fontSize: 14.sp, color: Colors.grey[600]),
                                ),
                              ],
                            ),
                          ),
                          _buildRatingBadge(doctor.rate),
                        ],
                      ),
                      SizedBox(height: 15.h),

                      // شبكة المعلومات: المكان والزيارات
                      Row(
                        children: [
                          _buildInfoBox("المكان", doctor.placeTitle, Icons.location_on_outlined),
                          SizedBox(width: 10.w),
                          _buildInfoBox("الزيارات", "${doctor.visits} زيارة", Icons.calendar_month_outlined),
                        ],
                      ),
                      SizedBox(height: 12.h),

                      // تفاصيل العنوان والوقت
                      _buildDetailRow(Icons.map_outlined, doctor.address),
                      if (doctor.workHours != null && doctor.workHours!.isNotEmpty)
                        _buildDetailRow(Icons.access_time, doctor.workHours!),

                      SizedBox(height: 15.h),

                      // ملاحظات المدير (صندوق ملون)
                      if (doctor.note != null && doctor.note!.isNotEmpty)
                        Container(
                          padding: EdgeInsets.all(12.w),
                          decoration: BoxDecoration(
                            color: const Color(0xFFE3F2FD),
                            borderRadius: BorderRadius.circular(15.r),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.info_outline, color: Color(0xFF1976D2), size: 20),
                              SizedBox(width: 8.w),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text("ملاحظات المدير", style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF1976D2))),
                                    Text(doctor.note!, style: TextStyle(fontSize: 12.sp, color: Colors.blueGrey[800])),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRatingBadge(String? rate) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(color: const Color(0xFFFFECB3), borderRadius: BorderRadius.circular(8.r)),
      child: Text(rate ?? "A", style: const TextStyle(color: Color(0xFFFFA000), fontWeight: FontWeight.bold)),
    );
  }



  Widget _buildInfoBox(String label, String value, IconData icon) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(10.w),
        decoration: BoxDecoration(color: const Color(0xFFF5F7FA), borderRadius: BorderRadius.circular(12.r)),
        child: Column(
          children: [
            Text(label, style: TextStyle(fontSize: 10.sp, color: Colors.grey)),
            Text(value, style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF263238)), textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 4.h),
      child: Row(
        children: [
          Icon(icon, size: 16, color: Colors.blue[300]),
          SizedBox(width: 8.w),
          Expanded(child: Text(text, style: TextStyle(fontSize: 12.sp, color: Colors.grey[700]))),
        ],
      ),
    );
  }
}