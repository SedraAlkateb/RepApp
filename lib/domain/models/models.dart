
class Token {
  String token;
  Token(this.token);
}
class PlaceModel {
  String id;
  String title;
  PlaceModel(this.id,this.title);
}
class SpecModel {
  String id;
  String title;
  SpecModel(this.id,this.title);
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
}

class CityModel {
  String id;
  String name;
  CityModel(this.id,this.name);
}
class BrandModel {
  String id;
  String title;
  String phTitle;
  BrandModel(this.id,this.title,this.phTitle);
}
class PharmacyModel {
  String id;
  String title;
  String placeId;
  String address;
  PharmacyModel(this.id,this.title,this.placeId,this.address);
}
