import 'package:domina_app/app/app.dart';
import 'package:domina_app/app/di/di.dart';
import 'package:domina_app/app/user_info.dart';
import 'package:domina_app/presentation/resources/routes_manager.dart';
import 'package:domina_app/presentation/sync/bloc/sync_bloc.dart';
import 'package:domina_app/presentation/sync/widget/plan_changed_dialog.dart';
import 'package:domina_app/presentation/sync/widget/sync_view.dart';
import 'package:domina_app/presentation/uniti/stateWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

/// صفحة "مزامنة" الوحيدة: رفع الزيارات ثم تحميل البيانات واستبدال المحلي.
/// عند أول دخول (أو تحميل غير مكتمل سابق: isLogging 1/4) لا يوجد ما يُرفع
/// فتكون العملية تحميلاً فقط.
class SyncPage extends StatelessWidget {
  const SyncPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SyncBloc>(
      create: (_) => instance<SyncBloc>(),
      child: const _SyncScaffold(),
    );
  }
}

class _SyncScaffold extends StatelessWidget {
  const _SyncScaffold();

  bool get _downloadOnly => UserInfo.isLogging == 1 || UserInfo.isLogging == 4;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SyncBloc, SyncState>(
      listener: _listener,
      builder: (context, state) {
        final busy = state is SyncInProgress || state is SyncPlanChangedState;
        final canLeave = state is! SyncFailureState || state.canLeave;
        final downloadOnly = _downloadOnly;

        return PopScope(
          canPop: !downloadOnly && !busy && canLeave,
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              surfaceTintColor: Colors.transparent,
              elevation: 0,
              automaticallyImplyLeading: false,
              actions: [
                if (downloadOnly && !busy)
                  // إلغاء قبل أول تحميل: حذف الجلسة والعودة لتسجيل الدخول.
                  IconButton(
                    onPressed: () => context
                        .read<SyncBloc>()
                        .add(const SyncStartEvent(SyncMode.forcedLogout)),
                    icon: const Icon(Icons.arrow_forward,
                        color: Color(0xFF0D47A1)),
                  )
                else if (!downloadOnly && !busy && canLeave)
                  IconButton(
                    onPressed: () => Navigator.maybePop(context),
                    icon: const Icon(Icons.arrow_forward,
                        color: Color(0xFF0D47A1)),
                  ),
                const SizedBox(width: 8),
              ],
            ),
            body: SyncView(
              mode: SyncMode.sync,
              description: downloadOnly
                  ? 'تأكد من اتصالك بالإنترنت واضغط على زر تحميل البيانات لبدء العمل على التطبيق'
                  : 'سيتم رفع زياراتك ثم تحميل أحدث البيانات. تأكد من اتصالك بالإنترنت ولا تغلق التطبيق أثناء المزامنة',
              startLabel: downloadOnly ? 'تحميل البيانات' : 'بدء المزامنة',
              steps: downloadOnly
                  ? const [SyncPhase.downloading, SyncPhase.saving]
                  : const [
                      SyncPhase.uploading,
                      SyncPhase.downloading,
                      SyncPhase.saving,
                    ],
            ),
          ),
        );
      },
    );
  }

  void _listener(BuildContext context, SyncState state) {
    if (state is SyncFailureState) {
      errorWithoutPop(context, state.failure.massage, state.failure.code);
    } else if (state is SyncPlanChangedState) {
      showPlanChangedDialog(
        context,
        onConfirm: () => context.read<SyncBloc>().add(const SyncPlanAckEvent()),
      );
    } else if (state is SyncSuccess) {
      if (state.mode == SyncMode.sync) {
        resetAppNavigatorKey();
        Phoenix.rebirth(context);
      } else {
        // إلغاء قبل أول تحميل: حُذفت الجلسة.
        Navigator.pushNamedAndRemoveUntil(
            context, Routes.login, (route) => false);
      }
    }
  }
}
