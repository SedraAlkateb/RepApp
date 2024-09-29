import 'package:bloc/bloc.dart';
import 'package:domina_app/data/network/failure.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/domain/usecase/all_brands_flag_sql_usecase.dart';
import 'package:domina_app/domain/usecase/all_brands_sql_usecase.dart';
import 'package:domina_app/domain/usecase/doctors_by_place_usecase.dart';
import 'package:domina_app/domain/usecase/hospitals_by_place_usecase.dart';
import 'package:domina_app/domain/usecase/insert_visit_brand_doctor_sql_usecase.dart';
import 'package:domina_app/domain/usecase/insert_visit_brand_hospital_sql_usecase.dart';
import 'package:domina_app/domain/usecase/insert_visit_brand_pharmacy_sql_usecase.dart';
import 'package:domina_app/domain/usecase/insert_visit_doctor_sql_usecase.dart';
import 'package:domina_app/domain/usecase/insert_visit_hospital_sql_usecase.dart';
import 'package:domina_app/domain/usecase/insert_visit_pharmacy_sql_usecase.dart';
import 'package:domina_app/domain/usecase/pharmacies_by_place_usecase.dart';
import 'package:domina_app/domain/usecase/sp_hospital_sql_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
part 'visit_place_event.dart';
part 'visit_place_state.dart';

class VisitPlaceBloc extends Bloc<VisitPlaceEvent, VisitPlaceState> {
  PharmaciesByPlaceUsecase pharmaciesByPlaceUsecase;
  AllBrandsFlagSqlUsecase allBrandsFlagSqlUsecase;
  DoctorsByPlaceUsecase doctorsByPlaceUsecase;
  HospitalsByPlaceUsecase hospitalsByPlaceUsecase;
  InsertVisitPharmacySqlUsecase insertVisitPharmacySqlUsecase;
  InsertVisitDoctorSqlUsecase insertVisitDoctorSqlUsecase;
  InsertVisitBrandPharmacySqlUsecase insertVisitBrandPharmacySqlUsecase;
  InsertVisitBrandDoctorSqlUsecase insertVisitBrandDoctorSqlUsecase;
  InsertVisitBrandHospitalSqlUsecase insertVisitBrandHospitalSqlUsecase;
  InsertVisitHospitalSqlUsecase insertVisitHospitalSqlUsecase;
  SpHospitalSqlUsecase spHospitalSqlUsecase;
  AllBrandsSqlUsecase allBrandsSqlUsecase;

  List<BrandModel> selectBrand = [];
  List<BrandModel> selectBrandAdd = [];
  List<BrandModel> bandFlag = [];
  List<PharmacyModel> pharmacies = [];
  List<DoctorModel> doctors = [];
  List<HospitalModel> hospitals = [];
  List<SpecHospitalSp> specialization = [];
  SpecHospitalSp? spec;
  List<VisitBrandPharmacyModel> visitBrandPharmacys = [];
  int current = 0;
  String not="";
  String br="";
  bool isScience=true;
  VisitPlaceBloc(
      this.pharmaciesByPlaceUsecase,
      this.allBrandsFlagSqlUsecase,
      this.doctorsByPlaceUsecase,
      this.hospitalsByPlaceUsecase,
      this.insertVisitPharmacySqlUsecase,
      this.insertVisitDoctorSqlUsecase,
      this.insertVisitBrandPharmacySqlUsecase,
      this.insertVisitBrandDoctorSqlUsecase,
      this.spHospitalSqlUsecase,
      this.insertVisitBrandHospitalSqlUsecase,
      this.insertVisitHospitalSqlUsecase,
      this.allBrandsSqlUsecase
      )
      : super(VisitPlaceInitial()) {
    on<VisitPlaceEvent>((event, emit) async {
      if (event is PharmacyByPlace) {
        current = event.current;
        (await pharmaciesByPlaceUsecase.execute(event.placeId)).fold((failure) {
          emit(AllPharmacyByPlaceErrorState(failure: failure));
        }, (data) async {
          pharmacies = data;
          emit(AllPharmacyByPlaceState(data));
        });
      }
      if (event is HospitalByPlace) {
        current = event.current;
        (await hospitalsByPlaceUsecase.execute(event.placeId)).fold((failure) {
          emit(AllHospitalByPlaceErrorState(failure: failure));
        }, (data) async {
          hospitals = data;
          emit(AllHospitalByPlaceState(data));
        });
      }
      if (event is SelectSpecEvent) {
        spec = event.spec;
        emit(SpecState(
            total: spec!.hospitalSpModel.totalDocs,
            visits: spec!.hospitalSpModel.visit));
      }
      if (event is DoctorByPlace) {
        current = event.current;
        (await doctorsByPlaceUsecase.execute(event.placeId)).fold((failure) {
          emit(AllDoctorByPlaceErrorState(failure: failure));
        }, (data) async {
          doctors = data;
          emit(AllDoctorByPlaceState(data));
        });
      }
      if (event is BrandFlagEvent) {
        (await allBrandsFlagSqlUsecase.execute()).fold((failure) {
          emit(BrandFlagErrorState(failure: failure));
        }, (data) async {
          bandFlag = data;
          emit(BrandFlagState(data));
        });
      }
      if (event is BrandAnyFlagEvent) {
        (await allBrandsSqlUsecase.execute()).fold((failure) {
          emit(BrandFlagErrorState(failure: failure));
        }, (data) async {
          bandFlag = data;
          emit(BrandFlagState(data));
        });
      }
      if (event is SelectBrandEvent) {
        final existingIndex =
            selectBrand.indexWhere((brand) => brand.id == event.brandModel.id);
        print(existingIndex);
        print("existingIndex");
        if (existingIndex != -1) {
          List<VisitBrandPharmacyModel> updatedList =
              List.from(visitBrandPharmacys);
          updatedList[existingIndex] = VisitBrandPharmacyModel(
              updatedList[existingIndex].id,
              updatedList[existingIndex].visitId,
              updatedList[existingIndex].brandId,
              updatedList[existingIndex].amount + 1 // زيادة الكمية
              );
          visitBrandPharmacys = updatedList;
          emit(EditAmountBrandState(visitBrandPharmacys));
        } else {
          final VisitBrandPharmacyModel v = VisitBrandPharmacyModel(
              0, event.pharmacyId, event.brandModel.id, 1);
          visitBrandPharmacys.add(v);
          List<BrandModel> updatedList = List.from(selectBrand);
          updatedList.add(event.brandModel);
          selectBrand = updatedList;
          emit(SelectBrandState(selectBrand));
        }
      }
      if (event is SelectBrandAddEvent) {
        br="${br} ${event.brand}";
        emit(SelectBrandAddState(br));
      }
      if (event is InsertVisitPharmacyEvent) {
        emit(InsertVisitPharmacyLoadingState());
        (await insertVisitPharmacySqlUsecase.execute(event.visitPharmacyModel))
            .fold((failure) {
          print(failure.massage);
          emit(InsertVisitPharmacyErrorState(failure: failure));
        }, (data) async {
          emit(InsertVisitPharmacyState());
        });
      }
      if (event is InsertVisitDoctorEvent) {
        event.visitDoctorModel.additaion=addition(event.visitDoctorModel.additaion);
        (await insertVisitDoctorSqlUsecase.execute(event.visitDoctorModel))
            .fold((failure) {
          print(failure.massage);
          emit(InsertVisitDoctorErrorState(failure: failure));
        }, (data) async {
          emit(InsertVisitDoctorState());
        });
      }
      if (event is InsertBrandVisitEvent) {
        emit(AllVisitBrandPharmacyLoadingState());
        (await insertVisitBrandPharmacySqlUsecase.execute(
                visitBrandPharmacys, event.visitPharmacyModel))
            .fold((failure) {
          selectBrand = [];
          emit(AllVisitBrandPharmacyErrorState(failure: failure));
        }, (data) async {
          selectBrand = [];
          emit(AllVisitBrandPharmacyState());
        });
      }
      if (event is InsertBrandVisitDoctorEvent) {
        event.visitDoctorModel.additaion=addition(event.visitDoctorModel.additaion);
        emit(AllVisitBrandDoctorLoadingState());
        (await insertVisitBrandDoctorSqlUsecase.execute(
                visitBrandPharmacys, event.visitDoctorModel))
            .fold((failure) {
          selectBrand = [];
          emit(AllVisitBrandDoctorErrorState(failure: failure));
        }, (data) async {
          selectBrand = [];
          emit(AllVisitBrandDoctorState());
        });
      }

      if (event is InsertBrandVisitHospitalEvent) {
        (await insertVisitBrandHospitalSqlUsecase.execute(visitBrandPharmacys,
                event.visitHospitalModel, event.hospitalId, spec!.specModel.id))
            .fold((failure) {
          selectBrand = [];
          emit(AllVisitBrandHospitalErrorState(failure: failure));
        }, (data) async {
          selectBrand = [];
          emit(AllVisitBrandHospitalState());
        });
      }

      if (event is InsertVisitHospitalEvent) {
        (await insertVisitHospitalSqlUsecase.execute(
                event.visitHospitalModel, event.hospitalId, spec!.specModel.id))
            .fold((failure) {
          selectBrand = [];
          emit(AllVisitBrandHospitalErrorState(failure: failure));
        }, (data) async {
          selectBrand = [];
          emit(AllVisitBrandHospitalState());
        });
      }

      if (event is EditAmountBrandEvent) {
        visitBrandPharmacys[event.index].amount = event.brand;
      }
      if(event is IsScienceEvent){
        isScience=event.isScience;
        emit(IsScienceState(isScience));
      }
      if (event is RemoveBrandEvent) {
        List<BrandModel> updatedList = List.from(selectBrand);
        updatedList.removeWhere(
          (v) => v.id == event.brandModel.id,
        );
        selectBrand = updatedList;
        visitBrandPharmacys.removeWhere(
          (v) => v.brandId == event.brandModel.id,
        );
        emit(DeleteBrandState(updatedList));
      }
      if (event is SpecializationHospitalEvent) {
        (await spHospitalSqlUsecase.execute(event.hospitalId)).fold((failure) {
          emit(SpecializationHospitalErrorState(failure: failure));
        }, (data) async {
          specialization = data;
          emit(SpecializationHospitalState());
        });
      }
      if (event is TypeAdditionEvent) {
        if (event.type.i == 0) {
          emit(BoxState(event.type.name));
        } else if (event.type.i == 1) {
          emit(DropDownState(event.type.name));
        } else {emit(BoxState(event.type.name));}
        not=event.type.name;
        br=" ";
      }
    });

  }
  String addition(String brand){
    String add="${not } \n ${brand} \n ${isScience==true?" مكتب علمي ":"مع الخطة "}" ;
    return add;
  }
}
