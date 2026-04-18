part of 'all_city_bloc.dart';

sealed class AllCityState extends Equatable {
  const AllCityState();
  
 
}

final class AllCityInitial extends AllCityState {
   @override
  List<Object> get props => [];
}
final class AllCityErrorState extends AllCityState {

  final Failure failure;
  const AllCityErrorState({required this.failure});
  @override

  List<Object?> get props =>[failure];
}

final class AllCityLoadingState extends AllCityState {
  const AllCityLoadingState();
  @override
  List<Object?> get props =>[];
}

final class GetAllCityState extends AllCityState {
  final List<CityModel> cities;
  const GetAllCityState(this.cities);
  @override
  List<Object?> get props =>[cities];
}
