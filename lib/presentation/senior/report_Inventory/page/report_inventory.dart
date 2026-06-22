import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/senior/report_Inventory/bloc/report_inventory_bloc.dart';
import 'package:domina_app/presentation/uniti/search_field.dart';
import 'package:domina_app/presentation/uniti/stateWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InventoryCard extends StatelessWidget {
  final InventoryModel data;

  const InventoryCard({super.key, required this.data});
  Widget _buildBadge(String text, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
      decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(6.r)),
      child: Text(text,
          style: TextStyle(
              color: color, fontSize: 10.sp, fontWeight: FontWeight.bold)),
    );
  }
  @override
  Widget build(BuildContext context) {
    final int total = int.parse(data.total);
    final int used =  int.parse(data.used);
    final int rest =  data.rest;

    // نسبة التوزيع
    double usePercent = total == 0 ? 0 : used / total;
    final Color typeColor = data.type==1 ? const Color(0xFF10B981) : const Color(0xFFF59E0B);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 12.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            // الجزء العلوي: اسم المستحضر
            Container(
              padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
              decoration: BoxDecoration(
                color: ColorManager.medicalSecondary.withOpacity(0.1),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.r),
                  topRight: Radius.circular(20.r),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Icon(Icons.medication_liquid, color: ColorManager.medicalSecondary, size: 22.sp),
                        SizedBox(width: 8.w),
                        Expanded(
                          child: Text(
                            data.title,
                            style: TextStyle(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF0D47A1),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  _buildBadge(
                      data.type == 1 ? "هدف" : "مساعد", typeColor),
                ],
              ),
            ),

            // الجزء الأوسط: الأرقام (توزيع المربعات)
            Padding(
              padding: EdgeInsets.all(16.w),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildInfoItem("الكل", total.toString(), Colors.blueGrey),
                      _buildInfoItem("الموزع", used.toString(), Colors.green),
                      _buildInfoItem("المتبقي", rest.toString(), Colors.orange),
                    ],
                  ),
                  SizedBox(height: 20.h),

                  // شريط التقدم (Inventory Progress)
                  Row(
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.r),
                          child: LinearProgressIndicator(
                            value: usePercent,
                            minHeight: 8.h,
                            backgroundColor: Colors.grey[200],
                            valueColor: AlwaysStoppedAnimation<Color>(ColorManager.medicalSecondary),
                          ),
                        ),
                      ),
                      SizedBox(width: 10.w),
                      Text(
                        "${(usePercent * 100).toInt()}%",
                        style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold, color: Colors.grey[700]),
                      ),
                    ],
                  ),
                  SizedBox(height: 4.h),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "نسبة توزيع العينات من المخزون",
                      style: TextStyle(fontSize: 10.sp, color: Colors.grey),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoItem(String label, String value, Color color) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 11.sp, color: Colors.grey[600]),
        ),
        SizedBox(height: 4.h),
        Text(
          value,
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }
}
class ReportInventory extends StatelessWidget {
  ReportInventory({super.key});
  final TextEditingController searchInventoryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC), // خلفية هادئة
      appBar: AppBar(
        title: const Text('تقرير توزيع العينات (الجرد)'),
      ),
      body: bodyBuild(context),
    );
  }

  Widget bodyBuild(BuildContext context) {
    return BlocBuilder<ReportInventoryBloc, ReportInventoryState>(
      builder: (context, state) {
        if (state is SenAllInventoryState) {
          final List<InventoryModel> inventoryModel = state.inventoryModel;
          return Column(
            children: [
              // حقل البحث
              Padding(
                padding: EdgeInsets.all(16.w),
                child: SearchField(
                  searchController: searchInventoryController,
                  onPressed: (value) {
                    BlocProvider.of<ReportInventoryBloc>(context)
                        .add(SenSearchInventoryEvent(value));
                  },
                ),
              ),

              // القائمة باستخدام البطاقات الجديدة
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.only(bottom: 20.h),
                  itemCount: inventoryModel.length,
                  itemBuilder: (context, index) {
                    return InventoryCard(data: inventoryModel[index]);
                  },
                ),
              ),
            ],
          );
        }

        if (state is SenAllInventoryLoadingState) return loadingFullScreen(context);

        if (state is SenAllInventoryErrorState) {
          return errorFullScreen(context, func: () =>
              BlocProvider.of<ReportInventoryBloc>(context).add(SenAllInventoryEvent(203,state.planId)));
        }

        return const SizedBox();
      },
    );
  }
}