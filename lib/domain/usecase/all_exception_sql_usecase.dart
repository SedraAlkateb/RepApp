
import 'package:dartz/dartz.dart';
import 'package:domina_app/data/network/failure.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/domain/repostitory/repository_sql.dart';
import 'package:equatable/equatable.dart';
class AllExceptionSqlUsecase extends Equatable {
  final RepositorySql _repository;
  AllExceptionSqlUsecase(this._repository);
  Future<Either<Failure, List<ExceptionModel>>> execute() async{
    return await _repository.allException();
  }

  @override

  List<Object?> get props => [_repository];

}




