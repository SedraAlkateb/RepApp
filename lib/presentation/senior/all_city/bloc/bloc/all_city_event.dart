part of 'all_city_bloc.dart';

sealed class AllCityEvent
    extends Equatable {
  const AllCityEvent();

  @override
  List<Object?> get props => [];
}

// =============================================================
// Get Cities
// =============================================================

class GetAllCityEvent
    extends AllCityEvent {
  const GetAllCityEvent();
}

// =============================================================
// Select City
// =============================================================

class SelectCityEvent
    extends AllCityEvent {
  const SelectCityEvent(
      this.city,
      );

  final CityModel city;

  @override
  List<Object?> get props => [
    city,
  ];
}