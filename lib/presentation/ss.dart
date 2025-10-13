import 'package:flutter/material.dart';
class Ss extends StatelessWidget {
  final String s;
  const Ss({super.key,required this.s});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Text(s),
    );
  }
}


// lib/calculator.dart

class Calculator {
  int add(int a, int b) {
    return a + b;
  }

  int subtract(int a, int b) {
    return a - b;
  }
}
