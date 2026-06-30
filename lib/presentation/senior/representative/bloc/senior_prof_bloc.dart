import 'package:bloc/bloc.dart';
import 'package:domina_app/data/network/failure.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/domain/usecase/all_brands_usecase.dart';
import 'package:domina_app/domain/usecase/all_doctor_usecase%20.dart';
import 'package:domina_app/domain/usecase/all_hospial_sp_usecase%20.dart';
import 'package:domina_app/domain/usecase/all_no_visit_doctor_usecase.dart';
import 'package:domina_app/domain/usecase/all_place_usecase.dart';
import 'package:domina_app/domain/usecase/all_reci_usecase%20.dart';
import 'package:domina_app/domain/usecase/all_sen_visit_doctor_usecase.dart';
import 'package:domina_app/domain/usecase/all_spec_usecase.dart';
import 'package:domina_app/domain/usecase/get_Rep_Reci.dart';
import 'package:domina_app/domain/usecase/info_rep_usecase.dart';
import 'package:domina_app/domain/usecase/remaining_visits_use_case.dart';
import 'package:domina_app/presentation/uniti/search.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
part 'senior_prof_event.dart';
part 'senior_prof_state.dart';

class SeniorProfBloc extends Bloc<SeniorProfEvent, SeniorProfState> {
  AllPlaceUsecase allPlaceUsecase;
  AllSpeUsecase allSpeUsecase;
  AllHospialSpUsecase _allHospitalSpUsecase;
  AllDoctorUsecase allDoctorUsecase;
  AllBrandsUsecase allBrandsUsecase;

  InfoRepUsecase infoRepUsecase;
  AllNoVisitDoctorUsecase allNoVisitDoctorUsecase;
  AllSenVisitDoctorUsecase allSenVisitDoctorUsecase;
  RemainingVisitsUsecase remainingVisitsUsecase;
  AllReciUsecase allReciUsecase;
  GetRepReciUsecase getRepReciUsecase;
  List<SpecDModel> specialization = [];
  List<HospitalSpModel> hospital = [];
  List<BrandModel> brand = [];

  List<NoVisitDocModel> noVisitDoc = [];

  List<NoVisitDocModel> remainingVisits = [];
  List<NoVisitDocModel> visitDoc = [];

  List<DoctorModel> doctor = [];
  SeniorProfBloc(
      this.allPlaceUsecase,
      this.allSpeUsecase,
      this.allDoctorUsecase,
      this._allHospitalSpUsecase,
      this.allNoVisitDoctorUsecase,
      this.remainingVisitsUsecase,
      this.allSenVisitDoctorUsecase,
      this.infoRepUsecase,
      this.allBrandsUsecase,
      this.allReciUsecase,
      this.getRepReciUsecase)
      : super(SeniorProfInitial()) {
    on<SeniorProfEvent>((event, emit) async {
      if (event is SenAllPlaceEvent) {
        emit(SenAllPlaceLoadingState());
        (await allPlaceUsecase.execute(event.id)).fold((failure) {
          emit(SenAllPlaceErrorState(failure: failure));
        }, (data) async {
          emit(SenAllPlaceState(data));
        });
      } else if (event is SenAllHospitalEvent) {
        emit(SenAllHospitalLoadingState());
        (await _allHospitalSpUsecase.execute(event.id)).fold((failure) {
          emit(SenAllHospitalErrorState(failure: failure));
        }, (data) async {
          hospital = data;
          emit(SenAllHospitalsState(data));
        });
      } else if (event is SenAllBrandEvent) {
        emit(SenAllBrandLoadingState());
        (await allBrandsUsecase.execute(event.id)).fold((failure) {
          emit(SenAllBrandErrorState(failure: failure));
        }, (data) async {
          brand = data;
          emit(SenAllBrandsState(data));
        });
      } else if (event is getInfoRepEvent) {
        emit(RepInfoLoadingState());
        (await infoRepUsecase.execute(event.id,event.planId)).fold((failure) {
          emit(RepInfoErrorState(failure: failure));
        }, (data) async {
          emit(RepInfoState(data));
        });
      } else if (event is SenAllSpecEvent) {
        emit(SenAllSpecLoadingState());
        (await allSpeUsecase.execute(event.id)).fold((failure) {
          emit(SenAllSpecErrorState(failure: failure));
        }, (data) async {
          specialization = data;
          emit(SenAllSpecState(data));
        });
      } else if (event is SenSearchSpecEvent) {
        List<SpecDModel> spec;
        String search = normalizeText(event.contant);
        spec = specialization.where((value) {
          if (normalizeText(value.title).contains(search)) {
            return true;
          }
          return false;
        }).toList();
        emit(SenAllSpecState(spec));
      } else if (event is SenSearchHospEvent) {
        List<HospitalSpModel> hospitalList;
        String search = normalizeText(event.contant);
        hospitalList = hospital.where((value) {
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

        emit(SenAllHospitalsState(hospitalList));
      } else if (event is SenSearchVisitDoctorEvent) {
        List<NoVisitDocModel> visitDocModel;
        String search = normalizeText(event.contant);
        visitDocModel = visitDoc.where((value) {
          if (normalizeText(value.docTitle).contains(search)) {
            return true;
          }
          if (normalizeText(value.spTitle).contains(search)) {
            return true;
          }
          if (normalizeText(value.address).contains(search)) {
            return true;
          }
          if (normalizeText(value.rate).contains(search)) {
            return true;
          }
          return false;
        }).toList();
        emit(SenVisitDocsState(visitDocModel));
      } else if (event is SenSearchNoVisitDoctorEvent) {
        List<NoVisitDocModel> noVisitDocModel;
        String search = normalizeText(event.contant);
        noVisitDocModel = noVisitDoc.where((value) {
          if (normalizeText(value.docTitle).contains(search)) {
            return true;
          }
          if (normalizeText(value.spTitle).contains(search)) {
            return true;
          }
          if (normalizeText(value.address).contains(search)) {
            return true;
          }
          if (normalizeText(value.rate).contains(search)) {
            return true;
          }
          return false;
        }).toList();
        emit(SenNoVisitDocsState(noVisitDocModel));
      } else if (event is SenAllDoctorEvent) {
        emit(SenAllDoctorLoadingState());
        (await allDoctorUsecase.execute(event.id)).fold((failure) {
          emit(SenAllDoctorErrorState(failure: failure));
          print(failure.massage);
        }, (data) async {
          doctor = data;
          if (doctor.isNotEmpty) {
            emit(SenAllDoctorsState(data));
          } else {
            emit(SenAllDoctorEmptyState());
          }
        });
      } else if (event is SenSearchDoctorEvent) {
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
        emit(SenAllDoctorsState(doctorList));
      } else if (event is NoVisitDocEvent) {
        emit(SenNoVisitDocLoadingState());
        (await allNoVisitDoctorUsecase.execute(event.id, event.planId)).fold(
            (failure) {
          emit(SenNoVisitDocErrorState(failure: failure, planId: event.planId));
        }, (data) async {
          noVisitDoc = data;
          if (data.isEmpty) {
            emit(SenNoVisitDocEmptyState());
          } else {
            emit(SenNoVisitDocsState(data));
          }
        });
      } else if (event is RemainingVisitsDocEvent) {
        emit(SenNoVisitDocLoadingState());
        (await remainingVisitsUsecase.execute(event.id, event.planId)).fold(
            (failure) {
          emit(SenNoVisitDocErrorState(failure: failure, planId: event.planId));
        }, (data) async {
          remainingVisits = data;
          if (data.isEmpty) {
            emit(SenNoVisitDocEmptyState());
          } else {
            emit(SenNoVisitDocsState(data));
          }
        });
      } else if (event is VisitDocEvent) {
        emit(SenVisitDocLoadingState());
        (await allSenVisitDoctorUsecase.execute(event.id, event.planId)).fold(
            (failure) {
          emit(SenVisitDocErrorState(failure: failure, planId: event.planId));
        }, (data) async {
          visitDoc = data;
          if (data.isEmpty) {
            emit(SenVisitDocEmptyState());
          } else {
            emit(SenVisitDocsState(data));
          }
        });
      }
      if (event is AllReciEvent) {
        emit(AllReciLoadingState());
        (await allReciUsecase.execute(event.id)).fold((failure) {
          emit(AllReciErrorState(failure: failure));
        }, (data) async {
          if (data.isEmpty) {
            emit(AllReciEmptyState());
          } else {
            emit(AllReciState(data));
          }
        });
      }
      if (event is GetRepReciEvent) {
        emit(ViewRecipeLoadingState());
        (await getRepReciUsecase.execute(event.reciId)).fold((failure) {
          emit(ViewRecipeErrorState(failure: failure));
        }, (data) async {
          emit(ViewRecipeState(data, event.isDoctor, event.name));
        });
      }
    });
  }
}
