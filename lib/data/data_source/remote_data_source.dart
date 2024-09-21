import 'package:domina_app/data/network/app_api.dart';
import 'package:domina_app/data/network/requests/requsets.dart';
import 'package:domina_app/data/responses/responses.dart';
import 'package:domina_app/domain/models/models.dart';

abstract class RemoteDataSource{

  Future<MessageResponse> logout();
  Future<LoginResponse > login(LoginRequest loginRequest);
  Future<AllPlaceBaseResponse > allPlaces(int id);
  Future<AllSpcBaseResponse> allSpecializations(int repDet);
  Future<AllMedicalVisitBaseResponse> allVisitDoctor( int repDet,);
  Future<AllCityBaseResponse> allCity();
  Future<AllMedicalRepresentativeBaseResponse> allMedicalRepresentative(int repDet);
  Future<AllBrandBaseResponse> allBrand(int id);
  Future<AllPharmacyBaseResponse> getAllPharmacy(int repDet);
 Future<AllDoctorsBaseResponse> getAllDoctor(int repDet);
  Future<AllHospitalBaseResponse> getAllHospital(int repDet);
  Future<AllHospitalSpBaseResponse> getAllHospitalSp(int repDet,);
  Future<Message1Response> visitPharmacy(VisitPharmacyRequestBody list1);
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
  Future<AllBrandBaseResponse> allBrand(id) async{
    return await _appServiceClient.allBrand(id);
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

  @override
  Future<AllHospitalSpBaseResponse> getAllHospitalSp(int repDet)async{
    return await _appServiceClient.getAllHospitalSp(repDet);
  }

  @override
  Future<Message1Response> visitPharmacy(VisitPharmacyRequestBody list1) async{
    return await _appServiceClient.visitPharmacy(list1);
  }




}