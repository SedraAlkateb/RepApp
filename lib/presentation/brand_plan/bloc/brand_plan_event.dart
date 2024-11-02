part of 'brand_plan_bloc.dart';

@immutable
abstract class BrandPlanEvent extends Equatable {

}

class ChangeFieldEvent extends BrandPlanEvent{
 final int number;
 final int index;
final int  indexBr;
final int brandM;
 ChangeFieldEvent(this.number,this.index,this.indexBr,this.brandM);
 @override
 List<Object?> get props => [number,index,indexBr,this.brandM];
}


class AllBrandPlanEvent extends BrandPlanEvent{
 final int index;
 AllBrandPlanEvent(this.index);
 @override
 List<Object?> get props => [];

}
class UpdateEvent extends BrandPlanEvent{

 @override
 List<Object?> get props => [];

}
class UpdateAmountSucEvent extends BrandPlanEvent{

 @override
 List<Object?> get props => [];

}
class UpdateAmount1SucEvent extends BrandPlanEvent{

 @override
 List<Object?> get props => [];

}

class SendToS extends BrandPlanEvent{

 @override
 List<Object?> get props => [];

}