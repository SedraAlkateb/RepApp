
import 'package:dartz/dartz.dart';
import 'package:domina_app/data/network/failure.dart';
import 'package:domina_app/data/responses/responses.dart';
import 'package:domina_app/domain/repostitory/repository.dart';
import 'package:equatable/equatable.dart';
class ChangeRepPlanStatus extends Equatable {
  final  Repository _repository;
  const ChangeRepPlanStatus(this._repository);
  Future<Either<Failure, Message1Response>> execute(int id,int status) async{
    return await _repository.changeRepPlanStatus(id,status);
  }

  @override
  List<Object?> get props => [_repository];

}




