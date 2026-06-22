import 'package:domina_app/app/user_info.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/senior/plan_management/bloc/plan_management_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateCurrentPlanPage extends StatefulWidget {
  const CreateCurrentPlanPage({super.key});

  @override
  State<CreateCurrentPlanPage> createState() => _CreateCurrentPlanPageState();
}

class _CreateCurrentPlanPageState extends State<CreateCurrentPlanPage> {
  @override
  void initState() {
    super.initState();
    print(UserInfo.endDate);
    context.read<PlanManagementBloc>().add(
          RepPlanBrandSpEvent(
              RepSp(UserInfo.otherPlanId ?? -1, 38, UserInfo.repId)),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50], // خلفية ناعمة تعطي عمقاً للكروت
      appBar: AppBar(
        title: const Text(
          'إدخال كميات البراندات',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
      ),
      body: BlocBuilder<PlanManagementBloc, PlanManagementState>(
        builder: (context, state) {
          if (state.status == PlanStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.status == PlanStatus.error) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, size: 48, color: Colors.red[300]),
                  const SizedBox(height: 12),
                  Text(
                    state.failure?.massage ?? "حدث خطأ غير متوقع",
                    style: const TextStyle(color: Colors.black54, fontSize: 15),
                  ),
                ],
              ),
            );
          }

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  itemCount: state.brands.length,
                  itemBuilder: (context, index) {
                    final brand = state.brands[index];
                    final isAssistant = brand.brandType == 1;

                    // تخصيص الألوان والهوية البصرية بناءً على النوع
                    final themeColor =
                        isAssistant ? Colors.blue : Colors.deepOrange;
                    final badgeText = isAssistant ? 'براند مساعد' : 'براند هدف';

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
                            // أيقونة دلالية بجانب النص
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: themeColor.withOpacity(0.08),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                isAssistant
                                    ? Icons.handshake_outlined
                                    : Icons.ads_click,
                                color: themeColor,
                                size: 22,
                              ),
                            ),
                            const SizedBox(width: 14),

                            // النصوص والتفاصيل
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    brand.titleAr,
                                    style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  // شارة التصنيف الأنيقة (Badge)
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: themeColor.withOpacity(0.12),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Text(
                                      badgeText,
                                      style: TextStyle(
                                        color: themeColor,
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            // حقل إدخال الكمية المطور
                            SizedBox(
                              width: 90,
                              child: TextFormField(
                                enabled: ((UserInfo.repType=="5")&&(UserInfo.otherstatus==5))

                                ,
                                keyboardType: TextInputType.number,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                                initialValue: brand.totalAmount == 0
                                    ? ''
                                    : brand.totalAmount.toString(),
                                decoration: InputDecoration(
                                  hintText: '0',
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 8),
                                  filled: true,
                                  fillColor: Colors.grey[50],
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide(
                                        color: Colors.grey.shade200,
                                        width: 1.5),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide(
                                        color: themeColor, width: 1.5),
                                  ),
                                ),
                                onChanged: (val) {
                                  final qty = int.tryParse(val) ?? 0;
                                  context.read<PlanManagementBloc>().add(
                                        UpdateBrandQuantityEvent(
                                            index: index, quantity: qty),
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

              // حاوية الزر السفلي المدمجة مع الشاشة
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.04),
                      offset: const Offset(0, -4),
                      blurRadius: 12,
                    ),
                  ],
                ),
                child: SafeArea(
                  child: SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors
                            .lightGreen, // لون أخضر مريح يدل على الإجراء الإيجابي
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      onPressed: state.status == PlanStatus.submitting
                          ? null
                          : () {
                              context
                                  .read<PlanManagementBloc>()
                                  .add(SubmitPlanEvent());
                            },
                      child: state.status == PlanStatus.submitting
                          ? const SizedBox(
                              height: 24,
                              width: 24,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2.5,
                              ),
                            )
                          : const Text(
                              'إضافة والموافقة النهائية',
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
