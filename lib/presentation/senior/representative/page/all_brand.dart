import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/resources/responsive/app_responsive.dart';
import 'package:domina_app/presentation/senior/representative/bloc/senior_prof_bloc.dart';
import 'package:domina_app/presentation/uniti/basic/brand.dart';
import 'package:domina_app/presentation/uniti/num_list.dart';
import 'package:domina_app/presentation/uniti/search_field.dart';
import 'package:domina_app/presentation/uniti/stateWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AllBrand extends StatelessWidget {
  AllBrand({
    super.key,
  });

  final TextEditingController searchDocController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final deviceType = AppResponsive.deviceType(context);

    double pageMaxWidth;

    double horizontalPadding;
    double topPadding;

    double searchBottomSpacing;

    double headerVerticalPadding;
    double headerTitleFontSize;
    double headerSubtitleFontSize;

    double countHorizontalPadding;
    double countVerticalPadding;
    double countFontSize;
    double countRadius;

    double listTopPadding;
    double listBottomPadding;

    double stateTopSpacing;

    switch (deviceType) {
      // =================================================
      // Mobile
      // =================================================
      case AppDeviceType.mobilePortrait:
        pageMaxWidth = 600;

        horizontalPadding = 16;
        topPadding = 16;

        searchBottomSpacing = 10;

        headerVerticalPadding = 12;
        headerTitleFontSize = 18;
        headerSubtitleFontSize = 12;

        countHorizontalPadding = 12;
        countVerticalPadding = 5;
        countFontSize = 11;
        countRadius = 10;

        listTopPadding = 6;
        listBottomPadding = 24;

        stateTopSpacing = 70;
        break;

      // =================================================
      // Tablet Portrait
      // =================================================
      case AppDeviceType.tabletPortrait:
        pageMaxWidth = 760;

        horizontalPadding = 28;
        topPadding = 20;

        searchBottomSpacing = 14;

        headerVerticalPadding = 16;
        headerTitleFontSize = 21;
        headerSubtitleFontSize = 14;

        countHorizontalPadding = 16;
        countVerticalPadding = 7;
        countFontSize = 13;
        countRadius = 12;

        listTopPadding = 8;
        listBottomPadding = 30;

        stateTopSpacing = 90;
        break;

      // =================================================
      // Tablet Landscape
      // =================================================
      case AppDeviceType.tabletLandscape:
        pageMaxWidth = 900;

        horizontalPadding = 32;
        topPadding = 16;

        searchBottomSpacing = 12;

        headerVerticalPadding = 14;
        headerTitleFontSize = 20;
        headerSubtitleFontSize = 13;

        countHorizontalPadding = 16;
        countVerticalPadding = 6;
        countFontSize = 13;
        countRadius = 12;

        listTopPadding = 6;
        listBottomPadding = 28;

        stateTopSpacing = 70;
        break;
    }

    return Scaffold(
      backgroundColor: const Color(
        0xFFF8FAFC,
      ),
      appBar: AppBar(
        title: const Text(
          'الأصناف',
        ),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: pageMaxWidth,
          ),
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              // =================================================
              // Search
              // =================================================
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(
                    horizontalPadding,
                    topPadding,
                    horizontalPadding,
                    0,
                  ),
                  child: SearchField(
                    searchController: searchDocController,

                    // ===========================================
                    // نفس سلوك البحث
                    // ===========================================
                    onPressed: (value) {
                      BlocProvider.of<SeniorProfBloc>(
                        context,
                      ).add(
                        SenSearchBrandEvent(
                          value,
                        ),
                      );
                    },
                  ),
                ),
              ),

              SliverToBoxAdapter(
                child: SizedBox(
                  height: searchBottomSpacing,
                ),
              ),

              // =================================================
              // Header + Count
              // =================================================
              // =================================================
// Header + Count
// =================================================
              SliverToBoxAdapter(
                child: BlocBuilder<SeniorProfBloc, SeniorProfState>(
                  buildWhen: (previous, current) =>
                      current is SenAllBrandsState ||
                      current is SenAllBrandEmptyState ||
                      current is SenAllBrandLoadingState ||
                      current is SenAllBrandErrorState,
                  builder: (context, state) {
                    // ===============================================
                    // القائمة الأساسية
                    // ===============================================
                    List<BrandModel> currentBrands =
                        context.read<SeniorProfBloc>().brand;

                    // ===============================================
                    // عند البحث أو جلب بيانات جديدة
                    // ناخد القائمة الموجودة داخل الـState
                    // ===============================================
                    if (state is SenAllBrandsState) {
                      currentBrands = state.brand;
                    }

                    // ===============================================
                    // عند Empty العدد = 0
                    // ===============================================
                    final int brandLength = state is SenAllBrandEmptyState
                        ? 0
                        : currentBrands.length;

                    return Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: horizontalPadding,
                        vertical: headerVerticalPadding,
                      ),
                      child: buildTotalReportsCard(brandLength, "قائمة الأصناف",
                          "الأصناف المتاحة ضمن الخطة"),
                    );
                  },
                ),
              ),
              // =================================================
              // Brands
              // =================================================
              BlocBuilder<SeniorProfBloc, SeniorProfState>(
                // نفس buildWhen الموجود عندك
                buildWhen: (
                  previous,
                  current,
                ) =>
                    current is SenAllBrandsState ||
                    current is SenAllBrandEmptyState,

                builder: (context, state) {
                  List<BrandModel> brandModel =
                      context.watch<SeniorProfBloc>().brand;

                  // ===========================================
                  // Success
                  // ===========================================
                  if (state is SenAllBrandsState) {
                    brandModel = state.brand;
                  }

                  // ==================[=========================
                  // Empty
                  // ===========================================
                  if (state is SenAllBrandEmptyState) {
                    return SliverToBoxAdapter(
                      child: Column(
                        children: [
                          SizedBox(
                            height: stateTopSpacing,
                          ),
                          emptyFullScreen(
                            context,
                          ),
                        ],
                      ),
                    );
                  }

                  // ===========================================
                  // Error
                  // نفس السلوك الأصلي
                  // ===========================================
                  if (state is SenAllBrandErrorState) {
                    return SliverToBoxAdapter(
                      child: Column(
                        children: [
                          SizedBox(
                            height: stateTopSpacing,
                          ),
                          errorFullScreen(
                            context,
                            func: () {
                              BlocProvider.of<SeniorProfBloc>(
                                context,
                              ).add(
                                SenAllBrandEvent(
                                  203,
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    );
                  }

                  // ===========================================
                  // Loading
                  // ===========================================
                  if (state is SenAllBrandLoadingState) {
                    return SliverToBoxAdapter(
                      child: Column(
                        children: [
                          SizedBox(
                            height: stateTopSpacing,
                          ),
                          loadingFullScreen(
                            context,
                          ),
                        ],
                      ),
                    );
                  }

                  // ===========================================
                  // Brand List
                  // ===========================================
                  return SliverPadding(
                    padding: EdgeInsets.fromLTRB(
                      horizontalPadding,
                      listTopPadding,
                      horizontalPadding,
                      listBottomPadding,
                    ),
                    sliver: SliverToBoxAdapter(
                      child: BrandListWidget(
                        brands: brandModel,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
