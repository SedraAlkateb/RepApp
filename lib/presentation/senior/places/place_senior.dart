import 'package:domina_app/presentation/drawer/pages/drawer_page.dart';
import 'package:flutter/material.dart';

class PlaceSenior extends StatelessWidget {
  const PlaceSenior({super.key});

  @override
  Widget build(BuildContext context) {
     return Scaffold(
         drawer: DrawerPage(),
          appBar: AppBar());
  }
}
