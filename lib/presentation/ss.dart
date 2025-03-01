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
