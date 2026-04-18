import 'package:domina_app/app/user_info.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/order/bloc/order_bloc.dart';
import 'package:domina_app/presentation/uniti/stateWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CreateOrderPage extends StatefulWidget {
  const CreateOrderPage({super.key});

  @override
  State<CreateOrderPage> createState() => _CreateOrderPageState();
}

class _CreateOrderPageState extends State<CreateOrderPage> {
  final TextEditingController _pharmacyNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<OrderBloc>().add(BrandOrderEvent());
  }

  @override
  void dispose() {
    _pharmacyNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FB),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "إنشاء طلبية جديدة",
          style: TextStyle(
            color: const Color(0xFF0D47A1),
            fontWeight: FontWeight.bold,
            fontSize: 18.sp,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF0D47A1)),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.w),
        child: Column(
          children: [
            // 1. بطاقة المكافأة (ثابتة)
            _buildRewardCard(),

            SizedBox(height: 25.h),

            // 2. حاوية المدخلات
            Container(
              padding: EdgeInsets.all(20.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.r),
                border: Border.all(color: Colors.blue.shade50),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  _buildLabel("اسم الصيدلية"),
                  _buildTextField("أدخل اسم الصيدلية..."),
                  SizedBox(height: 20.h),
                  _buildLabel("اختر الأدوية"),
                  _buildDropdownField("اختر دواء من القائمة..."),
                  SizedBox(height: 20.h),
                  const Divider(),
                  _buildSelectedItemsList(),
                ],
              ),
            ),

            SizedBox(height: 25.h),

            // 3. زر تأكيد الطلبية النهائي
            _buildConfirmButton(),
          ],
        ),
      ),
    );
  }

  // بطاقة المكافأة
  Widget _buildRewardCard() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFFFB74D), Color(0xFFFB8C00)],
        ),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text("المكافأة الإجمالية لهذا الشهر",
              style: TextStyle(color: Colors.white, fontSize: 14.sp)),
          Text("7,500 ل.س",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  // عرض القائمة المختارة
  Widget _buildSelectedItemsList() {
    return BlocBuilder<OrderBloc, OrderState>(
      builder: (context, state) {
        List<OrderDetails> items = [];
        if (state is BrandOrderState) {
          items = state.selectedItems;
        }

        if (items.isEmpty) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 20.h),
            child: Center(
              child: Text("لم يتم اختيار أي أدوية بعد",
                  style: TextStyle(
                      color: Colors.grey.shade400,
                      fontSize: 14.sp,
                      fontStyle: FontStyle.italic)),
            ),
          );
        }

        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];
            return Card(
              color: const Color(0xFFF0F4F8),
              elevation: 0,
              margin: EdgeInsets.symmetric(vertical: 5.h),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.r)),
              child: ListTile(
                title: Text(item.brandName,
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 14.sp)),
                subtitle: Text("الكمية: ${item.quantity}"),
                leading: IconButton(
                  icon:
                      const Icon(Icons.delete_outline, color: Colors.redAccent),
                  onPressed: () {
                    context
                        .read<OrderBloc>()
                        .add(RemoveItemFromOrderEvent(index));
                  },
                ),
                trailing: const Icon(Icons.medical_services_outlined,
                    color: Colors.blue),
              ),
            );
          },
        );
      },
    );
  }

  // حقل الدروب داون
  Widget _buildDropdownField(String hint) {
    return BlocBuilder<OrderBloc, OrderState>(
      builder: (context, state) {
        List<BrandModel> brands = [];
        if (state is BrandOrderState) {
          brands = state.brands;
        }

        return Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          decoration: BoxDecoration(
            color: const Color(0xFFF0F4F8),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<int>(
              isExpanded: true,
              hint: Text(hint,
                  style: TextStyle(fontSize: 13.sp, color: Colors.black)),
              icon: const Icon(Icons.keyboard_arrow_down),
              items: brands.map((brand) {
                return DropdownMenuItem<int>(
                  value: brand.id,
                  child: Text(
                    brand.title,
                    textAlign: TextAlign.right,
                    style: TextStyle(color: Colors.black),
                  ),
                );
              }).toList(),
              onChanged: (selectedId) {
                if (selectedId != null) {
                  final brand =
                      brands.firstWhere((element) => element.id == selectedId);
                  _showQuantityDialog(brand);
                }
              },
            ),
          ),
        );
      },
    );
  }

  // نافذة تحديد الكمية
  void _showQuantityDialog(BrandModel brand) {
    final TextEditingController qtyController =
        TextEditingController(text: "1");
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("تحديد الكمية لـ ${brand.title}",
            textAlign: TextAlign.center, style: TextStyle(fontSize: 16.sp)),
        content: TextField(
          controller: qtyController,
          keyboardType: TextInputType.number,
          textAlign: TextAlign.center,
          decoration: const InputDecoration(hintText: "أدخل العدد"),
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("إلغاء")),
          ElevatedButton(
            onPressed: () {
              int qty = int.tryParse(qtyController.text) ?? 1;
              context.read<OrderBloc>().add(AddItemToOrderEvent(
                    OrderDetails(
                      brand.id,
                      qty,
                      brand.title,
                    ),
                  ));
              Navigator.pop(context);
            },
            child: const Text("إضافة"),
          )
        ],
      ),
    );
  }

  // زر التأكيد النهائي
  Widget _buildConfirmButton() {
    return BlocConsumer<OrderBloc, OrderState>(
      listener: (context, state) {
        if (state is PharmacyOrderLoadingState) {
          loading(context);
        } else if (state is PharmacyOrderErrorState) {
          error(context, state.failure.massage, state.failure.code);
        } else if (state is PharmacyOrderState) {
          success(context);
         Navigator.pop(context);
        }

      },
      builder: (context, state) {
        return SizedBox(
          width: double.infinity,
          height: 55.h,
          child: ElevatedButton.icon(
            onPressed: () {
              if (_pharmacyNameController.text.isEmpty) {
                _showSnackBar("يرجى إدخال اسم الصيدلية");
                return;
              }

              if (state is BrandOrderState && state.selectedItems.isNotEmpty) {
                final requestBody = PharmacyOrderRequestBody(
                  orderModel(
                    UserInfo.repId,
                    _pharmacyNameController.text,
                    DateTime.now().toIso8601String(),
                    0,
                  ),
                  state.selectedItems,
                );
                context.read<OrderBloc>().add(PharmacyOrderEvent(requestBody));
              } else {
                _showSnackBar("يرجى اختيار دواء واحد على الأقل");
              }
            },
            icon: const Icon(Icons.shopping_bag_outlined, color: Colors.white),
            label: Text("تأكيد الطلبية",
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold)),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF0D47A1),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.r)),
            ),
          ),
        );
      },
    );
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Text(text,
          style: TextStyle(
              color: const Color(0xFF0D47A1),
              fontWeight: FontWeight.bold,
              fontSize: 14.sp)),
    );
  }

  Widget _buildTextField(String hint) {
    return TextField(
      controller: _pharmacyNameController,
      textAlign: TextAlign.right,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: const Color(0xFFF0F4F8),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: BorderSide.none),
      ),
    );
  }
}
