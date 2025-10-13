
import 'package:dartz/dartz.dart';
import 'package:domina_app/domain/repostitory/repository.dart';
import 'package:domina_app/data/network/failure.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:equatable/equatable.dart';
class AllNoVisitDoctorUsecase extends Equatable {
  final Repository _repository;
  AllNoVisitDoctorUsecase(this._repository);
  Future<Either<Failure, List<NoVisitDocModel>>> execute(int depId) async{
    return await _repository.noVisitDoc(depId);
  }

  @override
  List<Object?> get props => [_repository];

}




