import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/brand/bloc/brand_bloc.dart';
import 'package:domina_app/presentation/uniti/basic/brand.dart';
import 'package:domina_app/presentation/uniti/search_field.dart';
import 'package:domina_app/presentation/uniti/stateWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BrandContent extends StatelessWidget {
  const BrandContent({
    super.key,
    required this.searchController,
    required this.horizontalPadding,
    required this.topSpacing,
    required this.sectionSpacing,
  });

  final TextEditingController searchController;

  final double horizontalPadding;
  final double topSpacing;
  final double sectionSpacing;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPadding,
      ),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: topSpacing,
            ),

            // =========================================
            // Search
            // =========================================
            SearchField(
              searchController: searchController,
              onPressed: (value) {
                context.read<BrandBloc>().add(
                  SearchbradEvent(value),
                );
              },
            ),

            SizedBox(
              height: sectionSpacing,
            ),

            // =========================================
            // Brand Bloc
            // =========================================
            BlocConsumer<BrandBloc, BrandState>(
              listener: (context, state) {
                if (state is AllBrandErrorState) {
                  WidgetsBinding.instance.addPostFrameCallback(
                        (_) {
                      error(
                        context,
                        state.failure.massage,
                        state.failure.code,
                      );
                    },
                  );
                }
              },
              builder: (context, state) {
                if (state is AllBrandState) {
                  final List<BrandModel> brandModel =
                      state.brand;

                  return BrandListWidget(
                    brands: brandModel,
                    shrinkWrap: true,
                  );
                }

                return const SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
    );
  }
}