import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:domina_app/data/network/failure.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/domain/usecase/all_brands_sql_usecase.dart';
import 'package:domina_app/domain/usecase/all_brands_usecase.dart';
import 'package:domina_app/domain/usecase/insert_all_brands_sql_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'brand_event.dart';
part 'brand_state.dart';

class BrandBloc extends Bloc<BrandEvent, BrandState> {
  AllBrandsUsecase allBrandsUsecase;
  AllBrandsSqlUsecase allBrandsSqlUsecase;
  InsertAllBrandsSqlUsecase insertAllBrandsSqlUsecase;
  BrandBloc(this.allBrandsUsecase,this.allBrandsSqlUsecase
      ,this.insertAllBrandsSqlUsecase
      ) : super(BrandInitial()) {
    on<BrandEvent>((event, emit)async {
      if(event is AllBrandEvent){
        emit(AllBrandLoadingState());
        (
            await allBrandsSqlUsecase.execute()).fold(
      (failure)  {
      emit(AllBrandErrorState(failure: failure));
      },
      (data)  async{
      emit(AllBrandState(data));
      }

      );
    }

    });
  }
}
