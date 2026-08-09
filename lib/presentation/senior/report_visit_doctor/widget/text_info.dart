import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';

class TextInfo extends StatelessWidget {
  const TextInfo({
    super.key,
    required this.title,
    required this.supTitle,
    this.showDivider = true,
    this.icon,
  });

  final String title;
  final String? supTitle;
  final bool showDivider;
  final IconData? icon;

  /// تحقق سريع ومرتب للتأكد من أن النص يحتوي على قيمة فعلية
  bool get _isValidValue =>
      supTitle != null &&
          supTitle!.trim().isNotEmpty &&
          supTitle!.trim() != ".";

  @override
  Widget build(BuildContext context) {
    if (!_isValidValue) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: EdgeInsets.only(bottom: AppPaddingH.p8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (icon != null) ...[
                Padding(
                  padding: const EdgeInsets.only(top: 2, left: 8),
                  child: Icon(
                    icon,
                    size: 18,
                    color: ColorManager.primary1,
                  ),
                ),
              ],
              Expanded(
                child: Text.rich(
                  textAlign: TextAlign.start,
                  TextSpan(
                    text: "$title: ",
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF334155),
                    ),
                    children: [
                      TextSpan(
                        text: supTitle,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          if (showDivider) ...[
            const SizedBox(height: 12),
            Divider(
              height: 1,
              thickness: 0.8,
              color: ColorManager.secondaryColor7.withOpacity(0.3),
            ),
            const SizedBox(height: 8),
          ],
        ],
      ),
    );
  }
}