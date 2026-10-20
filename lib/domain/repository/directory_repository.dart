import 'package:dartz/dartz.dart';
import 'package:domina_app/domain/failure.dart';
import 'package:domina_app/domain/models/models.dart';

abstract class DirectoryRepository {
  Future<Either<Failure, List<PlaceModel>>> allPlace(int id,{int? cityId});

  Future<Either<Failure, List<SpecDModel>>> allSpec(int repDet, {int? planId});

  Future<Either<Failure, List<CityModel>>> allCity();

  Future<Either<Failure, List<BrandModel>>> allBrand(int id);

  Future<Either<Failure, List<PharmacyModel>>> getAllPharmacy(int repDet);

  Future<Either<Failure, List<DoctorModel>>> getAllDoctor(int repDet);

  Future<Either<Failure, List<HospitalModel>>> getAllHospital(int repDet);

  Future<Either<Failure, List<HospitalSpModel>>> getAllHospitalSp(int repDet);

  Future<Either<Failure, List<BrandSpModel>>> getBrandsSp(int repDet);

  Future<Either<Failure, List<DocdoctorsModel>>> docReport(int docId);

  Future<Either<Failure, List<doctorsModel>>> docSearch(
    String name,
      int repDet,
  {
    int ? cityId
  }
  );

  Future<Either<Failure, DoctorModel>> getDocInfo(int docId);

  Future<Either<Failure, List<SearchHospitalModel>>> getSearchHospitals(
      String name,int repDet,
      {int? cityId});

  Future<Either<Failure, List<SearchHospitalNoteModel>>>
      getSearchHospitalsNotes(int hosId, int spId);

  Future<Either<Failure, DocHosByPlaceAndSp>> getSpDocHos(int repDet,      {
    int? spId,
    int ?placeId,
    int? cityId
  });

  Future<Either<Failure, List<HosDocSpSearchModel>>> docSpSearch(int repPlanId, int spId);

  Future<Either<Failure, List<HosDocSpSearchModel>>> hosSpSearch(int repPlanId, int spId);
}
