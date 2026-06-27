import 'package:domina_app/presentation/recipes/pages/recipes_hospital.dart';
import 'package:domina_app/presentation/doctors/bloc/doctors_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:domina_app/app/di.dart';
import 'package:domina_app/presentation/uniti/stateWidget.dart';

class PrescriptionHospitalMenuWidget extends StatelessWidget {
  final int hospitalId;

  const PrescriptionHospitalMenuWidget({super.key, required this.hospitalId});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DoctorsBloc, DoctorsState>(
        listenWhen: (previous, current) {
          if (current is CheckRecipesState && current.docId == hospitalId) return true;
          if (current is CheckRecipesErrorState && current.docId == hospitalId) return true;
          return false;

        },
      listener: (context, state) {

        if (state is CheckRecipesState) {
          if (state.isCheck == true) {
            initBrandRecModule();

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => RecipesHospital(
                  HospitalId: hospitalId,
                  st: state.st,
                ),
              ),
            );

            // 💡 نصيحة احترافية: يفضل إرسال حدث للـ Bloc لتصفير الحالة (Reset State) هنا
            // لمنع تكرار فتح الشاشة عند العودة بـ Back (مثال: context.read<DoctorsBloc>().add(ResetCheckRecEvent());)

          } else {
            ScaffoldMessenger.of(context).clearSnackBars(); // تنظيف السناكبbars السابقة
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('لقد تجاوزت الحد المسموح لعدد الوصفات')),
            );
          }
        }
        if (state is CheckRecipesErrorState) {
          error(context, state.failure.massage, state.failure.code);
        }
      },
      // 2. الفحص الصارم للبناء: لا تعد بناء الـ Widget (حالة التحميل) إلا للمشفى المطلوب فقط
      buildWhen: (previous, current) {
        final bool isCurrentLoading = current is CheckRecipesLoadingState && current.docId == hospitalId;
        final bool isPreviousLoading = previous is CheckRecipesLoadingState && previous.docId == hospitalId;
        return isCurrentLoading || isPreviousLoading || current is AllHospitalsState;
      },
      builder: (context, state) {
        bool isLoading = (state is CheckRecipesLoadingState && state.docId == hospitalId);

        return PopupMenuButton<int>(
          onSelected: (value) {
            context.read<DoctorsBloc>().add(CheckReciEvent(hospitalId, value));
          },
          enabled: !isLoading,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.r)),
          offset: Offset(0, 40.h),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 8.h),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (isLoading)
                  SizedBox(
                    width: 15.sp,
                    height: 15.sp,
                    child: const CircularProgressIndicator(strokeWidth: 2, color: Colors.blue),
                  )
                else ...[
                  Text(
                    "إدارة الوصفة",
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                      fontSize: 14.sp,
                    ),
                  ),
                  SizedBox(width: 4.w),
                  Icon(Icons.keyboard_arrow_down, color: Colors.blue, size: 18.sp),
                ],
              ],
            ),
          ),
          itemBuilder: (context) => [
            _buildPopupItem(value: 0, label: "إنشاء وصفة", icon: Icons.add_box_outlined),
            _buildPopupItem(value: 1, label: "تكرار وصفة", icon: Icons.history_rounded),
          ],
        );
      },
    );
  }

  PopupMenuItem<int> _buildPopupItem({required int value, required String label, required IconData icon}) {
    return PopupMenuItem<int>(
      value: value,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(label, style: TextStyle(fontSize: 13.sp)),
          SizedBox(width: 10.w),
          Icon(icon, color: const Color(0xFF0D47A1), size: 20.sp),
        ],
      ),
    );
  }
}