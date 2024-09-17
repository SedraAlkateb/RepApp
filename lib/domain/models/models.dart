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

  factory VisitPharmacyModel.fromMap(Map<String, dynamic> map) {
    return VisitPharmacyModel(
      map['id'],
      map['data'],
      map['note'],
      map['pharmacyId'],
    );
  }
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
  Map<String, dynamic> toMap() {
    return {
      'data': data,
      'kaswn': kaswn,
      'science': science,
      'additaion': additaion,
      'doctorId': doctorId,
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

class BrandModel {
  int id;
  String title;
  String phTitle;
  int falg;
  int sampleCoast;
  Map<String, dynamic> toMap() {
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
