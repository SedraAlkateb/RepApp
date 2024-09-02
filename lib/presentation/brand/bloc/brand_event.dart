part of 'brand_bloc.dart';

@immutable
sealed class BrandEvent  extends Equatable{}
class AllBrandEvent extends BrandEvent{
  @override
  AllBrandEvent();
  List<Object?> get props => [];

}