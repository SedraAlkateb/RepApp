import 'package:domina_app/presentation/brand/widget/brand_content.dart';
import 'package:domina_app/presentation/resources/responsive/app_responsive.dart';
import 'package:flutter/material.dart';

class BrandResponsiveLayout extends StatelessWidget {
  const BrandResponsiveLayout({
    super.key,
    required this.searchController,

  });
  final TextEditingController searchController;

  // =========================================================
  // دالة عرض BottomSheet بالتفاصيل الثلاثة للصنف
  // =========================================================
  static void showBrandDetailsSheet(BuildContext context, dynamic brand) {
    final String features = (brand.features == null || brand.features.toString().trim().isEmpty)
        ? 'غير محدد'
        : brand.features.toString();

    final String genCoast = (brand.generalCoast == null || brand.generalCoast.toString().trim().isEmpty)
        ? 'غير محدد'
        : brand.generalCoast.toString();

    final String phCoast = (brand.phCoast == null || brand.phCoast.toString().trim().isEmpty)
        ? 'غير محدد'
        : brand.phCoast.toString();

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
                    title: 'الميزات (Features)',
                    value: features,
                    icon: Icons.featured_play_list_outlined,
                  ),
                  const SizedBox(height: 12),

                  // 2. الكلفة العامة (generalCoast)
                  _buildDetailTile(
                    context: context,
                    title: 'الكلفة العامة (General Coast)',
                    value: genCoast,
                    icon: Icons.monetization_on_outlined,
                  ),
                  const SizedBox(height: 12),

                  // 3. كلفة الصيدلية (phCoast)
                  _buildDetailTile(
                    context: context,
                    title: 'كلفة الصيدلية (Ph Coast)',
                    value: phCoast,
                    icon: Icons.local_pharmacy_outlined,
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            );
          },
        );
      },
    );
  }

  static Widget _buildDetailTile({
    required BuildContext context,
    required String title,
    required String value,
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
          Icon(icon, color: Theme.of(context).primaryColor, size: 24),
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
                  value,
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
    double topSpacing;
    double sectionSpacing;

    switch (deviceType) {
      case AppDeviceType.mobilePortrait:
        pageMaxWidth = 600;
        horizontalPadding = 8;
        topSpacing = 12;
        sectionSpacing = 12;
        break;

      case AppDeviceType.tabletPortrait:
        pageMaxWidth = 760;
        horizontalPadding = 24;
        topSpacing = 18;
        sectionSpacing = 18;
        break;

      case AppDeviceType.tabletLandscape:
        pageMaxWidth = 1000;
        horizontalPadding = 32;
        topSpacing = 20;
        sectionSpacing = 20;
        break;
    }

    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: pageMaxWidth,
        ),
        child: BrandContent(
          searchController: searchController,
          horizontalPadding: horizontalPadding,
          topSpacing: topSpacing,
          sectionSpacing: sectionSpacing,
          // إذا لم تُمرّر دالة onTap من الخارج، سيتم استدعاء showBrandDetailsSheet تلقائياً
          onTap:  (selectedBrand) => showBrandDetailsSheet(context, selectedBrand),
        ),
      ),
    );
  }
}