import 'package:bloc/bloc.dart';
import 'package:domina_app/app/user_info.dart';
import 'package:domina_app/data/mapper/mapper.dart';
import 'package:domina_app/data/network/failure.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/domain/usecase/all_doctor_sql_usecase%20.dart';
import 'package:domina_app/domain/usecase/all_doctor_usecase%20.dart';
import 'package:domina_app/domain/usecase/all_hospial_sp_usecase%20.dart';
import 'package:domina_app/domain/usecase/all_hospital_sp_n_sql_usecase.dart';
import 'package:domina_app/domain/usecase/check_reci_usecase.dart';
import 'package:domina_app/presentation/uniti/search.dart';
import 'package:equatable/equatable.dart';
part 'doctors_event.dart';
part 'doctors_state.dart';

class DoctorsBloc extends Bloc<DoctorsEvent, DoctorsState> {
  AllDoctorsSqlUsecase allDoctorsqlUsecase;
  CheckReciUsecase checkReciUsecase;
  AllHospitalSpNSqlUsecase allHospitalSpNSqlUsecase;
  AllDoctorUsecase allDoctorUsecase;
  AllHospialSpUsecase allHospitalUsecase;
  List<HospitalSpAllModel> hospital = [];
  List<DoctorModel> doctor = [];

  DoctorsBloc(
      this.allDoctorsqlUsecase, this.checkReciUsecase,this.allHospitalSpNSqlUsecase,this.allDoctorUsecase,this.allHospitalUsecase)
      : super(DoctorsInitial()) {
    on<DoctorsEvent>((event, emit) async {
      if (event is AllDoctorEvent) {
        emit(AllDoctorLoadingState());
        if(UserInfo.repType.i==6||UserInfo.repType.i==7){
          (await allDoctorsqlUsecase.execute()).fold((failure) {
            emit(AllDoctorErrorState(failure: failure));
            print(failure.massage);
          }, (data) async {
            doctor = data;
            if (doctor.isNotEmpty) {
              emit(AllDoctorState(data));
            } else {
              emit(AllDoctorEmptyState());
            }
          });
        }else{
          (await allDoctorUsecase.execute(UserInfo.repId)).fold((failure) {
            emit(AllDoctorErrorState(failure: failure));
            print(failure.massage);
          }, (data) async {
            doctor = data;
            if (doctor.isNotEmpty) {
              emit(AllDoctorState(data));
            } else {
              emit(AllDoctorEmptyState());
            }
          });
        }

      } else if (event is SearchDocEvent) {
        List<DoctorModel> doctorList;
        String search = normalizeText(event.contant);
        doctorList = doctor.where((value) {
          if (normalizeText(value.title).contains(search)) {
            return true;
          }
          if (normalizeText(value.address).contains(search)) {
            return true;
          }
          if (normalizeText(value.placeTitle).contains(search)) {
            return true;
          }
          if (normalizeText(value.spTitle).contains(search)) {
            return true;
          }
          return false;
        }).toList();

        emit(AllDoctorState(doctorList));
      }

      if (event is CheckReciEvent) {
        emit(CheckRecipesLoadingState(event.docId));
        (await checkReciUsecase.execute(UserInfo.repId)).fold((failure) {

          emit(CheckRecipesErrorState(failure: failure,event.docId));
        }, (data) async {
          emit(CheckRecipesState(data.accepted ?? false,event.st,event.docId));
        });
      }
      if (event is AllHospitalEvent) {
        emit(AllHospitalLoadingState());
        if(UserInfo.repType.i==6||UserInfo.repType.i==7){
        (await allHospitalSpNSqlUsecase.execute()).fold((failure) {
          emit(AllHospitalErrorState(failure: failure));
        }, (data) async {
          hospital = data;
          if (hospital.isNotEmpty) {
            emit(AllHospitalsState(data));
          } else {
            emit(AllHospitalEmptyState());
          }
        });

        }else{
          (await allHospitalUsecase.execute(UserInfo.repId)).fold((failure) {
            emit(AllHospitalErrorState(failure: failure));
          }, (data) async {
            hospital = data.toDomain();
            if (hospital.isNotEmpty) {
              emit(AllHospitalsState(hospital));
            } else {
              emit(AllHospitalEmptyState());
            }
          });
        }
      }
      else if (event is SearchhosEvent) {
        List<HospitalSpAllModel> hospitallist;
        String search = normalizeText(event.contant);
        hospitallist = hospital.where((value) {
          if (normalizeText(value.title ?? "").contains(search)) {
            return true;
          }
          if (normalizeText(value.address ?? "").contains(search)) {
            return true;
          }
          if (normalizeText(value.placeTitle ?? "").contains(search)) {
            return true;
          }

          return false;
        }).toList();

        emit(AllHospitalsState(hospitallist));
      }

    });
  }
}
