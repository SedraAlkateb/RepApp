
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


