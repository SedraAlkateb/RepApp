import 'package:bloc/bloc.dart';
import 'package:domina_app/app/user_info.dart';
import 'package:domina_app/data/network/failure.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/domain/usecase/doc_doctors_usecase.dart';
import 'package:domina_app/domain/usecase/search_doctors_usecase.dart';
import 'package:domina_app/presentation/uniti/search.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
part 'search_doctors_event.dart';
part 'search_doctors_state.dart';

class SearchDoctorsBloc extends Bloc<SearchDoctorsEvent, SearchDoctorsState> {
  List<doctorsModel> Representative = [];
  List<DocdoctorsModel> doctorDetails = [];
  SearchDoctorsUsecase searchDoctorsUsecase;
  DocDoctorsUseCase docDoctorsUseCase;
  String name1 = ' ';
  SearchDoctorsBloc(
    this.searchDoctorsUsecase,
    this.docDoctorsUseCase,
  ) : super(EditBrandPlanInitial()) {
    on<SearchDoctorsEvent>((event, emit) async {
      if (event is FutureSearchDocEvent) {
        Representative = [];
        emit(FutureSearchDoctorsLoadingState());
        (await searchDoctorsUsecase.execute(UserInfo.cityId, event.name)).fold(
            (failure) {
          emit(FutureFutureSearchDoctorsErrorState(failure: failure));
        }, (data) async {
          Representative = data;
          if(data.isEmpty){
            emit(FutureSearchDoctorsEmptyState());

          }else{
            emit(FutureSearchDoctorsState(data));

          }
        });
      } else if (event is FutureDocDoctorsEvent) {
        doctorDetails = [];
        emit(FutureDocDoctorsLoadingState());
        (await docDoctorsUseCase.execute(event.docId)).fold((failure) {
          emit(FutureDocDoctorsErrorState(failure: failure));
        }, (data) async {
             emit(FutureDocDoctorsState(data));
        
         if (data.isEmpty) {
              emit(FutureDocDoctorsEmptyState());
            } else {
            doctorDetails = data;
              emit(FutureDocDoctorsState(data));
            }
         }
         );
      } else if  (event is FutureSearchEvent) {
        List<DocdoctorsModel> rep;
        String search = normalizeText(event.name);
        rep = doctordetails.where((value) {
          if (normalizeText(value.repName).contains(search)) {
            return true;
          }
          return false;
        }).toList();
        emit(FutureDocDoctorsState(rep));
      }
      }
      else if (event is SearchNoteDoctorEvent) {
        List<DocdoctorsModel> doctorNote;
        String search = normalizeText(event.contant);
        doctorNote = doctorDetails.where((value) {
          if (normalizeText(value.issue).contains(search)) {
            return true;
          }
          if (normalizeText(value.note).contains(search)) {
            return true;
          }
          if (normalizeText(value.repName).contains(search)) {
            return true;
          }
          return false;
        }).toList();
        emit(FutureDocDoctorsState(doctorNote));
      }
    });
  }
}
