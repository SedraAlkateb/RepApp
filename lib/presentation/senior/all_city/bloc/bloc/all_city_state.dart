part of 'all_city_bloc.dart';

sealed class AllCityState
    extends Equatable {
  const AllCityState();

  @override
  List<Object?> get props => [];
}

// =============================================================
// Initial
// =============================================================

final class AllCityInitial
    extends AllCityState {
  const AllCityInitial();
}

// =============================================================
// Loading
// =============================================================

final class AllCityLoadingState
    extends AllCityState {
  const AllCityLoadingState();
}

// =============================================================
// Error
// =============================================================

final class AllCityErrorState
    extends AllCityState {
  const AllCityErrorState({
    required this.failure,
  });

  final Failure failure;

  @override
  List<Object?> get props => [
    failure,
  ];
}

// =============================================================
// Success
// =============================================================

final class GetAllCityState
    extends AllCityState {
  const GetAllCityState({
    required this.cities,
    required this.selectedCity,
  });

  final List<CityModel> cities;

  final CityModel? selectedCity;

  @override
  List<Object?> get props => [
    cities,
    selectedCity,
  ];
}