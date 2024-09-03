
class Token {
  String token;
  Token(this.token);
}
class PlaceModel {
  int id;
  String title;
  PlaceModel(this.id,this.title);
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
    };
  }
  factory PlaceModel.fromMap(Map<String, dynamic> map) {
    return PlaceModel(
      map['id'],
      map['title'],
    );
  }
}
class SpecModel {
  int id;
  String title;
  SpecModel(this.id,this.title);
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
class MedicalVisits{
  String visID;
  String visitDate;
  String title;
  String address;
  String note;
  String issue;
  String spTitle;
  String special;
  String brands;

  MedicalVisits(
      this.visID,
      this.visitDate,
      this.title,
      this.address,
      this.note,
      this.issue,
      this.spTitle,
      this.special,
      this.brands); // from
  Map<String, dynamic> toMap() {
    return {
      'visID': visID,
      'visitDate': visitDate,
      'title':title,
      'address':address,
      'note':note,
      'issue':issue,
      'spTitle':spTitle,
      'brands':brands

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
      map['brands']


    );
  }
}
class BrandModel {
  int id;
  String title;
  String phTitle;
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'phTitle': phTitle,
    };
  }
  factory BrandModel.fromMap(Map<String, dynamic> map) {
    return BrandModel(
       map['id'],
       map['title'],
       map['phTitle'],
    );
  }

  BrandModel(this.id,this.title,this.phTitle);
}
class PharmacyModel {
  int id;
  String title;
  String placeId;
  String address;
  PharmacyModel(this.id,this.title,this.placeId,this.address);
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

class DoctorModel{

  String  id;

  String title;

  String placeId;

  String address;

  String placeTitle;
  
  String visits;
   
  String spTitle;
  DoctorModel(this.id,this.title,this.placeId,this.address,this.placeTitle,this.visits,this.spTitle);
}

class CityModel {
  int id;
  String name;
  CityModel(this.id,this.name);
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
