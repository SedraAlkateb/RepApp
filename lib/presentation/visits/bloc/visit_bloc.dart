import 'package:bloc/bloc.dart';
import 'package:domina_app/data/network/failure.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/domain/usecase/all_brands_doctor_visits_sql_usecase.dart';
import 'package:domina_app/domain/usecase/all_brands_hospital_visits_sql_usecase.dart';
import 'package:domina_app/domain/usecase/all_brands_pharmacy_visits_sql_usecase.dart';
import 'package:domina_app/domain/usecase/all_visit_doctor_sql_usecase.dart';
import 'package:domina_app/domain/usecase/all_visit_hospital_sql_usecase.dart';
import 'package:domina_app/domain/usecase/all_visit_pharmacy_sql_usecase.dart';
import 'package:domina_app/domain/usecase/update_doctor_usecase.dart';
import 'package:domina_app/domain/usecase/update_hospital_usecase.dart';
import 'package:domina_app/domain/usecase/update_pharmacy_usecase.dart';
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
  int current =0;
 // List<VisitPharmacyAndPharmacy> pharmacies=[];
  List<VisitDoctorAndDoctor> doctors=[];
  List<VisitHospitalAndHospital> hospitals=[];

  List<PharmacyBrandModel> brands=[];

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
    on<VisitEvent>((event, emit)async {
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
      if(event is VisitDoctorEvent)
      {
        (await allVisitDoctorSqlUsecase.execute()).fold(
                (failure)  {print(failure.massage);
              emit(VisitDoctorErrorState(failure: failure));},
                (data)  async{
                  doctors=data;
                 emit(VisitDoctorState());

                });
      }
    /*
      if(event is UpdateVisitDoctorEvent)
      {
        (await updateDoctorUsecase.execute(event.id,event.sc,event.kas)).fold(
                (failure)  {print(failure.massage);
            emit(UpdateVisitDoctorErrorState(failure: failure));},
                (data)  async{
              emit(UpdateVisitDoctorState());
            });
      }
      if(event is UpdateVisitHospitalEvent)
      {
        (await updateHospitalUsecase.execute(event.id,event.sc,event.kas)).fold(
                (failure)  {print(failure.massage);
            emit(UpdateVisitHospitalErrorState(failure: failure));},
                (data)  async{
              emit(UpdateVisitHospitalState());

            });
      }
      if(event is UpdateVisitPharmacyEvent)
      {
        (await updatePharmacyUsecase.execute(event.id,event.data)).fold(
                (failure)  {print(failure.massage);
            emit(UpdateVisitPharmacyErrorState(failure: failure));},
                (data)  async{
              emit(UpdateVisitPharmacyState());

            });
      }
     */
      else   if(event is VisitHospitalEvent)
      {
        (await allVisitHospitalSqlUsecase.execute()).fold(
                (failure)  {print(failure.massage);
            emit(VisitHospitalErrorState(failure: failure));},
                (data)  async{
              hospitals=data;
              emit(VisitHospitalState());
            });
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
      else  if(event is BrandDoctorVisitEvent)
      {
        (await allBrandsDoctorVisitsSqlUsecase.execute(event.visitId)).fold(
                (failure)  {
              print(failure.massage);
              emit(BrandPharmacyVisitErrorState(failure: failure));
            },
                (data)  async{
              brands=data;
              emit(BrandPharmacyVisitState(data));
            });
      }
      else   if(event is BrandHospitalVisitEvent)
      {
        (await allBrandsHospitalVisitsSqlUsecase.execute(event.visitId)).fold(
                (failure)  {   
              print(failure.massage);
              emit(BrandHospitalVisitErrorState(failure: failure));
            },
                (data)  async{
              brands=data;
              emit(BrandHospitalVisitState(data));
            });
      }
          
    });
  }
}
