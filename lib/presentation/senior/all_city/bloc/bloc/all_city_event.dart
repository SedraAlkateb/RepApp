part of 'all_city_bloc.dart';

sealed class AllCityEvent extends Equatable {
  const AllCityEvent();
}
class GetAllCityEvent extends AllCityEvent{

 const GetAllCityEvent();
 
 @override
 List<Object?> get props => [];

}