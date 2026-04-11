import 'package:domina_app/app/user_info.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/order/bloc/order_bloc.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CreateOrderPage extends StatefulWidget {
  CreateOrderPage({super.key});

  @override
  State<CreateOrderPage> createState() => _CreateOrderPageState();
}

class _CreateOrderPageState extends State<CreateOrderPage> {

  @override
  void initState() {
    BlocProvider.of<OrderBloc>(context).add(BrandOrderEvent());
    super.initState();
  }

  final TextEditingController _pharmacyNameController = TextEditingController();

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
            // 1. بطاقة المكافأة البرتقالية (Gradient Card)
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(20.w),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFFFFB74D), Color(0xFFFB8C00)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.orange.withOpacity(0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  )
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "المكافأة الإجمالية لهذا الشهر",
                    style: TextStyle(color: Colors.white, fontSize: 14.sp),
                  ),
                  SizedBox(height: 5.h),
                  Text(
                    "7,500 ل.س",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 25.h),

            // 2. حاوية المدخلات (Form Container)
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
                  // اسم الصيدلية
                  _buildLabel("اسم الصيدلية"),
                  _buildTextField("أدخل اسم الصيدلية..."),

                  SizedBox(height: 20.h),

                  // اختر الأدوية
                  _buildLabel("اختر الأدوية"),
                  _buildDropdownField("اختر دواء من القائمة..."),

                  SizedBox(height: 30.h),

                  // أضف هذا الـ Widget داخل الـ Column تحت حاوية المدخلات
                  BlocBuilder<OrderBloc, OrderState>(
                    builder: (context, state) {
                      if (state.selectedItems.isEmpty) {
                        return Center(
                          child: Text("لم يتم اختيار أي أدوية بعد",
                              style: TextStyle(color: Colors.grey.shade400, fontSize: 14.sp)),
                        );
                      }
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: state.selectedItems.length,
                        itemBuilder: (context, index) {
                          final item = state.selectedItems[index];
                          // نجد اسم البراند من الـ item أو نكون قد خزنناه
                          return Card(
                            margin: EdgeInsets.only(bottom: 10.h),
                            child: ListTile(
                              title: Text(item.brandName), // ستحتاج إضافة الاسم للموديل أو البحث عنه
                              subtitle: Text("الكمية: ${item.quantity}"),
                              leading: IconButton(
                                icon: const Icon(Icons.delete, color: Colors.red),
                                onPressed: () {
                                  context.read<OrderBloc>().add(RemoveItemFromOrderEvent(item.brandId));
                                },
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),

            SizedBox(height: 25.h),

            // 3. زر تأكيد الطلبية
            SizedBox(
              width: double.infinity,
              height: 55.h,
              child: ElevatedButton.icon(
                onPressed: () {
                  // 1. إنشاء بيانات الطلبية الأساسية (Order Model)
                  orderModel fakeOrder = orderModel(
                    UserInfo.repId, // repId (رقم المندوب)
                    _pharmacyNameController.text, // اسم الصيدلية
                    DateTime.now().toIso8601String(), // تاريخ اليوم
                    0, // الحالة (مثلاً 0 تعني قيد الانتظار)
                  );

                  // 2. إنشاء قائمة بتفاصيل الأدوية (Order Details)
                  List<OrderDetails> fakeDetails = [
                    OrderDetails(101, 5), // الدواء رقم 101، الكمية 5
                    OrderDetails(102, 12), // الدواء رقم 102، الكمية 12
                    OrderDetails(105, 3), // الدواء رقم 105، الكمية 3
                  ];

                  // 3. تجميعهم في كائن الطلب النهائي (Request Body)
                  PharmacyOrderRequestBody requestBody =
                  PharmacyOrderRequestBody(fakeOrder, fakeDetails);

                  // 4. إرسال الايفنت مع البيانات الوهمية
                  context.read<OrderBloc>().add(
                      PharmacyOrderEvent(requestBody));

                  // اختياري: إظهار رسالة تأكيد في الكونسول للتأكد من البيانات
                  print("تم إرسال الطلبية لـ: ${requestBody.order.pharmacy}");
                  print("عدد الأصناف: ${requestBody.orderDetails.length}");
                },
                icon: const Icon(Icons.shopping_bag_outlined,
                    color: Colors.white),
                label: Text(
                  "تأكيد الطلبية",
                  style:
                  TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                  const Color(0xFF81A1C1), // لون أزرق رمادي كما في الصورة
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.r),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      // زر التحديث العائم
    );
  }

  // ويدجت لبناء العناوين الجانبية
  Widget _buildLabel(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Text(
        text,
        style: TextStyle(
          color: const Color(0xFF0D47A1),
          fontWeight: FontWeight.bold,
          fontSize: 14.sp,
        ),
      ),
    );
  }

  // ويدجت لبناء حقل النص
  Widget _buildTextField(String hint) {
    return TextField(
      controller: _pharmacyNameController,
      textAlign: TextAlign.right,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: Colors.grey.shade300, fontSize: 13.sp),
        filled: true,
        fillColor: const Color(0xFFF0F4F8),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _buildDropdownField(String hint) {
    return BlocBuilder<OrderBloc, OrderState>(
      builder: (context, state) {
        // 1. جلب القائمة من الـ State (افترضنا أن الحالة الناجحة تحتوي على brands)
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
            child: DropdownButton<int>( // نستخدم int لأنه يمثل الـ ID الخاص بالدواء
              isExpanded: true,
              hint: Text(hint,
                  style: TextStyle(
                    fontSize: 13.sp,color: ColorManager.black)),
              icon: const Icon(Icons.keyboard_arrow_down),

              // 2. تحويل قائمة الأدوية إلى DropdownMenuItems
              items: brands.map((brand) {
                return DropdownMenuItem<int>(
                  value: brand.id, // القيمة البرمجية (ID)
                  child: Text(
                    brand.title, // الاسم الذي يظهر للمستخدم
                    textAlign: TextAlign.right,
                    style: TextStyle(fontSize: 14.sp,color: ColorManager.black),
                  ),
                );
              }).toList(),

              onChanged: (selectedId) {
                // if (selectedId != null) {
                //   context.read<OrderBloc>().add(AddItemToOrderEvent(
                //  [
                //    OrderDetails(selectedId, quantity)
                //  ]
                //   ,
                //     brands,
                //
                //
                //   ));
                //   print("تم اختيار الدواء ذو الرقم: $selectedId");
                // }
              },
            ),
          ),
        );
      },
    );
  }
}
