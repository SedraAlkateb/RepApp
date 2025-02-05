import 'package:domina_app/app/user_info.dart';
import 'package:domina_app/data/network/app_api.dart';
import 'package:domina_app/data/responses/responses.dart';
import 'package:domina_app/domain/models/models.dart';

abstract class RemoteDataSource {
  Future<LoginResponse> login(LoginRequest loginRequest);
  Future<AllPlaceBaseResponse> allPlaces(int id);
  Future<AllSpcBaseResponse> allSpecializations(int repDet);
  Future<AllMedicalVisitBaseResponse> allVisitDoctor(
    int repDet,
  );
  Future<CheckRepResponse> checkRep(int repDet);
  Future<AllCityBaseResponse> allCity();

  Future<AllBrandBaseResponse> allBrand(int id);
  Future<AllPharmacyBaseResponse> getAllPharmacy(int repDet);
  Future<AllDoctorsBaseResponse> getAllDoctor(int repDet);
  Future<AllHospitalBaseResponse> getAllHospital(int repDet);
  Future<AllHospitalSpBaseResponse> getAllHospitalSp(
    int repDet,
  );
  Future<Message1Response> visitPharmacy(VisitPharmacyRequestBody list1);
  Future<Message1Response> visitDoctor(VisitDoctorRequestBody list1);
  Future<Message1Response> visitHospital(VisitHospitalRequestBody list1);
  Future<AllBrandSpBaseResponse> getBrandsSp(int repDet);
  Future<AllPlanBrandsBaseResponse> getAllPlanBrands(
      int repPlanIdActive, int repPlanIdOther);
  Future<Message1Response> repPlanBrand(RepPlanBrandBody list);
  Future<CheckBaseResponse> checkPlanBrand(int repPlanId);
  Future<LoginResponse> checkActivePlanBrand(int repDet);
  //
  Future<CopyRecResponse> copyReci(int docId, String recipeType);
  //
  Future<VisitHospitalBaseResponse> getHosVisit(
    int repPlanId,
    int representativeId,
  );
  Future<VisitDoctorBaseResponse> getDocVisit(
    String repPlanId,
    String representativeId,
  );
  Future<AllBrandResResponse> getBrandRes(int repDet);
  Future<Message1Response> insertReci(ReciRequest reciReq);
  Future<CheckReResponse> checkRe(int repDet);
  Future<ReciNumResponse> reciNum();
  Future<AllVisitNotesBaseResponse> visitNotes(int repDet);
  Future<AllRepresentativeBaseResponse> getReps(int id);
  Future<AllNoVisitDoctorBaseResponse> noVisitDoc(int repDet,);
  Future<AllNoVisitDoctorBaseResponse> visitDoc(int repDet,);
  Future<AllVisitIssueBaseResponse> getVisitIssue(int repDet);
  Future<Message1Response> insertLog(ExceptionRequestBody list);
  Future<InventoryResponseBaseResponse> getInventory(int repDet);
  Future<AllRepInfoResponseBaseResponse> getRepInfo( int id);
}


class RemoteDataSourceImpl implements RemoteDataSource {
  final AppServiceClient _appServiceClient;

  RemoteDataSourceImpl(this._appServiceClient);

  @override
  Future<LoginResponse> login(LoginRequest loginRequest) async {
    return await _appServiceClient.login(
        loginRequest.email, loginRequest.password, UserInfo.version);
  }

  @override
  Future<AllPlaceBaseResponse> allPlaces(int id) async {
    return await _appServiceClient.allPlace(id);
  }

  @override
  Future<AllSpcBaseResponse> allSpecializations(int repDet) async {
    return await _appServiceClient.allSpecializations(repDet);
  }

  @override
  Future<AllBrandBaseResponse> allBrand(id) async {
    return await _appServiceClient.allBrand(id);
  }


  @override
  Future<AllCityBaseResponse> allCity() async {
    return await _appServiceClient.allCity();
  }

  @override
  Future<AllMedicalVisitBaseResponse> allVisitDoctor(int repDet) async {
    return await _appServiceClient.allVisitDoctor(repDet);
  }

  @override
  Future<AllPharmacyBaseResponse> getAllPharmacy(int repDet) async {
    return await _appServiceClient.getAllPharmacy(repDet);
  }

  @override
  Future<AllDoctorsBaseResponse> getAllDoctor(int repDet) async {
    return await _appServiceClient.getAllDoctor(repDet);
  }

  @override
  Future<AllHospitalBaseResponse> getAllHospital(int repDet) async {
    return await _appServiceClient.getAllHospital(repDet);
  }

  @override
  Future<AllHospitalSpBaseResponse> getAllHospitalSp(int repDet) async {
    return await _appServiceClient.getAllHospitalSp(repDet);
  }

  @override
  Future<Message1Response> visitPharmacy(VisitPharmacyRequestBody list1) async {
    return await _appServiceClient.visitPharmacy(list1);
  }

  @override
  Future<Message1Response> visitDoctor(VisitDoctorRequestBody list1) async {
    return await _appServiceClient.visitDoctor(list1);
  }

  @override
  Future<Message1Response> visitHospital(VisitHospitalRequestBody list1) async {
    return await _appServiceClient.visitHospital(list1);
  }

  @override
  Future<AllBrandSpBaseResponse> getBrandsSp(int repDet) async {
    return await _appServiceClient.getBrandsSp(repDet);
  }

  @override
  Future<AllPlanBrandsBaseResponse> getAllPlanBrands(
      int repPlanIdActive, int repPlanIdOther) async {
    return await _appServiceClient.getAllPlanBrands(
        repPlanIdActive, repPlanIdOther);
  }

  @override
  Future<Message1Response> repPlanBrand(RepPlanBrandBody list) async {
    return await _appServiceClient.repPlanBrand(list);
  }

  @override
  Future<CheckBaseResponse> checkPlanBrand(int repPlanId) async {
    return await _appServiceClient.checkPlanBrand(repPlanId);
  }

  @override
  Future<LoginResponse> checkActivePlanBrand(int repDet) async {
    return await _appServiceClient.checkActivePlanBrand(
        repDet, UserInfo.version);
  }

  @override
  Future<VisitDoctorBaseResponse> getDocVisit(
      String repPlanId, String representativeId) async {
    return await _appServiceClient.getDocVisit(repPlanId, representativeId);
  }

  @override
  Future<VisitHospitalBaseResponse> getHosVisit(
      int repPlanId, int representativeId) async {
    return await _appServiceClient.getHosVisit(repPlanId, representativeId);
  }

  @override
  Future<AllBrandResResponse> getBrandRes(int repDet) async {
    return await _appServiceClient.getBrandRes(repDet);
  }

  @override
  Future<Message1Response> insertReci(ReciRequest reciReq) async {
    return await _appServiceClient.insertReci(
        reciReq.recipeType.toString(),
        reciReq.repId,
        reciReq.type,
        reciReq.docId,
        reciReq.spName,
        reciReq.brand_1,
        reciReq.address,
        reciReq.phone,
        reciReq.total,
        flagImage1: reciReq.flagImage1,
        flagImage2: reciReq.flagImage2,
        note1: reciReq.note1,
        note2: reciReq.note2,
        image1: reciReq.image1,
        image2: reciReq.image2,
        brand_2: reciReq.brand_2,
        brand_3: reciReq.brand_3,
        brand_4: reciReq.brand_4,
        note_emp: reciReq.note_emp);
  }

  @override
  Future<CheckReResponse> checkRe(int repDet) async {
    return await _appServiceClient.checkRe(repDet);
  }

  @override
  Future<ReciNumResponse> reciNum() async {
    return await _appServiceClient.reciNum();
  }

  @override
  Future<CopyRecResponse> copyReci(int docId, String recipeType) async {
    return await _appServiceClient.copyReci(docId, recipeType);
  }

  @override
  Future<CheckRepResponse> checkRep(int repDet) async {
    return await _appServiceClient.checkRep(repDet);
  }

  @override
  Future<AllVisitNotesBaseResponse> visitNotes(int repDet) async{
  return await _appServiceClient.getVisitNotes(repDet);
  }
  @override
  Future<AllRepresentativeBaseResponse> getReps(int id) async {
    return await _appServiceClient.getReps(id);
  }
  @override
  Future<AllNoVisitDoctorBaseResponse> noVisitDoc(int repDet)async{
    return await _appServiceClient.noVisitDoc(repDet);
  }

  @override
  Future<AllNoVisitDoctorBaseResponse> visitDoc(int repDet) async{
    return await _appServiceClient.visitDoc(repDet);
  }

  @override
  Future<AllVisitIssueBaseResponse>  getVisitIssue(int repDet) async {

    return await _appServiceClient.getVisitIssue(repDet);
  }

  @override
  Future<Message1Response> insertLog(ExceptionRequestBody list)async {

    return await _appServiceClient.insertLog(list);
  }

  @override
  Future<InventoryResponseBaseResponse> getInventory(int repDet) async {
    return await _appServiceClient.getInventory(repDet);

  }

  @override
  Future<AllRepInfoResponseBaseResponse> getRepInfo(int id) async {
    return await _appServiceClient.getRepInfo(id);
  }
}
