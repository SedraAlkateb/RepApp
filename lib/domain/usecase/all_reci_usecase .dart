
import 'package:dartz/dartz.dart';
import 'package:domina_app/domain/repostitory/repository.dart';
import 'package:domina_app/data/network/failure.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:equatable/equatable.dart';

class AllReciUsecase   extends Equatable {
  final Repository _repository;
  AllReciUsecase(this._repository);
  Future<Either<Failure, List<ReciModel>>> execute(int id) async{
    return await _repository.getAllRepReci(id);
  }
  @override
  List<Object?> get props => [_repository];
}




