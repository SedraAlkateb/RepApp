import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/senior/plan_management/bloc/plan_management_bloc.dart';
import 'package:domina_app/presentation/uniti/search_field.dart';
import 'package:domina_app/presentation/uniti/stateWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreatePlanBrandPage extends StatefulWidget {
  const CreatePlanBrandPage({super.key});

  @override
  State<CreatePlanBrandPage> createState() => _CreatePlanBrandPageState();
}

class _CreatePlanBrandPageState extends State<CreatePlanBrandPage> {
  final TextEditingController searchController = TextEditingController();

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  // 📝 دالة إظهار نافذة التأكيد قبل الإرسال
  void _showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false, // يمنع إغلاق النافذة عند الضغط خارجها لضمان التركيز
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20), // زوايا دائرية متناسقة مع الكروت
          ),
          title: Row(
            children: [
              Icon(Icons.help_outline, color: ColorManager.medicalPrimary, size: 28),
              const SizedBox(width: 10),
              const Text(
                'تأكيد إرسال الخطة',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ],
          ),
          content: const Text(
            'هل أنت متأكد من حفظ التعديلات وإرسال الخطة المستقبلية ؟',
            style: TextStyle(fontSize: 14, color: Colors.black87, height: 1.5),
          ),
          actions: [
            // زر التراجع (لا)
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.grey[600],
              ),
              onPressed: () {
                Navigator.of(dialogContext).pop(); // إغلاق النافذة فقط والتراجع
              },
              child: const Text(
                'تراجع',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
            ),
            // زر التأكيد (نعم)
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorManager.medicalPrimary,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              onPressed: () {
                Navigator.of(dialogContext).pop(); // إغلاق النافذة أولاً
                // إطلاق حدث الإرسال والحفظ في الـ Bloc من خلال الـ context الأصلي للصفحة
                context.read<PlanManagementBloc>().add(SubmitPlanEvent());
              },
              child: const Text(
                'نعم، إرسال',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PlanManagementBloc, PlanManagementState>(
      listener: (context, state) {
        if (state.futureStatus == PlanStatus.submitSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('تم حفظ الخطة والموافقة عليها بنجاح'),
              backgroundColor: Colors.green,
            ),
          );
          context.read<PlanManagementBloc>().add(GetRepInfoEvent());
          searchController.clear();
          FocusScope.of(context).unfocus();
        }
      },
      builder: (context, state) {
        if (state.futureStatus == PlanStatus.loading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state.futureStatus == PlanStatus.error) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.error_outline, size: 48, color: Colors.red[300]),
                const SizedBox(height: 12),
                Text(
                  state.futureFailure?.massage ?? "حدث خطأ غير متوقع",
                  style: const TextStyle(color: Colors.black54, fontSize: 15),
                ),
              ],
            ),
          );
        }

        final bool currentEnable = state.isEnable;
        final List<PlanBrandSp> displayBrands = state.searchFutureBrands;

        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
              child: SearchField(
                searchController: searchController,
                onPressed: (value) {
                  context.read<PlanManagementBloc>().add(SearchPlanBrandEvent(value));
                },
              ),
            ),
            Expanded(
              child: displayBrands.isEmpty
                  ? emptyFullScreen(context, message: 'لا توجد نتائج مطابقة للبحث')
                  : ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                itemCount: displayBrands.length,
                itemBuilder: (context, index) {
                  final brand = displayBrands[index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.03),
                          spreadRadius: 1,
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: brand.brandType.color.withOpacity(0.08),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              brand.brandType.i == 2 ? Icons.handshake_outlined : Icons.ads_click,
                              color: brand.brandType.color,
                              size: 22,
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  brand.titleAr,
                                  style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black87),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  brand.phTitle,
                                  style: const TextStyle(fontSize: 12, color: Colors.black54),
                                ),
                                const SizedBox(height: 6),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: brand.brandType.color.withOpacity(0.12),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    brand.brandType.name,
                                    style: TextStyle(
                                        color: brand.brandType.color,
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 90,
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                              key: ValueKey('${brand.id}_create'),
                              initialValue: brand.totalAmount == 0 ? '' : brand.totalAmount.toString(),
                              enabled: currentEnable,
                              decoration: InputDecoration(
                                hintText: '0',
                                contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                                filled: true,
                                fillColor: currentEnable ? Colors.grey[50] : Colors.grey[100],
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(color: Colors.grey.shade200, width: 1.5),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(
                                      color: brand.brandType.color , width: 1.5),
                                ),
                              ),
                              onChanged: (val) {
                                final qty = int.tryParse(val) ?? 0;
                                context.read<PlanManagementBloc>().add(
                                  UpdateBrandQuantityEvent(index: index, quantity: qty),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            if (state.isEnable)
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(color: Colors.black.withOpacity(0.04), offset: const Offset(0, -4), blurRadius: 12),
                  ],
                ),
                child: SafeArea(
                  child: SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorManager.medicalPrimary,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                      ),
                      // 💡 تعديل هنا: استدعاء دالة التأكيد بدلاً من الحفظ المباشر
                      onPressed: state.futureStatus == PlanStatus.submitting
                          ? null
                          : () => _showConfirmationDialog(context),
                      child: state.futureStatus == PlanStatus.submitting
                          ? const SizedBox(
                        height: 24,
                        width: 24,
                        child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2.5),
                      )
                          : const Text('حفظ الخطة والموافقة النهائية',
                          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}