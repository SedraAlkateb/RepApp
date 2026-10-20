import 'package:dartz/dartz.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/domain/repository/directory_repository.dart';
import 'package:domina_app/domain/failure.dart';
import 'package:equatable/equatable.dart';

class SearchDoctorsUsecase extends Equatable {
  final DirectoryRepository _repository;
  SearchDoctorsUsecase(this._repository);
  Future<Either<Failure, List<doctorsModel>>> execute(
    String name,
      int repDet,
  {int? cityId}
  ) async {
    return await _repository.docSearch( name,repDet,cityId: cityId);
  }

  @override
  List<Object?> get props => [_repository];
}
