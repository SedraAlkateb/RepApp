
import 'package:dartz/dartz.dart';
import 'package:domina_app/domain/repostitory/repository.dart';
import 'package:domina_app/data/network/failure.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:equatable/equatable.dart';
class DocDoctorsUseCase extends Equatable {
  final Repository _repository;
  DocDoctorsUseCase(this._repository);
  Future<Either<Failure,  List<DocdoctorsModel>>> execute(int docId) async{
    return await _repository.docReport(docId);
  }

  @override
  List<Object?> get props => [_repository];

}




