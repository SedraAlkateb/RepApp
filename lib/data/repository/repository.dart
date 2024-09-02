
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

  RepositoryImp(this._remoteDataSource,this._networkInfo);

  @override
  Future<Either<Failure, Token>> login(LoginRequest loginRequest) async {
    try {
      //connect to internet,its safe to call Api
      final response = await _remoteDataSource.login(loginRequest);
      if (response.st == null) {
        //success
        //return either right
        //return data
        return Right(response.toDomain());
      } else {
        //return either left
        //failure --business error
        return Left(Failure(ApiInternalStatus.FAILURE,
            response.message ?? ResponseMassage.DEFAULT));
      }
    } catch (error) {
      return Left(ErrorHandler
          .handle(error)
          .failure);
    }
  }

  @override
  Future<Either<Failure, List<PlaceModel>>> allPlace(int id)  async {
    try {
      //connect to internet,its safe to call Api
      final response = await _remoteDataSource.allPlaces(id);
      if (response.st == null) {
        //success
        //return either right
        //return data
        return Right(response.toDomain());
      } else {
        //return either left
        //failure --business error
        return Left(Failure(ApiInternalStatus.FAILURE,
            response.message ?? ResponseMassage.DEFAULT));
      }
    } catch (error) {
      return Left(ErrorHandler
          .handle(error)
          .failure);
    }
  }

  @override
  Future<Either<Failure, MessageResponse>> logout() {
    // TODO: implement logout
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<SpecModel>>> allSpec(int id) async {
    try {
      //connect to internet,its safe to call Api
      final response = await _remoteDataSource.allSpecializations(id);
      if (response.st == null) {
        //success
        //return either right
        //return data
        return Right(response.toDomain());
      } else {
        //return either left
        //failure --business error
        return Left(Failure(ApiInternalStatus.FAILURE,
            response.message ?? ResponseMassage.DEFAULT));
      }
    } catch (error) {
      return Left(ErrorHandler
          .handle(error)
          .failure);
    }
  }

  @override
  Future<Either<Failure, List<CityModel>>> allMedicalRepresentative(int id) async {
    try {
      //connect to internet,its safe to call Api
      final response = await _remoteDataSource.allMedicalRepresentative(id);
      if (response.st == null) {
        //success
        //return either right
        //return data
        return Right(response.toDomain());
      } else {
        //return either left
        //failure --business error
        return Left(Failure(ApiInternalStatus.FAILURE,
            response.message ?? ResponseMassage.DEFAULT));
      }
    } catch (error) {
      return Left(ErrorHandler
          .handle(error)
          .failure);
    }
  }

  @override
  Future<Either<Failure, List<BrandModel>>> allBrand()  async {
    try {
      //connect to internet,its safe to call Api
      final response = await _remoteDataSource.allBrand();
      if (response.st == null) {
        //success
        //return either right
        //return data
        return Right(response.toDomain());
      } else {
        //return either left
        //failure --business error
        return Left(Failure(ApiInternalStatus.FAILURE,
            response.message ?? ResponseMassage.DEFAULT));
      }
    } catch (error) {
      return Left(ErrorHandler
          .handle(error)
          .failure);
    }
  }

  @override
  Future<Either<Failure, List<CityModel>>> allCity() async {
    try {
      //connect to internet,its safe to call Api
      final response = await _remoteDataSource.allCity();
      if (response.st == null) {
        //success
        //return either right
        //return data
        return Right(response.toDomain());
      } else {
        //return either left
        //failure --business error
        return Left(Failure(ApiInternalStatus.FAILURE,
            response.message ?? ResponseMassage.DEFAULT));
      }
    } catch (error) {
      return Left(ErrorHandler
          .handle(error)
          .failure);
    }
  }
  @override
  Future<Either<Failure, List<MedicalVisits>>> allVisitDoctor(int id)  async {
    try {
      //connect to internet,its safe to call Api
      final response = await _remoteDataSource.allVisitDoctor(id);
      if (response.st == null) {
        //success
        //return either right
        //return data
        return Right(response.toDomain());
      } else {
        //return either left
        //failure --business error
        return Left(Failure(ApiInternalStatus.FAILURE,
            response.message ?? ResponseMassage.DEFAULT));
      }
    } catch (error) {
      return Left(ErrorHandler
          .handle(error)
          .failure);
    }
  }

  @override
  Future<Either<Failure, List<PharmacyModel>>> getAllPharmacy(int repDet)  async {
    try {
      //connect to internet,its safe to call Api
      final response = await _remoteDataSource.getAllPharmacy(repDet);
      if (response.st == null) {
        //success
        //return either right
        //return data
        return Right(response.toDomain());
      } else {
        //return either left
        //failure --business error
        return Left(Failure(ApiInternalStatus.FAILURE,
            response.message ?? ResponseMassage.DEFAULT));
      }
    } catch (error) {
      return Left(ErrorHandler
          .handle(error)
          .failure);
    }
  }

@override
  Future<Either<Failure, List<DoctorModel>>> getAllDoctor(int repDet) async {
    try {
      //connect to internet,its safe to call Api
      final response = await _remoteDataSource.getAllDoctor(repDet);
      if (response.st == null) {
        //success
        //return either right
        //return data
        return Right(response.toDomain());
      } else {
        //return either left
        //failure --business error
        return Left(Failure(ApiInternalStatus.FAILURE,
            response.message ?? ResponseMassage.DEFAULT));
      }
    } catch (error) {
      return Left(ErrorHandler
          .handle(error)
          .failure);
    }
  }
  
  @override
  Future<Either<Failure, List<DoctorModel>>> getAllHospital(int repDet)  async {
    try {
      //connect to internet,its safe to call Api
      final response = await _remoteDataSource.getAllHospital(repDet);
      if (response.st == null) {
        //success
        //return either right
        //return data
        return Right(response.toDomain());
      } else {
        //return either left
        //failure --business error
        return Left(Failure(ApiInternalStatus.FAILURE,
            response.message ?? ResponseMassage.DEFAULT));
      }
    } catch (error) {
      return Left(ErrorHandler
          .handle(error)
          .failure);
    }
  }
}
