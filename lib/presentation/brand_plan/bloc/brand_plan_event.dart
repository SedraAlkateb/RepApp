part of 'brand_plan_bloc.dart';

@immutable
abstract class BrandPlanEvent extends Equatable {

}

class ChangeFieldEvent extends BrandPlanEvent{
 final int number;
 final int index;
final int  indexBr;
 ChangeFieldEvent(this.number,this.index,this.indexBr);
 @override
 List<Object?> get props => [number,index,indexBr];
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
class SendToS extends BrandPlanEvent{

 @override
 List<Object?> get props => [];

}