class VisitPharmacyModel {
  int id;
  String data;
  String note;
  int pharmacyId;
  VisitPharmacyModel(this.id, this.data, this.note, this.pharmacyId);
  Map<String, dynamic> toJson() {
    return {
      'data': data,
      'note': note,
      'pharmacyId': pharmacyId,
    };
  }
  factory VisitPharmacyModel.fromMap(Map<String, dynamic> map) {
    return VisitPharmacyModel(
      map['id'],
      map['data'],
      map['note'],
      map['pharmacyId'],
    );
  }
  factory VisitPharmacyModel.fromMap1(Map<String, dynamic> map) {
    return VisitPharmacyModel(
      map['visit_pharmacy_id'],
      map['visit_pharmacy_data'],
      map['visit_pharmacy_note'],
      map['visit_pharmacy_pharmacyId'],
    );
  }
}

class VisitBrandPharmacyModel {
  int id;
  int visitId;
  int brandId;
  int amount=1;
  VisitBrandPharmacyModel(
      this.id,
      this.visitId,
      this.brandId,
      this.amount,
      );
  Map<String, dynamic> toJson() {
    return {
      'visitId': visitId,
      'brandId': brandId,
      'amount': amount==0?1:amount
    };
  }

  factory VisitBrandPharmacyModel.fromJson(Map<String, dynamic> map) {
    return VisitBrandPharmacyModel(
      map['id'],
      map['visitId'],
      map['brandId'],
      map['amount'],
    );
  }
}
class BrandModel {
  int id;
  String title;
  String phTitle;
  int falg;
  int sampleCoast;
  Map<String, dynamic> toMap(
      ) {
    return {
      'id': id,
      'title': title,
      'phTitle': phTitle,
      'falg': falg,
      'sampleCoast': sampleCoast
    };
  }

  factory BrandModel.fromMap(Map<String, dynamic> map) {
    return BrandModel(
      map['id'],
      map['title'],
      map['phTitle'],
      map['falg'],
      map['sampleCoast'],
    );
  }
  BrandModel(this.id, this.title, this.phTitle, this.falg, this.sampleCoast);
}
class PharmacyBrandModel {
  int id;
  String title;
  String phTitle;
  String? amount;
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'phTitle': phTitle,
      'amount': amount,
    };
  }

  factory PharmacyBrandModel.fromMap(Map<String, dynamic> map) {
    return PharmacyBrandModel(
      map['id'],
      map['title'],
      map['phTitle'],
      map['amount'],
    );
  }
  PharmacyBrandModel(this.id, this.title, this.phTitle, this.amount);
}

class VisitPharmacyRequest {
  String id;
  String VisitDate;
  String note;
  String pharmacyId;
  String repPlanId;
  String representativeId;

  VisitPharmacyRequest(this.id,this.repPlanId,this.representativeId,this.pharmacyId, this.VisitDate, this.note);
  Map<String, dynamic> toJson() {
    return {
      'id':id,
      'repPlanId':repPlanId,
      'representativeId':representativeId,
      'pharmacyId': pharmacyId,
      'VisitDate': VisitDate,
      'note': note
    };
  }
  factory VisitPharmacyRequest.fromMap(Map<String, dynamic> map) {
    return VisitPharmacyRequest(
      map['id'],
      map['repPlanId'],
      map['representativeId'],
      map['pharmacyId'],
      map['VisitDate'],
      map['note'],
    );
  }

}
class VisitPharmacyRequestBody {
  List<VisitPharmacyRequest> list1;
  List<VisitBrandPharmacyModel> list2;
  VisitPharmacyRequestBody(this.list1, this.list2);

  Map<String, dynamic> toJson() {
    return {
      'list1': list1.map((e) => e.toJson()).toList(),
      'list2': list2.map((e) => e.toJson()).toList(),
    };
  }
}
class VisitDoctorRequest {
  String id;
  String visitDate;
  String note;
  String issue;
  String special;

  String doctorId;
  String repPlanId;
  String representativeId;

  VisitDoctorRequest(this.id, this.visitDate, this.note, this.issue,
      this.special, this.doctorId, this.repPlanId, this.representativeId);

  Map<String, dynamic> toJson() {
    return {
      'id':id,
      'repPlanId':repPlanId,
      'representativeId':representativeId,
      'docId': doctorId,
      'visitDate': visitDate,
      'note': note,
      'issue': issue,
      'special': special
    };
  }
  factory VisitDoctorRequest.fromMap(Map<String, dynamic> map) {
    return VisitDoctorRequest(
      map['id'],
      map['VisitDate'],
      map['note'],
      map['issue'],
      map['special'],
      map['DoctorId'],
      map['repPlanId'],
      map['representativeId'],
    );
  }

}
class VisitDoctorRequestBody {
  List<VisitDoctorRequest> list1;
  List<VisitBrandPharmacyModel> list2;
  VisitDoctorRequestBody(this.list1, this.list2);

  Map<String, dynamic> toJson() {
    return {
      'list1': list1.map((e) => e.toJson()).toList(),
      'list2': list2.map((e) => e.toJson()).toList(),
    };
  }
}


class VisitHospitalRequest {
  String id;
  String visitDate;
  String note;
  String issue;
  String special;
  String splId;
  String hospitalId;
  String repPlanId;
  String representativeId;
  VisitHospitalRequest(this.id, this.visitDate, this.note, this.issue,
      this.special, this.hospitalId,this.splId, this.repPlanId, this.representativeId);

  Map<String, dynamic> toJson() {
    return {
      'id':id,
      'repPlanId':repPlanId,
      'representativeId':representativeId,
      'hospitalId': hospitalId,
      'splId': splId,
      'visitDate': visitDate,
      'note': note,
      'issue': issue,
      'special': special
    };
  }
  factory VisitHospitalRequest.fromMap(Map<String, dynamic> map) {
    return VisitHospitalRequest(
      map['id'],
      map['VisitDate'],
      map['note'],
      map['issue'],
      map['special'],
      map['hospitalId'],
      map['splId'],
      map['repPlanId'],
      map['representativeId'],
    );
  }

}
class VisitHospitalRequestBody {
  List<VisitHospitalRequest> list1;
  List<VisitBrandPharmacyModel> list2;

  VisitHospitalRequestBody(this.list1, this.list2);

  Map<String, dynamic> toJson() {
    return {
      'list1': list1.map((e) => e.toJson()).toList(),
      'list2': list2.map((e) => e.toJson()).toList(),
    };
  }
}


class VisitPharmacyAndPharmacy{
  PharmacyModel pharmacyModel;
  VisitPharmacyModel visitPharmacyModel;
  VisitPharmacyAndPharmacy(this.pharmacyModel,this.visitPharmacyModel);
}
class VisitDoctorAndDoctor{
  DoctorModel doctorModel;
  VisitDoctorModel visitDoctorModel;
  VisitDoctorAndDoctor(this.doctorModel,this.visitDoctorModel);
}
class VisitHospitalAndHospital{
  HospitalModel hospitalModel;
  VisitHospitalModel visitHospitalModel;
  SpecModel specModel;
  VisitHospitalAndHospital(this.hospitalModel,this.visitHospitalModel,this.specModel);
}
class VisitDoctorModel {
  int id;
  String data;
  String kaswn;
  String science;
  String additaion;
  int doctorId;
  VisitDoctorModel(this.id, this.data, this.kaswn, this.science, this.additaion,
      this.doctorId);
  Map<String, dynamic> toJson() {
    return {
      'data': data,
      'kaswn': kaswn,
      'science': science,
      'additaion': additaion,
      'doctorId': doctorId
    };
  }
  factory VisitDoctorModel.fromMap(Map<String, dynamic> map) {
    return VisitDoctorModel(
      map['id'],
      map['data'],
      map['kaswn'],
      map['science'],
      map['additaion'],
      map['doctorId']
    );
  }
  factory VisitDoctorModel.fromMap1(Map<String, dynamic> map) {
    return VisitDoctorModel(
      map['visit_doctor_id'],
      map['visit_doctor_data'],
      map['visit_doctor_kaswn'],
      map['visit_doctor_science'],
      map['visit_doctor_additaion'],
      map['visit_doctor_doctorId'],
    );
  }
}
class VisitHospitalModel {
  int id;
  String data;
  String kaswn;
  String science;
  String additaion;
  int hospitalSpId;
  VisitHospitalModel(this.id, this.data, this.kaswn, this.science, this.additaion,
      this.hospitalSpId);
  Map<String, dynamic> toJson() {
    return {
      'data': data,
      'kaswn': kaswn,
      'science': science,
      'additaion': additaion,
      'hospitalSpId': hospitalSpId
    };
  }
  factory VisitHospitalModel.fromMap(Map<String, dynamic> map) {
    return VisitHospitalModel(
        map['id'],
        map['data'],
        map['kaswn'],
        map['science'],
        map['additaion'],
        map['hospitalSpId']
    );
  }
  factory VisitHospitalModel.fromMap1(Map<String, dynamic> map) {
    return VisitHospitalModel(
      map['visit_hospital_id'],
      map['visit_hospital_data'],
      map['visit_hospital_kaswn'],
      map['visit_hospital_science'],
      map['visit_hospital_additaion'],
      map['visit_hospital_hospitalSpId'],
    );
  }
}

class PlaceModel {
  int placeId;
  String title;
  PlaceModel(this.placeId, this.title);
  Map<String, dynamic> toMap() {
    return {
      'placeId': placeId,
      'title': title,
    };
  }

  factory PlaceModel.fromMap(Map<String, dynamic> map) {
    return PlaceModel(
      map['placeId'],
      map['title'],
    );
  }
}
class SpecHospitalSp{
  SpecModel specModel;
  HospitalSpModel hospitalSpModel;
  SpecHospitalSp(this.specModel,this.hospitalSpModel);
}
class SpecModel {
  int id;
  String title;
  SpecModel(this.id, this.title);
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
    };
  }

  factory SpecModel.fromMap(Map<String, dynamic> map) {
    return SpecModel(
      map['id'],
      map['title'],
    );
  }
  factory SpecModel.fromMap1(Map<String, dynamic> map) {
    return SpecModel(
      map['specialization_id'],
      map['specialization_title'],
    );
  }
}
class MedicalVisits {
  int visID;
  String visitDate;
  String title;
  String address;
  String note;
  String issue;
  String spTitle;
  String special;
  String brands;

  MedicalVisits(this.visID, this.visitDate, this.title, this.address, this.note,
      this.issue, this.spTitle, this.special, this.brands); // from
  Map<String, dynamic> toMap() {
    return {
      'visID': visID,
      'visitDate': visitDate,
      'title': title,
      'address': address,
      'note': note,
      'issue': issue,
      'spTitle': spTitle,
      'brands': brands
    };
  }

  factory MedicalVisits.fromMap(Map<String, dynamic> map) {
    return MedicalVisits(
        map['visID'],
        map['visitDate'],
        map['title'],
        map['address'],
        map['note'],
        map['issue'],
        map['spTitle'],
        map['special'],
        map['brands']);
  }
}

class PharmacyModel {
  int id;
  String title;
  int placeId;
  String address;
  PharmacyModel(this.id, this.title, this.placeId, this.address);
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'placeId': placeId,
      'address': address,
    };
  }

  factory PharmacyModel.fromMap(Map<String, dynamic> map) {
    return PharmacyModel(
     map['id'],
      map['title'],
      map['placeId'],
      map['address'],
    );
  }
  factory PharmacyModel.fromMap1(Map<String, dynamic> map) {
    return PharmacyModel(
      (map['pharmacy_id']),
      map['pharmacy_title'],
      map['pharmacy_placeId'],
      map['pharmacy_address'],
    );
  }
}

class DoctorModel {
  int id;
  String title;
  int placeId;
  String address;

  String placeTitle;

  String visits;

  String spTitle;
  int spId;
  DoctorModel(
    this.id,
    this.title,
    this.placeId,
    this.address,
    this.placeTitle,
    this.visits,
    this.spTitle,
    this.spId,
  );
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'placeId': placeId,
      'address': address,
      "placeTitle": placeTitle,
      "visits": visits,
      "spTitle": spTitle,
      "spId": spId,
    };
  }

  factory DoctorModel.fromMap(Map<String, dynamic> map) {
    return DoctorModel(
      map['id'],
      map['title'],
      map['placeId'],
      map['address'],
      map["placeTitle"],
      map["visits"],
      map["spTitle"],
      map['spId'],
    );
  }
  factory DoctorModel.fromMap1(Map<String, dynamic> map) {
    return DoctorModel(
      (map['doctor_id']),
      map['doctor_title'],
      map['doctor_placeId'],
      map['doctor_address'],
      map['doctor_placeTitle'],
      map['doctor_visits'],
      map['doctor_spTitle'],
      map['doctor_spId'],
    );
  }
}
class HospitalSpModel {
  int id;
  int hospitalId;
  int spId;
  int totalDocs;
  String rate;
  int visit;
  HospitalSpModel(this.id, this.hospitalId, this.spId, this.totalDocs,
      this.rate, this.visit);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'hospitalId': hospitalId,
      'spId': spId,
      'totalDocs': totalDocs,
      "rate": rate,
      "visit": visit,
    };
  }
  factory HospitalSpModel.fromMap(Map<String, dynamic> map) {
    return HospitalSpModel(
      map['id'],
      map['hospitalId'],
      map['spId'],
      map['totalDocs'],
      map["rate"],
      map["visit"],
    );
  }
  factory HospitalSpModel.fromMap1(Map<String, dynamic> map) {
    return HospitalSpModel(
      map['hospitalSp_id'],
      map['hospitalId'],
      map['spId'],
      map['totalDocs'],
      map["rate"],
      map["visit"],
    );
  }
}
class HospitalModel {
  int id;
  String title;
  int placeId;
  String address;

  String placeTitle;

  HospitalModel(
      this.id,
      this.title,
      this.placeId,
      this.address,
      this.placeTitle
      );
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'placeId': placeId,
      'address': address,
      "placeTitle": placeTitle
    };
  }

  factory HospitalModel.fromMap(Map<String, dynamic> map) {
    return HospitalModel(
      map['id'],
      map['title'],
      map['placeId'],
      map['address'],
      map["placeTitle"],
    );
  }
  factory HospitalModel.fromMap1(Map<String, dynamic> map) {
    return HospitalModel(
      map['hospital_id'],
      map['hospital_title'],
      map['hospital_placeId'],
      map['hospital_address'],
      map["hospital_placeTitle"],
    );
  }
}
class CityModel {
  int id;
  String name;
  CityModel(this.id, this.name);
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }

  factory CityModel.fromMap(Map<String, dynamic> map) {
    return CityModel(
      map['id'],
      map['name'],
    );
  }
}

class LoginModel {
  String token;
  int repId;
  int planId;
  int percentage;
  String name;
  int isLogin;

  LoginModel(this.token, this.repId, this.planId, this.name, this.percentage,
      this.isLogin);
  Map<String, dynamic> toMap() {
    return {
      'token': token,
      'repId': repId,
      'planId': planId,
      'name': name,
      'percentage': percentage,
      'isLogin': 1
    };
  }

  factory LoginModel.fromMap(Map<String, dynamic> map) {
    return LoginModel(map['token'], map['repId'], map['planId'], map['name'],
        map['percentage'], map['isLogin']);
  }
}
class Type{
  int i;
  String name;
  Type(this.i,this.name);
}

final List<Type> type=[Type(0, "دفاتر"),Type(1, "عينات"),Type(2, "وصفات")];