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
      if (await _networkInfo.isConnected) {
        final response = await _remoteDataSource.login(loginRequest);

        if (response.status == "200"||response.status==ApiInternalStatus.SUCCESS) {
          return Right(response.toDomain());
        } else {
          return Left(Failure(ApiInternalStatus.FAILURE,
              response.message ?? ResponseMassage.DEFAULT));
        }
      } else {
        return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
      }


    } catch (error) {
      return Left(ErrorHandler.handle(error).failure);
    }
  }

  @override
  Future<Either<Failure, List<PlaceModel>>> allPlace(int id) async {
    try {
      if (await _networkInfo.isConnected) {
        final response = await _remoteDataSource.allPlaces(id);

        if (response.status == null||response.status==ApiInternalStatus.SUCCESS) {
          return Right(response.toDomain());
        } else {
          return Left(Failure(ApiInternalStatus.FAILURE,
              response.message ?? ResponseMassage.DEFAULT));
        }
      } else {
        return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
      }

    } catch (error) {
      return Left(ErrorHandler.handle(error).failure);
    }
  }

  @override
  Future<Either<Failure, List<SpecDModel>>> allSpec(int id) async {
    try {
      if (await _networkInfo.isConnected) {
        final response = await _remoteDataSource.allSpecializations(id);
        if (response.status == null||response.status==ApiInternalStatus.SUCCESS) {
          return Right(response.toDomain());
        } else {
          //return either left
          //failure --business error
          return Left(Failure(ApiInternalStatus.FAILURE,
              response.message ?? ResponseMassage.DEFAULT));
        }
        } else {
    return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
    } catch (error) {
      return Left(ErrorHandler.handle(error).failure);
    }
  }

  @override
  Future<Either<Failure, List<CityModel>>> allMedicalRepresentative(
      int id) async {
    try {
      if (await _networkInfo.isConnected) {
      final response = await _remoteDataSource.allMedicalRepresentative(id);
      if (response.status == null||response.status==ApiInternalStatus.SUCCESS) {
        return Right(response.toDomain());
      } else {
        return Left(Failure(ApiInternalStatus.FAILURE,
            response.message ?? ResponseMassage.DEFAULT));
      }
      } else {
        return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
      }
    } catch (error) {
      return Left(ErrorHandler.handle(error).failure);
    }
  }

  @override
  Future<Either<Failure, List<BrandModel>>> allBrand(int id) async {
    try {
      if (await _networkInfo.isConnected) {
      final response = await _remoteDataSource.allBrand(id);


      if (response.status == null||response.status==ApiInternalStatus.SUCCESS) {
        return Right(response.toDomain());
      } else {
        return Left(Failure(ApiInternalStatus.FAILURE,
            response.message ?? ResponseMassage.DEFAULT));
      }  } else {
        return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
      }
    } catch (error) {
      return Left(ErrorHandler.handle(error).failure);
    }
  }
  @override
  Future<Either<Failure, List<CityModel>>> allCity() async {
    try {
      if (await _networkInfo.isConnected) {
      final response = await _remoteDataSource.allCity();
      if (response.status == null||response.status==ApiInternalStatus.SUCCESS) {
        return Right(response.toDomain());
      } else {
        return Left(Failure(ApiInternalStatus.FAILURE,
            response.message ?? ResponseMassage.DEFAULT));
      }  } else {
        return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
      }
    } catch (error) {
      return Left(ErrorHandler.handle(error).failure);
    }
  }
  @override
  Future<Either<Failure, List<MedicalVisits>>> allVisitDoctor(int id) async {
    try {
      if (await _networkInfo.isConnected) {
      final response = await _remoteDataSource.allVisitDoctor(id);
      if (response.status == null||response.status==ApiInternalStatus.SUCCESS) {
        return Right(response.toDomain());
      } else {
        return Left(Failure(ApiInternalStatus.FAILURE,
            response.message ?? ResponseMassage.DEFAULT));
      }  } else {
        return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
      }
    } catch (error) {
      return Left(ErrorHandler.handle(error).failure);
    }
  }
  @override
  Future<Either<Failure, List<PharmacyModel>>> getAllPharmacy(
      int repDet) async {
    try {
      if (await _networkInfo.isConnected) {
      final response = await _remoteDataSource.getAllPharmacy(repDet);
      if (response.status == null||response.status==ApiInternalStatus.SUCCESS) {
        return Right(response.toDomain());
      } else {
        return Left(Failure(ApiInternalStatus.FAILURE,
            response.message ?? ResponseMassage.DEFAULT));
      }
      } else {
        return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
      }
    } catch (error) {
      return Left(ErrorHandler.handle(error).failure);
    }
  }

  @override
  Future<Either<Failure, List<DoctorModel>>> getAllDoctor(int repDet) async {
    try {
      if (await _networkInfo.isConnected) {
      final response = await _remoteDataSource.getAllDoctor(repDet);
      if (response.status == null||response.status==ApiInternalStatus.SUCCESS) {
        return Right(response.toDomain());
      } else {
        return Left(Failure(ApiInternalStatus.FAILURE,
            response.message ?? ResponseMassage.DEFAULT));
      }  } else {
        return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
      }
    } catch (error) {
      return Left(ErrorHandler.handle(error).failure);
    }
  }

  @override
  Future<Either<Failure, List<HospitalModel>>> getAllHospital(int repDet) async {
    try {
      if (await _networkInfo.isConnected) {
      final response = await _remoteDataSource.getAllHospital(repDet);
      if (response.status == null||response.status==ApiInternalStatus.SUCCESS) {
        print("hddddddddhh");
        return Right(response.toDomain());
      } else {
        return Left(Failure(ApiInternalStatus.FAILURE,
            response.message ?? ResponseMassage.DEFAULT));
      }  } else {
        return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
      }
    } catch (error) {
      return Left(ErrorHandler.handle(error).failure);
    }
  }

  @override
  Future<Either<Failure, List<HospitalSpModel>>> getAllHospitalSp(int repDet) async {
    try { if (await _networkInfo.isConnected) {
      final response = await _remoteDataSource.getAllHospitalSp(repDet);
      if (response.status == null||response.status==ApiInternalStatus.SUCCESS) {
        return Right(response.toDomain());
      }
      else {
        return Left(Failure(ApiInternalStatus.FAILURE,
            response.message ?? ResponseMassage.DEFAULT));
      }  } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
    } catch (error) {
      return Left(ErrorHandler.handle(error).failure);
    }
  }

  @override
  Future<Either<Failure, Message1Response>> visitPharmacy(
      VisitPharmacyRequestBody list1) async {
    try { if (await _networkInfo.isConnected) {
      final response = await _remoteDataSource.visitPharmacy(list1);
      if (response.status == null||response.status==ApiInternalStatus.SUCCESS) {
        return Right(response);
      } else {
        return Left(Failure(ApiInternalStatus.FAILURE,
            response.message ?? ResponseMassage.DEFAULT));
      }  } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
    } catch (error) {
      return Left(ErrorHandler.handle(error).failure);
    }
  }
  @override
  Future<Either<Failure, Message1Response>> visitDoctor(
      VisitDoctorRequestBody list1) async {
    try { if (await _networkInfo.isConnected) {
      final response = await _remoteDataSource.visitDoctor(list1);
      if (response.status == null||response.status==ApiInternalStatus.SUCCESS) {
        return Right(response);
      } else {
        return Left(Failure(ApiInternalStatus.FAILURE,
            response.message ?? ResponseMassage.DEFAULT));
      }  } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
    } catch (error) {
      return Left(ErrorHandler.handle(error).failure);
    }
  }
  @override
  Future<Either<Failure, Message1Response>> visitHospital(
      VisitHospitalRequestBody list1) async {
    try { if (await _networkInfo.isConnected) {
      final response = await _remoteDataSource.visitHospital(list1);
      if (response.status == null||response.status==ApiInternalStatus.SUCCESS) {
        return Right(response);
      } else {
        return Left(Failure(ApiInternalStatus.FAILURE,
            response.message ?? ResponseMassage.DEFAULT));
      }  } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
    } catch (error) {
      return Left(ErrorHandler.handle(error).failure);
    }
  }

  @override
  Future<Either<Failure, List<BrandSpModel>>> getBrandsSp(int repDet) async {
    try { if (await _networkInfo.isConnected) {
      final response = await _remoteDataSource.getBrandsSp(repDet);
      if (response.status == null||response.status==ApiInternalStatus.SUCCESS) {
        return Right(response.toDomain());
      } else {
        return Left(Failure(ApiInternalStatus.FAILURE,
            response.message ?? ResponseMassage.DEFAULT));
      }  } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
    } catch (error) {
      return Left(ErrorHandler.handle(error).failure);
    }
  }

  @override
  Future<Either<Failure, List<PlanBrandModel>>> getAllPlanBrands(int repPlanIdActive, int repPlanIdOther) async {
    try { if (await _networkInfo.isConnected) {
      final response = await _remoteDataSource.getAllPlanBrands(repPlanIdActive, repPlanIdOther);
      if (response.status == null||response.status==ApiInternalStatus.SUCCESS) {
        return Right(response.toDomain());
      } else {
        return Left(Failure(ApiInternalStatus.FAILURE,
            response.message ?? ResponseMassage.DEFAULT));
      }  } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
    } catch (error) {
      return Left(ErrorHandler.handle(error).failure);
    }
  }

  @override
  Future<Either<Failure, Message1Response>> repPlanBrand(RepPlanBrandBody list1)  async {
    try { if (await _networkInfo.isConnected) {
      final response = await _remoteDataSource.repPlanBrand(list1);
      if (response.status == null||response.status==ApiInternalStatus.SUCCESS) {
        return Right(response);
      } else {
        return Left(Failure(ApiInternalStatus.FAILURE,
            response.message ?? ResponseMassage.DEFAULT));
      }  } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
    } catch (error) {
      return Left(ErrorHandler.handle(error).failure);
    }
  }

  @override
  Future<Either<Failure, ActiveModel>> isActive(int repPlaneId)
  async {
    try { if (await _networkInfo.isConnected) {
      final response = await _remoteDataSource.checkPlanBrand(repPlaneId);
      if (response.status == null||response.status==ApiInternalStatus.SUCCESS) {
        return Right(response.toDomain());
      } else {
        return Left(Failure(ApiInternalStatus.FAILURE,
            response.message ?? ResponseMassage.DEFAULT));
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
    } catch (error) {
      return Left(ErrorHandler.handle(error).failure);
    }
  }

  @override
  Future<Either<Failure, LoginModel>> checkActivePlanBrand(int repDe)
  async
  {
    try { if (await _networkInfo.isConnected) {
      final response = await _remoteDataSource.checkActivePlanBrand(repDe);
      if (response.status == null||response.status==ApiInternalStatus.SUCCESS) {
        return Right(response.toDomain());
      } else {
        return Left(Failure(ApiInternalStatus.FAILURE,
            response.message ?? ResponseMassage.DEFAULT));
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
    } catch (error) {
      return Left(ErrorHandler.handle(error).failure);
    }
  }

  @override
  Future<Either<Failure, visitDoctorBase>> getDocVisit(String repPlanId, String representativeId)
  async
  {
    try { if (await _networkInfo.isConnected) {
      final response = await _remoteDataSource.getDocVisit(repPlanId, representativeId);
      if (response.status == null||response.status==ApiInternalStatus.SUCCESS) {
        return Right(response.toDomain());
      } else {
        return Left(Failure(ApiInternalStatus.FAILURE,
            response.message ?? ResponseMassage.DEFAULT));
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
    } catch (error) {
      return Left(ErrorHandler.handle(error).failure);
    }
  }

  @override
  Future<Either<Failure, List<VisitHospitalModel>>> getHosVisit(int repPlanId, int representativeId)
  async
  {
    try { if (await _networkInfo.isConnected) {
      final response = await _remoteDataSource.getHosVisit(repPlanId, representativeId);
      if (response.status == null||response.status==ApiInternalStatus.SUCCESS) {
        return Right(response.toDomain());
      } else {
        return Left(Failure(ApiInternalStatus.FAILURE,
            response.message ?? ResponseMassage.DEFAULT));
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
    } catch (error) {
      return Left(ErrorHandler.handle(error).failure);
    }
  }
}
