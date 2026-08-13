import 'package:domina_app/presentation/specialization/widget/spec_dh_responsive_layout.dart';
import 'package:flutter/material.dart';

class SpecDH extends StatelessWidget {
  const SpecDH({
    super.key,
    required this.spId,
  });

  final int spId;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: SpecDHResponsiveLayout(
        spId: spId,
      ),
    );
  }
}