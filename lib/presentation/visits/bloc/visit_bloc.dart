import 'package:bloc/bloc.dart';
import 'package:domina_app/data/network/failure.dart';
import 'package:domina_app/domain/usecase/all_visit_doctor_sql_usecase.dart';
import 'package:domina_app/domain/usecase/all_visit_pharmacy_sql_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'visit_event.dart';
part 'visit_state.dart';

class VisitBloc extends Bloc<VisitEvent, VisitState> {
  AllVisitPharmacySqlUsecase allVisitPharmacySqlUsecase;
  AllVisitDoctorSqlUsecase allVisitDoctorSqlUsecase;

  VisitBloc(
      this.allVisitPharmacySqlUsecase,
      this.allVisitDoctorSqlUsecase
      ) : super(VisitInitial()) {
    on<VisitEvent>((event, emit)async {
      if(event is VisitPharmacyEvent)
      {
        (
            await allVisitPharmacySqlUsecase.execute()).fold(
      (failure)  {
      print(failure.massage);
      emit(VisitPharmacyErrorState(failure: failure));
      },
      (data)  async{
      emit(VisitPharmacyState());
      });}
      if(event is VisitDoctorEvent)
      {
        (
            await allVisitDoctorSqlUsecase.execute()).fold(
                (failure)  {
              print(failure.massage);
              emit(VisitDoctorErrorState(failure: failure));
            },
                (data)  async{
              emit(VisitDoctorState());
            });}
    });
  }
}
