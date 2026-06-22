import 'package:bloc/bloc.dart';
import 'package:domina_app/app/user_info.dart';
import 'package:domina_app/data/network/failure.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/domain/usecase/all_place_sql_usecase.dart';
import 'package:domina_app/domain/usecase/check_rep_usecase%20.dart';
import 'package:domina_app/domain/usecase/doctors_by_place_usecase.dart';
import 'package:domina_app/domain/usecase/hospitals_by_place_usecase.dart';
import 'package:domina_app/domain/usecase/num_doc_has_sql_usecase.dart';
import 'package:domina_app/domain/usecase/num_visit_sql_usecase.dart';
import 'package:domina_app/presentation/uniti/search.dart';
import 'package:domina_app/presentation/uniti/time.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
part 'place_event.dart';
part 'place_state.dart';

class PlaceBloc extends Bloc<PlaceEvent, PlaceState> {
  AllPlacesSqlUsecase allPlaceUsecase;
  NumVisitSqlUsecase numVisitSqlUsecase;
  NumDocHasSqlUsecase numDocHasSqlUsecase;
  DoctorsByPlaceUsecase doctorsByPlaceUsecase;
  HospitalsByPlaceUsecase hospitalsByPlaceUsecase;
  CheckRepUsecase checkRepUsecase;
  List<PlaceModel> placeModel = [];
  List<PlaceModel> placeSearchModel = [];
  int k = 0;
  bool isOpen=false;
  String data= formatDateTime(DateTime.now().toIso8601String());
  PlaceBloc(this.doctorsByPlaceUsecase,this.hospitalsByPlaceUsecase,this.allPlaceUsecase,this.checkRepUsecase,this.numVisitSqlUsecase,this.numDocHasSqlUsecase) : super(PlaceInitial()) {
    on<PlaceEvent>((event, emit) async {
      //  VisitPharmacyRequestBody  v=VisitPharmacyRequestBody(vi.toDomain(), list2);
      if (event is AllPlaceEvent) {
        //   emit(AllPlaceLoadingState());
        (await allPlaceUsecase.execute()).fold((failure) {
          emit(AllPlaceErrorState(failure: failure));
        }, (data) async {
          placeModel = data;
          placeSearchModel = data;
          emit(AllPlaceState(data));
        });
      }
      if (event is NumVisitEvent) {
        //   emit(AllPlaceLoadingState());
        (await numVisitSqlUsecase.execute()).fold((failure) {
          emit(NumVisitErrorState(failure: failure));
        }, (data) async {
          UserInfo.numOfHospitalVisit=data.visitHospital;
          UserInfo.numOfDoctorVisit=data.visitDoctor;
          emit(NumVisitState());
        });
      }
   else   if ((event is NumEvent)&& (isOpen==false)) {
        (await numDocHasSqlUsecase.execute()).fold((failure) {
          emit(NumVisitErrorState(failure: failure));
        }, (data) async {
          isOpen=true;
        });
      }
     else if (event is CheckRepEvent) {
        //   emit(CheckRepLoadingState());
        (await checkRepUsecase.execute(UserInfo.repId)).fold((failure) {
          emit(CheckRepErrorState(failure: failure));
        }, (data) async {
          emit(CheckRepState(data.accepted??true));
        });
      }
      else
        if (event is SearchPlaceEvent) {
        String search = normalizeText(event.value);
        placeSearchModel = placeModel.where((value) {
          if (normalizeText(value.title).contains(search)) {
            return true;
          } else {
            return false;
          }
        }).toList();
        emit(SearchPlaceState(placeSearchModel));
      }
      if (event is HospitalArchiveByPlace) {
        (await hospitalsByPlaceUsecase.execute(event.placeId)).fold((failure) {
          emit(AllHospitalArchiveByPlaceErrorState(failure: failure));
        }, (data) async {
          if (data.isNotEmpty) {
            emit(AllHospitalArchiveByPlaceState(searchData: data,baseData: data));
          } else {
            emit(EmptyArchiveState());
          }
        });
      }
      else if (event is DoctorArchiveByPlace) {
        (await doctorsByPlaceUsecase.execute(event.placeId)).fold((failure) {
          emit(AllDoctorArchiveByPlaceErrorState(failure: failure));
        }, (data) async {
          if (data.isNotEmpty) {
            emit(AllDoctorArchiveByPlaceState(BaseData: data,searchData: data));
          } else {
            emit(EmptyArchiveState());
          }
        });
      } else if (event is SearchHospitalArchive) {
        String search = normalizeText(event.search);
        List<HospitalModel> hospital = event.hospital.where((value) {
          if (normalizeText(value.title).contains(search)) {
            return true;
          } else {
            return false;
          }
        }).toList();
        emit(AllHospitalArchiveByPlaceState(baseData: event.hospital,searchData: hospital));
      }else if (event is SearchDoctorArchive) {
        String search = normalizeText(event.search);
        List<DoctorModel> doctors = event.doctors.where((value) {
          if (normalizeText(value.title).contains(search)) {
            return true;
          } else {
            return false;
          }
        }).toList();
        emit(AllDoctorArchiveByPlaceState(searchData: doctors,BaseData: event.doctors));
      }
    });
  }
} 
