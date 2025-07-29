
import 'package:dartz/dartz.dart';
import 'package:domina_app/domain/repostitory/repository.dart';
import 'package:domina_app/data/network/failure.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:equatable/equatable.dart';
class DoctorInfoUsecase extends Equatable {
  final  Repository _repository;
  DoctorInfoUsecase(this._repository);
  Future<Either<Failure, DoctorModel>> execute(int id) async{
    return await _repository.getDocInfo(id);
  }

  @override
  List<Object?> get props => [_repository];

}




