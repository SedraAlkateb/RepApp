import 'package:domina_app/data/network/app_api.dart';
import 'package:domina_app/data/network/requests/requsets.dart';
import 'package:domina_app/data/responses/responses.dart';

abstract class RemoteDataSource{
  Future<MessageResponse> logout(
      );
  Future<TokenResponse > login(LoginRequest loginRequest);

}

class RemoteDataSourceImpl implements RemoteDataSource {

  final AppServiceClient _appServiceClient;

  RemoteDataSourceImpl(this._appServiceClient);

  @override
  Future<TokenResponse> login(LoginRequest loginRequest) {
    // TODO: implement login
    throw UnimplementedError();
  }

  @override
  Future<MessageResponse> logout() {
    // TODO: implement logout
    throw UnimplementedError();
  }

}