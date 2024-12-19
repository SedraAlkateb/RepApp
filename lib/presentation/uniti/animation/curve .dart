import 'package:flutter/material.dart';

class FadeInWidget extends StatefulWidget {
  @override
  _FadeInWidgetState createState() => _FadeInWidgetState();
}
class _FadeInWidgetState extends State<FadeInWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<Color?> alpha;
  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: const Duration(milliseconds: 5000),
      vsync: this,
    );
    final curve = CurvedAnimation(
      parent: controller,
      curve: Curves.easeOut,
    );
    alpha = ColorTween(begin: Colors.red, end: Colors.black54).animate(curve)
     ..addListener(() {
       setState(() {});
     });
    controller.forward().orCancel;
  }
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      color: alpha.value,
    );
  }
}
