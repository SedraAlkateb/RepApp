import 'dart:math';
import 'package:flutter/material.dart';
double randomBorderRadius() {
  return Random().nextDouble() * 64;
}
double randomMargin() {
  return Random().nextDouble() * 64;
}
Color randomColor() {
  return Color(0xFFFFFFFF & Random().nextInt(0xFFFFFFFF));
}
class AnimatedButton extends StatefulWidget {
  const AnimatedButton({super.key,this.onPressed, required this.text});
final Function()? onPressed;
final String text;
  @override
  State<AnimatedButton> createState() => _AnimatedButtonState();
}
class _AnimatedButtonState extends State<AnimatedButton> {
  late Color color;
  late double borderRadius;
  late double margin;

  @override
  void initState() {
    super.initState();
    color = randomColor();
    borderRadius = randomBorderRadius();
    margin = randomMargin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            SizedBox(
              width: 128,
              height: 128,
              child: Container(
                margin: EdgeInsets.all(margin),
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(borderRadius),
                ),
              ),
            ),
            ElevatedButton(
              child: Text(widget.text),
              onPressed: widget.onPressed,
            ),
          ],
        ),
      ),
    );
  }
}


