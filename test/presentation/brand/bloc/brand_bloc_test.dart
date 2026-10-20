// اختبار BrandBloc: نتأكد إن كل Event يوصّل الـ Bloc لـ State الصح،
// بدون ما نلمس قاعدة بيانات حقيقية — نستخدم Fake لـ RepositorySql.
import 'package:dartz/dartz.dart';
import 'package:domina_app/app/logger/app_logger.dart';
import 'package:domina_app/domain/failure.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/domain/repository/repository_sql.dart';
import 'package:domina_app/domain/usecase/all_brands_sql_usecase.dart';
import 'package:domina_app/presentation/brand/bloc/brand_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

/// Fake بسيط لـ RepositorySql: نطبّق بس getBrandsSql (اللي يحتاجه هذا التيست)،
/// وأي method ثانية غير متوقَّع استدعاؤها تفشل عبر noSuchMethod.
class FakeRepositorySql implements RepositorySql {
  FakeRepositorySql({this.brands, this.failure});
  final List<BrandModel>? brands;
  final Failure? failure;

  @override
  Future<Either<Failure, List<BrandModel>>> getBrandsSql() async {
    if (failure != null) return Left(failure!);
    return Right(brands ?? []);
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

BrandModel brandModel({int id = 1, String title = 'Panadol'}) =>
    BrandModel(id, title, 'الاسم العلمي', 0, 0, '', '', '');

void main() {
  final logger = AppLogger.get('BrandBlocTest');
  group('BrandBloc', () {
    test('AllBrandEvent مع نجاح الـ usecase يصدر AllBrandState بالبيانات', () async {
      final brand = brandModel(title: 'Panadol');
      final usecase = AllBrandsSqlUsecase(FakeRepositorySql(brands: [brand]));
      final bloc = BrandBloc(usecase);

      final firstState = bloc.stream.first; // نبدأ الاستماع قبل ما نرسل الحدث
      bloc.add(AllBrandEvent());
      logger.info("bloc.add(AllBrandEvent());");

      final state = await firstState;
      logger.fine('الحالة المستلمة: ${state.runtimeType}');
      expect(state, isA<AllBrandState>());
      expect((state as AllBrandState).brand.map((b) => b.title), ['Panadol']);

      await bloc.close();
    });

    test('AllBrandEvent مع فشل الـ usecase يصدر AllBrandErrorState', () async {
      logger.info('اختبار: AllBrandEvent (فشل)');
      final failure = Failure(500, 'خطأ بالسيرفر');
      final usecase = AllBrandsSqlUsecase(FakeRepositorySql(failure: failure));
      final bloc = BrandBloc(usecase);

      final firstState = bloc.stream.first;
      bloc.add(AllBrandEvent());
      final state = await firstState;
      logger.warning('الحالة المستلمة: ${state.runtimeType}');
      expect(state, isA<AllBrandErrorState>());
      expect((state as AllBrandErrorState).failure.massage, 'خطأ بالسيرفر');

      await bloc.close();
    });
  });
  group('BrandBloc - Search Tests', () {
    late FakeRepositorySql fakeRepository;
    late AllBrandsSqlUsecase usecase;
    late BrandBloc bloc;

    // يُنفّذ هذا البلوك تلقائياً قبل كل test منفصل
    setUp(() async {
      final mockBrands = [
        brandModel(id: 1, title: 'Panadol'),
        brandModel(id: 2, title: 'Eanadol'),
        brandModel(id: 3, title: 'Panadol Sq'),
      ];
      fakeRepository = FakeRepositorySql(brands: mockBrands);
      usecase = AllBrandsSqlUsecase(fakeRepository);
      bloc = BrandBloc(usecase);

      // نجهز الـ BLoC بالبيانات الأولية مرة واحدة لكل الاختبارات
      final nextState = bloc.stream.first;
      bloc.add(AllBrandEvent());
      await nextState;
    });

    tearDown(() async {
      await bloc.close(); // ينظف الموارد بعد كل اختبار
    });

    test('البحث بكلمة مطابقة يرجع العناصر الصحيحة فقط', () async {
      final nextState = bloc.stream.first;
      bloc.add(SearchbradEvent('Panadol'));
      final state = await nextState;

      expect((state as AllBrandState).brand.length, 2);
    });

    test('البحث بنص غير موجود يرجع قائمة فارغة', () async {
      final nextState = bloc.stream.first;
      bloc.add(SearchbradEvent('Qanadol'));
      final state = await nextState;

      expect((state as AllBrandState).brand, isEmpty);
    });

    test('البحث بنص فارغ يرجع القائمة كاملة', () async {
      bloc.add(SearchbradEvent(""));
      expect((bloc.state as AllBrandState).brand.length, 3);
    });
  });

}
