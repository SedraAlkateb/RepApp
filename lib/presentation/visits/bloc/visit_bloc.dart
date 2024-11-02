import 'package:bloc/bloc.dart';
import 'package:domina_app/data/network/failure.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/domain/usecase/all_brands_doctor_visits_sql_usecase.dart';
import 'package:domina_app/domain/usecase/all_brands_hospital_visits_sql_usecase.dart';
import 'package:domina_app/domain/usecase/all_visit_doctor_sql_usecase.dart';
import 'package:domina_app/domain/usecase/all_visit_hospital_sql_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
part 'visit_event.dart';
part 'visit_state.dart';

class VisitBloc extends Bloc<VisitEvent, VisitState> {
  // AllVisitPharmacySqlUsecase allVisitPharmacySqlUsecase;
  AllVisitDoctorSqlUsecase allVisitDoctorSqlUsecase;
//  AllBrandsPharmacyVisitsSqlUsecase allBrandsPharmacyVisitsSqlUsecase;
  AllBrandsDoctorVisitsSqlUsecase allBrandsDoctorVisitsSqlUsecase;
  AllBrandsHospitalVisitsSqlUsecase allBrandsHospitalVisitsSqlUsecase;
  AllVisitHospitalSqlUsecase allVisitHospitalSqlUsecase;
  // UpdatePharmacyUsecase updatePharmacyUsecase;
  // UpdateDoctorUsecase updateDoctorUsecase;
  // UpdateHospitalUsecase updateHospitalUsecase;
  int current = 0;
  // List<VisitPharmacyAndPharmacy> pharmacies=[];
  List<VisitDoctorAndDoctor> doctors = [];
  List<VisitHospitalAndHospital> hospitals = [];

  List<PharmacyBrandModel> brands = [];

  VisitBloc(
    //    this.allVisitPharmacySqlUsecase,
    this.allVisitDoctorSqlUsecase,
    //     this.allBrandsPharmacyVisitsSqlUsecase,
    this.allBrandsDoctorVisitsSqlUsecase,
    this.allBrandsHospitalVisitsSqlUsecase,
    this.allVisitHospitalSqlUsecase,
    //   this.updatePharmacyUsecase,
    //   this.updateDoctorUsecase,
    //   this.updateHospitalUsecase
  ) : super(VisitInitial()) {
    on<VisitEvent>((event, emit) async {
      // if(event is VisitPharmacyEvent)
      // {(
      //       await allVisitPharmacySqlUsecase.execute()).fold(
      // (failure)  {
      // print(failure.massage);
      // emit(VisitPharmacyErrorState(failure: failure));
      // },
      // (data)  async{
      //   pharmacies=data;
      //   emit(VisitPharmacyState());
      // });}
      if (event is VisitDoctorEvent) {
        (await allVisitDoctorSqlUsecase.execute()).fold((failure) {
          print(failure.massage);
          emit(VisitDoctorErrorState(failure: failure));
        }, (data) async {
          doctors = data;
          if(doctors.isNotEmpty){
            emit(VisitDoctorState(data));

          }else{
            emit(EmptyVisitHospitalState());
          }
        });
      } else if (event is VisitHospitalEvent) {
        (await allVisitHospitalSqlUsecase.execute()).fold((failure) {
          print(failure.massage);
          emit(VisitHospitalErrorState(failure: failure));
        }, (data) async {
          hospitals = data;
          if(hospitals.isNotEmpty){
            emit(VisitHospitalState(data));
          }else{
            emit(EmptyVisitHospitalState());
          }
        });
      } else if (event is SearchDoctorVisitEvent) {
        List<VisitDoctorAndDoctor> doctorSearch;
        doctorSearch = doctors.where((value) {
          if (value.doctorModel.title.contains(event.value)) {
            return true;
          }
          if (value.visitDoctorModel.science!.contains(event.value)) {
            return true;
          }
          return false;
        }
        ).toList();
        emit(SearchVisitDoctorState(doctorSearch));
      }
      else if (event is SearchHospitalVisitEvent) {
        List<VisitHospitalAndHospital> hospitalSearch;
        hospitalSearch = hospitals.where((value) {
          if (value.hospitalModel.title.contains(event.value)) {
            return true;
          }
          if (value.visitHospitalModel.science!.contains(event.value)) {
            return true;
          }
          return false;
        }).toList();
        emit(SearchVisitHospitalState(hospitalSearch));
      }
      // if(event is BrandPharmacyVisitEvent)
      // {
      //   (await allBrandsPharmacyVisitsSqlUsecase.execute(event.visitId)).fold(
      //         (failure)  {
      //       print(failure.massage);
      //       emit(BrandPharmacyVisitErrorState(failure: failure));
      //     },
      //         (data)  async{
      //           brands=data;
      //       emit(BrandPharmacyVisitState(data));
      //     });
      // }
      else if (event is BrandDoctorVisitEvent) {
        (await allBrandsDoctorVisitsSqlUsecase.execute(event.visitId)).fold(
            (failure) {
          print(failure.massage);
          emit(BrandPharmacyVisitErrorState(failure: failure));
        }, (data) async {
          brands = data;
          emit(BrandPharmacyVisitState(data));
        });
      } else if (event is BrandHospitalVisitEvent) {
        (await allBrandsHospitalVisitsSqlUsecase.execute(event.visitId)).fold(
            (failure) {
          print(failure.massage);
          emit(BrandHospitalVisitErrorState(failure: failure));
        }, (data) async {
          brands = data;
          emit(BrandHospitalVisitState(data));
        });
      }
    });
  }
}
