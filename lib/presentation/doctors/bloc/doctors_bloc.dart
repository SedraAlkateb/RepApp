import 'package:bloc/bloc.dart';
import 'package:domina_app/app/user_info.dart';
import 'package:domina_app/data/mapper/mapper.dart';
import 'package:domina_app/domain/failure.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/domain/usecase/all_doctor_sql_usecase.dart';
import 'package:domina_app/domain/usecase/all_doctor_usecase.dart';
import 'package:domina_app/domain/usecase/all_hospial_sp_usecase.dart';
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
      this.allDoctorsqlUsecase,
      this.checkReciUsecase,
      this.allHospitalSpNSqlUsecase,
      this.allDoctorUsecase,
      this.allHospitalUsecase)
      : super(DoctorsInitial()) {
    on<AllDoctorEvent>((event, emit) async {
      emit(AllDoctorLoadingState());
      if (UserInfo.repType.i == 6 || UserInfo.repType.i == 7) {
        (await allDoctorsqlUsecase.execute()).fold((failure) {
          emit(AllDoctorErrorState(failure: failure));
        }, (data) async {
          doctor = data;
          if (doctor.isNotEmpty) {
            emit(AllDoctorState(data));
          } else {
            emit(AllDoctorEmptyState());
          }
        });
      } else {
        (await allDoctorUsecase.execute(UserInfo.repId)).fold((failure) {
          emit(AllDoctorErrorState(failure: failure));
        }, (data) async {
          doctor = data;
          if (doctor.isNotEmpty) {
            emit(AllDoctorState(data));
          } else {
            emit(AllDoctorEmptyState());
          }
        });
      }
    });

    on<SearchDocEvent>((event, emit) async {
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
    });

    on<CheckReciEvent>((event, emit) async {
      emit(CheckRecipesLoadingState(event.docId));
      (await checkReciUsecase.execute(UserInfo.repId)).fold((failure) {
        emit(CheckRecipesErrorState(failure: failure, event.docId));
      }, (data) async {
        emit(CheckRecipesState(data.accepted ?? false, event.st, event.docId));
      });
    });

    on<AllHospitalEvent>((event, emit) async {
      emit(AllHospitalLoadingState());
      if (UserInfo.repType.i == 6 || UserInfo.repType.i == 7) {
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
      } else {
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
    });

    on<SearchhosEvent>((event, emit) async {
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
    });
  }
}
