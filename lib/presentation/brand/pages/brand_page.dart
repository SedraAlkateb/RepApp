import 'package:domina_app/app/di/di.dart';
import 'package:domina_app/presentation/brand/bloc/brand_bloc.dart';
import 'package:domina_app/presentation/brand/widget/brand_responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BrandPage extends StatefulWidget {
  const BrandPage({super.key});

  @override
  State<BrandPage> createState() => _BrandPageState();
}

class _BrandPageState extends State<BrandPage> {

  final TextEditingController searchbrandController = TextEditingController();

  @override
  void dispose() {
    searchbrandController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<BrandBloc>(
      create: (_) => instance<BrandBloc>()
        ..add(
          AllBrandEvent(),
        ),
      child: Scaffold(
        backgroundColor: const Color(0xFFF8FAFC),
        appBar: AppBar(
          title: const Text('الأصناف'),
        ),
        body: BrandResponsiveLayout(
          searchController: searchbrandController,
        ),
      ),
    );
  }
}