import 'package:dartz/dartz.dart';
import 'package:domina_app/domain/failure.dart';
import 'package:domina_app/domain/models/models.dart';

abstract class PlansRepository {
  Future<Either<Failure, List<PlanBrandModel>>> getAllPlanBrands(Rep rep);

  Future<Either<Failure, AllPlanBrandSp?>> getRepPlanBrandSp(RepSp rep);

  Future<Either<Failure, List<PlanBrandModel>>> getAllPlanBrandsType(Rep rep);

  Future<Either<Failure, MessageModel>> repPlanBrand(
      RepPlanBrandBody list1);

  Future<Either<Failure, LoginModel>> checkActivePlanBrand(int repDe);

  Future<Either<Failure, List<BrandRes>>> getBrandRes(int repDet);

  Future<Either<Failure, MessageModel>> changePlanBrandType(
      ChangePlanBrandType changePlanBrandType);

  Future<Either<Failure, List<ActivePlanBrandModel>>> getInfoPlanBrandsType(
      int repPlan,{int status=0});

  Future<Either<Failure, AllPlanBrandsInfo>> getInfoPlanBrands(int repPlanId);

  Future<Either<Failure, List<AllRepresentativeFuture>>> getRepsFuture(
      int id,
      {int ?cityId});

  Future<Either<Failure, MessageModel>> updateRepPlanBrandAmount(
      BrandAmountRequestBody list);

  Future<Either<Failure, MessageModel>> changeRepPlanStatus(
      int id, int status);

  Future<Either<Failure, List<FinishedPlanModel>>> getFinishedPlans(int cityId);

  Future<Either<Failure, List<PlanRepsModel>>> getPlanReps(int planId);
}
