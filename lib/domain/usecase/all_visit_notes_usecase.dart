
import 'package:dartz/dartz.dart';
import 'package:domina_app/domain/repostitory/repository.dart';
import 'package:domina_app/data/network/failure.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:equatable/equatable.dart';
class AllVisitNotesUsecase extends Equatable {
  final  Repository _repository;
  AllVisitNotesUsecase(this._repository);
  Future<Either<Failure, List<DoctorNoteModel>>> execute(int id) async{
    return await _repository.visitNotes(id);
  }

  @override
  List<Object?> get props => [_repository];

}




