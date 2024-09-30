import 'package:bloc/bloc.dart';
import 'package:domina_app/data/network/failure.dart';
import 'package:domina_app/domain/usecase/visit_doctor_usecase.dart';
import 'package:domina_app/domain/usecase/visit_hospital_usecase.dart';
import 'package:domina_app/domain/usecase/visit_pharmacy_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'async_in_event.dart';
part 'async_in_state.dart';

class AsyncInBloc extends Bloc<AsyncInEvent, AsyncInState> {
  VisitDoctorUsecase visitDoctorUsecase ;
  VisitPharmacyUsecase visitPharmacyUsecase;
  VisitHospitalUsecase visitHospitalUsecase;
  AsyncInBloc(this.visitPharmacyUsecase, this.visitDoctorUsecase, this.visitHospitalUsecase) : super(AsyncInInitial()) {
    on<AsyncInEvent>((event, emit) async{
      if (event is Async1DataEvent) {
        emit(SyncData1LoadingState());
   //     (await visitPharmacyUsecase.execute()).fold((failure) {
   ///   emit(SyncDataErrorState(failure: failure));
   //   return false;
  //    }, (data) async {
   //   brands = data;
 //     });
      }

    });
  }
}
