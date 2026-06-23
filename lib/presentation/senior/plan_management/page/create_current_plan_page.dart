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
    context.read<PlanManagementBloc>().add(GetRepInfoEvent());
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // تبويبين: إنشاء الخطة وعرض الخطة
      child: Scaffold(
        backgroundColor: Colors.grey[50],
        appBar: AppBar(
          title: const Text(
            'إدارة خطة البراندات',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black87,
          // 🔹 إضافة شريط التبويبات السفلي للـ AppBar
          bottom:  TabBar(
            labelColor: Colors.lightGreen,
            unselectedLabelColor: Colors.black54,
            indicatorColor: Colors.lightGreen,
            indicatorWeight: 3,
            onTap: (value) {
              if (value == 0) {
                context.read<PlanManagementBloc>().add(RepPlanBrandSpEvent(RepSp(UserInfo.otherPlanId ?? -1, 38, UserInfo.repId)));
              } else {
                context.read<PlanManagementBloc>().add(RepActivePlanBrandEvent());
              }
            },
            tabs: [
              Tab(icon: Icon(Icons.edit_note), text: 'إنشاء الخطة'),
              Tab(icon: Icon(Icons.visibility), text: 'عرض الخطة'),
            ],
          ),
        ),
        body: BlocConsumer<PlanManagementBloc, PlanManagementState>(
          listener: (context, state) {
            if (state.status == PlanStatus.submitSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('تم حفظ الخطة والموافقة عليها بنجاح'),
                  backgroundColor: Colors.green,
                ),
              );
              context.read<PlanManagementBloc>().add(GetRepInfoEvent());
              FocusScope.of(context).unfocus();
            }
          },
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

            // 🚀 فحص إذا كانت قائمة البراندات فارغة لعرض الشاشة البديلة
            if (state.brands.isEmpty) {
              return const FullEmptyWidget(message: 'لا توجد خطة متاح عرضها حالياً');
            }

            return TabBarView(
              children: [
                // 1️⃣ التبويب الأول: إنشاء وتعديل الخطة
                _buildPlanTab(context, state, isReadOnly: false),

                // 2️⃣ التبويب الثاني: عرض الخطة فقط (Read Only)
                _buildPlanTab(context, state, isReadOnly: true),
              ],
            );
          },
        ),
      ),
    );
  }

  // 🔹 عنصر واجهة موحد لبناء التبويبين لتقليل تكرار الكود
  Widget _buildPlanTab(BuildContext context, PlanManagementState state, {required bool isReadOnly}) {
    // تحديد الصلاحية: لو التبويب للعرض فقط -> نقفل الحقل فوراً، وإلا نعتمد على صلاحية الـ State
    final bool currentEnable = isReadOnly ? false : state.isEnable;

    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            itemCount: state.brands.length,
            itemBuilder: (context, index) {
              final brand = state.brands[index];
              final isAssistant = brand.brandType == 1;
              final themeColor = isAssistant ? Colors.blue : Colors.deepOrange;
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
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: themeColor.withOpacity(0.08),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          isAssistant ? Icons.handshake_outlined : Icons.ads_click,
                          color: themeColor,
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
                                color: Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
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
                      SizedBox(
                        width: 90,
                        child: TextFormField(
                          enabled: currentEnable,
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                          key: ValueKey('${brand.id}_${brand.totalAmount}_$isReadOnly'),
                          initialValue: brand.totalAmount == 0 ? '' : brand.totalAmount.toString(),
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
                              borderSide: BorderSide(color: themeColor, width: 1.5),
                            ),
                            disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: Colors.grey.shade200, width: 1.5),
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

        // 🚀 زر الحفظ يظهر فقط في تاب الإنشاء وبشرط أن تكون الصفحة مفعّلة للتعديل
        if (!isReadOnly && state.isEnable)
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
                    backgroundColor: Colors.lightGreen,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  onPressed: state.status == PlanStatus.submitting
                      ? null
                      : () {
                    context.read<PlanManagementBloc>().add(SubmitPlanEvent());
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
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}

// 🔸 الـ Widget الخاص بالشاشة الفارغة لتصميم متناسق
class FullEmptyWidget extends StatelessWidget {
  final String message;
  const FullEmptyWidget({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.folder_open_outlined, size: 64, color: Colors.grey[400]),
          const SizedBox(height: 16),
          Text(
            message,
            style: TextStyle(fontSize: 16, color: Colors.grey[600], fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}