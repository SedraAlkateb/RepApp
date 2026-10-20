import 'package:domina_app/presentation/resources/app_palette.dart';
import 'package:domina_app/presentation/sync/widget/database_widget.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class SyncIllustration extends StatelessWidget {
  final double size;

  const SyncIllustration({
    super.key,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: context.palette.surfaceAlt,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                LucideIcons.user,
                size: size * 0.30,
                color: context.palette.primary,
              ),

              SizedBox(width: size * 0.05),

              SyncServerAnimation(
                illustrationSize: size,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SyncServerAnimation extends StatefulWidget {
  final double illustrationSize;

  const SyncServerAnimation({
    super.key,
    required this.illustrationSize,
  });

  @override
  State<SyncServerAnimation> createState() =>
      _SyncServerAnimationState();
}

class _SyncServerAnimationState extends State<SyncServerAnimation>
    with SingleTickerProviderStateMixin {
  late final AnimationController _arrowController;

  @override
  void initState() {
    super.initState();

    _arrowController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _arrowController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = widget.illustrationSize;

    final databaseWidth = size * 0.25;
    final databaseHeight = size * 0.30;

    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AnimatedBuilder(
          animation: _arrowController,
          builder: (context, child) {
            return Icon(
              Icons.keyboard_arrow_up,
              color: Colors.blue,
              size: (size * 0.085) +
                  ((size * 0.035) * _arrowController.value),
            );
          },
        ),

        DatabaseWidget(
          width: databaseWidth,
          height: databaseHeight,
        ),

        AnimatedBuilder(
          animation: _arrowController,
          builder: (context, child) {
            return Icon(
              Icons.keyboard_arrow_down,
              color: Colors.blue,
              size: (size * 0.085) +
                  ((size * 0.035) * _arrowController.value),
            );
          },
        ),
      ],
    );
  }
}