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

class VisitBrandPharmacyModel {
  int id;
  int visitId;
  int brandId;
  int amount = 1;
  int? flag=0;
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

  factory VisitBrandPharmacyModel.fromJson(Map<String, dynamic> map) {
    return VisitBrandPharmacyModel(
        map['id'],
        map['visitId'],
        map['brandId'],
        int.parse(
          map['amount'],
        ),
        map['flag']
    );
  }
}
class BrandSpPlanModel{
  BrandModel brandModel;
  List<SpPlan> spPlan=[];
  BrandSpPlanModel(this.brandModel,this.spPlan);
}
class OtherBrandSpPlanModel{
  List<OtherBrandModel> brands=[];
  SpecModel specModel;
  OtherBrandSpPlanModel(this.specModel,this.brands);
}
class SpPlan{
  int id;
  int idSp;
  int amount;
  String title;
  String brandType;
  SpPlan(this.id,this.amount,this.title,this.brandType,this.idSp);
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
  OtherBrandModel(this.id, this.title, this.phTitle, this.flag, this.sampleCoast,this.Plan,this.amount,this.brandType);
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
  VisitDoctorRequest(this.id, this.visitDate, this.note, this.issue,
      this.special, this.doctorId, this.repPlanId,
      this.representativeId,this.flag,this.target);

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
'target':target
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
      map['target']
    );
  }
}

class VisitDoctorRequestBody {
  List<VisitDoctorModel> list1;//
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
  SpecModel specModel;
  VisitHospitalAndHospital(
      this.hospitalModel, this.visitHospitalModel, this.specModel);
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
      this.doctorId, this.flag,this.target, {this.repPlanId, this.representativeId});
  Map<String, dynamic> toMap() {
    return {
      'data': data,
      'kaswn': kaswn,
      'science': science,
      'additaion': additaion,
      'doctorId': doctorId,
      'flag': flag,
      'target':target
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
      'issue':  kaswn,
      'special': additaion,
      'target': target,
    };
  }

  factory VisitDoctorModel.fromMap(Map<String, dynamic> map) {
    return VisitDoctorModel(map['id'], map['data'], map['kaswn'],
        map['science'], map['additaion'], map['doctorId'], map['flag'],map['target']);
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
      map['target']
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
        map['flag'],
      map['visit_doctor_target']
    );
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
      this.additaion, this.hospitalSpId, this.flag,this.target);
  Map<String, dynamic> toMap() {
    return {
      'data': data,
      'kaswn': kaswn,
      'science': science,
      'additaion': additaion,
      'hospitalSpId': hospitalSpId,
      'flag': flag,
      'target':target
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
      'issue':  kaswn,
      'special': additaion,
      'target':target
    };
  }

  factory VisitHospitalModel.fromMap(Map<String, dynamic> map) {
    return VisitHospitalModel(map['id'], map['data'], map['kaswn'],
        map['science'], map['additaion'], map['hospitalSpId'], map['flag'],map['target']);
  }
  factory VisitHospitalModel.fromMap1(Map<String, dynamic> map) {
    return VisitHospitalModel(
        map['visit_hospital_id'],
        map['visit_hospital_data'],
        map['visit_hospital_kaswn'],
        map['visit_hospital_science'],
        map['visit_hospital_additaion'],
        map['visit_hospital_hospitalSpId'],
        map['flag'],map['target']);
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
  SpecModel specModel;
  HospitalSpModel hospitalSpModel;
  SpecHospitalSp(this.specModel, this.hospitalSpModel);
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
class SpecDModel {
  int id;
  String title;
  int sumDoctor;
  int sumHospital;
  SpecDModel(this.id, this.title,this.sumDoctor,this.sumHospital);
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'sumDoctor':sumDoctor,
      'sumHospital':sumHospital
    };
  }

  factory SpecDModel.fromMap(Map<String, dynamic> map) {
    return SpecDModel(
      map['id'],
      map['title'],
      map["sumDoctor"],
      map['sumHospital']
    );
  }
  factory SpecDModel.fromMap1(Map<String, dynamic> map,Map<String, dynamic> map1) {
    return SpecDModel(
      map['specialization_id'],
      map['specialization_title'],
      map['sumDoctor']??0,
      map1['sumHospital']??0
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
  int visited;
  String? note;
  String? rate;
  String spTitle;
  int spId;
  DoctorModel(
    this.id,
    this.title,
    this.placeId,
    this.address,
    this.placeTitle,
    this.visits,
    this.visited,
    this.note,
    this.rate,
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
      "visited": visited,
      "note": note,
      "rate": rate,
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
      map["visited"],
      map["note"],
      map["rate"],
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
      map['doctor_visited'],
      map["note"],
      map["rate"],
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
  String? rate;
  int visit;
  int visited;
  int flag;
  HospitalSpModel(this.id, this.hospitalId, this.spId, this.totalDocs,
      this.rate
      , this.visit,this.visited,this.flag,);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'hospitalId': hospitalId,
      'spId': spId,
      'totalDocs': totalDocs,
      "rate": rate,
      "visit": visit,
      "visited":visited,
      'flag':flag
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
        map["visited"],
        map['flag']
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
        map["visited"],
        map['flag']
    );
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
  int repId;
  int? otherPlanId = -1;
  int activePlanId;
  int? otherStatus = -1;
  int percentage;
  String name;
  int isLogin;

  LoginModel(this.token, this.repId, this.otherPlanId, this.activePlanId,
      this.otherStatus, this.name, this.percentage, this.isLogin);
  Map<String, dynamic> toMap() {
    return {
      'token': token,
      'repId': repId,
      'otherPlanId': otherPlanId == null ? -5 : otherStatus,
      'activePlanId': activePlanId,
      'otherStatus': otherStatus == null ? -5 : otherStatus,
      'name': name,
      'percentage': percentage,
      'isLogin': 1
    };
  }

  factory LoginModel.fromMap(Map<String, dynamic> map) {
    return LoginModel(
        map['token'],
        map['repId'],
        map['otherPlanId'],
        map['activePlanId'],
        map['otherStatus'],
        map['name'],
        map['percentage'],
        map['isLogin']);
  }
}

class Type {
  int i;
  String name;
  Type(this.i, this.name);
}

final List<Type> type = [Type(0, "دفاتر"), Type(1, "عينات"), 

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

class PlanBrandModel {
  int id;
  int spId;
  int brandId;
  int repPlanId;
  String brandType;
  String amount;
  PlanBrandModel(this.id, this.spId, this.brandId, this.repPlanId,
      this.brandType, this.amount);
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'spId': spId,
      'brandId': brandId,
      'repPlanId': repPlanId,
      'brandType': brandType,
      'amount': amount,
    };
  }
  factory PlanBrandModel.fromMap(Map<String, dynamic> map) {
    return PlanBrandModel(map['id'], map['spId'], map['brandId'], map['repPlanId'], map['brandType'], map['amount']);
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
  int visited;
  String? titleSp;
  HospitalSpAllModel(this.hospitalId, this.title, this.address, this.placeTitle,
      this.note, this.rate, this.totalDocs, this.visit,this.visited, this.titleSp);
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
      'titleSp': titleSp
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
        map['visited'],
        map['titleSp']);
  }
}
