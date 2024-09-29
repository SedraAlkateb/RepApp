import 'package:bloc/bloc.dart';
import 'package:domina_app/data/network/failure.dart';
import 'package:domina_app/domain/usecase/visit_doctor_usecase.dart';
import 'package:domina_app/domain/usecase/visit_pharmacy_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'async_in_event.dart';
part 'async_in_state.dart';

class AsyncInBloc extends Bloc<AsyncInEvent, AsyncInState> {
  VisitDoctorUsecase visitDoctorUsecase ;
  VisitPharmacyUsecase visitPharmacyUsecase;
  AsyncInBloc(
      this.visitPharmacyUsecase,
      this.visitDoctorUsecase
      ) : super(AsyncInInitial()) {
    on<AsyncInEvent>((event, emit) {
      if (event is Async1DataEvent) {
        emit(SyncData1LoadingState());
      }
    });
  }
}
