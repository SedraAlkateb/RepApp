import 'package:bloc/bloc.dart';
import 'package:domina_app/app/user_info.dart';
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
import 'package:domina_app/domain/usecase/delete_all_sql_usecase.dart';
import 'package:domina_app/domain/usecase/get_Rep_Reci.dart';
import 'package:domina_app/domain/usecase/get_doc_hos_by_sp_place.dart';
import 'package:domina_app/domain/usecase/info_rep_usecase.dart';
import 'package:domina_app/domain/usecase/no_visit_hos_usecase.dart';
import 'package:domina_app/domain/usecase/remaining_visits_use_case.dart';
import 'package:domina_app/domain/usecase/unfinished_visit_hos_usecase.dart';
import 'package:domina_app/domain/usecase/visit_hos_usecase.dart';
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

  VisitHosUsecase visitHosUsecase;
  NoVisitHosUsecase noVisitHosUsecase;
  UnfinishedVisitHosUsecase unfinishedVisitHosUsecase;
  DeleteAllSqlUsecase deleteAllSqlUsecase;
  AllReciUsecase allReciUsecase;
  GetRepReciUsecase getRepReciUsecase;
  GetDocHosBySpPlace getDocHosBySpPlace;
  List<SpecDModel> specialization = [];
  List<HospitalSpModel> hospital = [];
  List<BrandModel> brand = [];

  List<NoVisitDocModel> noVisitDoc = [];

  List<NoVisitDocModel> remainingVisits = [];
  List<NoVisitDocModel> visitDoc = [];
  List<DoctorModel> doctor = [];
  SeniorProfBloc(
      this.deleteAllSqlUsecase,
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
      this.getRepReciUsecase,
      this.visitHosUsecase,
      this.noVisitHosUsecase,
      this.unfinishedVisitHosUsecase,
      this.getDocHosBySpPlace)
      : super(SeniorProfInitial()) {
    on<SeniorProfEvent>((event, emit) async {
      if (event is SenAllPlaceEvent) {
        emit(SenAllPlaceLoadingState());
        (await allPlaceUsecase.execute(event.id)).fold((failure) {
          emit(SenAllPlaceErrorState(failure: failure));
        }, (data) async {
          emit(SenAllPlaceState(places: data, placesSearch: data));
        });
      }
      if (event is SearchSenAllPlaceEvent) {
        List<PlaceModel> placeModel;
        String search = normalizeText(event.contant);
        placeModel = event.places.where((value) {
          if (normalizeText(value.title).contains(search)) {
            return true;
          }
          return false;
        }).toList();
        emit(SenAllPlaceState(placesSearch: placeModel, places: event.places));
      } else if (event is SearchDocHosEvent) {
        final String search = normalizeText(
          event.content.trim(),
        );

        // ===========================================================
        // إذا السيرش فاضي رجع القوائم الأصلية
        // ===========================================================
        if (search.isEmpty) {
          emit(
            DocHosState(
              event.doctors,
              event.hospitals,
            ),
          );

          return;
        }

        // ===========================================================
        // Doctors
        // ===========================================================
        if (event.tabIndex == 0) {
          final List<DoctorSenModel> doctorList = event.doctors.where(
            (doctor) {
              if (normalizeText(
                doctor.title ?? '',
              ).contains(search)) {
                return true;
              }

              if (normalizeText(
                doctor.address ?? '',
              ).contains(search)) {
                return true;
              }

              if (normalizeText(
                doctor.place ?? '',
              ).contains(search)) {
                return true;
              }

              if (normalizeText(
                doctor.spTitle ?? '',
              ).contains(search)) {
                return true;
              }

              if (normalizeText(
                doctor.rate ?? '',
              ).contains(search)) {
                return true;
              }

              return false;
            },
          ).toList();

          // المشافي تبقى القائمة الأصلية
          emit(
            DocHosState(
              doctorList,
              event.hospitals,
            ),
          );

          return;
        }

        // ===========================================================
        // Hospitals
        // ===========================================================
        final List<HospitalSpModel> hospitalList = event.hospitals.where(
          (hospital) {
            if (normalizeText(
              hospital.title ?? '',
            ).contains(search)) {
              return true;
            }

            if (normalizeText(
              hospital.address ?? '',
            ).contains(search)) {
              return true;
            }

            if (normalizeText(
              hospital.placeTitle ?? '',
            ).contains(search)) {
              return true;
            }

            if (normalizeText(
              hospital.SpName ?? '',
            ).contains(search)) {
              return true;
            }

            if (normalizeText(
              hospital.rate ?? '',
            ).contains(search)) {
              return true;
            }

            return false;
          },
        ).toList();

        // الأطباء تبقى القائمة الأصلية
        emit(
          DocHosState(
            event.doctors,
            hospitalList,
          ),
        );
      } else if (event is LogoutDeleteAllEvent) {
        emit(LogoutDeleteAllLoadingState());
        (await deleteAllSqlUsecase.execute()).fold((failure) {
          emit(LogoutDeleteAllErrorState(failure: failure));
          return false;
        }, (data) async {
          UserInfo.flag1 = 0;
          emit(LogoutDeleteAllState());
        });
      } else if (event is SenAllHospitalEvent) {
        emit(SenAllHospitalLoadingState());
        (await _allHospitalSpUsecase.execute(event.id)).fold((failure) {
          emit(SenAllHospitalErrorState(failure: failure));
        }, (data) async {
          hospital = data;
          if (hospital.isEmpty) {
            emit(SenAllHospitalEmptyState());
          } else {
            emit(SenAllHospitalsState(data));
          }
        });
      } else if (event is SenAllBrandEvent) {
        emit(SenAllBrandLoadingState());
        (await allBrandsUsecase.execute(event.id)).fold((failure) {
          emit(SenAllBrandErrorState(failure: failure));
        }, (data) async {
          if (!event.isPr) {
            brand = data.where((item) => item.flag == 1).toList();
          } else {
            brand = data;
          }

          emit(SenAllBrandsState(brand));
        });
      } else if (event is getInfoRepEvent) {
        emit(RepInfoLoadingState());
        (await infoRepUsecase.execute(event.id, event.planId)).fold((failure) {
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
      } else if (event is SenSearchBrandEvent) {
        List<BrandModel> brandser;
        String search = normalizeText(event.contant);
        brandser = brand.where((value) {
          if (normalizeText(value.title).contains(search)) {
            return true;
          }
          return false;
        }).toList();
        emit(SenAllBrandsState(brandser));
      } else if (event is SenSearchHospEvent) {
        List<HospitalSpModel> hospitalList;
        String search = normalizeText(event.contant);
        hospitalList = hospital.where((value) {
          if (normalizeText(value.title ?? "").contains(search)) {
            return true;
          }
          if (normalizeText(value.placeTitle ?? "").contains(search)) {
            return true;
          }
          if ("${value.visit}زيارة".contains(search)) {
            return true;
          }
          if ((value.rate != null )&&
              ( normalizeText(value.rate!).contains(search))) {
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
      } else if (event is SenSearchRemainingVisitsDoctorEvent) {
        List<NoVisitDocModel> searchList;
        String search = normalizeText(event.contant);
        searchList = remainingVisits.where((value) {
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
        emit(SenNoVisitDocsState(searchList));
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
          if (normalizeText(value.placeTitle).contains(search)) {
            return true;
          }
          if (normalizeText(value.spTitle).contains(search)) {
            return true;
          }
          if ("${value.visits}زيارة".contains(search)) {
            return true;
          }
          if ((value.rate != null )&&
             ( normalizeText(value.rate!).contains(search))) {
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
      } else if (event is NoVisitHosEvent) {
        emit(SenNoVisitDocLoadingState());
        (await noVisitHosUsecase.execute(event.id, event.planId)).fold(
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
      } else if (event is RemainingVisitsHosEvent) {
        emit(SenNoVisitDocLoadingState());
        (await unfinishedVisitHosUsecase.execute(event.planId)).fold((failure) {
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
      } else if (event is VisitHosEvent) {
        emit(SenVisitDocLoadingState());
        (await visitHosUsecase.execute(event.planId)).fold((failure) {
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
      if (event is DocHosEvent) {
        emit(DocHosLoadingState());
        (await getDocHosBySpPlace.execute(event.repDet,
                spId: event.spId, placeId: event.placeId, cityId: event.cityId))
            .fold((failure) {
          emit(DocHosErrorState(failure: failure));
        }, (data) async {
          emit(DocHosState(data.doctors, data.hospitals));
        });
      }
    });
  }
}
