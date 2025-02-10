import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'future_rep_event.dart';
part 'future_rep_state.dart';

class FutureRepBloc extends Bloc<FutureRepEvent, FutureRepState> {
  FutureRepBloc() : super(FutureRepInitial()) {
    on<FutureRepEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
