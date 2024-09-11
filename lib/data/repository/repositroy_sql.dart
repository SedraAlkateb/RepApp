
import 'package:dartz/dartz.dart';
import 'package:domina_app/data/network/app_sql_api.dart';
import 'package:domina_app/data/network/error_handler.dart';
import 'package:domina_app/data/network/failure.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/domain/repostitory/repository_sql.dart';

class RepositroySqlImp extends RepositorySql {
  final AppSqlApi _databaseHelper;
  RepositroySqlImp(this._databaseHelper);

  @override
  Future<Either<Failure, List<BrandModel>>> getBrandsSql() async {
    try {
      // عملية قاعدة بيانات قد تفشل
      final response = await _databaseHelper.getBrands();
      return Right(response);
    } catch (e) {
      return Left(ErrorHandler
          .handle(e)
          .failure);
    }
  }
  @override
  Future<Either<Failure, List<PharmacyModel>>> getPharmacySql()
  async {
    try {
      // عملية قاعدة بيانات قد تفشل
      final response = await _databaseHelper.getPharmacy();
      return Right(response);
    } catch (e) {
      return Left(ErrorHandler
          .handle(e)
          .failure);
    }
  }
  @override
  Future<Either<Failure, List<PlaceModel>>> getPlaceSql() async {
    try {
      // عملية قاعدة بيانات قد تفشل
      final response = await _databaseHelper.getPlace();
      return Right(response);
    } catch (e) {
      return Left(ErrorHandler
          .handle(e)
          .failure);
    }
  }
  @override
  Future<Either<Failure, List<SpecModel>>> getSpecSql()async {
    try {
      // عملية قاعدة بيانات قد تفشل
      final response = await _databaseHelper.getSpec();
      return Right(response);
    } catch (e) {
      return Left(ErrorHandler
          .handle(e)
          .failure);
    }
  }



  @override
  Future<Either<Failure, Null>> insertBrandsSql(List<BrandModel> brandModel)  async {
    try {
      // عملية قاعدة بيانات قد تفشل
      final response = await _databaseHelper.insertBrands(brandModel);
      return Right(response);
    } catch (e) {
      return Left(ErrorHandler
          .handle(e)
          .failure);
    }
  }

  @override
  Future<Either<Failure, Null>> insertPharmacy(List<PharmacyModel> pharmacyModel)
  async {
    try {
      // عملية قاعدة بيانات قد تفشل
      final response = await _databaseHelper.insertPharmacy(pharmacyModel);
      return Right(response);
    } catch (e) {
      print(e);
      return Left(ErrorHandler
          .handle(e)
          .failure);
    }
  }

  @override
  Future<Either<Failure, Null>> insertPlace(List<PlaceModel> placeModel)
  async {
    try {
      // عملية قاعدة بيانات قد تفشل
      final response = await _databaseHelper.insertPlace(placeModel);
      return Right(response);
    } catch (e) {
      return Left(ErrorHandler
          .handle(e)
          .failure);
    }
  }

  @override
  Future<Either<Failure, Null>> insertSpec(List<SpecModel> specModel)  async {
    try {
      // عملية قاعدة بيانات قد تفشل
      final response = await _databaseHelper.insertSpec(specModel);
      return Right(response);
    } catch (e) {
      return Left(
          ErrorHandler.handle(e).failure
      );
    }
  }
  @override
  Future<Either<Failure, Null>> clearDatabase() async {
    try {
  await _databaseHelper.clearDatabase();
      return Right(null);
    } catch (e) {
      return Left(
          ErrorHandler
          .handle(e)
          .failure
      );
    }
  }
  @override
  Future<Either<Failure, Null>> loginSql( LoginModel loginModel)
  async {
    try {
      final response = await _databaseHelper.insertLogin(loginModel);
      return Right(response);
    } catch (e) {
      return Left(ErrorHandler
          .handle(e)
          .failure);
    }
  }
  @override
  Future<Either<Failure, LoginModel?>> getRep()   async {
    try {
      final response = await _databaseHelper.getRep();
      return Right(response);
    } catch (e) {
      return Left(ErrorHandler
          .handle(e)
          .failure);
    }
  }
  @override
  Future<Either<Failure, List<PharmacyModel>>> getPharmaciesByPlaceId(int placeId) async {
    try {
      final response = await _databaseHelper.getPharmaciesByPlaceId(placeId);
      return Right(response);
    } catch (e) {
      return Left(ErrorHandler
          .handle(e)
          .failure);
    }
  }
  @override
  Future<Either<Failure, String>> asyncData
      (List<BrandModel> brands, List<PharmacyModel> pharmacies, List<PlaceModel> places, List<SpecModel> specs,
      List<DoctorModel>doctors,
      List<DoctorModel>hospitals
      )async {
    try {
      final response = await _databaseHelper.asyncData(brands,pharmacies,places,specs,doctors,hospitals);
      if(response==""){
        return Right(response);
      }else{
        return Left(Failure(6, response));
      }
    } catch (e) {
      return Left(ErrorHandler
          .handle(e)
          .failure);
    }
  }
  @override
  Future<Either<Failure, List<BrandModel>>> getBrandsWithFlag()  async {
    try {
      final response = await _databaseHelper.getBrandsWithFlag();
      return Right(response);
    } catch (e) {
      return Left(ErrorHandler
          .handle(e)
          .failure);
    }
  }
  @override
  Future<Either<Failure, Null>> insertDoctor(
      List<DoctorModel> doctorModel) async {
    try {
      final response = await _databaseHelper.insertdoctor(doctorModel);
      return Right(response);
    } catch (e) {print(e);
    return Left(ErrorHandler.handle(e).failure);
    }
  }

  @override
  Future<Either<Failure, List<DoctorModel>>> getHospitalSql() async {
    try {
      final response = await _databaseHelper.getHospital();
      return Right(response);
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }

  @override
  Future<Either<Failure, Null>> insertHospital(
      List<DoctorModel> hospitalModel) async {
    try {
      // عملية قاعدة بيانات قد تفشل
      final response = await _databaseHelper.inserthospital(hospitalModel);
      return Right(response);
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }

  @override
  Future<Either<Failure, List<DoctorModel>>> getDoctorSql() async {
    try {
      // عملية قاعدة بيانات قد تفشل
      final response = await _databaseHelper.getDotors();
      return Right(response);
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }

  @override
  Future<Either<Failure, List<DoctorModel>>> getDoctorByPlaceId(int placeId)async {
    try {
      final response = await _databaseHelper.getDoctorByPlaceId(placeId);
      return Right(response);
    } catch (e) {
      return Left(ErrorHandler
          .handle(e)
          .failure);
    }
  }

  @override
  Future<Either<Failure, List<DoctorModel>>> getHospitalByPlaceId(int placeId)async {
    try {
      final response = await _databaseHelper.getHospitalByPlaceId(placeId);
      return Right(response);
    } catch (e) {
      return Left(ErrorHandler
          .handle(e)
          .failure);
    }
  }

}