import 'package:bloc/bloc.dart';
import 'package:domina_app/data/network/failure.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/domain/usecase/all_city_usecase.dart';
import 'package:equatable/equatable.dart';

part 'all_city_event.dart';
part 'all_city_state.dart';

class AllCityBloc extends Bloc<AllCityEvent, AllCityState> {
        List<CityModel> cities = [];
      AllCityUsecase allcityUsecase;
  AllCityBloc( this.allcityUsecase) : super(AllCityInitial()) {
  
    on<AllCityEvent>((event, emit) async {
         if (event is GetAllCityEvent) {
           emit(const AllCityLoadingState());
        (await allcityUsecase.execute()).fold(
            (failure) {
          emit(AllCityErrorState(failure: failure));
          return false;
        }, (data) async {
          cities = data;
          emit(GetAllCityState(data));
        });
      }
    }
    );
  }
}
