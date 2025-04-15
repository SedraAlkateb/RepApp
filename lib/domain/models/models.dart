import 'dart:io';
import 'package:domina_app/app/user_info.dart';

class VisitPharmacyModel {
  int id;
  String data;
  String note;
  int pharmacyId;
  VisitPharmacyModel(this.id, this.data, this.note, this.pharmacyId);
  Map<String, dynamic> toMap() {
    return {
      'data': data,
      'note': note,
      'pharmacyId': pharmacyId,
    };
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'repPlanId': UserInfo.activePlanId,
      'representativeId': UserInfo.repId,
      'pharmacyId': pharmacyId,
      'VisitDate': data,
      'note': note
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

class BrandSpPlanModel {
  BrandModel brandModel;
  List<SpPlan> spPlan = [];
  BrandSpPlanModel(this.brandModel, this.spPlan);
}

class OtherBrandSpPlanModel {
  List<OtherBrandModel> brands = [];
  SpecDModel specModel;
  int brandk;
  int brandm;
  OtherBrandSpPlanModel(this.specModel, this.brands, this.brandk, this.brandm);
}

class SpPlan {
  int id;
  int idSp;
  int flagSp;
  int amount;
  String title;
  String brandType;
  int sumDoctor;
  int sumHospital;
  int sumBrandHospital;
  SpPlan(this.id, this.amount, this.title, this.brandType, this.idSp,
      this.flagSp, this.sumDoctor, this.sumHospital, this.sumBrandHospital);
}

class BrandAddition {
  int id;
  String title;
  String phTitle;
  int amount;

  BrandAddition(this.id, this.title, this.phTitle, this.amount);
}

class BrandModel {
  int id;
  String title;
  String phTitle;
  int flag;
  int sampleCoast;
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'phTitle': phTitle,
      'falg': flag,
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
  BrandModel(this.id, this.title, this.phTitle, this.flag, this.sampleCoast);
}

class OtherBrandModel {
  int id;
  String title;
  String phTitle;
  int flag;
  int sampleCoast;
  int Plan;
  int amount;
  String brandType;
  OtherBrandModel(this.id, this.title, this.phTitle, this.flag,
      this.sampleCoast, this.Plan, this.amount, this.brandType);
}

class FutureBrandModel {
  int id;
  String title;
  String phTitle;
  int flag;
  int amount;
  String brandType;
  FutureBrandModel(this.id, this.title, this.phTitle, this.flag, this.amount,
      this.brandType);
}

class VisitBrandPharmacyModel {
  int id;
  int visitId;
  int brandId;
  int amount = 1;
  int? flag = 0;
  VisitBrandPharmacyModel(
      this.id, this.visitId, this.brandId, this.amount, this.flag);
  Map<String, dynamic> toJson() {
    return {
      'visitId': visitId,
      'brandId': brandId,
      'amount': amount == 0 ? 1 : amount,
      //  'flag': flag
    };
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'visitId': visitId,
      'brandId': brandId,
      'amount': amount == 0 ? 1 : amount,
      'flag': 1
    };
  }

  factory VisitBrandPharmacyModel.fromJson(Map<String, dynamic> map) {
    return VisitBrandPharmacyModel(
        map['id'],
        map['visitId'],
        map['brandId'],
        int.parse(
          map['amount'],
        ),
        1);
  }

  factory VisitBrandPharmacyModel.fromJson1(Map<String, dynamic> map) {
    return VisitBrandPharmacyModel(
        map['id'],
        map['visitId'],
        map['brandId'],
        int.parse(
          map['amount'],
        ),
        map['flag']);
  }
}

class PharmacyBrandModel {
  int id;
  String title;
  String phTitle;
  String amount;
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'phTitle': phTitle,
      'amount': amount,
    };
  }

  Map<String, dynamic> toMapEditBrand(PharmacyBrandModel brand, int visitId) {
    return {
      'visitId': visitId,
      'brandId': brand.id,
      'amount': brand.amount == 0 ? 1 : brand.amount,
      'flag': 0
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

  VisitPharmacyRequest(this.id, this.repPlanId, this.representativeId,
      this.pharmacyId, this.VisitDate, this.note);
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'repPlanId': repPlanId,
      'representativeId': representativeId,
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
  List<VisitPharmacyModel> list1;
  List<VisitBrandPharmacyModel> list2;
  VisitPharmacyRequestBody(this.list1, this.list2);

  Map<String, dynamic> toJson() {
    return {
      'list1': list1.map((e) => e.toJson()).toList(),
      'list2': list2.map((e) => e.toJson()).toList(),
    };
  }
}

class RepPlanBrandBody {
  List<PlanBrandModel> planBrand;
  RepPlanBrandBody(this.planBrand);
  Map<String, dynamic> toJson() {
    return {
      'list1': planBrand.map((e) => e.toMap()).toList(),
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
  int flag;
  String target;
  VisitDoctorRequest(
      this.id,
      this.visitDate,
      this.note,
      this.issue,
      this.special,
      this.doctorId,
      this.repPlanId,
      this.representativeId,
      this.flag,
      this.target);

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'repPlanId': repPlanId,
      'representativeId': representativeId,
      'docId': doctorId,
      'visitDate': visitDate,
      'note': note,
      'issue': issue,
      'special': special,
      'target': target
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
        map['flag'],
        map['target']);
  }
}

class VisitDoctorRequestBody {
  List<VisitDoctorModel> list1; ////
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
  String hospitalSpId;
  String repPlanId;
  String representativeId;
  VisitHospitalRequest(this.id, this.visitDate, this.note, this.issue,
      this.special, this.hospitalSpId, this.repPlanId, this.representativeId);

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'repPlanId': repPlanId,
      'representativeId': representativeId,
      'hospitalSpId': hospitalSpId,
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
      map['hospitalSpId'],
      map['repPlanId'],
      map['representativeId'],
    );
  }
}

class VisitHospitalRequestBody {
  List<VisitHospitalModel> list1;
  List<VisitBrandPharmacyModel> list2;
  VisitHospitalRequestBody(this.list1, this.list2);
  Map<String, dynamic> toJson() {
    return {
      'list1': list1.map((e) => e.toJson()).toList(),
      'list2': list2.map((e) => e.toJson()).toList(),
    };
  }
}

class ExceptionRequestBody {
  List<ExceptionModel> list1;
  ExceptionRequestBody(this.list1);
  Map<String, dynamic> toJson() {
    return {
      'list1': list1.map((e) => e.toJson()).toList(),
    };
  }
}

class ExceptionRequestBody2 {
  ExceptionModel list1;
  ExceptionRequestBody2(this.list1);
  Map<String, dynamic> toJson() {
    return {
      'list1': list1,
    };
  }
}

class VisitPharmacyAndPharmacy {
  PharmacyModel pharmacyModel;
  VisitPharmacyModel visitPharmacyModel;
  VisitPharmacyAndPharmacy(this.pharmacyModel, this.visitPharmacyModel);
}

class VisitDoctorAndDoctor {
  DoctorModel doctorModel;
  VisitDoctorModel visitDoctorModel;
  VisitDoctorAndDoctor(this.doctorModel, this.visitDoctorModel);
}

class VisitHospitalAndHospital {
  HospitalModel hospitalModel;
  VisitHospitalModel visitHospitalModel;
  SpecDModel specModel;
  VisitHospitalAndHospital(
      this.hospitalModel, this.visitHospitalModel, this.specModel);
}

class VisitDoctorBase {
  List<VisitBrandPharmacyModel> brand;
  List<VisitDoctorModel> data;
  VisitDoctorBase(this.brand, this.data);
}

class VisitHospitalBase {
  List<VisitBrandPharmacyModel> brand;
  List<VisitHospitalModel> data;
  VisitHospitalBase(this.brand, this.data);
}

class VisitDoctorModel {
  int id;
  String data;
  String? kaswn;
  String? science;
  String? additaion;
  int doctorId;
  String? repPlanId;
  String? representativeId;
  int? flag = 0;
  String? target;
  VisitDoctorModel(this.id, this.data, this.kaswn, this.science, this.additaion,
      this.doctorId, this.flag, this.target,
      {this.repPlanId, this.representativeId});
  Map<String, dynamic> toMap1() {
    return {
      'data': data,
      'kaswn': kaswn,
      'science': science,
      'additaion': additaion,
      'doctorId': doctorId,
      'flag': flag,
      'target': target
    };
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'data': data,
      'kaswn': kaswn ?? "",
      'science': science ?? "",
      'additaion': additaion ?? "",
      'doctorId': doctorId,
      'flag': flag ?? 0,
      'target': target ?? ""
    };
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'repPlanId': UserInfo.activePlanId,
      'representativeId': UserInfo.repId,
      'docId': doctorId,
      'visitDate': data,
      'note': science,
      'issue': kaswn,
      'special': additaion,
      'target': target,
    };
  }

  factory VisitDoctorModel.fromMap(Map<String, dynamic> map) {
    return VisitDoctorModel(
        map['id'],
        map['data'],
        map['kaswn'],
        map['science'],
        map['additaion'],
        map['doctorId'],
        map['flag'],
        map['target']);
  }
  factory VisitDoctorModel.fromMap2(Map<String, dynamic> map) {
    return VisitDoctorModel(
        map['id'],
        map['data'],
        map['kaswn'],
        map['science'],
        map['additaion'],
        map['doctorId'],
        repPlanId: UserInfo.activePlanId.toString(),
        representativeId: UserInfo.repId.toString(),
        map['flag'],
        map['target']);
  }
  factory VisitDoctorModel.fromMap1(Map<String, dynamic> map) {
    return VisitDoctorModel(
        map['visit_doctor_id'],
        map['visit_doctor_data'],
        map['visit_doctor_kaswn'],
        map['visit_doctor_science'],
        map['visit_doctor_additaion'],
        map['visit_doctor_doctorId'],
        map['flag'],
        map['visit_doctor_target']);
  }
}

class VisitHospitalModel {
  int id;
  String data;
  String? kaswn;
  String? science;
  String? additaion;
  int hospitalSpId;
  int? flag = 0;
  String? target;
  VisitHospitalModel(this.id, this.data, this.kaswn, this.science,
      this.additaion, this.hospitalSpId, this.flag, this.target);
  Map<String, dynamic> toMap1() {
    return {
      'data': data,
      'kaswn': kaswn,
      'science': science,
      'additaion': additaion,
      'hospitalSpId': hospitalSpId,
      'flag': flag,
      'target': target
    };
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'data': data,
      'kaswn': kaswn,
      'science': science,
      'additaion': additaion,
      'hospitalSpId': hospitalSpId,
      'flag': flag,
      'target': target
    };
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'repPlanId': UserInfo.activePlanId,
      'representativeId': UserInfo.repId,
      'hospitalSpId': hospitalSpId,
      'visitDate': data,
      'note': science,
      'issue': kaswn,
      'special': additaion,
      'target': target
    };
  }

  factory VisitHospitalModel.fromMap(Map<String, dynamic> map) {
    return VisitHospitalModel(
        map['id'],
        map['data'],
        map['kaswn'],
        map['science'],
        map['additaion'],
        map['hospitalSpId'],
        map['flag'],
        map['target']);
  }
  factory VisitHospitalModel.fromMap1(Map<String, dynamic> map) {
    return VisitHospitalModel(
        map['visit_hospital_id'],
        map['visit_hospital_data'],
        map['visit_hospital_kaswn'],
        map['visit_hospital_science'],
        map['visit_hospital_additaion'],
        map['visit_hospital_hospitalSpId'],
        map['flag'],
        map['target']);
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

class SpecHospitalSp {
  SpecDModel specModel;
  HospitalSpModel hospitalSpModel;
  SpecHospitalSp(this.specModel, this.hospitalSpModel);
}

class SpecDModel {
  int id;
  String title;
  int flag;
  int sumDoctor;
  int sumHospital;
  int sumBrandHospital;
  SpecDModel(this.id, this.title, this.flag, this.sumDoctor, this.sumHospital,
      this.sumBrandHospital);
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'flag': flag,
      'sumDoctor': sumDoctor,
      'sumHospital': sumHospital,
      'sumBrandHospital': sumBrandHospital,
    };
  }

  factory SpecDModel.fromJson(Map<String, dynamic> map) {
    return SpecDModel(map['id'], map['title'], map['flag'], map["sumDoctor"],
        map['sumHospital'], map['sumBrandHospital']);
  }
  factory SpecDModel.fromMap(Map<String, dynamic> map) {
    return SpecDModel(
        map['specialization_id'],
        map['specialization_title'],
        map['specialization_flag'],
        map["sumDoctor"],
        map['sumHospital'],
        map['sumBrandHospital']);
  }
  factory SpecDModel.fromMap2(Map<String, dynamic> map) {
    return SpecDModel(map['specialization_id'], map['specialization_title'],
        map['specialization_flag'], 0, 0, 0);
  }
  factory SpecDModel.fromMap1(
      Map<String, dynamic> map, Map<String, dynamic> map1) {
    return SpecDModel(
        map['specialization_id'],
        map['specialization_title'],
        map['specialization_flag'],
        map['sumDoctor'] ?? 0,
        map1['sumHospital'] ?? 0,
        map1['sumBrandHospital'] ?? 0);
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
      'note': issue,
      'issue': note,
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
  int visits;
  String? note;
  String? rate;
  String spTitle;
  int spId;
  int? visited;
  String? workHours;
  DoctorModel(
      this.id,
      this.title,
      this.placeId,
      this.address,
      this.placeTitle,
      this.visits,
      this.note,
      this.rate,
      this.spTitle,
      this.spId,
      this.workHours,
      {this.visited});
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'placeId': placeId,
      'address': address,
      "placeTitle": placeTitle,
      "visits": visits,
      "note": note,
      "rate": rate,
      "spTitle": spTitle,
      "spId": spId,
      "workHours": workHours
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
        map["note"],
        map["rate"],
        map["spTitle"],
        map['spId'],
        visited: map["visited"],
        map['workHours']);
  }
  factory DoctorModel.fromMap1(Map<String, dynamic> map) {
    return DoctorModel(
        (map['doctor_id']),
        map['doctor_title'],
        map['doctor_placeId'],
        map['doctor_address'],
        map['doctor_placeTitle'],
        map['doctor_visits'],
        visited: map['doctor_visited'],
        map["note"],
        map["rate"],
        map['doctor_spTitle'],
        map['doctor_spId'],
        map['workHours']);
  }
}

//
class DoctorIssueModel {
  String docTitle;
  String spTitle;
  String address;
  String visitDate;
  String? issue;
  DoctorIssueModel(
      this.docTitle, this.spTitle, this.address, this.visitDate, this.issue);
  Map<String, dynamic> toMap() {
    return {
      'docTitle': docTitle,
      'spTitle': spTitle,
      'address': address,
      'visitDate': visitDate,
      "issue": issue,
    };
  }

  factory DoctorIssueModel.fromMap(Map<String, dynamic> map) {
    return DoctorIssueModel(
      map['docTitle'],
      map['spTitle'],
      map['address'],
      map['visitDate'],
      map["issue"],
    );
  }
  factory DoctorIssueModel.fromMap1(Map<String, dynamic> map) {
    return DoctorIssueModel(
      (map['docTitle']),
      map['spTitle'],
      map['address'],
      map['visitDate'],
      map['issue'],
    );
  }
}

//
class DoctorNoteModel {
  String docTitle;
  String spTitle;
  String address;
  String visitDate;
  String? note;

  DoctorNoteModel(
      this.docTitle, this.spTitle, this.address, this.visitDate, this.note);
  Map<String, dynamic> toMap() {
    return {
      'docTitle': docTitle,
      'spTitle': spTitle,
      'address': address,
      'visitDate': visitDate,
      "note": note,
    };
  }

  factory DoctorNoteModel.fromMap(Map<String, dynamic> map) {
    return DoctorNoteModel(
      map['docTitle'],
      map['spTitle'],
      map['address'],
      map['visitDate'],
      map["note"],
    );
  }
  factory DoctorNoteModel.fromMap1(Map<String, dynamic> map) {
    return DoctorNoteModel(
      (map['docTitle']),
      map['spTitle'],
      map['address'],
      map['visitDate'],
      map['note'],
    );
  }
}

class NoVisitDocModel {
  String docTitle;
  String spTitle;
  String address;
  String rate;
  String? visits;
  NoVisitDocModel(
      this.docTitle, this.spTitle, this.address, this.rate, this.visits);
  Map<String, dynamic> toMap() {
    return {
      'docTitle': docTitle,
      'spTitle': spTitle,
      'address': address,
      'rate': rate,
      "visits": visits,
    };
  }

  factory NoVisitDocModel.fromMap(Map<String, dynamic> map) {
    return NoVisitDocModel(
      map['docTitle'],
      map['spTitle'],
      map['address'],
      map['rate'],
      map["visits"],
    );
  }
}

class HospitalSpModel {
  int id;
  int hospitalId;
  int spId;
  int totalDocs;
  String? rate;
  int visit;
  int? visited;
  int flag;
  HospitalSpModel(
    this.id,
    this.hospitalId,
    this.spId,
    this.totalDocs,
    this.rate,
    this.visit,
    this.flag, {
    this.visited,
  });
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'hospitalId': hospitalId,
      'spId': spId,
      'totalDocs': totalDocs,
      "rate": rate,
      "visit": visit,
      'flag': flag
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
        visited: map["visited"],
        map['flag']);
  }
  factory HospitalSpModel.fromMap1(Map<String, dynamic> map) {
    return HospitalSpModel(
        map['hospitalSp_id'],
        map['hospitalId'],
        map['spId'],
        map['totalDocs'],
        map["rate"],
        map["visit"],
        visited: map["visited"],
        map['flag']);
  }
}

class HospitalModel {
  int id;
  String title;
  int placeId;
  String address;
  String? note;
  String placeTitle;

  HospitalModel(this.id, this.title, this.placeId, this.address, this.note,
      this.placeTitle);
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'placeId': placeId,
      'address': address,
      "note": note,
      "placeTitle": placeTitle,
    };
  }

  factory HospitalModel.fromMap(Map<String, dynamic> map) {
    return HospitalModel(
      map['id'],
      map['title'],
      map['placeId'],
      map['address'],
      map["note"],
      map["placeTitle"],
    );
  }
  factory HospitalModel.fromMap1(Map<String, dynamic> map) {
    return HospitalModel(
      map['hospital_id'],
      map['hospital_title'],
      map['hospital_placeId'],
      map['hospital_address'],
      map["note"],
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
  int cityId;
  int repId;
  int? otherPlanId = -1;
  int? activePlanId;
  int? otherStatus = -1;
  int percentage;
  int samplesCount;
  String name;
  int isLogin;
  String? endDate;
  String? startDate;
  int flag;
  int recipesCount;
  String? otherStartDate;
  String? otherEndDate;
  int flag1;
  String repType;
  LoginModel(
      this.samplesCount,
      this.token,
      this.repId,
      this.otherPlanId,
      this.activePlanId,
      this.otherStatus,
      this.name,
      this.percentage,
      this.isLogin,
      this.startDate,
      this.endDate,
      this.flag,
      this.recipesCount,
      this.flag1,
      this.cityId,
      this.repType,
      {this.otherStartDate,
      this.otherEndDate});
  Map<String, dynamic> toMap() {
    return {
      'samplesCount': samplesCount,
      'token': token,
      'repId': repId,
      'cityId': cityId,
      'otherPlanId': otherPlanId == null ? -5 : otherStatus,
      'activePlanId': activePlanId == null ? -5 : activePlanId,
      'otherStatus': otherStatus == null ? -5 : otherStatus,
      'name': name,
      'percentage': percentage,
      'isLogin': 1,
      'endDate': endDate,
      'startDate': startDate,
      'flag': flag,
      'flag1': flag1,
      'recipesCount': recipesCount,
      'otherStartDate': otherStartDate,
      'otherEndDate': otherEndDate,
      'repType': repType
    };
  }

  factory LoginModel.fromMap(Map<String, dynamic> map) {
    return LoginModel(
      map['samplesCount'] ?? 0,
      map['token'] ?? "",
      map['repId'] ?? 0,
      map['otherPlanId'] ?? 0,
      map['activePlanId'] ?? -5,
      map['otherStatus'] ?? 0,
      map['name'] ?? "",
      map['percentage'] ?? 0,
      map['isLogin'] ?? 0,
      map['startDate'] ?? "",
      map['endDate'] ?? "",
      map['flag'] ?? 0,
      map['recipesCount'] ?? 0,
      map['flag1'] ?? 0,
      map['cityId'] ?? 0,
      map['repType'] ?? "0",
      otherStartDate: map['otherStartDate'] ?? "",
      otherEndDate: map['otherEndDate'] ?? "",
    );
  }
}

class Type {
  int i;
  String name;
  Type(this.i, this.name);
}

final List<Type> type = [
  Type(0, "دفاتر"),
  Type(1, "عينات"),
  Type(2, "لاشيء"),
];
final List<Type> brandType = [
  Type(1, "هدف"),
  Type(2, "مساعد"),
  Type(3, "لاشيء"),
];

class BrandSpModel {
  int id;
  int spId;
  int brandId;
  String brandType;
  BrandSpModel(this.id, this.spId, this.brandId, this.brandType);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'spId': spId,
      'brandId': brandId,
      'brandType': brandType,
    };
  }

  factory BrandSpModel.fromMap(Map<String, dynamic> map) {
    return BrandSpModel(
        map['id'], map['spId'], map['brandId'], map['brandType']);
  }
}

class Rep {
  int activeRepId;
  int? otherRepId;
  int? flag;
  Rep(this.activeRepId, this.flag, {this.otherRepId});
}

class RepSp {
  int spId;
  int repPlanId;
  int repId;
  RepSp(this.repPlanId, this.spId, this.repId);
}

class PlanBrandModel {
  int id;
  int spId;
  int brandId;
  int repPlanId;
  String brandType;
  String title;
  String amount;
  PlanBrandModel(this.id, this.spId, this.brandId, this.repPlanId,
      this.brandType, this.title, this.amount);
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'spId': spId,
      'brandId': brandId,
      'repPlanId': repPlanId,
      'brandType': brandType,
      //  'title': title,
      'amount': amount,
    };
  }

  factory PlanBrandModel.fromMap(Map<String, dynamic> map) {
    return PlanBrandModel(map['id'], map['spId'], map['brandId'],
        map['repPlanId'], map['brandType'], "", map['amount']);
  }
}

class PlanBrandsSp {
  int id;
  int spId;
  int brandId;
  String brandType;
  String titleAr;
  String phTitle;
  String totalAmount;

  // Constructor
  PlanBrandsSp(this.id, this.spId, this.brandId, this.brandType, this.titleAr,
      this.phTitle, this.totalAmount);
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'spId': spId,
      'brandId': brandId,
      'brandType': brandType,
      'titleAr': titleAr,
      'phTitle': phTitle,
      'totalAmount': totalAmount,
    };
  }

  factory PlanBrandsSp.fromMap(Map<String, dynamic> map) {
    return PlanBrandsSp(map['id'], map['spId'], map['brandId'],
        map['brandType'], map['titleAr'], map['phTitle'], map['totalAmount']);
  }
}

class BrandPlanBrandsSpWithSamples {
  int totalSamplesDoctors;
  int totalSamplesHospitals;
  int totalSamplesDepartments;

  // Constructor
  BrandPlanBrandsSpWithSamples(this.totalSamplesDoctors,
      this.totalSamplesHospitals, this.totalSamplesDepartments);
  Map<String, dynamic> toMap() {
    return {
      'totalSamplesDoctors': totalSamplesDoctors,
      'totalSamplesHospitals': totalSamplesHospitals,
      'totalSamplesDepartments': totalSamplesDepartments,
    };
  }

  factory BrandPlanBrandsSpWithSamples.fromMap(Map<String, dynamic> map) {
    return BrandPlanBrandsSpWithSamples(map['totalSamplesDoctors'],
        map['totalSamplesHospitals'], map['totalSamplesDepartments']);
  }
}

class ExceptionModel {
  String exceptionModel;
  String type;
  String createDate;
  ExceptionModel(this.exceptionModel, this.type, {String? createDate})
      : createDate = createDate ?? DateTime.now().toString();
  Map<String, dynamic> toMap() {
    return {
      'exception': exceptionModel.toString(),
      'type': type.toString(),
      'createDate': createDate
    };
  }

  Map<String, dynamic> toJson() {
    return {
      'repId': UserInfo.repId,
      'issue': exceptionModel.toString(),
      'type': type.toString(),
      'createDate': createDate
    };
  }

  factory ExceptionModel.fromMap(Map<String, dynamic> map) {
    return ExceptionModel(
      map['exception'],
      map['type'],
      createDate: map['createDate'],
    );
  }
}

class PlanBrandSqlModel {
  int id;
  int repPlanId;
  String brandType;
  int amount;
  String phTitle;
  String brandTitle;
  int sampleCoast;
  String specializationTitle;

  PlanBrandSqlModel(
      this.id,
      this.repPlanId,
      this.brandType,
      this.amount,
      this.phTitle,
      this.brandTitle,
      this.sampleCoast,
      this.specializationTitle);

  Map<String, dynamic> toMap() {
    return {
      'id': id.toString(),
      'repPlanId': repPlanId.toString(),
      'brandType': brandType.toString(),
      'amount': amount.toString(),
      'phTitle': phTitle.toString(),
      'brandTitle': brandTitle.toString(),
      'sampleCoast': sampleCoast.toString(),
      'specializationTitle': specializationTitle.toString(),
    };
  }

  factory PlanBrandSqlModel.fromMap(Map<String, dynamic> map) {
    return PlanBrandSqlModel(
        map['id'],
        map['repPlanId'],
        map['brandType'],
        int.parse(map['amount']),
        map['phTitle'],
        map['brandTitle'],
        map['sampleCoast'],
        map['specializationTitle']);
  }
}

class ActiveModel {
  int id;
  int active;
  ActiveModel(this.id, this.active);
}

class CheckActiveModel {
  int activePlanId;
  int? otherPlanId;
  int? otherstatus;
  CheckActiveModel(this.activePlanId, this.otherPlanId, this.otherstatus);
}
//  hospital.id
//       hospital.title
//        hospital.address
//       hospital.placeTitle
//       hospital.note
//       hospitalSp.rate
//       hospitalSp.totalDocs
//       hospitalSp.visit
//       specialization.title as titleSp

class HospitalSpAllModel {
  int? hospitalId;
  String? title;
  String? address;
  String? placeTitle;
  String? note;
  String? rate;
  int totalDocs;
  int visit;
  int? visited;
  String? titleSp;
  int? flagSp;
  HospitalSpAllModel(
      this.hospitalId,
      this.title,
      this.address,
      this.placeTitle,
      this.note,
      this.rate,
      this.totalDocs,
      this.visit,
      this.titleSp,
      this.flagSp,
      {this.visited});
  Map<String, dynamic> toMap() {
    return {
      'hospitalId': hospitalId,
      'title': title,
      'address': address,
      'placeTitle': placeTitle,
      'note': note,
      'rate': rate,
      'totalDocs': totalDocs,
      'visit': visit,
      'visited': visited,
      'titleSp': titleSp,
      'flagSp': flagSp
    };
  }

  factory HospitalSpAllModel.fromMap(Map<String, dynamic> map) {
    return HospitalSpAllModel(
        map['hospitalId'],
        map['title'],
        map['address'],
        map['placeTitle'],
        map['note'],
        map['rate'],
        map['totalDocs'],
        map['visit'],
        visited: map['visited'],
        map['titleSp'],
        map['flagSp']);
  }
}

class BrandRes {
  int id;
  String title_en;
  BrandRes(this.id, this.title_en);
}

class StatePlan {
  int index;
  int state;
  StatePlan(this.index, this.state);
//state 0 true , state 1 more state 2 0
}

class UpdateReciRequest {
  int recipeId;
  int recipeType;
  String repId;
  String type;
  String docId;
  String spName;
  String brand_1;
  String address;
  String phone;
  String total;
  String? flagImage1;
  String? flagImage2;
  String? note1;
  String? note2;
  String? note_emp;
  File? image1;
  File? image2;
  String? brand_2;
  String? brand_3;
  String? brand_4;
  String? create_date;
  String? print_date;

  UpdateReciRequest(
    this.recipeId,
    this.recipeType,
    this.repId,
    this.type,
    this.docId,
    this.spName,
    this.brand_1,
    this.address,
    this.phone,
    this.total,
    this.create_date,
    this.print_date, {
    this.note1,
    this.note2,
    this.flagImage1,
    this.flagImage2,
    this.note_emp,
    this.image1,
    this.image2,
    this.brand_2,
    this.brand_3,
    this.brand_4,
  });

  Map<String, dynamic> toJson() {
    return {
      "recipeId": recipeId,
      "recipeType": recipeType,
      "repId": repId,
      "type": type,
      "docId": docId,
      "spName": spName,
      "brand_1": brand_1,
      "address": address,
      "phone": phone,
      "total": total,
      "create_date": create_date,
      "print_date": print_date,
      "note1": note1,
      "note2": note2,
      "flagImage1": flagImage1,
      "flagImage2": flagImage2,
      "note_emp": note_emp,
      "image1": image1,
      "image2": image2,
      "brand_2": brand_2,
      "brand_3": brand_3,
      "brand_4": brand_4,
    };
  }
}

class ReciRequest {
  int recipeType;
  String repId;
  String type;
  String docId;
  String spName;
  String brand_1;
  String address;
  String phone;
  String total;
  String? flagImage1;
  String? flagImage2;
  String? note1;
  String? note2;
  String? note_emp;
  File? image1;
  File? image2;
  String? brand_2;
  String? brand_3;
  String? brand_4;

  ReciRequest(
    this.recipeType,
    this.repId,
    this.type,
    this.docId,
    this.spName,
    this.brand_1,
    this.address,
    this.phone,
    this.total, {
    this.note1,
    this.note2,
    this.flagImage1,
    this.flagImage2,
    this.note_emp,
    this.image1,
    this.image2,
    this.brand_2,
    this.brand_3,
    this.brand_4,
  });
}

class CopyReciRequest {
  int id;
  int repId;
  int type;
  int docId;
  String spName;
  BrandRes brand_1;
  BrandRes? brand_2;
  BrandRes? brand_3;
  BrandRes? brand_4;
  String? note1;
  String? note2;
  String address;
  String phone;
  String total;
  String? note_emp;
  String? image1;
  String? image2;
  String? create_date;
  String? print_date;

  CopyReciRequest(
    this.id,
    this.repId,
    this.type,
    this.docId,
    this.spName,
    this.brand_1,
    this.address,
    this.phone,
    this.total,
    this.create_date,
    this.print_date, {
    this.note1,
    this.note2,
    this.note_emp,
    this.image1,
    this.image2,
    this.brand_2,
    this.brand_3,
    this.brand_4,
  });
}

class StateImage {
  int id;
  String type;
  StateImage(this.id, this.type);
}

List<StateImage> stateImage = [
  StateImage(0, "لا يوجد صورة"),
  StateImage(1, "تكرار صورة"),
  StateImage(2, "اضافة صورة")
];

class LoginRequest {
  String email;
  String password;

  LoginRequest(this.email, this.password);
}

class AllRepresentative {
  int id;
  int activePlan;
  String name;
  int number;
  AllRepresentative(this.id, this.name, this.number, this.activePlan);
}

class AllRepresentativeFuture {
  int id;
  int activePlan;
  String name;
  FlagModel flag;
  AllRepresentativeFuture(this.id, this.name, this.flag, this.activePlan);
}

class FlagModel {
  final int flag;
  final String name;

  FlagModel(this.flag) : name = _getFlagName(flag);

  static String _getFlagName(int flag) {
    switch (flag) {
      case 0:
        return "بانتظار موافقة المندوب";
      case 1:
        return "بانتظار موافقة المشرف";
      case 2:
        return "فعالة";
      case 3:
        return "منتهية";
      case 4:
        return "بانتظار موافقة المستودع";
      default:
        return "خطأ";
    }
  }
}

class InventoryModel {
  String title;
  String used;
  String total;
  int rest;
  InventoryModel(this.title, this.used, this.total, this.rest);
}

class AsRead {
  int visitId;
  int userId;
  int status;
  int reqType;
  AsRead(this.visitId, this.userId, this.status, this.reqType);
}

class ChangePlanBrandType {
  int id;
  int brandType;

  ChangePlanBrandType(this.id, this.brandType);
}

class InfoRep {
  int id;
  String name;
  String mobile;
  String address;
  String sampleCount;

  String recipesCount;
  int repPlanId;
  int totalVisit;
  int visitDon;
  int visitNoteYet;
  InfoRep(
      this.id,
      this.name,
      this.mobile,
      this.address,
      this.sampleCount,
      this.recipesCount,
      this.repPlanId,
      this.totalVisit,
      this.visitDon,
      this.visitNoteYet);
}

class VisitRepSen {
  int repId;
  int userId;
  VisitRepSen(this.repId, this.userId);
}

class ReadAll {
  int repPlanId;
  int userId;
  int type;
  int flag;
  ReadAll(this.repPlanId, this.userId, this.type, this.flag);
}

class RepVisitsModel {
  String visitId;
  String visitDate;
  String placeTitle;
  String docTitle;
  String rate;
  String spTitle;
  String note;
  String issue;
  String special;
  String target;
  bool flag;
  List<String> samples;
  RepVisitsModel(
      this.visitId,
      this.visitDate,
      this.placeTitle,
      this.docTitle,
      this.rate,
      this.spTitle,
      this.note,
      this.issue,
      this.special,
      this.target,
      this.flag,
      this.samples);
}

class RepVisitsModelSearch {
  int index;
  String visitId;
  String visitDate;
  String placeTitle;
  String docTitle;
  String rate;
  String spTitle;
  String note;
  String issue;
  String special;
  String target;
  bool flag;
  List<String> samples;
  RepVisitsModelSearch(
      this.index,
      this.visitId,
      this.visitDate,
      this.placeTitle,
      this.docTitle,
      this.rate,
      this.spTitle,
      this.note,
      this.issue,
      this.special,
      this.target,
      this.flag,
      this.samples);
}

class BrandFlag {
  int id;
  String brand;
  int flag;

  BrandFlag(this.id, this.brand, this.flag);
}

class NumVisit {
  int visitDoctor;
  int visitHospital;
  NumVisit(this.visitDoctor, this.visitHospital);
}

class ReciModel {
  String? id;
  String? docName;
  String? create_date;
  String? total;
  String? note_emp;
  String docId;
  String recipeType;
  ReciModel(this.id, this.docName, this.create_date, this.total, this.note_emp,
      this.docId, this.recipeType);
}

class PlanBrandSp {
  int id;
  int brandId;
  int brandType;
  String titleAr;
  int spId;
  String phTitle;
  int totalAmount;

  PlanBrandSp(this.id, this.brandId, this.brandType, this.titleAr, this.spId,
      this.phTitle, this.totalAmount);
}

class doctorsModel {
  int id;
  String name;
  String spTitle;
  String placeTitle;

  doctorsModel(this.id, this.name, this.spTitle, this.placeTitle);
}

class DocdoctorsModel {
  String repName;
  String visitDate;
  String issue;
  String note;

  DocdoctorsModel(this.repName, this.visitDate, this.issue, this.note);
}

class BrandAmountModel {
  int numDoctor;
  int numHospital;
  int numDepartment;
  BrandAmountModel(this.numDoctor, this.numHospital, this.numDepartment);
}

class AllPlanBrandSp {
  List<PlanBrandSp> planBrandSps;
  int amount;

  AllPlanBrandSp(this.planBrandSps, this.amount);
}
