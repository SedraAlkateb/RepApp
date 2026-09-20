import 'package:dio/dio.dart';
import 'package:domina_app/data/network/error_handler.dart';
import 'package:flutter_test/flutter_test.dart';

DioException _bad(dynamic data, {int status = 500}) {
  final req = RequestOptions(path: '/x');
  return DioException(
    requestOptions: req,
    type: DioExceptionType.badResponse,
    response: Response(requestOptions: req, statusCode: status, data: data),
  );
}

void main() {
  test('رد نصي (HTML) لا يسبب انهياراً', () {
    final f = ErrorHandler.handle(_bad('<html>502 Bad Gateway</html>', status: 502))
        .failure;
    expect(f.code, 502);
    expect(f.massage, contains('502'));
  });

  test('رد JSON يقرأ message ثم error', () {
    expect(ErrorHandler.handle(_bad({'message': 'خطأ'})).failure.massage, 'خطأ');
    expect(ErrorHandler.handle(_bad({'error': 'boom'})).failure.massage, 'boom');
  });

  test('Map بلا message/error لا ينهار', () {
    final f = ErrorHandler.handle(_bad({'x': 1})).failure;
    expect(f.massage, isNotEmpty);
  });

  test('مهلة الاستقبال تُرجع Failure ولا ترمي', () {
    final req = RequestOptions(path: '/x');
    final e = DioException(
        requestOptions: req, type: DioExceptionType.receiveTimeout);
    expect(() => ErrorHandler.handle(e), returnsNormally);
  });
}
