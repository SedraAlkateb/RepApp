import 'package:bloc/bloc.dart';
import 'package:domina_app/data/network/failure.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/domain/usecase/all_spec_usecase.dart';
import 'package:domina_app/domain/usecase/rep_plan_brand_sp_usecase.dart';
import 'package:domina_app/presentation/uniti/search.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'future_rep_event.dart';
part 'future_rep_state.dart';

class FutureRepBloc extends Bloc<FutureRepEvent, FutureRepState> {
  AllSpeUsecase allSpeUsecase;
  RepPlanBrandSpUsecase repPlanBrandSpUsecase;
  int sumBrandsAmount=0;
  List<SpecDModel> specialization = [];
  List<BrandFlag> brandFlag = [];
  AllPlanBrandSp planBrandSp=AllPlanBrandSp([], 0);
  FutureRepBloc(this.allSpeUsecase,
      this.repPlanBrandSpUsecase)
      : super(FutureRepInitial()) {
    on<FutureRepEvent>((event, emit) async {
      if (event is FutureSpEvent) {
        specialization = [];
        emit(FutureSpRepLoadingState());
        (await allSpeUsecase.execute(event.id)).fold((failure) {
          emit(FutureSpRepErrorState(failure: failure));
        }, (data) async {
          specialization = data;
          emit(FutureSpRepState(data));
        });
      }
      else if(event is FutureSearchSpecEvent){
        List<SpecDModel> specializationSearch=[];
        String search = normalizeText(event.contan);
        specializationSearch = specialization.where((value) {
          if (normalizeText(value.title).contains(search)) {
            return true;
          }
          return false;
        }).toList();
        emit(FutureSpRepState(specializationSearch));
      }
      else if (event is FutureRepPlanBrandSpEvent) {
        emit(FutureRepPlanBrandSpLoadingState());
        (await repPlanBrandSpUsecase.execute(event.rep)).fold((failure) {
          emit(FutureRepPlanBrandSpErrorState(failure: failure));
        }, (data) async {
          planBrandSp=data??AllPlanBrandSp([], 0);
          if (data!.planBrandSps.isEmpty) {
            emit(FutureRepPlanBrandSpEmptyState(data));
          } else {
            sumBrandsAmount=0;
            sumBrandsAmount=   sumBrandAmount(data.planBrandSps);
           emit(FutureRepPlanBrandSpState(data.planBrandSps));
          }
        });
      }
      else if(event is ChangeFieldEvent ){
        int sumF=sumBrandsAmount-planBrandSp.planBrandSps[event.index].totalAmount;
        sumF=sumF+event.number;
        if(sumF>planBrandSp.amount){
          emit(SumErrorState(failure: Failure(4, "لقد تجاوزت الحد المسموح لهذا الاختصاص")));
        }else{
        planBrandSp.planBrandSps[event.index].totalAmount= event.number;
        sumBrandsAmount=sumF;
        }
      }
    });
  }
 int  sumBrandAmount(List<PlanBrandSp> planBrands){
   int sum = 0;
   for (PlanBrandSp brand in planBrands) {
     sum += brand.totalAmount;
   }
   return sum;
  }
}
