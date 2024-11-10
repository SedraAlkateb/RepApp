import 'package:bloc/bloc.dart';
import 'package:domina_app/data/network/failure.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/domain/usecase/all_brands_flag_sql_usecase.dart';
import 'package:domina_app/domain/usecase/doctors_by_place_usecase.dart';
import 'package:domina_app/domain/usecase/hospitals_by_place_usecase.dart';
import 'package:domina_app/domain/usecase/insert_visit_brand_doctor_sql_usecase.dart';
import 'package:domina_app/domain/usecase/insert_visit_brand_hospital_sql_usecase.dart';
import 'package:domina_app/domain/usecase/insert_visit_doctor_sql_usecase.dart';
import 'package:domina_app/domain/usecase/insert_visit_hospital_sql_usecase.dart';
import 'package:domina_app/domain/usecase/sp_hospital_sql_usecase.dart';
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
  // AllBrandsSqlUsecase allBrandsSqlUsecase;

  List<BrandModel> selectBrand = [];
  List<BrandAddition> selectAddBrand = [];
  List<BrandModel> selectBrandAdd = [];
  List<BrandModel> bandFlag = [];
  // List<PharmacyModel> pharmacies = [];
  //  List<PharmacyModel> pharmaSearchModel = [];
  List<DoctorModel> doctors = [];
  List<DoctorModel> doctorSearchModel = [];
  List<HospitalModel> hospitals = [];
  List<HospitalModel> hospitalSearchModel = [];
  List<SpecHospitalSp> specialization = [];
  SpecHospitalSp? spec;
  List<VisitBrandPharmacyModel> visitBrandPharmacys = [];
  int current = 0;
  String not = "";
  String br = "";
  int isScience = 0;
  Type type=Type(0, "لا شيئ");
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
    //    this.allBrandsSqlUsecase
  ) : super(VisitPlaceInitial()) {
    on<VisitPlaceEvent>((event, emit) async {
      // if (event is PharmacyByPlace) {
      //   current = event.current;
      //   (await pharmaciesByPlaceUsecase.execute(event.placeId)).fold((failure) {
      //     emit(AllPharmacyByPlaceErrorState(failure: failure));
      //   }, (data) async {
      //     pharmacies = data;
      //     emit(AllPharmacyByPlaceState(data));
      //   });
      // }
      if(event is BoxAddEvent){
        br=event.n;
        print(br);
      }
      if (event is HospitalByPlace) {
        current = event.current;
        (await hospitalsByPlaceUsecase.execute(event.placeId)).fold((failure) {
          emit(AllHospitalByPlaceErrorState(failure: failure));
        }, (data) async {
          hospitals = data;
          if(hospitals.isNotEmpty){
            emit(AllHospitalByPlaceState(data));
          }else{
            emit(EmptyState());
          }
        });
      } else if (event is SelectSpecEvent) {
        spec = event.spec;
        emit(SpecState(
            total: spec!.hospitalSpModel.totalDocs,
            visits: spec!.hospitalSpModel.visit,
            visited: spec!.hospitalSpModel.visited??0
        ));
      } else if (event is DoctorByPlace) {
        current = event.current;
        (await doctorsByPlaceUsecase.execute(event.placeId)).fold((failure) {
          emit(AllDoctorByPlaceErrorState(failure: failure));
        }, (data) async {
          doctors = data;
          doctorSearchModel = doctors;
          if(doctors.isNotEmpty){
            emit(AllDoctorByPlaceState(data));
          }else{
            emit(EmptyState());
          }
        });
      } else if (event is BrandFlagEvent) {
        (await allBrandsFlagSqlUsecase.execute()).fold((failure) {
          emit(BrandFlagErrorState(failure: failure));
        }, (data) async {
          bandFlag = data;
          emit(BrandFlagState(data));
        });
      }
      // if (event is BrandAnyFlagEvent) {
      //   (await allBrandsSqlUsecase.execute()).fold((failure) {
      //     emit(BrandFlagErrorState(failure: failure));
      //   }, (data) async {
      //     bandFlag = data;
      //     emit(BrandFlagState(data));
      //   });
      // }
      else if (event is SelectBrandEvent) {
        final existingIndex =
            selectBrand.indexWhere((brand) => brand.id == event.brandModel.id);
        if (existingIndex != -1) {
          List<VisitBrandPharmacyModel> updatedList =
              List.from(visitBrandPharmacys);
          updatedList[existingIndex] = VisitBrandPharmacyModel(
              updatedList[existingIndex].id,
              updatedList[existingIndex].visitId,
              updatedList[existingIndex].brandId,
              updatedList[existingIndex].amount + 1,0);
          visitBrandPharmacys = updatedList;
          emit(EditAmountBrandState(visitBrandPharmacys));
        } else {
          final VisitBrandPharmacyModel v = VisitBrandPharmacyModel(
              0, event.pharmacyId, event.brandModel.id, 1,0);
          visitBrandPharmacys.add(v);
          List<BrandModel> updatedList = List.from(selectBrand);
          updatedList.add(event.brandModel);
          selectBrand = updatedList;
          emit(SelectBrandState(selectBrand));
        }
      }
      if(event is SelectBrandAdditionAddEvent){
        List<BrandAddition> updatedList = List.from(selectAddBrand);
        updatedList.add(BrandAddition(event.brand.id,event.brand.title, event.brand.phTitle, 0));
        selectAddBrand=updatedList;
       emit(SelectBrandAddState());
      }
      if( event is SelectNumBrandAddEvent){

        List<BrandAddition> updatedList = List.from(selectAddBrand);
        updatedList.last.amount=int.parse(event.num);
        selectAddBrand = updatedList;
        emit(SelectBrandAddNumState(updatedList));
      }
      // if (event is InsertVisitPharmacyEvent) {
      //   emit(InsertVisitPharmacyLoadingState());
      //   (await insertVisitPharmacySqlUsecase.execute(event.visitPharmacyModel))
      //       .fold((failure) {
      //     print(failure.massage);
      //     emit(InsertVisitPharmacyErrorState(failure: failure));
      //   }, (data) async {
      //     emit(InsertVisitPharmacyState());
      //   });
      // }
      else if (event is InsertVisitDoctorEvent) {

        event.visitDoctorModel.additaion =type.i==2?null:not==""?null:
         addition();
        (await insertVisitDoctorSqlUsecase.execute(event.visitDoctorModel))
            .fold((failure) {
          print(failure.massage);
          emit(InsertVisitDoctorErrorState(failure: failure));
        }, (data) async {
          emit(InsertVisitDoctorState());
        });
      }
      // if (event is InsertBrandVisitEvent) {
      //   emit(AllVisitBrandPharmacyLoadingState());
      //   (await insertVisitBrandPharmacySqlUsecase.execute(
      //           visitBrandPharmacys, event.visitPharmacyModel))
      //       .fold((failure) {
      //     selectBrand = [];
      //     emit(AllVisitBrandPharmacyErrorState(failure: failure));
      //   }, (data) async {
      //     selectBrand = [];
      //     emit(AllVisitBrandPharmacyState());
      //   });
      // }
      else if (event is InsertBrandVisitDoctorEvent) {
        event.visitDoctorModel.additaion =type.i==2?null:not==""?null:
        addition();
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
      else if (event is InsertBrandVisitHospitalEvent) {
        event.visitHospitalModel.additaion =type.i==2?null:not ==""?null:
        addition();
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
      else if (event is InsertVisitHospitalEvent) {
        event.visitHospitalModel.additaion =type.i==2?null: (not ==""?null:
        addition());
        (await insertVisitHospitalSqlUsecase.execute(
                event.visitHospitalModel, event.hospitalId, spec!.specModel.id))
            .fold((failure) {
          selectBrand = [];
          emit(AllVisitBrandHospitalErrorState(failure: failure));
        }, (data) async {
          selectBrand = [];
          emit(AllVisitBrandHospitalState());
        });
      } else if (event is EditAmountBrandEvent) {
        visitBrandPharmacys[event.index].amount = event.brand;
      } else if (event is IsScienceEvent) {
        isScience = event.isScience;
        emit(IsScienceState(isScience));
      } else if (event is RemoveBrandEvent) {
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
      else if (event is RemoveBrandAdditionEvent) {
        List<BrandAddition> updatedList = List.from(selectAddBrand);
        updatedList.removeWhere(
              (v) => v == event.brandAddition,
        );
        selectAddBrand = updatedList;
        emit(DeleteBrandAddState(updatedList));
      }
      else if (event is SpecializationHospitalEvent) {
        (await spHospitalSqlUsecase.execute(event.hospitalId)).fold((failure) {
          emit(SpecializationHospitalErrorState(failure: failure));
        }, (data) async {
          specialization = data;
          emit(SpecializationHospitalState(data));
        });
      } else if (event is TypeAdditionEvent) {
        type=event.type;

        if (event.type.i == 0) {

          emit(BoxState(event.type.name));
        } else if (event.type.i == 1) {
          emit(DropDownState(event.type.name));
        }
        else if (event.type.i == 2) {
          emit(NothingState());
        }else {
          emit(BoxState(event.type.name));
        }
        not = event.type.name;
        br = "";
      } else if (event is SearchDoctorVisitEvent) {
        doctorSearchModel = doctors.where((doctorvalue) {
          if (doctorvalue.title.contains(event.value)) {
            return true;
          } else {
            return false;
          }
        }).toList();
        emit(SearchVisitDoctorState(doctorSearchModel));
      } else if (event is SearchHospitalVisitEvent) {
        hospitalSearchModel = hospitals.where((hospital) {
          if (hospital.title.contains(event.value)) {
            return true;
          } else {
            return false;
          }
        }).toList();
        emit(SearchVisitHospitalState(hospitalSearchModel));
      } else if (event is EndEvent) {
        emit(EndState());
      }

//      if(event is SearchPharmacyVisitEvent){
//    pharmaSearchModel = pharmacies
//       .where((pharmacy) {
// if(pharmacy.title.contains(event.value)){
//   return true;
// }else{
//   return false;
// }
//
//       }  )
//       .toList();
//       emit(SearchVisitPharmacyState(pharmaSearchModel));
//     }
    });
  }
  String addition() {
    String brand="";
   if(br==""){
     for( var ss in selectAddBrand ){
       brand= "${brand} ${ss.title} ${ss.phTitle} ${ss.amount} \n";
     }
   }

   else{
     brand= "${br}\n";
   }
    String add =
        "${not} \n ${brand} ${isScience == 0 ? " مكتب علمي " :isScience == 1? "مع الخطة ": "مع الموزع "}";
    return add;
  }

}
