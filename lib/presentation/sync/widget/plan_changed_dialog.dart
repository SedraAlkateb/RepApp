import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';

/// رسالة "تم وضع خطتك من قبل المشرف": تظهر أثناء الرفع، والموافقة تُكمل العملية.
Future<void> showPlanChangedDialog(
  BuildContext context, {
  required VoidCallback onConfirm,
}) {
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (dialogContext) => PopScope(
      canPop: false,
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSize.s14),
        ),
        backgroundColor: ColorManager.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('تم وضع خطتك من قبل المشرف'),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(dialogContext).pop();
                  onConfirm();
                },
                child: const Text('موافق'),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
