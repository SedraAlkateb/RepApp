import 'package:dartz/dartz.dart';
import 'package:domina_app/data/data_source/remote_data_source.dart';
import 'package:domina_app/data/mapper/mapper.dart';
import 'package:domina_app/data/network/error_handler.dart';
import 'package:domina_app/data/network/failure.dart';
import 'package:domina_app/data/network/network_info.dart';
import 'package:domina_app/data/responses/responses.dart';
import 'package:domina_app/domain/ex.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/domain/repostitory/repository.dart';

class RepositoryImp implements Repository {
  final RemoteDataSource _remoteDataSource;
  final ExcRepository excRepository;

  final NetworkInfo _networkInfo;

  RepositoryImp(this._remoteDataSource, this._networkInfo, this.excRepository);

  @override
  Future<Either<Failure, LoginModel>> login(LoginRequest loginRequest) async {
    try {
      if (await _networkInfo.isConnected) {
        final response = await _remoteDataSource.login(loginRequest);

        if (response.status == "200" ||
            response.status == ApiInternalStatus.SUCCESS) {
          return Right(response.toDomain());
        } else {
          Failure failure = Failure(ApiInternalStatus.FAILURE,
              response.message ?? ResponseMassage.DEFAULT);
          insertLog(ExceptionRequestBody([ExceptionModel(failure.massage, "login")]));
          return Left(failure);

          // return Left(Failure(ApiInternalStatus.FAILURE,
          //     response.message ?? ResponseMassage.DEFAULT));
        }
      } else {
        return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
      }
    } catch (error) {
      Failure failure = ErrorHandler.handle(error).failure;
      insertLog(ExceptionRequestBody([ExceptionModel(failure.massage, "login")]));
      return Left(failure);
    }
  }

  @override
  Future<Either<Failure, List<PlaceModel>>> allPlace(int id) async {
    try {
      if (await _networkInfo.isConnected) {
        final response = await _remoteDataSource.allPlaces(id);
        if (response.status == null ||
            response.status == ApiInternalStatus.SUCCESS ||
            response.status == "200") {
          return Right(response.toDomain());
        } else {
           Failure failure = Failure(ApiInternalStatus.FAILURE,
              response.message ?? ResponseMassage.DEFAULT);
           insertLog(ExceptionRequestBody([ExceptionModel(failure.massage, "AllPlace")]));
          return Left(failure);
        }
      } else {
        Failure failure = DataSource.NO_INTERNET_CONNECTION.getFailure();
        insertLog(ExceptionRequestBody([ExceptionModel(failure.massage, "allPlace")]));
        return Left(failure);
      }
    } catch (error) {
      Failure failure = ErrorHandler.handle(error).failure;
      insertLog(ExceptionRequestBody([ExceptionModel(failure.massage, "allPlace")]));
      return Left(failure);
    }
  }

  @override
  Future<Either<Failure, List<SpecDModel>>> allSpec(int id) async {
    try {
      if (await _networkInfo.isConnected) {
        final response = await _remoteDataSource.allSpecializations(id);
        if (response.status == null ||
            response.status == ApiInternalStatus.SUCCESS ||
            response.status == "200") {
          return Right(response.toDomain());
        } else {
          //return either left
          //failure --business error
           Failure failure = Failure(ApiInternalStatus.FAILURE,
              response.message ?? ResponseMassage.DEFAULT);
          insertLog(ExceptionRequestBody([ExceptionModel(failure.massage, "allSpec")]));
          return Left(failure);
        }
      } else {
        return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
      }
    } catch (error) {
      Failure failure = ErrorHandler.handle(error).failure;
      insertLog(ExceptionRequestBody([ExceptionModel(failure.massage, "allSpec")]));
      return Left(failure);
    }
  }

  @override
  Future<Either<Failure, List<CityModel>>> allMedicalRepresentative(
      int id) async {
    try {
      if (await _networkInfo.isConnected) {
        final response = await _remoteDataSource.allMedicalRepresentative(id);
        if (response.status == null ||
            response.status == ApiInternalStatus.SUCCESS ||
            response.status == "200") {
          return Right(response.toDomain());
        } else {
           Failure failure = Failure(ApiInternalStatus.FAILURE,
              response.message ?? ResponseMassage.DEFAULT);
          insertLog(ExceptionRequestBody([ExceptionModel(failure.massage, "allMedicalRepresentative")]));
          return Left(failure);
        }
      } else {
        return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
      }
    } catch (error) {
      Failure failure = ErrorHandler.handle(error).failure;
      insertLog(ExceptionRequestBody([ExceptionModel(failure.massage, "allMedicalRepresentative")]));
      return Left(failure);
    }
  }

  @override
  Future<Either<Failure, List<BrandModel>>> allBrand(int id) async {
    try {
      if (await _networkInfo.isConnected) {
        final response = await _remoteDataSource.allBrand(id);
        if (response.status == null ||
            response.status == ApiInternalStatus.SUCCESS ||
            response.status == "200") {
          return Right(response.toDomain());
        } else {
           Failure failure = Failure(ApiInternalStatus.FAILURE,
              response.message ?? ResponseMassage.DEFAULT);
           insertLog(ExceptionRequestBody([ExceptionModel(failure.massage, "allBrand")]));
          return Left(failure);
        }
      } else {
        return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
      }
    } catch (error) {
      Failure failure = ErrorHandler.handle(error).failure;
      insertLog(ExceptionRequestBody([ExceptionModel(failure.massage, "allBrand")]));
      return Left(failure);
    }
  }

  @override
  Future<Either<Failure, List<CityModel>>> allCity() async {
    try {
      if (await _networkInfo.isConnected) {
        final response = await _remoteDataSource.allCity();
        if (response.status == null ||
            response.status == ApiInternalStatus.SUCCESS ||
            response.status == "200") {
          return Right(response.toDomain());
        } else {
           Failure failure = Failure(ApiInternalStatus.FAILURE,
              response.message ?? ResponseMassage.DEFAULT);
          insertLog(ExceptionRequestBody([ExceptionModel(failure.massage, "allCity")]));
          return Left(failure);
        }
      } else {
        return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
      }
    } catch (error) {
      Failure failure = ErrorHandler.handle(error).failure;
      insertLog(ExceptionRequestBody([ExceptionModel(failure.massage, "allCity")]));
      return Left(failure);
    }
  }

  @override
  Future<Either<Failure, List<MedicalVisits>>> allVisitDoctor(int id) async {
    try {
      if (await _networkInfo.isConnected) {
        final response = await _remoteDataSource.allVisitDoctor(id);
        if (response.status == null ||
            response.status == ApiInternalStatus.SUCCESS ||
            response.status == "200") {
          return Right(response.toDomain());
        } else {
           Failure failure = Failure(ApiInternalStatus.FAILURE,
              response.message ?? ResponseMassage.DEFAULT);
          insertLog(ExceptionRequestBody([ExceptionModel(failure.massage, "allVisitDoctor")]));
          return Left(failure);
        }
      } else {
        return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
      }
    } catch (error) {
      Failure failure = ErrorHandler.handle(error).failure;
      insertLog(ExceptionRequestBody([ExceptionModel(failure.massage, "allVisitDoctor")]));
      return Left(failure);
    }
  }

  @override
  Future<Either<Failure, List<PharmacyModel>>> getAllPharmacy(
      int repDet) async {
    try {
      if (await _networkInfo.isConnected) {
        final response = await _remoteDataSource.getAllPharmacy(repDet);
        if (response.status == null ||
            response.status == ApiInternalStatus.SUCCESS ||
            response.status == "200") {
          return Right(response.toDomain());
        } else {
           Failure failure = Failure(ApiInternalStatus.FAILURE,
              response.message ?? ResponseMassage.DEFAULT);
          insertLog(ExceptionRequestBody([ExceptionModel(failure.massage, "getAllPharmacy")]));
          return Left(failure);
        }
      } else {
        return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
      }
    } catch (error) {
      Failure failure = ErrorHandler.handle(error).failure;
      insertLog(ExceptionRequestBody([ExceptionModel(failure.massage, "getAllPharmacy")]));
      return Left(failure);
    }
  }

  @override
  Future<Either<Failure, List<DoctorModel>>> getAllDoctor(int repDet) async {
    try {
      if (await _networkInfo.isConnected) {
        final response = await _remoteDataSource.getAllDoctor(repDet);
        if (response.status == null ||
            response.status == ApiInternalStatus.SUCCESS ||
            response.status == "200") {
          return Right(response.toDomain());
        } else {
           Failure failure = Failure(ApiInternalStatus.FAILURE,
              response.message ?? ResponseMassage.DEFAULT);
          insertLog(ExceptionRequestBody([ExceptionModel(failure.massage, "getAllDoctor")]));
          return Left(failure);
        }
      } else {
        return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
      }
    } catch (error) {
      Failure failure = ErrorHandler.handle(error).failure;
      insertLog(ExceptionRequestBody([ExceptionModel(failure.massage, "getAllDoctor")]));
      return Left(failure);
    }
  }

  @override
  Future<Either<Failure, List<HospitalModel>>> getAllHospital(
      int repDet) async {
    try {
      if (await _networkInfo.isConnected) {
        final response = await _remoteDataSource.getAllHospital(repDet);
        if (response.status == null ||
            response.status == ApiInternalStatus.SUCCESS ||
            response.status == "200") {
          return Right(response.toDomain());
        } else {
           Failure failure = Failure(ApiInternalStatus.FAILURE,
              response.message ?? ResponseMassage.DEFAULT);
          insertLog(ExceptionRequestBody([ExceptionModel(failure.massage, "getAllHospital")]));
          return Left(failure);
        }
      } else {
        return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
      }
    } catch (error) {
      Failure failure = ErrorHandler.handle(error).failure;
      insertLog(ExceptionRequestBody([ExceptionModel(failure.massage, "getAllHospital")]));
      return Left(failure);
    }
  }

  @override
  Future<Either<Failure, List<HospitalSpModel>>> getAllHospitalSp(
      int repDet) async {
    try {
      if (await _networkInfo.isConnected) {
        final response = await _remoteDataSource.getAllHospitalSp(repDet);
        if (response.status == null ||
            response.status == ApiInternalStatus.SUCCESS ||
            response.status == "200") {
          return Right(response.toDomain());
        } else {
           Failure failure = Failure(ApiInternalStatus.FAILURE,
              response.message ?? ResponseMassage.DEFAULT);
          insertLog(ExceptionRequestBody([ExceptionModel(failure.massage, "getAllHospitalSp")]));
          return Left(failure);
        }
      } else {
        return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
      }
    } catch (error) {
      Failure failure = ErrorHandler.handle(error).failure;
      insertLog(ExceptionRequestBody([ExceptionModel(failure.massage, "getAllHospitalSp")]));
      return Left(failure);
    }
  }

  @override
  Future<Either<Failure, Message1Response>> visitPharmacy(
      VisitPharmacyRequestBody list1) async {
    try {
      if (await _networkInfo.isConnected) {
        final response = await _remoteDataSource.visitPharmacy(list1);
        if (response.status == null ||
            response.status == ApiInternalStatus.SUCCESS ||
            response.status == "200") {
          return Right(response);
        } else {
           Failure failure = Failure(ApiInternalStatus.FAILURE,
              response.message ?? ResponseMassage.DEFAULT);
          insertLog(ExceptionRequestBody([ExceptionModel(failure.massage, "visitPharmacy")]));
          return Left(failure);
        }
      } else {
        return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
      }
    } catch (error) {
      Failure failure = ErrorHandler.handle(error).failure;
      insertLog(ExceptionRequestBody([ExceptionModel(failure.massage, "visitPharmacy")]));
      return Left(failure);
    }
  }

  @override
  Future<Either<Failure, Message1Response>> visitDoctor(
      VisitDoctorRequestBody list1) async {
    try {
      if (await _networkInfo.isConnected) {
        final response = await _remoteDataSource.visitDoctor(list1);
        if (response.status == null ||
            response.status == ApiInternalStatus.SUCCESS ||
            response.status == "200") {
          return Right(response);
        } else {
          Failure failure = Failure(ApiInternalStatus.FAILURE,
              response.message ?? ResponseMassage.DEFAULT);
          insertLog(ExceptionRequestBody([ExceptionModel(failure.massage, "visitDoctor")]));
          return Left(failure);
        }
      } else {
        return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
      }
    } catch (error) {
      Failure failure = ErrorHandler.handle(error).failure;
      insertLog(ExceptionRequestBody([ExceptionModel(failure.massage, "visitDoctor")]));
      return Left(failure);
    }
  }

  @override
  Future<Either<Failure, Message1Response>> visitHospital(
      VisitHospitalRequestBody list1) async {
    try {
      if (await _networkInfo.isConnected) {
        final response = await _remoteDataSource.visitHospital(list1);
        if (response.status == null ||
            response.status == ApiInternalStatus.SUCCESS ||
            response.status == "200") {
          return Right(response);
        } else {
           Failure failure = Failure(ApiInternalStatus.FAILURE,
              response.message ?? ResponseMassage.DEFAULT);
          insertLog(ExceptionRequestBody([ExceptionModel(failure.massage, "visitHospital")]));
          return Left(failure);
        }
      } else {
        return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
      }
    } catch (error) {
      Failure failure = ErrorHandler.handle(error).failure;
      insertLog(ExceptionRequestBody([ExceptionModel(failure.massage, "visitHospital")]));
      return Left(failure);
    }
  }

  @override
  Future<Either<Failure, List<BrandSpModel>>> getBrandsSp(int repDet) async {
    try {
      if (await _networkInfo.isConnected) {
        final response = await _remoteDataSource.getBrandsSp(repDet);
        if (response.status == null ||
            response.status == ApiInternalStatus.SUCCESS ||
            response.status == "200") {
          return Right(response.toDomain());
        } else {
           Failure failure = Failure(ApiInternalStatus.FAILURE,
              response.message ?? ResponseMassage.DEFAULT);
          insertLog(ExceptionRequestBody([ExceptionModel(failure.massage, "getBrandsSp")]));
          return Left(failure);
        }
      } else {
        return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
      }
    } catch (error) {
      Failure failure = ErrorHandler.handle(error).failure;
      insertLog(ExceptionRequestBody([ExceptionModel(failure.massage, "getBrandsSp")]));
      return Left(failure);
    }
  }

  @override
  Future<Either<Failure, List<PlanBrandModel>>> getAllPlanBrands(
      int repPlanIdActive, int repPlanIdOther) async {
    try {
      if (await _networkInfo.isConnected) {
        final response = await _remoteDataSource.getAllPlanBrands(
            repPlanIdActive, repPlanIdOther);
        if (response.status == null ||
            response.status == ApiInternalStatus.SUCCESS ||
            response.status == "200") {
          return Right(response.toDomain());
        } else {
           Failure failure = Failure(ApiInternalStatus.FAILURE,
              response.message ?? ResponseMassage.DEFAULT);
          insertLog(ExceptionRequestBody([ExceptionModel(failure.massage, "getAllPlanBrands")]));
          return Left(failure);
        }
      } else {
        return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
      }
    } catch (error) {
      Failure failure = ErrorHandler.handle(error).failure;
      insertLog(ExceptionRequestBody([ExceptionModel(failure.massage, "getAllPlanBrands")]));
      return Left(failure);
    }
  }

  @override
  Future<Either<Failure, Message1Response>> repPlanBrand(
      RepPlanBrandBody list1) async {
    try {
      if (await _networkInfo.isConnected) {
        final response = await _remoteDataSource.repPlanBrand(list1);
        if (response.status == null ||
            response.status == ApiInternalStatus.SUCCESS ||
            response.status == "200") {
          return Right(response);
        } else {
           Failure failure = Failure(ApiInternalStatus.FAILURE,
              response.message ?? ResponseMassage.DEFAULT);
          insertLog(ExceptionRequestBody([ExceptionModel(failure.massage, "repPlanBrand")]));
          return Left(failure);
        }
      } else {
        return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
      }
    } catch (error) {
      Failure failure = ErrorHandler.handle(error).failure;
      insertLog(ExceptionRequestBody([ExceptionModel(failure.massage, "repPlanBrand")]));
      return Left(failure);
    }
  }

  @override
  Future<Either<Failure, ActiveModel>> isActive(int repPlaneId) async {
    try {
      if (await _networkInfo.isConnected) {
        final response = await _remoteDataSource.checkPlanBrand(repPlaneId);
        if (response.status == null ||
            response.status == ApiInternalStatus.SUCCESS ||
            response.status == "200") {
          return Right(response.toDomain());
        } else {
           Failure failure = Failure(ApiInternalStatus.FAILURE,
              response.message ?? ResponseMassage.DEFAULT);
          insertLog(ExceptionRequestBody([ExceptionModel(failure.massage, "isActive")]));
          return Left(failure);
        }
      } else {
        return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
      }
    } catch (error) {
      Failure failure = ErrorHandler.handle(error).failure;
      insertLog(ExceptionRequestBody([ExceptionModel(failure.massage, "isActive")]));
      return Left(failure);
    }
  }

  @override
  Future<Either<Failure, LoginModel>> checkActivePlanBrand(int repDe) async {
    try {
      if (await _networkInfo.isConnected) {
        final response = await _remoteDataSource.checkActivePlanBrand(repDe);
        if (response.status == null ||
            response.status == ApiInternalStatus.SUCCESS ||
            response.status == "200") {
          return Right(response.toDomain());
        } else {
           Failure failure = Failure(ApiInternalStatus.FAILURE,
              response.message ?? ResponseMassage.DEFAULT);
           insertLog(ExceptionRequestBody([ExceptionModel(failure.massage, "checkActivePlanBrand")]));

           return Left(failure);
        }
      } else {
        Failure failure = DataSource.NO_INTERNET_CONNECTION.getFailure();
        insertLog(ExceptionRequestBody([ExceptionModel(failure.massage, "checkActivePlanBrand")]));

        return Left(failure);
      }
    } catch (error) {
      Failure failure = ErrorHandler.handle(error).failure;
      insertLog(ExceptionRequestBody([ExceptionModel(failure.massage, "checkActivePlanBrand")]));

      return Left(failure);
    }
  }

  @override
  Future<Either<Failure, VisitDoctorBase>> getDocVisit(
      String repPlanId, String representativeId) async {
    try {
      if (await _networkInfo.isConnected) {
        final response =
            await _remoteDataSource.getDocVisit(repPlanId, representativeId);
        if (response.status == null ||
            response.status == ApiInternalStatus.SUCCESS ||
            response.status == "200") {
          return Right(response.toDomain());
        } else {
           Failure failure = Failure(ApiInternalStatus.FAILURE,
              response.message ?? ResponseMassage.DEFAULT);
          insertLog(ExceptionRequestBody([ExceptionModel(failure.massage, "getDocVisit")]));
          return Left(failure);
        }
      } else {
        return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
      }
    } catch (error) {
      Failure failure = ErrorHandler.handle(error).failure;
      insertLog(ExceptionRequestBody([ExceptionModel(failure.massage, "getDocVisit")]));
      return Left(failure);
    }
  }

  @override
  Future<Either<Failure, VisitHospitalBase>> getHosVisit(
      int repPlanId, int representativeId) async {
    try {
      if (await _networkInfo.isConnected) {
        final response =
            await _remoteDataSource.getHosVisit(repPlanId, representativeId);
        if (response.status == null ||
            response.status == ApiInternalStatus.SUCCESS ||
            response.status == "200") {
          return Right(response.toDomain());
        } else {
           Failure failure = Failure(ApiInternalStatus.FAILURE,
              response.message ?? ResponseMassage.DEFAULT);
          insertLog(ExceptionRequestBody([ExceptionModel(failure.massage, "getHosVisit")]));
          return Left(failure);
        }
      } else {
        return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
      }
    } catch (error) {
      Failure failure = ErrorHandler.handle(error).failure;
      insertLog(ExceptionRequestBody([ExceptionModel(failure.massage, "getHosVisit")]));
      return Left(failure);
    }
  }

  @override
  Future<Either<Failure, List<BrandRes>>> getBrandRes(int repDet) async {
    try {
      if (await _networkInfo.isConnected) {
        final response = await _remoteDataSource.getBrandRes(repDet);
        if (response.status == null ||
            response.status == ApiInternalStatus.SUCCESS ||
            response.status == "200") {
          return Right(response.toDomain());
        } else {
           Failure failure = Failure(ApiInternalStatus.FAILURE,
              response.message ?? ResponseMassage.DEFAULT);
          insertLog(ExceptionRequestBody([ExceptionModel(failure.massage, "getBrandRes")]));
          return Left(failure);
        }
      } else {
        return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
      }
    } catch (error) {
      Failure failure = ErrorHandler.handle(error).failure;
      insertLog(ExceptionRequestBody([ExceptionModel(failure.massage, "getBrandRes")]));
      return Left(failure);
    }
  }

  @override
  Future<Either<Failure, Message1Response>> insertReci(
      ReciRequest reciReq) async {
    try {
      if (await _networkInfo.isConnected) {
        final response = await _remoteDataSource.insertReci(reciReq);
        if (response.status == null ||
            response.status == ApiInternalStatus.SUCCESS ||
            response.status == "200") {
          return Right(response);
        } else {
           Failure failure = Failure(ApiInternalStatus.FAILURE,
              response.message ?? ResponseMassage.DEFAULT);
          insertLog(ExceptionRequestBody([ExceptionModel(failure.massage, "insertReci")]));
          return Left(failure);
        }
      } else {
        return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
      }
    } catch (error) {
      Failure failure = ErrorHandler.handle(error).failure;
      insertLog(ExceptionRequestBody([ExceptionModel(failure.massage, "insertReci")]));
      return Left(failure);
    }
  }

  @override
  Future<Either<Failure, CheckReResponse>> checkRe(int repDet) async {
    try {
      if (await _networkInfo.isConnected) {
        final response = await _remoteDataSource.checkRe(repDet);
        if (response.status == null ||
            response.status == ApiInternalStatus.SUCCESS ||
            response.status == "200") {
          return Right(response);
        } else {
           Failure failure = Failure(ApiInternalStatus.FAILURE,
              response.message ?? ResponseMassage.DEFAULT);
          insertLog(ExceptionRequestBody([ExceptionModel(failure.massage, "checkRe")]));
          return Left(failure);
        }
      } else {
        return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
      }
    } catch (error) {
      Failure failure = ErrorHandler.handle(error).failure;
      insertLog(ExceptionRequestBody([ExceptionModel(failure.massage, "checkRe")]));
      return Left(failure);
    }
  }

  @override
  Future<Either<Failure, List<int>>> reciNum() async {
    try {
      if (await _networkInfo.isConnected) {
        final response = await _remoteDataSource.reciNum();
        if (response.status == null ||
            response.status == ApiInternalStatus.SUCCESS ||
            response.status == "200") {
          return Right(response.toDomain());
        } else {
           Failure failure = Failure(ApiInternalStatus.FAILURE,
              response.message ?? ResponseMassage.DEFAULT);
          insertLog(ExceptionRequestBody([ExceptionModel(failure.massage, "reciNum")]));
          return Left(failure);
        }
      } else {
        return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
      }
    } catch (error) {
      Failure failure = ErrorHandler.handle(error).failure;
      insertLog(ExceptionRequestBody([ExceptionModel(failure.massage, "reciNum")]));
      return Left(failure);
    }
  }

  @override
  Future<Either<Failure, CopyReciRequest>> copyReci(
      int docId, String recipeType) async {
    try {
      if (await _networkInfo.isConnected) {
        final response = await _remoteDataSource.copyReci(docId, recipeType);
        if (response.status == null ||
            response.status == ApiInternalStatus.SUCCESS ||
            response.status == "200") {
          return Right(response.toDomain());
        } else {
           Failure failure = Failure(ApiInternalStatus.FAILURE,
              response.message ?? ResponseMassage.DEFAULT);
          insertLog(ExceptionRequestBody([ExceptionModel(failure.massage, "copyReci")]));
          return Left(failure);
        }
      } else {
        return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
      }
    } catch (error) {
      Failure failure = ErrorHandler.handle(error).failure;
      insertLog(ExceptionRequestBody([ExceptionModel(failure.massage, "copyReci")]));
      return Left(failure);
    }
  }

  @override
  Future<Either<Failure, CheckRepResponse>> checkRep(int repId) async {
    try {
      if (await _networkInfo.isConnected) {
        final response = await _remoteDataSource.checkRep(repId);
        if (response.status == null ||
            response.status == ApiInternalStatus.SUCCESS ||
            response.status == "200") {
          return Right(response);
        } else {
           Failure failure = Failure(ApiInternalStatus.FAILURE,
              response.message ?? ResponseMassage.DEFAULT);
          insertLog(ExceptionRequestBody([ExceptionModel(failure.massage, "checkRep")]));
          return Left(failure);
        }
      } else {
        return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
      }
    } catch (error) {
      Failure failure = ErrorHandler.handle(error).failure;
      insertLog(ExceptionRequestBody([ExceptionModel(failure.massage, "checkRep")]));
      return Left(failure);
    }
  }

  @override
  Future<Either<Failure, List<DoctorNoteModel>>> visitNotes(int repId) async {
    try {
      if (await _networkInfo.isConnected) {
        final response = await _remoteDataSource.visitNotes(repId);
        if (response.status == null ||
            response.status == ApiInternalStatus.SUCCESS ||
            response.status == "200") {
          return Right(response.toDomain());
        } else {
           Failure failure = Failure(ApiInternalStatus.FAILURE,
              response.message ?? ResponseMassage.DEFAULT);
          insertLog(ExceptionRequestBody([ExceptionModel(failure.massage, "visitNotes")]));
          return Left(failure);
        }
      } else {
        return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
      }
    } catch (error) {
      Failure failure = ErrorHandler.handle(error).failure;
      insertLog(ExceptionRequestBody([ExceptionModel(failure.massage, "visitNotes")]));
      return Left(failure);
    }
  }

  //
  @override
  Future<Either<Failure, List<DoctorIssueModel>>> getVisitIssue(
      int repId) async {
    try {
      if (await _networkInfo.isConnected) {
        final response = await _remoteDataSource.getVisitIssue(repId);
        if (response.status == null ||
            response.status == ApiInternalStatus.SUCCESS ||
            response.status == "200") {
          return Right(response.toDomain());
        } else {
           Failure failure = Failure(ApiInternalStatus.FAILURE,
              response.message ?? ResponseMassage.DEFAULT);
          insertLog(ExceptionRequestBody([ExceptionModel(failure.massage, "getVisitIssue")]));
          return Left(failure);
        }
      } else {
        return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
      }
    } catch (error) {
      Failure failure = ErrorHandler.handle(error).failure;
      insertLog(ExceptionRequestBody([ExceptionModel(failure.massage, "getVisitIssue")]));
      return Left(failure);
    }
  }

  //
  @override
  Future<Either<Failure, List<AllRepresentative>>> getReps(int id) async {
    try {
      if (await _networkInfo.isConnected) {
        final response = await _remoteDataSource.getReps(id);
        if (response.status == null ||
            response.status == ApiInternalStatus.SUCCESS ||
            response.status == "200") {
          return Right(response.toDomain());
        } else {
           Failure failure = Failure(ApiInternalStatus.FAILURE,
              response.message ?? ResponseMassage.DEFAULT);
          insertLog(ExceptionRequestBody([ExceptionModel(failure.massage, "getReps")]));
          return Left(failure);
        }
      } else {
        return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
      }
    } catch (error) {
      Failure failure = ErrorHandler.handle(error).failure;
      insertLog(ExceptionRequestBody([ExceptionModel(failure.massage, "getReps")]));
      return Left(failure);
    }
  }

  @override
  Future<Either<Failure, List<NoVisitDocModel>>> noVisitDoc(int depId) async {
    try {
      if (await _networkInfo.isConnected) {
        final response = await _remoteDataSource.noVisitDoc(depId);
        if (response.status == null ||
            response.status == ApiInternalStatus.SUCCESS ||
            response.status == "200") {
          return Right(response.toDomain());
        } else {
           Failure failure = Failure(ApiInternalStatus.FAILURE,
              response.message ?? ResponseMassage.DEFAULT);
          insertLog(ExceptionRequestBody([ExceptionModel(failure.massage, "noVisitDoc")]));
          return Left(failure);
        }
      } else {
        return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
      }
    } catch (error) {
      Failure failure = ErrorHandler.handle(error).failure;
      insertLog(ExceptionRequestBody([ExceptionModel(failure.massage, "noVisitDoc")]));
      return Left(failure);
    }
  }

  @override
  Future<Either<Failure, List<NoVisitDocModel>>> visitDoc(int depId) async {
    try {
      if (await _networkInfo.isConnected) {
        final response = await _remoteDataSource.visitDoc(depId);
        if (response.status == null ||
            response.status == ApiInternalStatus.SUCCESS ||
            response.status == "200") {
          return Right(response.toDomain());
        } else {
           Failure failure = Failure(ApiInternalStatus.FAILURE,
              response.message ?? ResponseMassage.DEFAULT);
          insertLog(ExceptionRequestBody([ExceptionModel(failure.massage, "visitDoc")]));
          return Left(failure);
        }
      } else {
        return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
      }
    } catch (error) {
      Failure failure = ErrorHandler.handle(error).failure;
      insertLog(ExceptionRequestBody([ExceptionModel(failure.massage, "visitDoc")]));
      return Left(failure);
    }
  }

  @override
  Future<Either<Failure, Message1Response>> insertLog(ExceptionRequestBody list1)  async {
    try {
      if (await _networkInfo.isConnected) {
        final response = await _remoteDataSource.insertLog(list1);
        if (response.status == null ||
            response.status == ApiInternalStatus.SUCCESS ||
            response.status == "200") {
          return Right(response);
        } else {
          Failure failure = Failure(ApiInternalStatus.FAILURE,
              response.message ?? ResponseMassage.DEFAULT);
          return Left(failure);
        }
      } else {
        return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
      }
    } catch (error) {
      Failure failure = ErrorHandler.handle(error).failure;
      return Left(failure);
    }
  }
}
