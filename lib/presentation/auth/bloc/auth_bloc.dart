import 'package:bloc/bloc.dart';
import 'package:domina_app/data/network/failure.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/domain/usecase/all_brands_usecase.dart';
import 'package:domina_app/domain/usecase/all_pharmacy_usecase.dart';
import 'package:domina_app/domain/usecase/all_place_usecase.dart';
import 'package:domina_app/domain/usecase/all_spec_usecase.dart';
import 'package:domina_app/domain/usecase/delete_sql_usecase.dart';
import 'package:domina_app/domain/usecase/insert_all_brands_sql_usecase.dart';
import 'package:domina_app/domain/usecase/insert_all_pharmacy_sql_usecase.dart';
import 'package:domina_app/domain/usecase/insert_all_place_sql_usecase.dart';
import 'package:domina_app/domain/usecase/insert_all_spec_sql_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AllBrandsUsecase allBrandsUsecase;
  InsertAllBrandsSqlUsecase insertAllBrandsSqlUsecase;
  AllPharmacyUsecase allPharmacyUsecase;
  InsertAllPharmacysSqlUsecase insertAllPharmacysSqlUsecase;
  AllPlaceUsecase allPlaceUsecase;
  InsertAllPlacesSqlUsecase insertAllPlacesSqlUsecase;
  AllSpeUsecase allSpeUsecase;
  InsertAllSpecsSqlUsecase insertAllSpecsSqlUsecase;
  DeleteSqlUsecase deleteSqlUsecase;
  List<BrandModel> brands = [];
  List<PharmacyModel> pharmacies = [];
  List<PlaceModel> places = [];
  List<SpecModel> spec = [];

  AuthBloc(
      this.allBrandsUsecase,
      this.insertAllBrandsSqlUsecase,
      this.allPharmacyUsecase,
      this.insertAllPharmacysSqlUsecase,
      this.allPlaceUsecase,
      this.insertAllPlacesSqlUsecase,
      this.allSpeUsecase,
      this.insertAllSpecsSqlUsecase,
      this.deleteSqlUsecase)
      : super(AuthInitial()) {
    on<AuthEvent>((event, emit) async {
      if (event is AsyncDataEvent) {
        emit(SyncDataLoadingState());
        (await deleteSqlUsecase.execute()).fold((failure) {
          emit(SyncDataErrorState(failure: failure));
          return false;
        }, (data) async {
       await getData();
       await setData();
        });

      }
    });
  }

  Future<bool> getData() async {
    brands=[];
    places=[];
    pharmacies=[];
    spec=[];
    (await allBrandsUsecase.execute()).fold((failure) {
      emit(SyncDataErrorState(failure: failure));
      return false;
    }, (data) async {
      brands = data;
    });
    (await allPharmacyUsecase.execute(117)).fold((failure) {
      emit(SyncDataErrorState(failure: failure));
      return false;
    }, (data) async {
      pharmacies = data;
    });
    (await allPlaceUsecase.execute(117)).fold((failure) {
      emit(SyncDataErrorState(failure: failure));

      return false;
    }, (data) async {
      places = data;
    });
    (await allSpeUsecase.execute(117)).fold((failure) {
      emit(SyncDataErrorState(failure: failure));

      return false;
    }, (data) async {
      spec = data;

    });
  //  emit(SyncDataState());
    return true;
  }
  Future<bool> setData() async {
    (await insertAllBrandsSqlUsecase.execute(brands)).fold((failure) {
      emit(SyncDataErrorState(failure: failure));
      return false;
    }, (data) async {
      print("brand");
      brands = [];
    });
    (await insertAllPlacesSqlUsecase.execute(places)).fold((failure) {
      emit(SyncDataErrorState(failure: failure));

      return false;
    }, (data) async {
      print("places");
      places = [];
    });
    (await insertAllPharmacysSqlUsecase.execute(pharmacies)).fold((failure) {
      emit(SyncDataErrorState(failure: failure));
      return false;
    }, (data) async {
      pharmacies = [];
      print("pharmacies");

    });

    (await insertAllSpecsSqlUsecase.execute(spec)).fold((failure) {
      emit(SyncDataErrorState(failure: failure));

      return false;
    }, (data) async {
      print("spec");

      spec = [];

    });
    emit(SyncDataState());
    return true;
  }
}
