import 'package:dartz/dartz.dart';
import 'package:domina_app/domain/failure.dart';
import 'package:domina_app/domain/models/models.dart';

abstract class SqlPlansRepository {
  Future<Either<Failure, List<PlanBrandModel>>> planBrandsAs();
  Future<Either<Failure, Null>> updateAmounts(
      List<OtherBrandSpPlanModel> planBrands);
  Future<Either<Failure, Null>> updateOtherStatus(
      int repId, int status, List<OtherBrandSpPlanModel> planBrands);
  Future<Either<Failure, List<BrandSpPlanModel>>> planBrandByRepPlanId(
      int repPlanId);
  Future<Either<Failure, List<OtherBrandSpPlanModel>>>
      otherPlanBrandByRepPlanId(int repPlanId);
  Future<Either<Failure, void>> editRecipe(InsertRecResponse recNum);
}
