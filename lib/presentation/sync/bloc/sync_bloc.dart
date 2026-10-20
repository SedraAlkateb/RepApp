import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:domina_app/analytics/analytics_service.dart';
import 'package:domina_app/app/logger/app_logger.dart';
import 'package:domina_app/app/user_info.dart';
import 'package:domina_app/domain/failure.dart';
import 'package:domina_app/domain/usecase/delete_all_sql_usecase.dart';
import 'package:domina_app/presentation/sync/bloc/sync_diagnostics.dart';
import 'package:domina_app/presentation/sync/bloc/sync_downloader.dart';
import 'package:domina_app/presentation/sync/bloc/sync_event.dart';
import 'package:domina_app/presentation/sync/bloc/sync_state.dart';
import 'package:domina_app/presentation/sync/bloc/sync_support.dart';
import 'package:domina_app/presentation/sync/bloc/sync_uploader.dart';

export 'package:domina_app/presentation/sync/bloc/sync_event.dart';
export 'package:domina_app/presentation/sync/bloc/sync_state.dart';
export 'package:domina_app/presentation/sync/bloc/sync_support.dart' show SyncPayload;

final _log = AppLogger.get('SyncBloc');

/// مزامنة موحّدة: رفع الزيارات → (رسالة تغيّر الخطة) → تحميل واستبدال البيانات،
/// أو رفع → حذف كل شيء (تسجيل الخروج).
///
/// - لا يعمل إلا مزامنة واحدة في التطبيق كله ([_running]) حتى لو فُتحت صفحتان
///   (مثلاً من إشعار انتهاء الخطة) فلا تتكرر الزيارات على السيرفر.
/// - لا تُحذف البيانات المحلية إلا بعد التأكد أن لا زيارات غير مرسلة.
/// - الحذف والإدخال بمعاملة واحدة فلا تبقى قاعدة فارغة إذا فشل التحميل.
/// - شروط الخطة (otherstatus/flag/flag1 وأنواع المستخدمين) منقولة كما هي.
class SyncBloc extends Bloc<SyncEvent, SyncState> {
  final AnalyticsService analyticsService;
  final SyncDiagnostics diagnostics;
  final SyncUploader uploader;
  final SyncDownloader downloader;
  final DeleteAllSqlUsecase deleteAllSqlUsecase;

  /// حارس عام: مزامنة واحدة فقط في نفس الوقت مهما تعددت الصفحات/الـ blocs.
  static bool _running = false;

  /// نوع العملية المنتظرة لموافقة المندوب على رسالة تغيّر الخطة.
  SyncMode? _pendingMode;

  SyncBloc({
    required this.analyticsService,
    required this.uploader,
    required this.downloader,
    required this.deleteAllSqlUsecase,
    SyncDiagnostics? diagnostics,
  })  : diagnostics = diagnostics ?? const FirebaseSyncDiagnostics(),
        super(const SyncInitial()) {
    on<SyncStartEvent>(_onStart);
    on<SyncPlanAckEvent>(_onPlanAck);
  }

  // ===========================================================
  // Analytics: مراقبة الحالة بس (onChange)، بدون أي تعديل على منطق
  // المزامنة نفسه، وبدون await (unawaited) حتى ما نأخر ولا نبطّئ شي.
  // ===========================================================
  @override
  void onChange(Change<SyncState> change) {
    super.onChange(change);

    final next = change.nextState;

    if (next is SyncSuccess) {
      unawaited(
        analyticsService.logEvent(
          name: 'sync_completed',
          parameters: {
            'mode': next.mode.name,
          },
        ),
      );
    } else if (next is SyncFailureState) {
      unawaited(
        analyticsService.logEvent(
          name: 'sync_failed',
          parameters: {
            'error_code': next.failure.code.toString(),
          },
        ),
      );
    }
  }

  // ===========================================================
  // نقاط الدخول
  // ===========================================================

  Future<void> _onStart(SyncStartEvent event, Emitter<SyncState> emit) async {
    if (_running) return;
    _running = true;
    var waitingForAck = false;
    try {
      await _setCrashContext(event.mode.name);
      downloader.resetPlanState();

      switch (event.mode) {
        case SyncMode.forcedLogout:
          await _cleanAndLogout(emit, event.mode);
          break;

        case SyncMode.logout:
        case SyncMode.sync:
          // isLogging 1/4 = تحميل فقط (أول دخول أو تحميل غير مكتمل سابق):
          // لا يوجد ما يُرفع، ورفع الخطة هنا سيكون خطأً.
          final downloadOnly = event.mode == SyncMode.sync &&
              (UserInfo.isLogging == 1 || UserInfo.isLogging == 4);

          if (!downloadOnly) {
            final outcome = await uploader.upload(emit);
            if (outcome == UploadOutcome.failed) return;
            if (outcome == UploadOutcome.planChanged) {
              _pendingMode = event.mode;
              waitingForAck = true;
              emit(const SyncPlanChangedState());
              return;
            }
          }
          await _finish(event.mode, emit);
          break;
      }
    } catch (error, stackTrace) {
      await recordSyncError(diagnostics, error, stackTrace, 'Fatal exception in sync');
      emit(SyncFailureState(Failure(-9, error.toString()),
          canLeave: !downloader.planStateChanged));
    } finally {
      if (!waitingForAck) _running = false;
    }
  }

  Future<void> _onPlanAck(
      SyncPlanAckEvent event, Emitter<SyncState> emit) async {
    final mode = _pendingMode;
    if (mode == null) return;
    _pendingMode = null;
    try {
      await _finish(mode, emit);
    } catch (error, stackTrace) {
      await recordSyncError(diagnostics, error, stackTrace, 'Fatal exception in sync (ack)');
      emit(SyncFailureState(Failure(-9, error.toString()),
          canLeave: !downloader.planStateChanged));
    } finally {
      _running = false;
    }
  }

  Future<void> _finish(SyncMode mode, Emitter<SyncState> emit) {
    return mode == SyncMode.sync
        ? downloader.downloadAndReplace(emit)
        : _cleanAndLogout(emit, mode);
  }

  Future<void> _cleanAndLogout(Emitter<SyncState> emit, SyncMode mode) async {
    emit(const SyncInProgress(SyncPhase.cleaning));
    final result = await deleteAllSqlUsecase.execute();
    result.fold(
      (failure) => emit(SyncFailureState(failure)),
      (_) {
        UserInfo.flag1 = 0;
        UserInfo.isLogging = 0;
        emit(SyncSuccess(mode));
      },
    );
  }

  Future<void> _setCrashContext(String mode) async {
    try {
      await diagnostics
          .setUserIdentifier('${UserInfo.repId}${UserInfo.name}');
      await diagnostics.setCustomKey('sync_mode', mode);
    } catch (error) {
      _log.warning('crashlytics context failed', error);
    }
  }
}
