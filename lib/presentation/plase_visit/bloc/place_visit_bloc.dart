import 'package:bloc/bloc.dart';
import 'package:domina_app/data/network/failure.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/domain/usecase/all_brands_flag_sql_usecase.dart';
import 'package:domina_app/domain/usecase/pharmacies_by_place_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

part 'place_visit_event.dart';
part 'place_visit_state.dart';

class PlaceVisitBloc extends Bloc<PlaceVisitEvent, PlaceVisitState> {
  PharmaciesByPlaceUsecase pharmaciesByPlaceUsecase;
  AllBrandsFlagSqlUsecase allBrandsFlagSqlUsecase;
  List<BrandModel> selectBrand=[];
  PlaceVisitBloc(
      this.pharmaciesByPlaceUsecase,
      this.allBrandsFlagSqlUsecase
      ) : super(PlaceVisitInitial()) {
    on<PlaceVisitEvent>((event, emit)async {
      if(event is PharmacyByPlace){
        //    emit(AllPharmacyByPlaceLoadingState());
        (
            await pharmaciesByPlaceUsecase.execute(event.placeId)).fold(
      (failure)  {
        print("dsd");

        emit(AllPharmacyByPlaceErrorState(failure: failure));
      },
      (data)  async{
      emit(AllPharmacyByPlaceState(data));
      print("dshhhhhhhhhhhhhhbbbbbbbbbbbbbbhhhd");
      print(data.length);
      }

      );
    }
      if(event is BrandFlagEvent){
        (
            await allBrandsFlagSqlUsecase.execute()).fold(
                (failure)  {
              print("dsd");
              emit(BrandFlagErrorState(failure: failure));
            },
                (data)  async{
                  print("DSsssssssssssssssssssssssssssssssssssssssssssssssssssssssssssss");
                  emit(BrandFlagState(data));

            }

        );
      }
      if(event is SelectBrandEvent){
        selectBrand.add(event.brandModel);
        SelectBrandState(selectBrand);
      }
    });
  }
}
