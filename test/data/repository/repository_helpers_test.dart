// اختبارات سلوك الـ helpers المشتركة في الـ repositories:
// RepositoryImp._remoteCall و RepositroySqlImp._sqlCall / _sqlRun.
import 'package:dartz/dartz.dart';
import 'package:domina_app/data/data_source/remote_data_source.dart';
import 'package:domina_app/data/network/app_sql_api.dart';
import 'package:domina_app/data/network/error_handler.dart';
import 'package:domina_app/data/network/network_info.dart';
import 'package:domina_app/data/repository/repositroy_sql.dart';
import 'package:domina_app/data/repository/repository.dart';
import 'package:domina_app/data/responses/responses.dart';
import 'package:domina_app/domain/ex.dart';
import 'package:domina_app/domain/failure.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:flutter_test/flutter_test.dart';

class FakeNetworkInfo implements NetworkInfo {
  FakeNetworkInfo(this.connected);
  bool connected;

  /// إن وُجدت قيم هنا فتُستهلك واحدة واحدة عند كل فحص، ثم يُرجع [connected].
  final sequence = <bool>[];

  @override
  Future<bool> get isConnected async =>
      sequence.isNotEmpty ? sequence.removeAt(0) : connected;
}

class FakeRemote implements RemoteDataSource {
  Future<AllCityBaseResponse> Function()? onAllCity;
  Future<AllPlaceBaseResponse> Function()? onAllPlaces;
  Future<LoginResponse> Function()? onLogin;
  Future<InventoryResponseBaseResponse> Function()? onInventory;

  /// ما وصل إلى سجل الأخطاء في الخادم.
  final serverLogs = <ExceptionModel>[];
  int calls = 0;

  @override
  Future<AllCityBaseResponse> allCity() {
    calls++;
    return onAllCity!();
  }

  @override
  Future<AllPlaceBaseResponse> allPlaces(int id) {
    calls++;
    return onAllPlaces!();
  }

  @override
  Future<LoginResponse> login(LoginRequest loginRequest) {
    calls++;
    return onLogin!();
  }

  @override
  Future<InventoryResponseBaseResponse> getInventory(int repDet, int planId) {
    calls++;
    return onInventory!();
  }

  @override
  Future<Message1Response> insertLog(ExceptionRequestBody list) async {
    serverLogs.addAll(list.list1);
    return Message1Response();
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

/// ما وصل إلى سجل الأخطاء المحلي (SQLite).
class FakeExc implements ExcRepository {
  final localLogs = <ExceptionModel>[];

  @override
  Future<Either<Failure, Null>> exceptionApi(
      ExceptionModel exceptionModel) async {
    localLogs.add(exceptionModel);
    return const Right(null);
  }
}

class FakeSqlApi implements AppSqlApi {
  Future<List<BrandModel>> Function()? onGetBrands;
  Object? clearError;
  int clearCalls = 0;

  @override
  Future<List<BrandModel>> getBrands() => onGetBrands!();

  @override
  Future<void> clearDatabase() async {
    clearCalls++;
    if (clearError != null) throw clearError!;
  }

  // في AppSqlApi هذه الدوال بلا نوع إرجاع، فتُرجع Future<dynamic> وقت التشغيل.
  // نُبقيها كذلك عمداً لأن الخطأ السابق ظهر بسببها فقط.
  Object? untypedResult;

  @override
  insertPlace(List<PlaceModel> places) async {
    return untypedResult;
  }

  @override
  updateOtherStatus(
      int repId, int status, List<OtherBrandSpPlanModel> planBrands) async {
    return untypedResult;
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

Failure? leftOf<T>(Either<Failure, T> r) => r.fold((f) => f, (_) => null);
T? rightOf<T>(Either<Failure, T> r) => r.fold((_) => null, (v) => v);

/// insertLog غير منتظَر داخل الـ repository، فنترك حلقة الأحداث تكمل.
Future<void> settle() => Future<void>.delayed(Duration.zero);

void main() {
  group('RepositoryImp._remoteCall', () {
    late FakeRemote remote;
    late FakeNetworkInfo network;
    late FakeExc exc;
    late RepositoryImp repo;

    setUp(() {
      remote = FakeRemote();
      network = FakeNetworkInfo(true);
      exc = FakeExc();
      repo = RepositoryImp(remote, network, exc);
    });

    test('نجاح: يُرجع Right بقيمة التحويل ولا يسجّل شيئاً', () async {
      remote.onAllCity = () async => AllCityBaseResponse(null);

      final result = await repo.allCity();
      await settle();

      expect(rightOf(result), isEmpty);
      expect(remote.serverLogs, isEmpty);
      expect(exc.localLogs, isEmpty);
    });

    test('فشل منطقي (status غير ناجح): Left برسالة الخادم + تسجيل بالوسم',
        () async {
      remote.onAllCity = () async =>
          AllCityBaseResponse(null)
            ..status = '500'
            ..message = 'boom';

      final result = await repo.allCity();
      await settle();

      final failure = leftOf(result)!;
      expect(failure.massage, 'boom');
      expect(failure.code, ApiInternalStatus.FAILURE);
      expect(remote.serverLogs.map((e) => e.type), ['allCity']);
      expect(remote.serverLogs.single.exceptionModel, 'boom');
    });

    test('بدون رسالة من الخادم: تُستعمل الرسالة الافتراضية', () async {
      remote.onAllCity = () async => AllCityBaseResponse(null)..status = '500';

      final failure = leftOf(await repo.allCity())!;

      expect(failure.massage, ResponseMassage.DEFAULT);
    });

    test('استثناء: Left عبر ErrorHandler + تسجيل بالوسم', () async {
      remote.onAllCity = () async => throw Exception('kaboom');

      final result = await repo.allCity();
      await settle();

      expect(leftOf(result)!.massage, contains('kaboom'));
      expect(remote.serverLogs.map((e) => e.type), ['allCity']);
    });

    test('لا إنترنت: Left دون استدعاء الخادم ودون تسجيل (الافتراضي)', () async {
      network.connected = false;
      remote.onAllCity = () async => AllCityBaseResponse(null);

      final result = await repo.allCity();
      await settle();

      expect(leftOf(result)!.massage,
          DataSource.NO_INTERNET_CONNECTION.getFailure().massage);
      expect(remote.calls, 0);
      expect(remote.serverLogs, isEmpty);
    });

    test('logNoInternet: allPlace تحاول تسجيل حالة انعدام الاتصال', () async {
      // الفحص الأول (داخل allPlace) منقطع، وفحص insertLog التالي متصل حتى
      // نلاحظ أن المحاولة حدثت. (insertLog نفسها ترفض الإرسال إن كان
      // الاتصال مقطوعاً، وهذا سلوك الكود الأصلي.)
      network.sequence.addAll([false, true]);
      remote.onAllPlaces = () async => AllPlaceBaseResponse(null);

      final result = await repo.allPlace(1);
      await settle();

      expect(leftOf(result), isNotNull);
      expect(remote.calls, 0);
      expect(remote.serverLogs.map((e) => e.type), ['allPlace']);
    });

    test('isSuccess مخصّص: login لا يعتبر status=null نجاحاً', () async {
      remote.onLogin = () async => LoginResponse(null)..message = 'no';

      final result = await repo.login(LoginRequest('a', 'b'));
      await settle();

      expect(leftOf(result)!.massage, 'no');
      expect(remote.serverLogs.map((e) => e.type), ['login']);
    });

    test('log محلي: getInventory تسجّل في SQLite لا في الخادم', () async {
      remote.onInventory = () async =>
          InventoryResponseBaseResponse(null)
            ..status = '500'
            ..message = 'inv';

      final result = await repo.getInventory(1, 2);
      await settle();

      expect(leftOf(result)!.massage, 'inv');
      expect(exc.localLogs.map((e) => e.type), ['getInventory']);
      expect(remote.serverLogs, isEmpty);
    });
  });

  group('RepositroySqlImp._sqlCall / _sqlRun', () {
    late FakeSqlApi db;
    late FakeExc exc;
    late RepositroySqlImp repo;

    setUp(() {
      db = FakeSqlApi();
      exc = FakeExc();
      repo = RepositroySqlImp(db, exc);
    });

    test('_sqlCall نجاح: Right بالقيمة ولا تسجيل', () async {
      db.onGetBrands = () async => [];

      final result = await repo.getBrandsSql();

      expect(rightOf(result), isEmpty);
      expect(exc.localLogs, isEmpty);
    });

    test('_sqlCall استثناء: Left + تسجيل محلي بالوسم', () async {
      db.onGetBrands = () async => throw Exception('db down');

      final result = await repo.getBrandsSql();

      expect(leftOf(result)!.massage, contains('db down'));
      expect(exc.localLogs.map((e) => e.type), ['getBrandsSql']);
    });

    test('_sqlRun نجاح: ينفّذ العملية ويُرجع Right(null)', () async {
      final result = await repo.clearDatabase();

      expect(db.clearCalls, 1);
      expect(result.isRight(), isTrue);
      expect(exc.localLogs, isEmpty);
    });

    test('دالة DB بلا نوع إرجاع (Future<dynamic>) لا تكسر Either<Failure, Null>',
        () async {
      // انحدار: كانت تفشل بـ "type 'Future<dynamic>' is not a subtype of
      // type 'Future<Null>?'" فتتعطل المزامنة وتسجيل الدخول المحلي.
      final place = await repo.insertPlace([]);
      final status = await repo.updateOtherStatus(1, 2, []);

      expect(place.isRight(), isTrue, reason: leftOf(place)?.massage);
      expect(status.isRight(), isTrue, reason: leftOf(status)?.massage);
      expect(exc.localLogs, isEmpty);
    });

    test('دالة DB بلا نوع إرجاع تُرجع قيمة غير null: تبقى Left كما كانت',
        () async {
      // السلوك الأصلي: Right(response) بنوع Null يفشل ويُلتقط في catch.
      db.untypedResult = 42;

      final result = await repo.insertPlace([]);

      expect(result.isLeft(), isTrue);
      expect(exc.localLogs.map((e) => e.type), ['insertPlace']);
    });

    test('_sqlRun استثناء: Left + تسجيل محلي بالوسم', () async {
      db.clearError = Exception('locked');

      final result = await repo.clearDatabase();

      expect(leftOf(result)!.massage, contains('locked'));
      expect(exc.localLogs.map((e) => e.type), ['clearDatabase']);
    });
  });
}
