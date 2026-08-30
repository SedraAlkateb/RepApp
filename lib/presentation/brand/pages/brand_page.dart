import 'package:domina_app/app/di/di.dart';
import 'package:domina_app/presentation/brand/bloc/brand_bloc.dart';
import 'package:domina_app/presentation/brand/widget/brand_responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BrandPage extends StatelessWidget {

  BrandPage({
    super.key,

  });

  final TextEditingController searchbrandController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider<BrandBloc>(
      create: (_) => instance<BrandBloc>()
        ..add(
          AllBrandEvent(),
        ),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('الأصناف'),
        ),
        body: BrandResponsiveLayout(
          searchController: searchbrandController,

          // ت مرير الدالة أو البارامترات لـ Responsive Layout إذا أردت استدعاء السحب عند الضغط على أحد العناصر
        ),
      ),
    );
  }
}