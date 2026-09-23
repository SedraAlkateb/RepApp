// presentation/doctors/widget/hospital_card_item.dart

import 'package:domina_app/presentation/uniti/animation/pressable_effect.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/Recipes/widget/hospital_recipe.dart';
import 'package:domina_app/presentation/place_visit/widget/build_card_buttom.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/resources/responsive/app_ui.dart';
import 'package:domina_app/presentation/resources/routes_manager.dart';
import 'package:flutter/material.dart';

class HospitalCardItem extends StatelessWidget {
  const HospitalCardItem({
    super.key,
    required this.hospitalGroup,
  });

  /// كل عناصر هذه القائمة تخص نفس المشفى وتختلف بالاختصاص/الشعبة (titleSp).
  final List<HospitalSpAllModel> hospitalGroup;

  @override
  Widget build(BuildContext context) {
    final HospitalSpAllModel hospital = hospitalGroup.first;

    final ui = AppUi.of(context);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(
        ui.cardPadding,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(
          ui.cardRadius,
        ),
        border: Border.all(
          color: const Color(
            0xFFE2E8F0,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(
              0.03,
            ),
            blurRadius: 12,
            offset: const Offset(
              0,
              4,
            ),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // =====================================================
          // Header
          // نفس ترتيب الكارد الأصلي
          // =====================================================
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // =================================================
              // Hospital Name
              // =================================================
              Expanded(
                child: Text(
                  hospital.title ?? '',
                  textAlign: TextAlign.end,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: ui.cardTitleSize,
                    fontWeight: FontWeight.w700,
                    color: ColorManager.medicalPrimary,
                    height: 1.35,
                  ),
                ),
              ),
            ],
          ),

          SizedBox(
            height: ui.mediumSpacing,
          ),

          // =====================================================
          // Information
          // =====================================================
          _buildInfoRow(
            ui: ui,
            icon: Icons.location_on_outlined,
            text: hospital.placeTitle,
          ),

          _buildInfoRow(
            ui: ui,
            icon: Icons.map_outlined,
            text: hospital.address,
          ),

          SizedBox(
            height: ui.mediumSpacing,
          ),

          const Divider(
            height: 1,
            thickness: 1,
            color: Color(
              0xFFE9EEF3,
            ),
          ),

          SizedBox(
            height: ui.mediumSpacing,
          ),

          // =====================================================
          // Actions
          // نفس السلوك والترتيب الأصلي
          // =====================================================
          Row(
            children: [
              PrescriptionHospitalMenuWidget(
                hospitalId: hospital.id ?? hospital.hospitalId,
              ),
              const Spacer(),
              AppInkWell(
                borderRadius: BorderRadius.circular(
                  ui.smallRadius,
                ),
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    Routes.hospitalDetails,
                    arguments: hospitalGroup,
                  );
                },
                child: buildCardButton(
                  context,
                  'عرض التفاصيل',
                  ColorManager.medicalPrimary,
                  Colors.white,
                  Icons.directions_run,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ===========================================================
  // Information Row
  // ===========================================================

  Widget _buildInfoRow({
    required AppUi ui,
    required IconData icon,
    required String? text,
    Color iconColor = const Color(0xFF94A3B8),
  }) {
    final value = text?.trim() ?? '';

    if (value.isEmpty) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: ui.smallSpacing / 2,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            size: ui.smallIconSize + 2,
            color: iconColor,
          ),
          SizedBox(
            width: ui.smallSpacing,
          ),
          Expanded(
            child: Text(
              value,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: const Color(
                  0xFF475569,
                ),
                fontSize: ui.bodyTextSize,
                fontWeight: FontWeight.w500,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
