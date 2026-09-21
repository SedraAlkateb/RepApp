part of 'sync_bloc.dart';

/// نوع العملية:
/// - [sync]: رفع الزيارات ثم تحميل البيانات واستبدال المحلي (أو تحميل فقط
///   عند أول دخول/بعد فشل سابق، حسب `UserInfo.isLogging`).
/// - [logout]: رفع الزيارات ثم حذف كل البيانات المحلية والخروج.
/// - [forcedLogout]: حذف كل البيانات والخروج بدون رفع (المندوب غير موجود
///   بالسيرفر، أو إلغاء قبل أول تحميل).
enum SyncMode { sync, logout, forcedLogout }

@immutable
sealed class SyncEvent extends Equatable {
  const SyncEvent();
}

class SyncStartEvent extends SyncEvent {
  final SyncMode mode;
  const SyncStartEvent(this.mode);

  @override
  List<Object?> get props => [mode];
}

/// المندوب اطّلع على رسالة "تم وضع خطتك من قبل المشرف" فنكمل العملية.
class SyncPlanAckEvent extends SyncEvent {
  const SyncPlanAckEvent();

  @override
  List<Object?> get props => [];
}
