import 'package:dartz/dartz.dart';
import 'package:domina_app/domain/failure.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/domain/repository/repository_sql.dart';
import 'package:equatable/equatable.dart';

class AllPharmacySqlUsecase extends Equatable {
  final RepositorySql _repositorySql;
  AllPharmacySqlUsecase(this._repositorySql);
  Future<Either<Failure, List<PharmacyModel>>> execute() async {
    return await _repositorySql.getPharmacySql();
  }

  @override
  List<Object?> get props => [_repositorySql];
}
