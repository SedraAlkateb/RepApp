import 'package:dartz/dartz.dart';
import 'package:domina_app/domain/failure.dart';
import 'package:domina_app/domain/models/models.dart';

abstract class RecipesRepository {
  Future<Either<Failure, InsertRecResponse>> insertReci(ReciRequest reciReq);

  Future<Either<Failure, CheckReModel>> checkRe(int repDet);

  Future<Either<Failure, List<int>>> reciNum();

  Future<Either<Failure, CopyReciRequest>> copyReci(
      int docId, String recipeType);

  Future<Either<Failure, CopyReciRequest>> getRepReci(int reciId);

  Future<Either<Failure, List<ReciModel>>> getAllRepReci(int repDet);

  Future<Either<Failure, InsertRecResponse>> updateReci(
      UpdateReciRequest reciReq);
}
