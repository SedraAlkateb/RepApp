import 'package:bloc/bloc.dart';
import 'package:domina_app/app/user_info.dart';
import 'package:domina_app/data/network/failure.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/domain/usecase/all_reci_usecase%20.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'reci_event.dart';
part 'reci_state.dart';

class ReciBloc extends Bloc<ReciEvent, ReciState> {
  AllReciUsecase allReciUsecase;
  ReciBloc(this.allReciUsecase) : super(ReciInitial()) {
    on<ReciEvent>((event, emit) async{
      if (event is AllReciEvent) {
          emit(AllReciLoadingState());
        (await allReciUsecase.execute(UserInfo.repId)).fold((failure) {
      emit(AllReciErrorState(failure: failure));
      }, (data) async {
      emit(AllReciState(data));
      });
    }
    });
  }
}
