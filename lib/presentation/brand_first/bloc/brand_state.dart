part of 'brand_bloc.dart';

sealed class BrandState extends Equatable {
  const BrandState();
  
  @override
  List<Object> get props => [];
}

final class BrandInitial extends BrandState {}
