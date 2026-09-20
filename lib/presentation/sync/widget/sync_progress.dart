import 'package:domina_app/presentation/sync/bloc/sync_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

String _phaseLabel(SyncPhase phase) {
  switch (phase) {
    case SyncPhase.uploading:
      return 'رفع الزيارات';
    case SyncPhase.downloading:
      return 'تحميل البيانات';
    case SyncPhase.saving:
      return 'حفظ البيانات';
    case SyncPhase.cleaning:
      return 'حذف بيانات الجهاز';
  }
}

/// خطوات العملية وحالة كل خطوة (منتهية / جارية / بالانتظار) مع شريط تقدّم.
class SyncProgress extends StatelessWidget {
  const SyncProgress({super.key, required this.steps});

  final List<SyncPhase> steps;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SyncBloc, SyncState>(
      builder: (context, state) {
        final SyncPhase? current = state is SyncInProgress ? state.phase : null;
        final bool finished = state is SyncSuccess;
        final int currentIndex = current == null ? -1 : steps.indexOf(current);

        double? progress;
        if (finished) {
          progress = 1;
        } else if (state is SyncInProgress &&
            state.phase == SyncPhase.downloading &&
            state.total > 0) {
          progress = state.done / state.total;
        }

        return Column(
          children: [
            for (var i = 0; i < steps.length; i++)
              _StepRow(
                label: _phaseLabel(steps[i]),
                status: finished || (currentIndex > i)
                    ? _StepStatus.done
                    : currentIndex == i
                        ? _StepStatus.active
                        : _StepStatus.pending,
                detail: currentIndex == i &&
                        state is SyncInProgress &&
                        state.total > 0
                    ? '${state.done} / ${state.total}'
                    : null,
              ),
            if (current != null) ...[
              const SizedBox(height: 12),
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: LinearProgressIndicator(
                  value: progress,
                  minHeight: 8,
                  color: const Color(0xFF0D47A1),
                  backgroundColor: const Color(0xFFE3EAF5),
                ),
              ),
            ],
          ],
        );
      },
    );
  }
}

enum _StepStatus { pending, active, done }

class _StepRow extends StatelessWidget {
  const _StepRow({required this.label, required this.status, this.detail});

  final String label;
  final _StepStatus status;
  final String? detail;

  @override
  Widget build(BuildContext context) {
    final color = status == _StepStatus.pending
        ? Colors.grey.shade500
        : const Color(0xFF0D47A1);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          SizedBox(
            width: 22,
            height: 22,
            child: status == _StepStatus.active
                ? const CircularProgressIndicator(strokeWidth: 2.5)
                : Icon(
                    status == _StepStatus.done
                        ? Icons.check_circle_rounded
                        : Icons.radio_button_unchecked,
                    size: 22,
                    color: status == _StepStatus.done
                        ? const Color(0xFF2D947A)
                        : color,
                  ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 16,
                fontWeight: status == _StepStatus.active
                    ? FontWeight.bold
                    : FontWeight.w500,
                color: color,
              ),
            ),
          ),
          if (detail != null)
            Text(detail!,
                style: TextStyle(fontSize: 14, color: Colors.grey.shade700)),
        ],
      ),
    );
  }
}
