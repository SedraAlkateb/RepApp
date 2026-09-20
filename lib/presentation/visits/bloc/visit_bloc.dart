import 'package:bloc/bloc.dart';
import 'package:domina_app/domain/failure.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/domain/usecase/all_brands_doctor_visits_sql_usecase.dart';
import 'package:domina_app/domain/usecase/all_brands_flag_sql_usecase.dart';
import 'package:domina_app/domain/usecase/all_brands_hospital_visits_sql_usecase.dart';
import 'package:domina_app/domain/usecase/all_visit_doctor_sql_usecase.dart';
import 'package:domina_app/domain/usecase/all_visit_hospital_sql_usecase.dart';
import 'package:domina_app/domain/usecase/update_doctor_usecase.dart';
import 'package:domina_app/domain/usecase/update_hospital_usecase.dart';
import 'package:domina_app/presentation/uniti/search.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
part 'visit_event.dart';
part 'visit_state.dart';

class VisitBloc extends Bloc<VisitEvent, VisitState> {
  AllVisitDoctorSqlUsecase allVisitDoctorSqlUsecase;
  AllBrandsFlagSqlUsecase allBrandsFlagSqlUsecase;
  AllBrandsDoctorVisitsSqlUsecase allBrandsDoctorVisitsSqlUsecase;
  AllBrandsHospitalVisitsSqlUsecase allBrandsHospitalVisitsSqlUsecase;
  AllVisitHospitalSqlUsecase allVisitHospitalSqlUsecase;
  UpdateDoctorUsecase updateDoctorUsecase;
  UpdateHospitalUsecase updateHospitalUsecase;
  int current = 0;
  List<VisitDoctorAndDoctor> doctors = [];
  List<VisitHospitalAndHospital> hospitals = [];
  List<PharmacyBrandModel> brands = [];
  List<BrandAddition> selectAddBrand = [];
  bool isBrand = false;
  List<BrandModel> bandFlag = [];
  VisitBloc(
      this.allBrandsFlagSqlUsecase,
      //    this.allVisitPharmacySqlUsecase,
      this.allVisitDoctorSqlUsecase,
      //     this.allBrandsPharmacyVisitsSqlUsecase,
      this.allBrandsDoctorVisitsSqlUsecase,
      this.allBrandsHospitalVisitsSqlUsecase,
      this.allVisitHospitalSqlUsecase,
      //   this.updatePharmacyUsecase,
      this.updateDoctorUsecase,
      this.updateHospitalUsecase)
      : super(VisitInitial()) {
    on<IsBrandEvent>((event, emit) async {
      isBrand = !isBrand;
      if (isBrand == true) {
        brands = [];
        selectAddBrand = [];
      }
      emit(IsBrandState(isBrand));
    });

    on<BrandFlagEditeEvent>((event, emit) async {
      (await allBrandsFlagSqlUsecase.execute()).fold((failure) {
        emit(BrandFlagErrorState(failure: failure));
      }, (data) async {
        bandFlag = data;

        emit(BrandFlagState(data));
      });
    });

    on<RemoveBrandEvent>((event, emit) async {
      List<PharmacyBrandModel> updatedList = List.from(brands);
      updatedList.removeWhere(
        (v) => v.id == event.brandModel.id,
      );
      brands = updatedList;
      emit(DeleteBrandState(updatedList));
    });

    on<SelectBrandEvent>((event, emit) async {
      final existingIndex =
          brands.indexWhere((brand) => brand.id == event.brandModel.id);
      if (existingIndex != -1) {
        List<PharmacyBrandModel> updatedList = List.from(brands);
        int v = int.parse(updatedList[existingIndex].amount) + 1;
        updatedList[existingIndex] = PharmacyBrandModel(
            updatedList[existingIndex].id,
            updatedList[existingIndex].title,
            updatedList[existingIndex].phTitle,
            v.toString());
        brands = updatedList;
        emit(EditAmountBrandState(brands));
      } else {
        final v = PharmacyBrandModel(event.brandModel.id,
            event.brandModel.title, event.brandModel.phTitle, 1.toString());
        List<PharmacyBrandModel> updatedList = List.from(brands);
        updatedList.add(v);
        brands = updatedList;
        emit(SelectBrandState(brands));
      }
    });

    on<VisitDoctorEvent>((event, emit) async {
      (await allVisitDoctorSqlUsecase.execute()).fold((failure) {
        emit(VisitDoctorErrorState(failure: failure));
      }, (data) async {
        doctors = data;
        if (doctors.isNotEmpty) {
          emit(VisitDoctorState(data));
        } else {
          emit(EmptyVisitHospitalState());
        }
      });
    });

    on<VisitHospitalEvent>((event, emit) async {
      (await allVisitHospitalSqlUsecase.execute()).fold((failure) {
        emit(VisitHospitalErrorState(failure: failure));
      }, (data) async {
        hospitals = data;
        if (hospitals.isNotEmpty) {
          emit(VisitHospitalState(data));
        } else {
          emit(EmptyVisitHospitalState());
        }
      });
    });

    on<SearchDoctorVisitEvent>((event, emit) async {
      List<VisitDoctorAndDoctor> doctorSearch;
      String search = normalizeText(event.value);
      doctorSearch = doctors.where((value) {
        if (normalizeText(value.doctorModel.title).contains(search)) {
          return true;
        }
        if (normalizeText(value.doctorModel.spTitle).contains(search)) {
          return true;
        }
        if (normalizeText(value.visitDoctorModel.science ?? "")
            .contains(search)) {
          return true;
        }
        return false;
      }).toList();
      emit(SearchVisitDoctorState(doctorSearch));
    });

    on<SearchHospitalVisitEvent>((event, emit) async {
      List<VisitHospitalAndHospital> hospitalSearch;
      String search = normalizeText(event.value);
      hospitalSearch = hospitals.where((value) {
        if (normalizeText(value.hospitalModel.title).contains(search)) {
          return true;
        }
        if (normalizeText(value.specModel.title).contains(search)) {
          return true;
        }
        if (normalizeText(value.visitHospitalModel.science!).contains(search)) {
          return true;
        }
        return false;
      }).toList();
      emit(SearchVisitHospitalState(hospitalSearch));
    });

    on<UpdateVisitDoctorEvent>((event, emit) async {
      (await updateDoctorUsecase.execute(
              event.id, event.sc, event.kas, event.target, event.selectBrand))
          .fold((failure) {
        emit(UpdateVisitDoctorErrorState(failure: failure));
      }, (data) async {
        emit(UpdateVisitDoctorState());
      });
    });

    on<UpdateVisitHospitalEvent>((event, emit) async {
      (await updateHospitalUsecase.execute(
              event.id, event.sc, event.kas, event.target, event.selectBrand))
          .fold((failure) {
        emit(UpdateVisitHospitalErrorState(failure: failure));
      }, (data) async {
        emit(UpdateVisitHospitalState());
      });
    });

    on<BrandDoctorVisitEvent>((event, emit) async {
      (await allBrandsDoctorVisitsSqlUsecase.execute(event.visitId)).fold(
          (failure) {
        emit(BrandPharmacyVisitErrorState(failure: failure));
      }, (data) async {
        brands = data;
        if (brands.isEmpty) {
          isBrand = true;
        } else {
          isBrand = false;
        }
        emit(BrandPharmacyVisitState(data));
      });
    });

    on<BrandHospitalVisitEvent>((event, emit) async {
      (await allBrandsHospitalVisitsSqlUsecase.execute(event.visitId)).fold(
          (failure) {
        emit(BrandHospitalVisitErrorState(failure: failure));
      }, (data) async {
        brands = data;
        if (brands.isEmpty) {
          isBrand = true;
        } else {
          isBrand = false;
        }
        emit(BrandHospitalVisitState(data));
      });
    });

    on<EditAmountBrandEvent>((event, emit) async {
      brands[event.index].amount = event.brand.toString();
    });
  }
}
