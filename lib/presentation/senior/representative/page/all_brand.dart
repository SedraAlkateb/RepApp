import 'package:domina_app/app/user_info.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
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
    required this.isPr
  });
final bool isPr;
  final TextEditingController searchDocController = TextEditingController();

  // =========================================================
  // دالة عرض BottomSheet لعرض التفاصيل الثلاثة للصنف
  // =========================================================
  void _showBrandDetailsSheet(BuildContext context, BrandModel brand) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.5,
          minChildSize: 0.3,
          maxChildSize: 0.85,
          builder: (context, scrollController) {
            return Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: ListView(
                controller: scrollController,
                children: [
                  // مؤشر السحب العلوي
                  Center(
                    child: Container(
                      width: 45,
                      height: 5,
                      margin: const EdgeInsets.only(bottom: 16),
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),

                  // عنوان الصنف
                  Text(
                    brand.title ?? 'تفاصيل الصنف',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1E293B),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),

                  // 1. الميزات (features)
                  _buildDetailTile(
                    context: context,
                    title: 'الميزة التسويقية ',
                    value: brand.features,
                    icon: Icons.featured_play_list_outlined,
                  ),
                  const SizedBox(height: 12),


                  // 3. كلفة الصيدلية (phCoast)
                  _buildDetailTile(
                    context: context,
                    title: 'سعر الصيدلي ',
                    value: brand.phCoast,
                    icon: Icons.local_pharmacy_outlined,
                  ),
                  // 2. الكلفة العامة (generalCoast)

                  const SizedBox(height: 20),
                  _buildDetailTile(
                    context: context,
                    title: 'سعر العموم',
                    value: brand.generalCoast,
                    icon: Icons.monetization_on_outlined,
                  ),
                  const SizedBox(height: 12),

                ],
              ),
            );
          },
        );
      },
    );
  }

  // ودجت بناء عنصر التفاصيل
  Widget _buildDetailTile({
    required BuildContext context,
    required String title,
    required String? value,
    required IconData icon,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: ColorManager.primary1, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                    color: Color(0xFF64748B),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  (value == null || value.trim().isEmpty) ? '' : value,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF0F172A),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final deviceType = AppResponsive.deviceType(context);

    double pageMaxWidth;

    double horizontalPadding;
    double topPadding;

    double searchBottomSpacing;

    double headerVerticalPadding;

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
              SliverToBoxAdapter(
                child: BlocBuilder<SeniorProfBloc, SeniorProfState>(
                  buildWhen: (previous, current) =>
                  current is SenAllBrandsState ||
                      current is SenAllBrandEmptyState ||
                      current is SenAllBrandLoadingState ||
                      current is SenAllBrandErrorState,
                  builder: (context, state) {
                    List<BrandModel> currentBrands =
                        context.read<SeniorProfBloc>().brand;

                    if (state is SenAllBrandsState) {
                      currentBrands = state.brand;
                    }

                    final int brandLength = state is SenAllBrandEmptyState
                        ? 0
                        : currentBrands.length;

                    return Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: horizontalPadding,
                        vertical: headerVerticalPadding,
                      ),
                      child: buildTotalReportsCard(
                        brandLength,
                        "قائمة الأصناف",
                        "الأصناف المتاحة ضمن الخطة",
                      ),
                    );
                  },
                ),
              ),

              // =================================================
              // Brands
              // =================================================
              BlocBuilder<SeniorProfBloc, SeniorProfState>(
                buildWhen: (
                    previous,
                    current,
                    ) =>
                current is SenAllBrandsState ||
                    current is SenAllBrandEmptyState ||
                    current is SenAllBrandErrorState ||
                    current is SenAllBrandLoadingState,
                builder: (context, state) {
                  List<BrandModel> brandModel =
                      context.watch<SeniorProfBloc>().brand;

                  if (state is SenAllBrandsState) {
                    brandModel = state.brand;
                  }

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

                  if (state is SenAllBrandErrorState) {
                    return SliverToBoxAdapter(
                      child: Column(
                        children: [
                          SizedBox(
                            height: stateTopSpacing,
                          ),
                          errorFullScreen(
                            context,
                            func: isPr?() {
                              BlocProvider.of<SeniorProfBloc>(
                                context,
                              ).add(
                                SenAllBrandEvent(
                                  UserInfo.activePlanId
                                ,isPr
                                )
                              );
                            }:null,
                          ),
                        ],
                      ),
                    );
                  }

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
                        // عند الضغط على صنف محدد تفتح دالة _showBrandDetailsSheet
                        onTap: isPr?(selectedBrand) {
                          _showBrandDetailsSheet(context, selectedBrand);
                        }:null,
                        isPr: isPr,
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