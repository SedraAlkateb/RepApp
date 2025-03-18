import 'package:bloc/bloc.dart';
import 'package:domina_app/app/user_info.dart';
import 'package:domina_app/data/network/failure.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/domain/usecase/all_reps_future_usecase.dart';
import 'package:domina_app/presentation/uniti/search.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'manage_future_event.dart';
part 'manage_future_state.dart';

class ManageFutureBloc extends Bloc<ManageFutureEvent, ManageFutureState> {
  List<AllRepresentativeFuture> allRepresentative = [];
  AllRepsFutureUsecase allRepsFutureUsecase;
  ManageFutureBloc(this.allRepsFutureUsecase) : super(ManageFutureInitial()) {

    on<ManageFutureEvent>((event, emit) async{

      if (event is AllSeniorRepFutureEvent) {
        emit(AllSeniorRepLoadingState());
        (await allRepsFutureUsecase.execute(UserInfo.repId)).fold((failure) {
      emit(AllSeniorRepErrorState(failure: failure));
      }, (data) async {
      data.sort((a, b) => b.flag.compareTo(a.flag));
      allRepresentative=data;
      emit(AllSeniorRepState(data));
      });
      }
      else if (event is SenSearchRepFutureEvent) {
      List<AllRepresentativeFuture> allRepresentativeModel=[];
      String search = normalizeText(event.contant);
      allRepresentativeModel = allRepresentative.where((value) {
      if (normalizeText(value.name).contains(search)) {
      return true;
      }
      return false;
      }).toList();
      emit(AllSeniorRepState(allRepresentativeModel));
      }
    });
  }

}
