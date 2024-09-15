import 'package:bloc/bloc.dart';
import 'package:domina_app/data/network/failure.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/domain/usecase/all_brands_flag_sql_usecase.dart';
import 'package:domina_app/domain/usecase/doctors_by_place_usecase.dart';
import 'package:domina_app/domain/usecase/hospitals_by_place_usecase.dart';
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
  List<BrandModel> selectBrand=[];
  List<BrandModel> bandFlag=[];
  int current =0;
  VisitPlaceBloc(
      this.pharmaciesByPlaceUsecase,
      this.allBrandsFlagSqlUsecase,
      this.doctorsByPlaceUsecase,
      this.hospitalsByPlaceUsecase
      )  : super(VisitPlaceInitial()) {
    on<VisitPlaceEvent>((event, emit) async {
      if(event is PharmacyByPlace){
        current=event.current;
        (
            await pharmaciesByPlaceUsecase.execute(event.placeId)).fold(
                (failure)  {
              emit(AllPharmacyByPlaceErrorState(failure: failure));
            },
                (data)  async{
              emit(AllPharmacyByPlaceState(data));
              print("dshhhhhhhhhhhhhhbbbbbbbbbbbbbbhhhd");
              print(data.length);
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
              emit(AllHospitalByPlaceState(data));
              print("dshhhhhhhhhhhhhhbbbbbbbbbbbbbbhhhd");
              print(data.length);
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
              emit(AllDoctorByPlaceState(data));
              print("dshhhhhhhhhhhhhhbbbbbbbbbbbbbbhhhd");
              print(data.length);
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
        selectBrand.add(event.brandModel);
        emit(SelectBrandState(selectBrand));
      }
    });
  }
}
