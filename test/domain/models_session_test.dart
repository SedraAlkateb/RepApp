import 'package:domina_app/domain/models/models.dart';
import 'package:flutter_test/flutter_test.dart';

/// يثبّت ما يُحقَن في JSON المرسَل للخادم (هوية المندوب/الخطة) الآن بعد أن
/// صار يُمرَّر صراحةً من الطبقات الخارجية بدل قراءته من حالة عامة.
void main() {
  test('VisitPharmacyModel.toJson يحقن الخطة والمندوب الممرَّرين', () {
    final j = VisitPharmacyModel(1, 'd', 'n', 9)
        .toJson(repPlanId: 7, representativeId: 42);
    expect(j['repPlanId'], 7);
    expect(j['representativeId'], 42);
    expect(j['pharmacyId'], 9);
  });

  test('VisitDoctorRequestBody.toJson يختم كل زيارة بالخطة والمندوب', () {
    final body = VisitDoctorRequestBody(
      [VisitDoctorModel(1, 'd', 'k', 's', 'a', 5, 0, 't')],
      [],
      repPlanId: 7,
      representativeId: 42,
    );
    final item = (body.toJson()['list1'] as List).single as Map;
    expect(item['repPlanId'], 7);
    expect(item['representativeId'], 42);
    expect(item['docId'], 5);
  });

  test('VisitHospitalRequestBody.toJson', () {
    final body = VisitHospitalRequestBody(
      [VisitHospitalModel(1, 'd', 'k', 's', 'a', 3, 0, 't')],
      [],
      repPlanId: 7,
      representativeId: 42,
    );
    final item = (body.toJson()['list1'] as List).single as Map;
    expect(item['repPlanId'], 7);
    expect(item['representativeId'], 42);
    expect(item['hospitalSpId'], 3);
  });

  test('ExceptionRequestBody.toJson يحقن repId', () {
    final body = ExceptionRequestBody(
        [ExceptionModel('e', 't', createDate: 'c')],
        repId: 42);
    final item = (body.toJson()['list1'] as List).single as Map;
    expect(item['repId'], 42);
    expect(item['issue'], 'e');
  });

  test('getAllFlags يضيف نوع 4 فقط عندما يكون نوع مندوب الجلسة 4', () {
    expect(getAllFlags(1, currentRepTypeId: 4).map((f) => f.flag), contains(4));
    expect(getAllFlags(1, currentRepTypeId: 8).map((f) => f.flag),
        isNot(contains(4)));
  });
}
