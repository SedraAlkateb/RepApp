import 'dart:ffi';

import 'package:dartz/dartz.dart';
import 'package:domina_app/data/network/app_sql_api.dart';
import 'package:domina_app/data/network/error_handler.dart';
import 'package:domina_app/data/network/failure.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/domain/repostitory/repository_sql.dart';

class RepositroySqlImp extends RepositorySql {
  final AppSqlApi _databaseHelper;
  RepositroySqlImp(this._databaseHelper);

  @override
  Future<Either<Failure, List<BrandModel>>> getBrandsSql() async {
    try {
      // عملية قاعدة بيانات قد تفشل
      final response = await _databaseHelper.getBrands();
      return Right(response);
    } catch (e) {
      return Left(ErrorHandler
          .handle(e)
          .failure);
    }
  }
  @override
  Future<Either<Failure, List<PharmacyModel>>> getPharmacySql()
  async {
    try {
      // عملية قاعدة بيانات قد تفشل
      final response = await _databaseHelper.getPharmacy();
      return Right(response);
    } catch (e) {
      return Left(ErrorHandler
          .handle(e)
          .failure);
    }
  }
  @override
  Future<Either<Failure, List<PlaceModel>>> getPlaceSql() async {
    try {
      // عملية قاعدة بيانات قد تفشل
      final response = await _databaseHelper.getPlace();
      return Right(response);
    } catch (e) {
      return Left(ErrorHandler
          .handle(e)
          .failure);
    }
  }
  @override
  Future<Either<Failure, List<SpecModel>>> getSpecSql()async {
    try {
      // عملية قاعدة بيانات قد تفشل
      final response = await _databaseHelper.getSpec();
      return Right(response);
    } catch (e) {
      return Left(ErrorHandler
          .handle(e)
          .failure);
    }
  }



  @override
  Future<Either<Failure, Null>> insertBrandsSql(List<BrandModel> brandModel)  async {
    try {
      // عملية قاعدة بيانات قد تفشل
      final response = await _databaseHelper.insertBrands(brandModel);
      return Right(response);
    } catch (e) {
      return Left(ErrorHandler
          .handle(e)
          .failure);
    }
  }

  @override
  Future<Either<Failure, Null>> insertPharmacy(List<PharmacyModel> pharmacyModel)
  async {
    try {
      // عملية قاعدة بيانات قد تفشل
      final response = await _databaseHelper.insertPharmacy(pharmacyModel);
      return Right(response);
    } catch (e) {
      return Left(ErrorHandler
          .handle(e)
          .failure);
    }
  }

  @override
  Future<Either<Failure, Null>> insertPlace(List<PlaceModel> placeModel)
  async {
    try {
      // عملية قاعدة بيانات قد تفشل
      final response = await _databaseHelper.insertPlace(placeModel);
      return Right(response);
    } catch (e) {
      return Left(ErrorHandler
          .handle(e)
          .failure);
    }
  }

  @override
  Future<Either<Failure, Null>> insertSpec(List<SpecModel> specModel)  async {
    try {
      // عملية قاعدة بيانات قد تفشل
      final response = await _databaseHelper.insertSpec(specModel);
      return Right(response);
    } catch (e) {
      return Left(ErrorHandler
          .handle(e)
          .failure);
    }
  }
}