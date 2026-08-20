import 'package:bloc/bloc.dart';
import 'package:domina_app/data/network/failure.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/domain/usecase/all_city_usecase.dart';
import 'package:equatable/equatable.dart';

part 'all_city_event.dart';
part 'all_city_state.dart';

class AllCityBloc
    extends Bloc<AllCityEvent, AllCityState> {
  AllCityBloc(
      this.allcityUsecase,
      ) : super(
     AllCityInitial(),
  ) {

    // =========================================================
    // Get Cities
    // =========================================================
    on<GetAllCityEvent>(
      _getAllCities,
    );

    // =========================================================
    // Select City
    // =========================================================
    on<SelectCityEvent>(
      _selectCity,
    );
  }

  final AllCityUsecase allcityUsecase;

  // ===========================================================
  // Cities
  // ===========================================================

  List<CityModel> cities = [];

  // ===========================================================
  // Selected City
  // ===========================================================

  CityModel? selectedCity;

  // ===========================================================
  // Get All Cities
  // ===========================================================

  Future<void> _getAllCities(
      GetAllCityEvent event,
      Emitter<AllCityState> emit,
      ) async {
    emit(
      const AllCityLoadingState(),
    );

    final result =
    await allcityUsecase.execute();

    result.fold(
          (failure) {
        emit(
          AllCityErrorState(
            failure: failure,
          ),
        );
      },
          (data) {
        cities = data;

        // =====================================================
        // أول محافظة هي الافتراضية
        // =====================================================
        selectedCity =
        cities.isNotEmpty
            ? cities.first
            : null;

        emit(
          GetAllCityState(
            cities: cities,
            selectedCity:
            selectedCity,
          ),
        );
      },
    );
  }

  // ===========================================================
  // Select City
  // ===========================================================

  void _selectCity(
      SelectCityEvent event,
      Emitter<AllCityState> emit,
      ) {
    selectedCity =
        event.city;

    emit(
      GetAllCityState(
        cities: cities,
        selectedCity:
        selectedCity,
      ),
    );
  }
  int cityIdOf(CityModel city) {
    return int.tryParse(
      city.id.toString(),
    ) ??
        -1;
  }

  String cityNameOf(CityModel city) {
    return city.title.toString();
  }

  int? get selectedCityId {
    final city = selectedCity;

    if (city == null) {
      return null;
    }

    return cityIdOf(city);
  }

  String get selectedCityName {
    final city = selectedCity;

    if (city == null) {
      return '';
    }

    return cityNameOf(city);
  }
}