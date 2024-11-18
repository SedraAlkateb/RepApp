import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
part 'recipes_event.dart';
part 'recipes_state.dart';

class RecipesBloc extends Bloc<RecipesEvent, RecipesState> {
  RecipesBloc() : super(RecipesInitial()) {
    on<RecipesEvent>((event, emit) {

    });
  }
}
