import 'package:bloc/bloc.dart';
import 'package:domina_app/data/network/failure.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/domain/usecase/all_brands_doctor_visits_sql_usecase.dart';
import 'package:domina_app/domain/usecase/all_brands_pharmacy_visits_sql_usecase.dart';
import 'package:domina_app/domain/usecase/all_visit_doctor_sql_usecase.dart';
import 'package:domina_app/domain/usecase/all_visit_pharmacy_sql_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'visit_event.dart';
part 'visit_state.dart';

class VisitBloc extends Bloc<VisitEvent, VisitState> {
  AllVisitPharmacySqlUsecase allVisitPharmacySqlUsecase;
  AllVisitDoctorSqlUsecase allVisitDoctorSqlUsecase;
  AllBrandsPharmacyVisitsSqlUsecase allBrandsPharmacyVisitsSqlUsecase;
  AllBrandsDoctorVisitsSqlUsecase allBrandsDoctorVisitsSqlUsecase;
  int current =0;
  List<VisitPharmacyAndPharmacy> pharmacies=[];
  List<VisitDoctorAndDoctor> pharmaciesDoctor=[];

  List<PharmacyBrandModel> brands=[];

  VisitBloc(
      this.allVisitPharmacySqlUsecase,
      this.allVisitDoctorSqlUsecase,
      this.allBrandsPharmacyVisitsSqlUsecase,
      this.allBrandsDoctorVisitsSqlUsecase
      ) : super(VisitInitial()) {
    on<VisitEvent>((event, emit)async {
      if(event is VisitPharmacyEvent)
      {(
            await allVisitPharmacySqlUsecase.execute()).fold(
      (failure)  {
      print(failure.massage);
      emit(VisitPharmacyErrorState(failure: failure));
      },
      (data)  async{
        pharmacies=data;
        emit(VisitPharmacyState());
      });}
      if(event is VisitDoctorEvent)
      {
        (await allVisitDoctorSqlUsecase.execute()).fold(
                (failure)  {print(failure.massage);
              emit(VisitDoctorErrorState(failure: failure));},
                (data)  async{
                  pharmaciesDoctor=data;
                 emit(VisitDoctorState());

                });
      }
      if(event is BrandPharmacyVisitEvent)
      {
        (await allBrandsPharmacyVisitsSqlUsecase.execute(event.visitId)).fold(
              (failure)  {
            print(failure.massage);
            emit(BrandPharmacyVisitErrorState(failure: failure));
          },
              (data)  async{
                brands=data;
            emit(BrandPharmacyVisitState(data));
          });
      }
      if(event is BrandDoctorVisitEvent)
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
    });
  }
}
