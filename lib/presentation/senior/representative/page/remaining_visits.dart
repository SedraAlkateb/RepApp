import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/resources/values_manager.dart';
import 'package:domina_app/presentation/senior/representative/bloc/senior_prof_bloc.dart';
import 'package:domina_app/presentation/senior/representative/widget/no_visit_doc_card.dart';
import 'package:domina_app/presentation/uniti/search_field.dart';
import 'package:domina_app/presentation/uniti/stateWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RemainingVisits extends StatelessWidget {
  RemainingVisits({super.key});
  final TextEditingController searchNoteDoctorController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("عدد زيارات الأطباء المتبقية"),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Icon(
                size: AppSize.s30,
                Icons.arrow_back_sharp,
                color: ColorManager.secondaryColor1,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            );
          },
        ),
      ),
      // داخل الـ build الخاص بصفحة RemainingVisits

      body: Column(
        children: [
          // 1. حقل البحث
          Padding(
            padding: EdgeInsets.all(16.w),
            child: SearchField(
              searchController: searchNoteDoctorController,
              onPressed: (value) {
                BlocProvider.of<SeniorProfBloc>(context)
                    .add(SenSearchNoVisitDoctorEvent(value));
              },
            ),
          ),

          // 2. القائمة باستخدام الـ ListView والـ Card الجديد الموحد
          Expanded(
            child: BlocBuilder<SeniorProfBloc, SeniorProfState>(
              builder: (context, state) {
                List<NoVisitDocModel> noVisitDoc =
                    context.watch<SeniorProfBloc>().noVisitDoc;

                if (state is SenNoVisitDocsState) {
                  noVisitDoc = state.noVisitDoc;
                }

                // حالات الواجهة (Loading, Error, Empty)
                if (state is SenNoVisitDocLoadingState)
                  return loadingFullScreen(context);
                if (state is SenNoVisitDocEmptyState || noVisitDoc.isEmpty)
                  return emptyFullScreen(context);
                if (state is SenNoVisitDocErrorState)
                  return errorFullScreen(context);

                // عرض القائمة باستخدام الـ ListView.builder (الأفضل للأداء)
                return ListView.builder(
                  padding: EdgeInsets.only(bottom: 16.h),
                  itemCount: noVisitDoc.length,
                  itemBuilder: (context, index) {
                    // نمرر الموديل للبطاقة الموحدة وهي تتكفل بالرسم وحساب النسبة
                    return RemainingVisitCard(data: noVisitDoc[index]);
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
