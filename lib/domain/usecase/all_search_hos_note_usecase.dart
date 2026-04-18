
import 'package:dartz/dartz.dart';
import 'package:domina_app/data/network/failure.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/domain/repostitory/repository.dart';
import 'package:equatable/equatable.dart';
class AllSearchHosNoteUsecase extends Equatable {
  final  Repository _repository;
  const AllSearchHosNoteUsecase(this._repository);
  Future<Either<Failure, List<SearchHospitalNoteModel>>> execute(int hosId,int spId) async{
    return await _repository.getSearchHospitalsNotes(hosId,spId);
  }

  @override
  List<Object?> get props => [_repository];

}




