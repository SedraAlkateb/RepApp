import 'package:dartz/dartz.dart';
import 'package:domina_app/data/data_source/remote_data_source.dart';
import 'package:domina_app/data/mapper/mapper.dart';
import 'package:domina_app/data/network/error_handler.dart';
import 'package:domina_app/data/network/failure.dart';
import 'package:domina_app/data/network/network_info.dart';
import 'package:domina_app/data/network/requests/requsets.dart';
import 'package:domina_app/data/responses/responses.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/domain/repostitory/repository.dart';

class RepositoryImp implements Repository {
  final RemoteDataSource _remoteDataSource;

  final NetworkInfo _networkInfo;

  RepositoryImp(this._remoteDataSource, this._networkInfo);

  @override
  Future<Either<Failure, LoginModel>> login(LoginRequest loginRequest) async {
    try {
      final response = await _remoteDataSource.login(loginRequest);
      if (response.status == "200") {
        return Right(response.toDomain());
      } else {
        return Left(Failure(ApiInternalStatus.FAILURE,
            response.message ?? ResponseMassage.DEFAULT));
      }
    } catch (error) {
      return Left(ErrorHandler.handle(error).failure);
    }
  }

  @override
  Future<Either<Failure, List<PlaceModel>>> allPlace(int id) async {
    try {
      final response = await _remoteDataSource.allPlaces(id);
      if (response.status == null) {
        return Right(response.toDomain());
      } else {
        return Left(Failure(ApiInternalStatus.FAILURE,
            response.message ?? ResponseMassage.DEFAULT));
      }
    } catch (error) {
      return Left(ErrorHandler.handle(error).failure);
    }
  }

  @override
  Future<Either<Failure, List<SpecModel>>> allSpec(int id) async {
    try {
      final response = await _remoteDataSource.allSpecializations(id);
      if (response.status == null) {
        return Right(response.toDomain());
      } else {
        //return either left
        //failure --business error
        return Left(Failure(ApiInternalStatus.FAILURE,
            response.message ?? ResponseMassage.DEFAULT));
      }
    } catch (error) {
      return Left(ErrorHandler.handle(error).failure);
    }
  }

  @override
  Future<Either<Failure, List<CityModel>>> allMedicalRepresentative(
      int id) async {
    try {
      final response = await _remoteDataSource.allMedicalRepresentative(id);
      if (response.status == null) {
        return Right(response.toDomain());
      } else {
        return Left(Failure(ApiInternalStatus.FAILURE,
            response.message ?? ResponseMassage.DEFAULT));
      }
    } catch (error) {
      return Left(ErrorHandler.handle(error).failure);
    }
  }

  @override
  Future<Either<Failure, List<BrandModel>>> allBrand(int id) async {
    try {
      final response = await _remoteDataSource.allBrand(id);
      if (response.status == null) {
        return Right(response.toDomain());
      } else {
        return Left(Failure(ApiInternalStatus.FAILURE,
            response.message ?? ResponseMassage.DEFAULT));
      }
    } catch (error) {
      return Left(ErrorHandler.handle(error).failure);
    }
  }
  @override
  Future<Either<Failure, List<CityModel>>> allCity() async {
    try {
      final response = await _remoteDataSource.allCity();
      if (response.status == null) {
        return Right(response.toDomain());
      } else {
        return Left(Failure(ApiInternalStatus.FAILURE,
            response.message ?? ResponseMassage.DEFAULT));
      }
    } catch (error) {
      return Left(ErrorHandler.handle(error).failure);
    }
  }
  @override
  Future<Either<Failure, List<MedicalVisits>>> allVisitDoctor(int id) async {
    try {
      final response = await _remoteDataSource.allVisitDoctor(id);
      if (response.status == null) {
        return Right(response.toDomain());
      } else {
        return Left(Failure(ApiInternalStatus.FAILURE,
            response.message ?? ResponseMassage.DEFAULT));
      }
    } catch (error) {
      return Left(ErrorHandler.handle(error).failure);
    }
  }
  @override
  Future<Either<Failure, List<PharmacyModel>>> getAllPharmacy(
      int repDet) async {
    try {
      final response = await _remoteDataSource.getAllPharmacy(repDet);
      if (response.status == null) {
        return Right(response.toDomain());
      } else {
        return Left(Failure(ApiInternalStatus.FAILURE,
            response.message ?? ResponseMassage.DEFAULT));
      }
    } catch (error) {
      return Left(ErrorHandler.handle(error).failure);
    }
  }

  @override
  Future<Either<Failure, List<DoctorModel>>> getAllDoctor(int repDet) async {
    try {
      final response = await _remoteDataSource.getAllDoctor(repDet);
      if (response.status == null) {
        return Right(response.toDomain());
      } else {
        return Left(Failure(ApiInternalStatus.FAILURE,
            response.message ?? ResponseMassage.DEFAULT));
      }
    } catch (error) {
      return Left(ErrorHandler.handle(error).failure);
    }
  }

  @override
  Future<Either<Failure, List<HospitalModel>>> getAllHospital(int repDet) async {
    try {
      final response = await _remoteDataSource.getAllHospital(repDet);
      if (response.status == null) {
        print("hddddddddhh");
        return Right(response.toDomain());
      } else {
        return Left(Failure(ApiInternalStatus.FAILURE,
            response.message ?? ResponseMassage.DEFAULT));
      }
    } catch (error) {
      return Left(ErrorHandler.handle(error).failure);
    }
  }

  @override
  Future<Either<Failure, List<HospitalSpModel>>> getAllHospitalSp(int repDet) async {
    try {
      final response = await _remoteDataSource.getAllHospitalSp(repDet);
      if (response.status == null) {
        return Right(response.toDomain());
      }
      else {
        return Left(Failure(ApiInternalStatus.FAILURE,
            response.message ?? ResponseMassage.DEFAULT));
      }
    } catch (error) {
      return Left(ErrorHandler.handle(error).failure);
    }
  }

  @override
  Future<Either<Failure, Message1Response>> visitPharmacy(
      VisitPharmacyRequestBody list1) async {
    try {
      final response = await _remoteDataSource.visitPharmacy(list1);
      if (response.status == null) {
        return Right(response);
      } else {
        return Left(Failure(ApiInternalStatus.FAILURE,
            response.message ?? ResponseMassage.DEFAULT));
      }
    } catch (error) {
      return Left(ErrorHandler.handle(error).failure);
    }
  }
  @override
  Future<Either<Failure, Message1Response>> visitDoctor(
      VisitDoctorRequestBody list1) async {
    try {
      final response = await _remoteDataSource.visitDoctor(list1);
      if (response.status == null) {
        return Right(response);
      } else {
        return Left(Failure(ApiInternalStatus.FAILURE,
            response.message ?? ResponseMassage.DEFAULT));
      }
    } catch (error) {
      return Left(ErrorHandler.handle(error).failure);
    }
  }
  @override
  Future<Either<Failure, Message1Response>> visitHospital(
      VisitHospitalRequestBody list1) async {
    try {
      final response = await _remoteDataSource.visitHospital(list1);
      if (response.status == null) {
        return Right(response);
      } else {
        return Left(Failure(ApiInternalStatus.FAILURE,
            response.message ?? ResponseMassage.DEFAULT));
      }
    } catch (error) {
      return Left(ErrorHandler.handle(error).failure);
    }
  }

  @override
  Future<Either<Failure, List<BrandSpModel>>> getBrandsSp(int repDet) async {
    try {
      final response = await _remoteDataSource.getBrandsSp(repDet);
      if (response.status == null) {
        return Right(response.toDomain());
      } else {
        return Left(Failure(ApiInternalStatus.FAILURE,
            response.message ?? ResponseMassage.DEFAULT));
      }
    } catch (error) {
      return Left(ErrorHandler.handle(error).failure);
    }
  }

}
