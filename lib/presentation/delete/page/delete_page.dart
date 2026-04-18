
import 'package:domina_app/presentation/delete/bloc/delete_bloc.dart';
import 'package:domina_app/presentation/resources/routes_manager.dart';
import 'package:domina_app/presentation/resources/values_manager.dart';
import 'package:domina_app/presentation/uniti/stateWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lucide_icons/lucide_icons.dart';

class DeletePage extends StatefulWidget {
  const DeletePage({super.key});

  @override
  State<DeletePage> createState() => _DeletePageState();
}

class _DeletePageState extends State<DeletePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // 1. الشريط الجانبي الرمادي المميز للديزاين
          Positioned(
            right: 0,
            top: 100.h,
            bottom: 100.h,
            child: Container(
              width: 8.w,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.horizontal(left: Radius.circular(10.r)),
              ),
            ),
          ),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: AppPaddingW.p40),
            child: SingleChildScrollView(
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center, // جعل المحتوى في المنتصف
                  children: [
                    SizedBox(height: 120.h), // مسافة علوية متناسبة

                    // 2. الرسم التوضيحي (حاوية الدائرة مع أيقونات الحذف)
                    Container(
                      width: 260.w,
                      height: 260.w,
                      decoration: const BoxDecoration(
                        color: Color(0xFFF8F9FB),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(LucideIcons.user, size: 70, color: Color(0xFF1A3E62)),
                            Stack(
                              clipBehavior: Clip.none,
                              children: [
                                const Icon(LucideIcons.monitor, size: 100, color: Color(0xFF1A3E62)),
                                Positioned(
                                  top: 15,
                                  right: -5,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                                    color: const Color(0xFF1A3E62),
                                    child: const Text(
                                      "Delete",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 9,
                                          fontWeight: FontWeight.bold
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 40),

                    // 3. النص الوصفي
                    const Text(
                      "سوف نحذف الداتا لاعادة تنزيلها",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0D47A1),
                        height: 1.4,
                      ),
                    ),

                    const SizedBox(height: 50),

                    // 4. البلوك ليسنر مع الحفاظ على اللوجيك الأصلي
                    BlocListener<DeleteBloc, DeleteState>(
                      listener: (context, state) {
                        if (state is DeleteBaseErrorState) {
                          error(context, state.failure.massage, state.failure.code);
                        }
                        if (state is Edit1StatusSErrorState) {
                          error(context, state.failure.massage, state.failure.code);
                        }
                        if (state is Edit1StatusState) {
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            Routes.syncData,
                                (route) => false,
                          );
                        }
                        if (state is DeleteBaseState) {
                          BlocProvider.of<DeleteBloc>(context).add(Edit1EventIn(1));
                        }
                      },
                      child: BlocBuilder<DeleteBloc, DeleteState>(
                        builder: (context, state) {
                          return SizedBox(
                            width: double.infinity,
                            height: 60.h,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF0D47A1),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.r),
                                ),
                                elevation: 5,
                              ),
                              onPressed: state is DeleteBaseLoadingState // افتراض وجود حالة تحميل
                                  ? null
                                  : () {
                                BlocProvider.of<DeleteBloc>(context).add(DeleteBaseEvent());
                              },
                              child: Text(
                                state is DeleteBaseLoadingState ? "جاري الحذف..." : " حذف البيانات ",
                                style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: AppSize.s50),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}