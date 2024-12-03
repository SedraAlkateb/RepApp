import 'package:bloc/bloc.dart';
import 'package:domina_app/app/user_info.dart';
import 'package:domina_app/data/network/failure.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/domain/usecase/all_place_sql_usecase.dart';
import 'package:domina_app/domain/usecase/check_rep_usecase%20.dart';
import 'package:domina_app/presentation/uniti/search.dart';
import 'package:domina_app/presentation/uniti/time.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
part 'place_event.dart';
part 'place_state.dart';

class PlaceBloc extends Bloc<PlaceEvent, PlaceState> {
  AllPlacesSqlUsecase allPlaceUsecase;
  CheckRepUsecase checkRepUsecase;
  List<PlaceModel> placeModel = [];
  List<PlaceModel> placeSearchModel = [];
  int k = 0;
  String data= formatDateTime(DateTime.now().toString());
/*
List<VisitPharmacyModel> vi=[
  VisitPharmacyModel(0, "data5", "note75", 5),
  VisitPharmacyModel(1, "data58", "note", 6),
  VisitPharmacyModel(2, "data57", "note7", 7),
  VisitPharmacyModel(3, "data7", "note", 8)
];
  List<VisitBrandPharmacyModel> list2=[
    VisitBrandPharmacyModel(0, 0, 0, 0)
  ];
 */
  PlaceBloc(this.allPlaceUsecase,this.checkRepUsecase) : super(PlaceInitial()) {
    on<PlaceEvent>((event, emit) async {
      //  VisitPharmacyRequestBody  v=VisitPharmacyRequestBody(vi.toDomain(), list2);
      if (event is AllPlaceEvent) {
        //   emit(AllPlaceLoadingState());
        (await allPlaceUsecase.execute()).fold((failure) {
          emit(AllPlaceErrorState(failure: failure));
        }, (data) async {
          placeModel = data;
          placeSearchModel = data;
          emit(AllPlaceState(data));
        });
      }
      if (event is CheckRepEvent) {
        //   emit(CheckRepLoadingState());
        (await checkRepUsecase.execute(UserInfo.repId)).fold((failure) {
          emit(CheckRepErrorState(failure: failure));
        }, (data) async {
          emit(CheckRepState(data.accepted??true));
        });
      }
      else    if (event is SearchPlaceEvent) {
        String search = normalizeText(event.value);
        placeSearchModel = placeModel.where((value) {
          if (normalizeText(value.title).contains(search)) {
            return true;
          } else {
            return false;
          }
        }).toList();
        emit(SearchPlaceState(placeSearchModel));
      }
    });
  }
} 
