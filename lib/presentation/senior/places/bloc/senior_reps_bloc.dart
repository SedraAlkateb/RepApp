import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'senior_reps_event.dart';
part 'senior_reps_state.dart';

class SeniorRepsBloc extends Bloc<SeniorRepsEvent, SeniorRepsState> {
  SeniorRepsBloc() : super(SeniorRepsInitial()) {
    on<SeniorRepsEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
