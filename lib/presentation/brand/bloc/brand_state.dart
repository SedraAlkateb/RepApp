part of 'brand_bloc.dart';

@immutable
sealed class BrandState extends Equatable {}

final class BrandInitial extends BrandState {
  @override

  List<Object?> get props => throw UnimplementedError();
}
final class AllBrandState extends BrandState {
  final List<BrandModel> brand;
  AllBrandState(this.brand);
  @override
  List<Object?> get props =>[brand];
}
final class AllBrandErrorState extends BrandState {
  final Failure failure;
  AllBrandErrorState({required this.failure});
  @override

  List<Object?> get props =>[failure];
}
final class AllBrandLoadingState extends BrandState {
  @override
  AllBrandLoadingState();
  @override
  List<Object?> get props =>[];
}
final class InsertAllBrandState extends BrandState {

  InsertAllBrandState();
  @override
  List<Object?> get props =>[];
}
final class InsertAllBrandErrorState extends BrandState {
  final Failure failure;
  InsertAllBrandErrorState({required this.failure});
  @override

  List<Object?> get props =>[failure];
}
final class InsertAllBrandLoadingState extends BrandState {
  @override
  InsertAllBrandLoadingState();
  @override
  List<Object?> get props =>[];
}