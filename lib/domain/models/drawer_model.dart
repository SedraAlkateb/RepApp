import 'package:flutter/material.dart';

class DrawerMenuItem {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final Color? color;

  DrawerMenuItem({required this.icon, required this.title, required this.onTap, this.color});
}