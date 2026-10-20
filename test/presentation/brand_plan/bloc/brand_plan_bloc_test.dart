import 'package:domina_app/app/logger/app_logger.dart';
import 'package:domina_app/domain/repository/repository_sql.dart';
import 'package:flutter_test/flutter_test.dart';

class FakeRepositorySql implements RepositorySql {
  FakeRepositorySql();

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
void main() {
  final logger = AppLogger.get('changeFormField');

  group('BrandBloc', () {
    test('AllBrandEvent مع نجاح الـ usecase يصدر AllBrandState بالبيانات', () async {

    });

  });
}