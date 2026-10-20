import 'package:dartz/dartz.dart';
import 'package:domina_app/domain/repository/directory_repository.dart';
import 'package:domina_app/domain/failure.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:equatable/equatable.dart';

class AllCityUsecase extends Equatable {
  final DirectoryRepository _repository;
  AllCityUsecase(this._repository);
  Future<Either<Failure, List<CityModel>>> execute() async {
    return await _repository.allCity();
  }

  @override
  List<Object?> get props => [_repository];
}
