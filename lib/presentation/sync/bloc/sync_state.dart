part of 'sync_bloc.dart';

enum SyncPhase { uploading, downloading, saving, cleaning }

@immutable
sealed class SyncState extends Equatable {
  const SyncState();
}

final class SyncInitial extends SyncState {
  const SyncInitial();

  @override
  List<Object?> get props => [];
}

/// عملية جارية. [done]/[total] تقدّم المرحلة الحالية (قد يكون [total] = 0).
final class SyncInProgress extends SyncState {
  final SyncPhase phase;
  final int done;
  final int total;
  const SyncInProgress(this.phase, {this.done = 0, this.total = 0});

  @override
  List<Object?> get props => [phase, done, total];
}

/// المشرف وضع خطة جديدة للمندوب أثناء الرفع: تُعرض رسالة ثم تكتمل العملية.
final class SyncPlanChangedState extends SyncState {
  const SyncPlanChangedState();

  @override
  List<Object?> get props => [];
}

final class SyncSuccess extends SyncState {
  final SyncMode mode;
  const SyncSuccess(this.mode);

  @override
  List<Object?> get props => [mode];
}

/// فشل. [canLeave] = false عندما تغيّرت حالة الخطة المحلية ولا يجوز العمل
/// بالبيانات القديمة قبل إتمام التحميل.
final class SyncFailureState extends SyncState {
  final Failure failure;
  final bool canLeave;
  const SyncFailureState(this.failure, {this.canLeave = true});

  @override
  List<Object?> get props => [failure.code, failure.massage, canLeave];
}
