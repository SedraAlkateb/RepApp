import 'package:domina_app/presentation/resources/responsive/app_ui.dart';
import 'package:domina_app/presentation/sync/bloc/sync_bloc.dart';
import 'package:domina_app/presentation/sync/widget/sync_illustration.dart';
import 'package:domina_app/presentation/sync/widget/sync_progress.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// الواجهة المشتركة لصفحتي "مزامنة" و"تسجيل الخروج":
/// رسم توضيحي + وصف + خطوات التقدّم + زر البدء/إعادة المحاولة.
class SyncView extends StatelessWidget {
  const SyncView({
    super.key,
    required this.mode,
    required this.description,
    required this.startLabel,
    required this.steps,
  });

  final SyncMode mode;
  final String description;
  final String startLabel;
  final List<SyncPhase> steps;

  @override
  Widget build(BuildContext context) {
    final ui = AppUi.of(context);
    final double illustrationSize = ui.isMobile
        ? 200
        : ui.isTabletPortrait
            ? 280
            : 200;

    return SafeArea(
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: ui.isMobile ? 520 : 640),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.symmetric(
              horizontal: ui.isMobile ? 24 : 40,
              vertical: 16,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SyncIllustration(size: illustrationSize),
                const SizedBox(height: 28),
                Text(
                  description,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: ui.isMobile ? 17 : 21,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF0D47A1),
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 24),
                SyncProgress(steps: steps),
                const SizedBox(height: 24),
                _StartButton(
                  mode: mode,
                  label: startLabel,
                  height: ui.isMobile ? 56 : 60,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _StartButton extends StatelessWidget {
  const _StartButton({
    required this.mode,
    required this.label,
    required this.height,
  });

  final SyncMode mode;
  final String label;
  final double height;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SyncBloc, SyncState>(
      builder: (context, state) {
        final busy = state is SyncInProgress || state is SyncPlanChangedState;
        final failed = state is SyncFailureState;

        return SizedBox(
          width: double.infinity,
          height: height,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF0D47A1),
              disabledBackgroundColor:
                  const Color(0xFF0D47A1).withValues(alpha: 0.55),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            onPressed: busy
                ? null
                : () => context.read<SyncBloc>().add(SyncStartEvent(mode)),
            child: Text(
              busy
                  ? 'جاري التنفيذ...'
                  : failed
                      ? 'إعادة المحاولة'
                      : label,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        );
      },
    );
  }
}
