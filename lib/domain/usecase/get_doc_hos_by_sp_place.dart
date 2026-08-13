import 'package:dartz/dartz.dart';
import 'package:domina_app/domain/repostitory/repository.dart';
import 'package:domina_app/data/network/failure.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:equatable/equatable.dart';

class GetDocHosBySpPlace extends Equatable {
  final Repository _repository;
  GetDocHosBySpPlace(this._repository);
  Future<Either<Failure,DocHosByPlaceAndSp>> execute(int repDet,      {
    int? spId,
    int ?placeId,
  }) async {
    return await _repository.getSpDocHos(repDet,spId: spId,placeId: placeId);
  }

  @override
  List<Object?> get props => [_repository];
}
