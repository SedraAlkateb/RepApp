import 'package:bloc/bloc.dart';
import 'package:domina_app/domain/failure.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/domain/usecase/all_brands_flag_sql_usecase.dart';
import 'package:domina_app/domain/usecase/all_brands_sql_usecase.dart';
import 'package:domina_app/domain/usecase/doctors_by_place_usecase.dart';
import 'package:domina_app/domain/usecase/hospitals_by_place_usecase.dart';
import 'package:domina_app/domain/usecase/insert_visit_brand_doctor_sql_usecase.dart';
import 'package:domina_app/domain/usecase/insert_visit_brand_hospital_sql_usecase.dart';
import 'package:domina_app/domain/usecase/insert_visit_doctor_sql_usecase.dart';
import 'package:domina_app/domain/usecase/insert_visit_hospital_sql_usecase.dart';
import 'package:domina_app/domain/usecase/sp_hospital_sql_usecase.dart';
import 'package:domina_app/presentation/resources/language_manager.dart';
import 'package:domina_app/presentation/uniti/search.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
part 'visit_place_event.dart';
part 'visit_place_state.dart';

class VisitPlaceBloc extends Bloc<VisitPlaceEvent, VisitPlaceState> {
  // PharmaciesByPlaceUsecase pharmaciesByPlaceUsecase;
  AllBrandsFlagSqlUsecase allBrandsFlagSqlUsecase;
  DoctorsByPlaceUsecase doctorsByPlaceUsecase;
  HospitalsByPlaceUsecase hospitalsByPlaceUsecase;
  // InsertVisitPharmacySqlUsecase insertVisitPharmacySqlUsecase;
  InsertVisitDoctorSqlUsecase insertVisitDoctorSqlUsecase;
  // InsertVisitBrandPharmacySqlUsecase insertVisitBrandPharmacySqlUsecase;
  InsertVisitBrandDoctorSqlUsecase insertVisitBrandDoctorSqlUsecase;
  InsertVisitBrandHospitalSqlUsecase insertVisitBrandHospitalSqlUsecase;
  InsertVisitHospitalSqlUsecase insertVisitHospitalSqlUsecase;
  SpHospitalSqlUsecase spHospitalSqlUsecase;
  AllBrandsSqlUsecase allBrandsSqlUsecase;
  List<BrandModel> selectBrand = [];
  List<BrandAddition> selectAddBrand = [];
  List<BrandModel> bandFlag = [];
  List<BrandModel> allBandFlag = [];
  // List<PharmacyModel> pharmacies = [];
  //  List<PharmacyModel> pharmaSearchModel = [];
  List<DoctorModel> doctors = [];
  List<DoctorModel> doctorSearchModel = [];
  List<HospitalSpAllModel> hospitals = [];
  List<HospitalSpAllModel> hospitalSearchModel = [];
  List<SpecHospitalSp> specialization = [];
  SpecHospitalSp? spec;
  List<VisitBrandPharmacyModel> visitBrandPharmacys = [];
  int current = 0;
  String not = "";
  String br = "";
  bool isBrand = false;
  Type type = Type(2, "لا شيئ");
  VisitPlaceBloc(
      //    this.pharmaciesByPlaceUsecase,
      this.allBrandsFlagSqlUsecase,
      this.doctorsByPlaceUsecase,
      this.hospitalsByPlaceUsecase,
      //    this.insertVisitPharmacySqlUsecase,
      this.insertVisitDoctorSqlUsecase,
//      this.insertVisitBrandPharmacySqlUsecase,
      this.insertVisitBrandDoctorSqlUsecase,
      this.spHospitalSqlUsecase,
      this.insertVisitBrandHospitalSqlUsecase,
      this.insertVisitHospitalSqlUsecase,
      this.allBrandsSqlUsecase)
      : super(VisitPlaceInitial()) {
    on<BoxAddEvent>((event, emit) async {
      br = event.n;
    });

    on<HospitalByPlace>((event, emit) async {
      current = event.current;
      (await hospitalsByPlaceUsecase.execute(event.placeId)).fold((failure) {
        emit(AllHospitalByPlaceErrorState(failure: failure));
      }, (data) async {
        hospitals = data;
        if (hospitals.isNotEmpty) {
          emit(AllHospitalByPlaceState(data));
        } else {
          emit(EmptyState());
        }
      });
    });

    on<SelectSpecEvent>((event, emit) async {
      spec = event.spec;
      emit(SpecState(
          total: spec!.hospitalSpModel.totalDocs,
          visits: spec!.hospitalSpModel.visit,
          visited: spec!.hospitalSpModel.visited ?? 0));
    });

    on<DoctorByPlace>((event, emit) async {
      current = event.current;
      (await doctorsByPlaceUsecase.execute(event.placeId)).fold((failure) {
        emit(AllDoctorByPlaceErrorState(failure: failure));
      }, (data) async {
        doctors = data;
        doctorSearchModel = doctors;
        if (doctors.isNotEmpty) {
          emit(AllDoctorByPlaceState(data));
        } else {
          emit(EmptyState());
        }
      });
    });

    on<BrandFlagEvent>((event, emit) async {
      (await allBrandsFlagSqlUsecase.execute()).fold((failure) {
        emit(BrandFlagErrorState(failure: failure));
      }, (data) async {
        bandFlag = data;
        emit(BrandFlagState(data));
      });
    });

    on<BrandAnyFlagEvent>((event, emit) async {
      (await allBrandsSqlUsecase.execute()).fold((failure) {
        emit(BrandFlagErrorState(failure: failure));
      }, (data) async {
        allBandFlag = data;
        emit(BrandFlagState(data));
      });
    });

    on<SelectBrandEvent>((event, emit) async {
      final existingIndex =
          selectBrand.indexWhere((brand) => brand.id == event.brandModel.id);
      if (existingIndex != -1) {
        List<VisitBrandPharmacyModel> updatedList =
            List.from(visitBrandPharmacys);
        updatedList[existingIndex] = VisitBrandPharmacyModel(
            updatedList[existingIndex].id,
            updatedList[existingIndex].visitId,
            updatedList[existingIndex].brandId,
            updatedList[existingIndex].amount + 1,
            0);
        visitBrandPharmacys = updatedList;
        emit(EditAmountBrandState(visitBrandPharmacys));
      } else {
        final VisitBrandPharmacyModel v = VisitBrandPharmacyModel(
            0, event.pharmacyId, event.brandModel.id, 1, 0);
        visitBrandPharmacys.add(v);
        List<BrandModel> updatedList = List.from(selectBrand);
        updatedList.add(event.brandModel);
        selectBrand = updatedList;
        emit(SelectBrandState(selectBrand));
      }
    });

    on<SelectBrandAdditionAddEvent>((event, emit) async {
      List<BrandAddition> updatedList = List.from(selectAddBrand);
      updatedList.add(BrandAddition(
          event.brand.id, event.brand.title, event.brand.phTitle, 0));
      selectAddBrand = updatedList;
      emit(SelectBrandAddState());
    });

    on<SelectNumBrandAddEvent>((event, emit) async {
      List<BrandAddition> updatedList = List.from(selectAddBrand);
      updatedList.last.amount =
          int.parse(convertArabicNumberToEnglish(event.num));
      selectAddBrand = updatedList;
      emit(SelectBrandAddNumState(updatedList));
    });

    on<InsertVisitDoctorEvent>((event, emit) async {
      event.visitDoctorModel.additaion = type.i == 2
          ? null
          : not == ""
              ? null
              : addition();
      (await insertVisitDoctorSqlUsecase.execute(event.visitDoctorModel)).fold(
          (failure) {
        emit(InsertVisitDoctorErrorState(failure: failure));
      }, (data) async {
        emit(InsertVisitDoctorState());
      });
    });

    on<InsertBrandVisitDoctorEvent>((event, emit) async {
      event.visitDoctorModel.additaion = type.i == 2
          ? null
          : not == ""
              ? null
              : addition();
      (await insertVisitBrandDoctorSqlUsecase.execute(
              visitBrandPharmacys, event.visitDoctorModel))
          .fold((failure) {
        selectBrand = [];
        emit(AllVisitBrandDoctorErrorState(failure: failure));
      }, (data) async {
        selectBrand = [];
        emit(AllVisitBrandDoctorState());
      });
    });

    on<InsertBrandVisitHospitalEvent>((event, emit) async {
      event.visitHospitalModel.additaion = type.i == 2
          ? null
          : not == ""
              ? null
              : addition();
      (await insertVisitBrandHospitalSqlUsecase.execute(visitBrandPharmacys,
              event.visitHospitalModel, event.hospitalId, spec!.specModel.id))
          .fold((failure) {
        selectBrand = [];
        emit(AllVisitBrandHospitalErrorState(failure: failure));
      }, (data) async {
        selectBrand = [];
        emit(AllVisitBrandHospitalState());
      });
    });

    on<InsertVisitHospitalEvent>((event, emit) async {
      event.visitHospitalModel.additaion =
          type.i == 2 ? null : (not == "" ? null : addition());
      (await insertVisitHospitalSqlUsecase.execute(
              event.visitHospitalModel, event.hospitalId, spec!.specModel.id))
          .fold((failure) {
        selectBrand = [];
        emit(AllVisitBrandHospitalErrorState(failure: failure));
      }, (data) async {
        selectBrand = [];
        emit(AllVisitBrandHospitalState());
      });
    });

    on<EditAmountBrandEvent>((event, emit) async {
      visitBrandPharmacys[event.index].amount = event.brand;
    });

    on<IsBrandEvent>((event, emit) async {
      isBrand = !isBrand;
      if (isBrand == true) {
        selectBrand = [];
        visitBrandPharmacys = [];
      }
      emit(IsBrandState(isBrand));
    });

    on<RemoveBrandEvent>((event, emit) async {
      List<BrandModel> updatedList = List.from(selectBrand);
      updatedList.removeWhere(
        (v) => v.id == event.brandModel.id,
      );
      selectBrand = updatedList;
      visitBrandPharmacys.removeWhere(
        (v) => v.brandId == event.brandModel.id,
      );
      emit(DeleteBrandState(updatedList));
    });

    on<RemoveBrandAdditionEvent>((event, emit) async {
      List<BrandAddition> updatedList = List.from(selectAddBrand);
      updatedList.removeWhere(
        (v) => v == event.brandAddition,
      );
      selectAddBrand = updatedList;
      emit(DeleteBrandAddState(updatedList));
    });

    on<SpecializationHospitalEvent>((event, emit) async {
      (await spHospitalSqlUsecase.execute(event.hospitalId)).fold((failure) {
        emit(SpecializationHospitalErrorState(failure: failure));
      }, (data) async {
        specialization = data;
        emit(SpecializationHospitalState(data));
      });
    });

    on<TypeAdditionEvent>((event, emit) async {
      type = event.type;

      if (event.type.i == 0) {
        emit(BoxState(event.type.name));
      } else if (event.type.i == 1) {
        emit(DropDownState(event.type.name));
      } else if (event.type.i == 2) {
        emit(NothingState());
      } else {
        emit(BoxState(event.type.name));
      }
      not = event.type.name;
      br = "";
    });

    on<SearchDoctorVisitEvent>((event, emit) async {
      String search = normalizeText(event.value);

      doctorSearchModel = doctors.where((doctorValue) {
        final nameMatch = normalizeText(doctorValue.title).contains(search);
        final specialtyMatch =
            normalizeText(doctorValue.spTitle).contains(search);

        return nameMatch || specialtyMatch;
      }).toList();

      emit(SearchVisitDoctorState(doctorSearchModel));
    });

    on<SearchHospitalVisitEvent>((event, emit) async {
      String search = normalizeText(event.value);
      hospitalSearchModel = hospitals.where((hospital) {
        if (normalizeText(hospital.title ?? "").contains(search)) {
          return true;
        } else {
          return false;
        }
      }).toList();
      emit(SearchVisitHospitalState(hospitalSearchModel));
    });

    on<EndEvent>((event, emit) async {
      emit(EndState());
    });
  }
  String addition() {
    String brand = "";
    if (br == "") {
      for (var ss in selectAddBrand) {
        brand = "${brand} ${ss.title} ${ss.phTitle} ${ss.amount} \n";
      }
    } else {
      brand = "${br}\n";
    }
    String add = "${not} \n ${brand}";
    return add;
  }
}
