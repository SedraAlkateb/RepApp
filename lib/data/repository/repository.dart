
import 'package:dartz/dartz.dart';
import 'package:domina_app/data/data_source/remote_data_source.dart';
import 'package:domina_app/data/mapper/mapper.dart';
import 'package:domina_app/data/network/error_handler.dart';
import 'package:domina_app/data/network/failure.dart';
import 'package:domina_app/data/network/requests/requsets.dart';
import 'package:domina_app/data/responses/responses.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/domain/repostitory/repository.dart';

class RepositoryImp implements Repository {
  final RemoteDataSource _remoteDataSource;

// final NetworkInfo _networkInfo;

  RepositoryImp(this._remoteDataSource);

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
            response.massage ?? ResponseMassage.DEFAULT));
      }
    } catch (error) {
      return Left(ErrorHandler
          .handle(error)
          .failure);
    }
  }

}