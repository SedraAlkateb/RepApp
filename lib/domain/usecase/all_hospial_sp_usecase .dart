
import 'package:dartz/dartz.dart';
import 'package:domina_app/domain/repostitory/repository.dart';
import 'package:domina_app/data/network/failure.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:equatable/equatable.dart';

class AllHospialSpUsecase  extends Equatable {
  final Repository _repository;
  AllHospialSpUsecase(this._repository);
  Future<Either<Failure, List<HospitalSpModel>>> execute(int id) async{
    return await _repository.getAllHospitalSp(id);
  }

  @override

  List<Object?> get props => [_repository];

}




