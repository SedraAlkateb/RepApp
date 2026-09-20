import 'package:domina_app/app/di/di.dart';
import 'package:domina_app/presentation/resources/routes_manager.dart';
import 'package:domina_app/presentation/sync/bloc/sync_bloc.dart';
import 'package:domina_app/presentation/sync/widget/plan_changed_dialog.dart';
import 'package:domina_app/presentation/sync/widget/sync_view.dart';
import 'package:domina_app/presentation/uniti/stateWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// صفحة "تسجيل الخروج": رفع الزيارات ثم حذف كل بيانات الجهاز والعودة لتسجيل الدخول.
/// [withoutUpload] = true عندما لا يمكن الرفع (المندوب غير موجود بالسيرفر).
class LogoutPage extends StatelessWidget {
  const LogoutPage({super.key, this.withoutUpload = false});

  final bool withoutUpload;

  @override
  Widget build(BuildContext context) {
    final mode = withoutUpload ? SyncMode.forcedLogout : SyncMode.logout;

    return BlocProvider<SyncBloc>(
      create: (_) => instance<SyncBloc>(),
      child: BlocConsumer<SyncBloc, SyncState>(
        listener: _listener,
        builder: (context, state) {
          final busy = state is SyncInProgress || state is SyncPlanChangedState;

          return PopScope(
            // بعد الحذف الإجباري لا رجوع؛ وأثناء التنفيذ لا رجوع.
            canPop: !withoutUpload && !busy,
            child: Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                surfaceTintColor: Colors.transparent,
                elevation: 0,
                automaticallyImplyLeading: false,
                actions: [
                  if (!withoutUpload && !busy)
                    IconButton(
                      onPressed: () => Navigator.maybePop(context),
                      icon: const Icon(Icons.arrow_forward,
                          color: Color(0xFF0D47A1)),
                    ),
                  const SizedBox(width: 8),
                ],
              ),
              body: SyncView(
                mode: mode,
                description: withoutUpload
                    ? 'سيتم حذف بيانات الجهاز وتسجيل الخروج'
                    : 'تأكد من اتصالك بالإنترنت؛ سيتم رفع زياراتك ثم حذف بيانات الجهاز وتسجيل الخروج',
                startLabel: 'تسجيل الخروج',
                steps: withoutUpload
                    ? const [SyncPhase.cleaning]
                    : const [SyncPhase.uploading, SyncPhase.cleaning],
              ),
            ),
          );
        },
      ),
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
      Navigator.pushNamedAndRemoveUntil(
          context, Routes.login, (route) => false);
    }
  }
}
