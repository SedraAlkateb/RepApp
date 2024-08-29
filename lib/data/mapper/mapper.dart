
import 'package:domina_app/app/constants.dart';
import 'package:domina_app/data/responses/responses.dart';
import 'package:domina_app/domain/models/models.dart';

extension UserResponseMapper on TokenResponse? {
  Token toDomain() {
    return Token(
      this?.token ?? Constants.empty,

    );
  }
}

extension AllPlaceResponseMapper on AllPlaceBaseResponse? {
  List<PlaceModel> toDomain() {
    List<PlaceModel> places =(this?.data.places.map((response) => response.toDomain()) ??
        const Iterable.empty())
        .cast<PlaceModel>()
        .toList();
    return places;
  }
}

extension PlaceResponseMapper on PlaceResponse? {
  PlaceModel toDomain() {
    return PlaceModel(
      this?.id ?? Constants.empty,
      this?.title ?? Constants.empty,
    );
  }
}
extension SpecResponseMapper on SpecResponse? {
  SpecModel toDomain() {
    return SpecModel(
      this?.id ?? Constants.empty,
      this?.title ?? Constants.empty,
    );
  }
}

extension AllSpecResponseMapper on AllSpcBaseResponse? {
  List<SpecModel> toDomain() {
    List<SpecModel> spec =(this?.data.specializations.map((response) => response.toDomain()) ??
        const Iterable.empty())
        .cast<SpecModel>()
        .toList();
    return spec;
  }
}