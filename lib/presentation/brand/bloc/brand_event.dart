part of 'brand_bloc.dart';

@immutable
sealed class BrandEvent  extends Equatable{}
class AllBrandEvent extends BrandEvent{
  @override
  AllBrandEvent();
  List<Object?> get props => [];

}
class SearchbradEvent extends BrandEvent {
  final String contant;
  SearchbradEvent(this.contant);
  @override
  List<Object?> get props => [contant];



}
