// اختبارات تثبيت لمسار المزامنة (SyncBloc): الرفع ← رسالة تغيّر الخطة ← التحميل،
// وتسجيل الخروج. تمنع تغيّر شروط الخطة وترتيب الخطوات أثناء إعادة الهيكلة.
import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:domina_app/analytics/analytics_service.dart';
import 'package:domina_app/app/user_info.dart';
import 'package:domina_app/domain/failure.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/domain/repository/repository.dart';
import 'package:domina_app/domain/repository/repository_sql.dart';
import 'package:domina_app/domain/usecase/all_brands_sp_usecase.dart';
import 'package:domina_app/domain/usecase/all_brands_usecase.dart';
import 'package:domina_app/domain/usecase/all_doctor_usecase.dart';
import 'package:domina_app/domain/usecase/all_exception_sql_usecase.dart';
import 'package:domina_app/domain/usecase/all_exception_usecase.dart';
import 'package:domina_app/domain/usecase/all_hospial_sp_usecase.dart';
import 'package:domina_app/domain/usecase/all_hospial_usecase.dart';
import 'package:domina_app/domain/usecase/all_place_usecase.dart';
import 'package:domina_app/domain/usecase/all_plan_brands_usecase.dart';
import 'package:domina_app/domain/usecase/all_spec_usecase.dart';
import 'package:domina_app/domain/usecase/async_data_sql_usecase.dart';
import 'package:domina_app/domain/usecase/check_active_brand_plan_sql_usecase.dart';
import 'package:domina_app/domain/usecase/delete_all_sql_usecase.dart';
import 'package:domina_app/domain/usecase/edit_is_login_sql_usecase.dart';
import 'package:domina_app/domain/usecase/get_visit_doctor_usecase.dart';
import 'package:domina_app/domain/usecase/get_visit_hospital_usecase.dart';
import 'package:domina_app/domain/usecase/insert_as/get_brands_doctor_visits_sql_usecase.dart';
import 'package:domina_app/domain/usecase/insert_as/get_brands_hospital_visits_sql_usecase.dart';
import 'package:domina_app/domain/usecase/insert_as/get_doctor_visits_sql_usecase.dart';
import 'package:domina_app/domain/usecase/insert_as/get_hospital_visits_sql_usecase.dart';
import 'package:domina_app/domain/usecase/insert_as/get_plan_brand_sql_usecase.dart';
import 'package:domina_app/domain/usecase/is_plan_sql_usecase.dart';
import 'package:domina_app/domain/usecase/plan_brand_usecase.dart';
import 'package:domina_app/domain/usecase/update_active_sql_usecase.dart';
import 'package:domina_app/domain/usecase/update_flag_doctor_sql_usecase.dart';
import 'package:domina_app/domain/usecase/update_flag_hospital_sql_usecase.dart';
import 'package:domina_app/domain/usecase/visit_doctor_usecase.dart';
import 'package:domina_app/domain/usecase/visit_hospital_usecase.dart';
import 'package:domina_app/presentation/sync/bloc/sync_bloc.dart';
import 'package:domina_app/presentation/sync/bloc/sync_diagnostics.dart';
import 'package:domina_app/presentation/sync/bloc/sync_downloader.dart';
import 'package:domina_app/presentation/sync/bloc/sync_uploader.dart';
import 'package:flutter_test/flutter_test.dart';

Future<Either<Failure, T>> ok<T>(T v) async => Right(v);
Future<Either<Failure, T>> bad<T>(String m) async => Left(Failure(7, m));

/// واجهة خلفية وهمية للمستودعين البعيد والمحلي: تسجّل كل استدعاء، ويمكن
/// استبدال سلوك أي دالة بالاسم.
class FakeBackend implements Repository, RepositorySql {
  final calls = <String>[];
  final invocations = <String, List<Invocation>>{};
  final overrides = <String, Object? Function(Invocation)>{};

  late final defaults = <String, Object? Function(Invocation)>{
    // بعيد
    'insertLog': (_) => ok<MessageModel>(const MessageModel()),
    'visitDoctor': (_) => ok<MessageModel>(const MessageModel()),
    'visitHospital': (_) => ok<MessageModel>(const MessageModel()),
    'repPlanBrand': (_) => ok<MessageModel>(const MessageModel()),
    'checkActivePlanBrand': (_) => ok<LoginModel>(login()),
    'getDocVisit': (_) => ok<VisitDoctorBase>(VisitDoctorBase([], [])),
    'getHosVisit': (_) => ok<VisitHospitalBase>(VisitHospitalBase([], [])),
    'allBrand': (_) => ok<List<BrandModel>>([]),
    'getAllPlanBrands': (_) => ok<List<PlanBrandModel>>([]),
    'getAllDoctor': (_) => ok<List<DoctorModel>>([]),
    'getAllHospital': (_) => ok<List<HospitalModel>>([]),
    'allPlace': (_) => ok<List<PlaceModel>>([]),
    'allSpec': (_) => ok<List<SpecDModel>>([]),
    'getAllHospitalSp': (_) => ok<List<HospitalSpModel>>([]),
    'getBrandsSp': (_) => ok<List<BrandSpModel>>([]),
    // محلي
    'allException': (_) => ok<List<ExceptionModel>>([]),
    'planBrandsAs': (_) => ok<List<PlanBrandModel>>([]),
    'visitBrandDoctorAs': (_) => ok<List<VisitBrandPharmacyModel>>([]),
    'visitBrandHospitalAs': (_) => ok<List<VisitBrandPharmacyModel>>([]),
    'visitDoctorAs': (_) => ok<List<VisitDoctorModel>>([]),
    'visitHospitalAs': (_) => ok<List<VisitHospitalModel>>([]),
    'updateFlagsToDoctor': (_) => ok<bool>(true),
    'updateFlagsToHospital': (_) => ok<bool>(true),
    'editIsPlan': (_) => ok<Null>(null),
    'updateRep': (_) => ok<Null>(null),
    'asyncData': (_) => ok<String>('ok'),
    'editIsLogin': (_) => ok<Null>(null),
    'clearDatabaseAll': (_) => ok<Null>(null),
  };

  List<Invocation> of(String name) => invocations[name] ?? const [];

  @override
  dynamic noSuchMethod(Invocation invocation) {
    final name = RegExp(r'"(.*)"')
        .firstMatch(invocation.memberName.toString())!
        .group(1)!;
    calls.add(name);
    (invocations[name] ??= []).add(invocation);
    final handler = overrides[name] ?? defaults[name];
    if (handler == null) {
      throw StateError('استدعاء غير متوقع: $name');
    }
    return handler(invocation);
  }
}

class FakeAnalytics implements AnalyticsService {
  final events = <String>[];
  @override
  Future<void> logEvent(
      {required String name, Map<String, Object>? parameters}) async {
    events.add(name);
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class FakeDiagnostics implements SyncDiagnostics {
  @override
  Future<void> setUserIdentifier(String identifier) async {}
  @override
  Future<void> setCustomKey(String key, Object value) async {}
  @override
  Future<void> recordError(Object error, StackTrace? stackTrace,
      {String? reason, bool fatal = false}) async {}
  @override
  void log(String message) {}
}

LoginModel login({
  int? activePlanId = 10,
  int? otherPlanId = 0,
  int? otherStatus = -1,
  int flag1 = 0,
}) =>
    LoginModel(2, 'tok', 1, otherPlanId, activePlanId, otherStatus, 'rep', 0, 5,
        '2026-01-01', '2026-12-31', 0, 0, flag1, 1, 'city', RepType(8, 'o'), 0,
        0, 0, 'grp', otherStartDate: '', otherEndDate: '');

VisitDoctorModel docVisit(int id) =>
    VisitDoctorModel(id, 'd', 'k', 's', 'a', 5, 0, 't');

void resetUserInfo() {
  UserInfo.repId = 1;
  UserInfo.activePlanId = 10;
  UserInfo.otherPlanId = 0;
  UserInfo.otherstatus = -1;
  UserInfo.startDate = '2026-01-01';
  UserInfo.endDate = '2026-12-31';
  UserInfo.otherStartDate = '';
  UserInfo.otherEndDate = '';
  UserInfo.flag = 1; // مندوب عادي: بعد تحديث الخطة otherStatus=-1 ⇒ flag=1
  UserInfo.flag1 = 0;
  UserInfo.isLogging = 5;
  UserInfo.isChange = false;
  UserInfo.repType = RepType(8, 'o');
  UserInfo.name = 'rep';
}

class Harness {
  Harness() {
    final diagnostics = FakeDiagnostics();
    bloc = SyncBloc(
      analyticsService: analytics,
      diagnostics: diagnostics,
      uploader: SyncUploader(
      allExceptionSqlUsecase: AllExceptionSqlUsecase(backend),
      allExceptionUsecase: AllExceptionUsecase(backend),
      getBrandsDoctorVisitsSqlUsecase: GetBrandsDoctorVisitsSqlUsecase(backend),
      getBrandsHospitalVisitsSqlUsecase: GetBrandsHospitalVisitsSqlUsecase(backend),
      getDoctorVisitsSqlUsecase: GetDoctorVisitsSqlUsecase(backend),
      getHospitalVisitsSqlUsecase: GetHospitalVisitsSqlUsecase(backend),
      getPlanBrandSqlUsecase: GetPlanBrandSqlUsecase(backend),
      visitDoctorUsecase: VisitDoctorUsecase(backend),
      visitHospitalUsecase: VisitHospitalUsecase(backend),
      planBrandUsecase: PlanBrandUsecase(backend),
      updateFlagDoctorSqlUsecase: UpdateFlagDoctorSqlUsecase(backend),
      updateFlagHospitalSqlUsecase: UpdateFlagHospitalSqlUsecase(backend),
      isPlanSqlUsecase: IsPlanSqlUsecase(backend),
      checkActiveBrandPlanUsecase: CheckActiveBrandPlanUsecase(backend),
      ),
      downloader: SyncDownloader(
        analyticsService: analytics,
        diagnostics: diagnostics,
      checkActiveBrandPlanUsecase: CheckActiveBrandPlanUsecase(backend),
      updateActiveSqlUsecase: UpdateActiveSqlUsecase(backend),
      allBrandsUsecase: AllBrandsUsecase(backend),
      getVisitDoctorUsecase: GetVisitDoctorUsecase(backend),
      getVisitHospitalUsecase: GetVisitHospitalUsecase(backend),
      allPlanBrandsUsecase: AllPlanBrandsUsecase(backend),
      allDoctorUsecase: AllDoctorUsecase(backend),
      allHospitalUsecase: AllHospitalUsecase(backend),
      allPlaceUsecase: AllPlaceUsecase(backend),
      allSpeUsecase: AllSpeUsecase(backend),
      allHospialSpUsecase: AllHospialSpUsecase(backend),
      allBrandsSpUsecase: AllBrandsSpUsecase(backend),
      asyncDataSqlUsecase: AsyncDataSqlUsecase(backend),
      editIsLoginSqlUsecase: EditIsLoginSqlUsecase(backend),
      ),
      deleteAllSqlUsecase: DeleteAllSqlUsecase(backend),
    );
    bloc.stream.listen(states.add);
  }

  final backend = FakeBackend();
  final analytics = FakeAnalytics();
  late final SyncBloc bloc;
  final states = <SyncState>[];

  List<String> get calls => backend.calls;

  /// ينتظر أول حالة نهائية (نجاح/فشل/رسالة تغيّر الخطة).
  Future<SyncState> run(SyncEvent event) async {
    final done = bloc.stream.firstWhere((s) =>
        s is SyncSuccess || s is SyncFailureState || s is SyncPlanChangedState);
    bloc.add(event);
    return done.timeout(const Duration(seconds: 5));
  }

  Future<void> close() => bloc.close();
}

void main() {
  late Harness h;

  setUp(() {
    resetUserInfo();
    h = Harness();
  });
  tearDown(() => h.close());

  test('مزامنة كاملة بلا زيارات معلّقة: رفع فارغ ثم تحميل واستبدال ثم isLogging=2',
      () async {
    final end = await h.run(const SyncStartEvent(SyncMode.sync));

    expect(end, const SyncSuccess(SyncMode.sync));
    expect(h.calls.where((c) => c == 'visitDoctor' || c == 'visitHospital'),
        isEmpty);
    expect(h.calls, contains('getAllPlanBrands')); // flag1 == 0 → 10 خطوات
    final async = h.backend.of('asyncData').single;
    expect(async.namedArguments[#replaceExisting], true);
    expect(async.namedArguments[#keepPlanBrand], false);
    expect(h.backend.of('editIsLogin').single.positionalArguments, [1, 2]);
    expect(UserInfo.isLogging, 2);
    expect(h.states.first, const SyncInProgress(SyncPhase.uploading));
    expect(h.states, contains(const SyncInProgress(SyncPhase.saving)));
    expect(h.analytics.events, containsAll(['sync_completed', 'plan_audit']));
  });

  test('زيارات طبيب معلّقة: تُرفع بهوية المندوب/الخطة ثم تُعلَّم قبل التحميل',
      () async {
    var pass = 0;
    h.backend.overrides['visitDoctorAs'] =
        (_) => ok<List<VisitDoctorModel>>(pass++ == 0 ? [docVisit(3)] : []);

    final end = await h.run(const SyncStartEvent(SyncMode.sync));

    expect(end, const SyncSuccess(SyncMode.sync));
    final body = h.backend.of('visitDoctor').single.positionalArguments.single
        as VisitDoctorRequestBody;
    expect(body.repPlanId, 10);
    expect(body.representativeId, 1);
    final flagCall = h.backend.of('updateFlagsToDoctor').single;
    expect(flagCall.namedArguments[#visitIds], [3]);
    expect(
        h.calls.indexOf('visitDoctor'), lessThan(h.calls.indexOf('asyncData')));
    expect(h.calls.indexOf('updateFlagsToDoctor'),
        lessThan(h.calls.indexOf('asyncData')));
  });

  test('فشل رفع الزيارات: لا تحميل ولا حذف، والرسالة تحمل رقم الخطوة 2',
      () async {
    h.backend.overrides['visitDoctorAs'] =
        (_) => ok<List<VisitDoctorModel>>([docVisit(3)]);
    h.backend.overrides['visitDoctor'] = (_) => bad<MessageModel>('boom');

    final end = await h.run(const SyncStartEvent(SyncMode.sync));

    expect(end, isA<SyncFailureState>());
    expect((end as SyncFailureState).failure.massage, 'boom 2');
    expect(h.calls, isNot(contains('asyncData')));
    expect(h.calls, isNot(contains('clearDatabaseAll')));
    expect(h.calls, isNot(contains('allBrand')));
    expect(UserInfo.isLogging, 5);
  });

  test('زيارات تُضاف باستمرار: يتوقف بعد 3 دورات ولا يتابع للتحميل', () async {
    h.backend.overrides['visitDoctorAs'] =
        (_) => ok<List<VisitDoctorModel>>([docVisit(3)]);

    final end = await h.run(const SyncStartEvent(SyncMode.sync));

    expect(end, isA<SyncFailureState>());
    expect(h.backend.of('visitDoctor').length, 3);
    expect(h.calls, isNot(contains('asyncData')));
  });

  test('تحميل فقط (isLogging=1): لا رفع أبداً', () async {
    UserInfo.isLogging = 1;

    final end = await h.run(const SyncStartEvent(SyncMode.sync));

    expect(end, const SyncSuccess(SyncMode.sync));
    expect(h.calls, isNot(contains('allException')));
    expect(h.calls, isNot(contains('visitDoctorAs')));
    expect(h.calls, contains('asyncData'));
    expect(UserInfo.isLogging, 2);
    expect(h.states.first, const SyncInProgress(SyncPhase.downloading));
  });

  test('تحميل فقط (isLogging=4) أيضاً بلا رفع', () async {
    UserInfo.isLogging = 4;
    await h.run(const SyncStartEvent(SyncMode.sync));
    expect(h.calls, isNot(contains('allException')));
  });

  test('تسجيل الخروج: رفع ثم حذف كل شيء وتصفير flag1/isLogging', () async {
    UserInfo.flag1 = 3;

    final end = await h.run(const SyncStartEvent(SyncMode.logout));

    expect(end, const SyncSuccess(SyncMode.logout));
    expect(h.calls, contains('allException'));
    expect(h.calls.last, 'clearDatabaseAll');
    expect(h.calls, isNot(contains('asyncData')));
    expect(UserInfo.flag1, 0);
    expect(UserInfo.isLogging, 0);
  });

  test('خروج قسري: بلا رفع، حذف مباشر', () async {
    final end = await h.run(const SyncStartEvent(SyncMode.forcedLogout));

    expect(end, const SyncSuccess(SyncMode.forcedLogout));
    expect(h.calls, ['clearDatabaseAll']);
  });

  test('فشل الحذف عند الخروج: حالة فشل ولا تُصفَّر الحالة', () async {
    h.backend.overrides['clearDatabaseAll'] = (_) => bad<Null>('x');
    UserInfo.flag1 = 3;

    final end = await h.run(const SyncStartEvent(SyncMode.forcedLogout));

    expect(end, isA<SyncFailureState>());
    expect(UserInfo.flag1, 3);
    expect(UserInfo.isLogging, 5);
  });

  test('فشل التحميل والخطة لم تتغير: يستطيع المندوب المغادرة وتبقى حالته',
      () async {
    h.backend.overrides['getAllDoctor'] = (_) => bad<List<DoctorModel>>('net');

    final end = await h.run(const SyncStartEvent(SyncMode.sync));

    expect(end, isA<SyncFailureState>());
    expect((end as SyncFailureState).canLeave, true);
    expect(h.calls, isNot(contains('asyncData')));
    expect(h.calls, isNot(contains('editIsLogin')));
    expect(UserInfo.isLogging, 5);
  });

  test('فشل التحميل بعد تغيّر الخطة: canLeave=false و isLogging=1 (تحميل مطلوب)',
      () async {
    h.backend.overrides['checkActivePlanBrand'] =
        (_) => ok<LoginModel>(login(activePlanId: 11));
    h.backend.overrides['getAllDoctor'] = (_) => bad<List<DoctorModel>>('net');

    final end = await h.run(const SyncStartEvent(SyncMode.sync));

    expect((end as SyncFailureState).canLeave, false);
    expect(h.backend.of('editIsLogin').single.positionalArguments, [1, 1]);
    expect(UserInfo.isLogging, 1);
    expect(UserInfo.activePlanId, 11);
    expect(h.calls, isNot(contains('asyncData')));
  });

  test('فشل تحديث سجل المندوب: تُستعاد حالة الخطة في الذاكرة كما كانت',
      () async {
    h.backend.overrides['checkActivePlanBrand'] =
        (_) => ok<LoginModel>(login(activePlanId: 11));
    h.backend.overrides['updateRep'] = (_) => bad<Null>('db');

    final end = await h.run(const SyncStartEvent(SyncMode.sync));

    expect(end, isA<SyncFailureState>());
    expect((end as SyncFailureState).canLeave, true);
    expect(UserInfo.activePlanId, 10);
    expect(h.calls, isNot(contains('allBrand')));
  });

  test('خطة المندوب المحفوظة offline (flag1 != 0): لا تُحمَّل خطة ولا تُحذف',
      () async {
    UserInfo.flag1 = 1;
    UserInfo.otherstatus = 5;
    h.backend.overrides['checkActivePlanBrand'] =
        (_) => ok<LoginModel>(login(otherStatus: 5, flag1: 1));

    final end = await h.run(const SyncStartEvent(SyncMode.sync));

    expect(end, const SyncSuccess(SyncMode.sync));
    expect(h.calls, isNot(contains('getAllPlanBrands'))); // 9 خطوات
    expect(
        h.backend.of('asyncData').single.namedArguments[#keepPlanBrand], true);
  });

  test(
      'رفع الخطة (otherstatus=5 و flag=0) مع خطة وضعها المشرف: رسالة ثم متابعة بعد الإقرار',
      () async {
    UserInfo.otherstatus = 5;
    UserInfo.flag = 0;
    h.backend.overrides['checkActivePlanBrand'] =
        (_) => ok<LoginModel>(login(otherStatus: 5));

    final first = await h.run(const SyncStartEvent(SyncMode.sync));

    expect(first, const SyncPlanChangedState());
    expect(h.calls, contains('planBrandsAs'));
    expect(h.calls, isNot(contains('repPlanBrand'))); // isChange == true
    expect(h.backend.of('editIsPlan').single.positionalArguments, [1, 1]);
    expect(UserInfo.flag, 1);
    expect(h.calls, isNot(contains('asyncData')));

    final done = h.bloc.stream.firstWhere((s) => s is SyncSuccess);
    h.bloc.add(const SyncPlanAckEvent());
    expect(await done.timeout(const Duration(seconds: 5)),
        const SyncSuccess(SyncMode.sync));
    expect(h.calls, contains('asyncData'));
  });

  test('رفع الخطة بلا تغيّر من المشرف: تُرسل أصناف الخطة ولا تظهر رسالة',
      () async {
    UserInfo.otherstatus = 5;
    UserInfo.flag = 0;
    h.backend.overrides['checkActivePlanBrand'] =
        (_) => ok<LoginModel>(login(otherStatus: 0));

    final end = await h.run(const SyncStartEvent(SyncMode.sync));

    expect(end, const SyncSuccess(SyncMode.sync));
    expect(h.calls, contains('repPlanBrand'));
    expect(h.calls.indexOf('repPlanBrand'),
        lessThan(h.calls.indexOf('asyncData')));
  });

  test('حارس التشغيل: مزامنة ثانية أثناء الأولى تُتجاهل بالكامل', () async {
    final gate = Completer<void>();
    h.backend.overrides['allException'] = (_) async {
      await gate.future;
      return Right<Failure, List<ExceptionModel>>(<ExceptionModel>[]);
    };
    final second = Harness();
    addTearDown(second.close);

    final firstDone = h.run(const SyncStartEvent(SyncMode.sync));
    await Future<void>.delayed(const Duration(milliseconds: 50));
    second.bloc.add(const SyncStartEvent(SyncMode.sync));
    await Future<void>.delayed(const Duration(milliseconds: 100));

    expect(second.calls, isEmpty);
    expect(second.states, isEmpty);

    gate.complete();
    expect(await firstDone, const SyncSuccess(SyncMode.sync));
  });
}
