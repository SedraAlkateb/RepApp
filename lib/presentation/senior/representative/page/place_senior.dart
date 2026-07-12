import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/senior/representative/bloc/senior_prof_bloc.dart';
import 'package:domina_app/presentation/uniti/stateWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PlaceSenior extends StatelessWidget {
  PlaceSenior({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('المناطق المتاحة'),
      ),
      body: bodyBuild(context),
    );
  }

  Widget bodyBuild(BuildContext context) {
    return BlocBuilder<SeniorProfBloc, SeniorProfState>(
      builder: (context, state) {
        if (state is SenAllPlaceState) {
          final List<PlaceModel> placeModel = state.places;

          return
            placeModel.isEmpty?emptyFullScreen(context):
            ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            itemCount: placeModel.length,
            itemBuilder: (context, index) {
              return _buildPlaceCard(context, placeModel[index]);
            },
          );
        }

        if (state is SenAllPlaceLoadingState) {
          return loadingFullScreen(context);
        }

        if (state is SenAllPlaceErrorState) {
          return errorFullScreen(
            context,
            func: () => BlocProvider.of<SeniorProfBloc>(context).add(SenAllPlaceEvent(203)),
          );
        }

        return const SizedBox();
      },
    );
  }

  Widget _buildPlaceCard(BuildContext context, PlaceModel place) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: Colors.grey.withOpacity(0.1)),
      ),
      child: Material( // إضافة تأثير الضغط (InkWell)
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16.r),
          onTap: () {
            // هنا يمكنك إضافة منطق عند الضغط على المنطقة
          },
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
            child: Row(
              children: [
                // أيقونة الموقع بخلفية دائرية خفيفة
                Container(
                  padding: EdgeInsets.all(10.w),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE3F2FD),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.location_on_rounded,
                    color: const Color(0xFF1E88E5),
                    size: 24.sp,
                  ),
                ),
                SizedBox(width: 16.w),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "اسم المنطقة",
                        style: TextStyle(
                          fontSize: 10.sp,
                          color: Colors.grey[500],
                          letterSpacing: 0.5,
                        ),
                      ),
                      Text(
                        place.title,
                        style: TextStyle(
                          fontSize: 17.sp,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF263238),
                        ),
                      ),
                    ],
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
