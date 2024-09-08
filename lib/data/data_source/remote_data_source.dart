import 'package:domina_app/data/network/app_api.dart';
import 'package:domina_app/data/network/requests/requsets.dart';
import 'package:domina_app/data/responses/responses.dart';

abstract class RemoteDataSource{

  Future<MessageResponse> logout();
  Future<LoginResponse > login(LoginRequest loginRequest);
  Future<AllPlaceBaseResponse > allPlaces(int id);
  Future<AllSpcBaseResponse> allSpecializations(int repDet);
  Future<AllMedicalVisitBaseResponse> allVisitDoctor( int repDet,);
  Future<AllCityBaseResponse> allCity();
  Future<AllMedicalRepresentativeBaseResponse> allMedicalRepresentative(int repDet);
  Future<AllBrandBaseResponse> allBrand();
  Future<AllPharmacyBaseResponse> getAllPharmacy(int repDet);
 Future<AllDoctorsBaseResponse> getAllDoctor(int repDet);
  Future<AllHospitalBaseResponse> getAllHospital(int repDet);
}

class RemoteDataSourceImpl implements RemoteDataSource {

  final AppServiceClient _appServiceClient;

  RemoteDataSourceImpl(this._appServiceClient);

  @override
  Future<LoginResponse> login(LoginRequest loginRequest) async{
    return await _appServiceClient.login(loginRequest.email,loginRequest.password);
  }

  @override
  Future<MessageResponse> logout() {

    throw UnimplementedError();
  }

  @override
  Future<AllPlaceBaseResponse> allPlaces(int id) async{
  return await _appServiceClient.allPlace(id);
  }

  @override
  Future<AllSpcBaseResponse> allSpecializations(int repDet) async{
    return await _appServiceClient.allSpecializations(repDet);
  }

  @override
  Future<AllBrandBaseResponse> allBrand() async{
    return await _appServiceClient.allBrand();
  }

  @override
  Future<AllMedicalRepresentativeBaseResponse> allMedicalRepresentative(int repDet) async{
    return await _appServiceClient.allMedicalRepresentative(repDet);
  }

  @override
  Future<AllCityBaseResponse> allCity() async{
    return await _appServiceClient.allCity();
  }

  @override
  Future<AllMedicalVisitBaseResponse> allVisitDoctor(int repDet) async{
    return await _appServiceClient.allVisitDoctor(repDet);
  }

  @override
  Future<AllPharmacyBaseResponse> getAllPharmacy(int repDet) async{
    return await _appServiceClient.getAllPharmacy(repDet);
  }
  
  @override
  Future<AllDoctorsBaseResponse> getAllDoctor(int repDet)async{
    return await _appServiceClient.getAllDoctor(repDet);
  }
  
  @override
  Future<AllHospitalBaseResponse> getAllHospital(int repDet) async{
    return await _appServiceClient.getAllHospital(repDet);
  }
}