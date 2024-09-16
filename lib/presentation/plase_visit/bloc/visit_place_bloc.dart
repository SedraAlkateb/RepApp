import 'package:bloc/bloc.dart';
import 'package:domina_app/data/network/failure.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/domain/usecase/all_brands_flag_sql_usecase.dart';
import 'package:domina_app/domain/usecase/doctors_by_place_usecase.dart';
import 'package:domina_app/domain/usecase/hospitals_by_place_usecase.dart';
import 'package:domina_app/domain/usecase/insert_visit_pharmacy_sql_usecase.dart';
import 'package:domina_app/domain/usecase/pharmacies_by_place_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'visit_place_event.dart';
part 'visit_place_state.dart';

class VisitPlaceBloc extends Bloc<VisitPlaceEvent, VisitPlaceState> {
  PharmaciesByPlaceUsecase pharmaciesByPlaceUsecase;
  AllBrandsFlagSqlUsecase allBrandsFlagSqlUsecase;
  DoctorsByPlaceUsecase doctorsByPlaceUsecase;
  HospitalsByPlaceUsecase hospitalsByPlaceUsecase;
  InsertVisitPharmacySqlUsecase insertVisitPharmacySqlUsecase;
  List<BrandModel> selectBrand=[];
  List<BrandModel> bandFlag=[];
  List<PharmacyModel> pharmacies=[];
  List<DoctorModel> doctors=[];
  List<DoctorModel> hospitals=[];

  int current =0;
  VisitPlaceBloc(
      this.pharmaciesByPlaceUsecase,
      this.allBrandsFlagSqlUsecase,
      this.doctorsByPlaceUsecase,
      this.hospitalsByPlaceUsecase,
      this.insertVisitPharmacySqlUsecase
      )  : super(VisitPlaceInitial()) {
    on<VisitPlaceEvent>((event, emit) async {
      print("objectssssssssss");
      if(event is PharmacyByPlace){
        current=event.current;
        (
            await pharmaciesByPlaceUsecase.execute(event.placeId)).fold(
                (failure)  {
              emit(AllPharmacyByPlaceErrorState(failure: failure));
            },
                (data)  async{
                  pharmacies=data;
              emit(AllPharmacyByPlaceState(data));
            }
        );
      }
      if(event is HospitalByPlace){
        current=event.current;
        (

            await hospitalsByPlaceUsecase.execute(event.placeId)).fold(
                (failure)  {
              emit(AllHospitalByPlaceErrorState(failure: failure));
            },
                (data)  async{
                  hospitals=data;
              emit(AllHospitalByPlaceState(data));
            }

        );
      }
      if(event is DoctorByPlace)
      {  current=event.current;
        (
            await doctorsByPlaceUsecase.execute(event.placeId)).fold(
                (failure)  {
              emit(AllDoctorByPlaceErrorState(failure: failure));
            },
                (data)  async{
                  doctors=data;
                  print(doctors.length);
              emit(AllDoctorByPlaceState(data));
            }

        );
      }
      if(event is BrandFlagEvent)
      {
        (
            await allBrandsFlagSqlUsecase.execute()
        ).fold
          (
                (failure)  {
              emit(BrandFlagErrorState(failure: failure));
            },
                (data)  async {
              bandFlag=data;
              emit(BrandFlagState(data));
            }
        );
      }
      if(event is SelectBrandEvent)
      {
        List<BrandModel> updatedList = List.from(selectBrand);
        updatedList.add(event.brandModel);
        selectBrand = updatedList;
        emit(SelectBrandState(selectBrand));
      }
    });
  }
}
