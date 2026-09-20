import 'package:flutter/material.dart';

class CustomReportBottomSheet extends StatefulWidget {
  final Widget child;
  final VoidCallback onClose;
  final double initialChildSize;
  final double minChildSize;
  final double maxChildSize;

  const CustomReportBottomSheet({
    Key? key,
    required this.child,
    required this.onClose,
    this.initialChildSize = 0.5,
    this.minChildSize = 0.15,
    this.maxChildSize = 0.9,
  }) : super(key: key);

  @override
  State<CustomReportBottomSheet> createState() => _CustomReportBottomSheetState();
}

class _CustomReportBottomSheetState extends State<CustomReportBottomSheet> {
  late final DraggableScrollableController _sheetController;
  bool _isClosing = false;

  @override
  void initState() {
    super.initState();
    _sheetController = DraggableScrollableController();
  }

  @override
  void dispose() {
    _sheetController.dispose();
    super.dispose();
  }

  /// دالة الإغلاق السلسة مع الأنيميشن
  Future<void> _animateAndClose() async {
    if (_isClosing) return;
    _isClosing = true;

    await _sheetController.animateTo(
      0,
      duration: const Duration(milliseconds: 220),
      curve: Curves.easeIn,
    );

    widget.onClose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // 1. الخلفية المعتمة مع إمكانية الضغط للإغلاق بدل ModalBarrier
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: _animateAndClose,
          child: Container(
            color: Colors.black.withOpacity(0.42),
          ),
        ),

        // 2. الـ BottomSheet مع معالجة السحب والأنيميشن
        NotificationListener<DraggableScrollableNotification>(
          onNotification: (notification) {
            // الاستجابة عند السحب للأسفل للوصول للحد الأدنى
            if (notification.extent <= widget.minChildSize + 0.02 && !_isClosing) {
              _isClosing = true;

              _sheetController
                  .animateTo(
                0,
                duration: const Duration(milliseconds: 220),
                curve: Curves.easeIn,
              )
                  .then((_) {
                widget.onClose();
              });
            }
            return false; // منع انتشار الإشعار لتفادي الـ Rebuild المفرط
          },
          child: DraggableScrollableSheet(
            controller: _sheetController,
            initialChildSize: widget.initialChildSize,
            minChildSize: widget.minChildSize,
            maxChildSize: widget.maxChildSize,
            snap: true,
            builder: (context, scrollController) {
              return Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // 3. مقبض السحب (Drag Handle) مع حركة إغلاق أنيقة عند النقر
                      GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: _animateAndClose,
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          child: Center(
                            child: Container(
                              width: 40,
                              height: 5,
                              decoration: BoxDecoration(
                                color: Colors.grey[400],
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),
                      ),

                      // محتوى الـ Sheet
                      widget.child,
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}