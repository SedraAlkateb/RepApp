import 'package:bloc/bloc.dart';
import 'package:domina_app/app/user_info.dart';
import 'package:domina_app/domain/failure.dart';
import 'package:domina_app/domain/usecase/delete_all_sql_usecase.dart';
import 'package:domina_app/domain/usecase/delete_sql_usecase.dart';
import 'package:domina_app/domain/usecase/edit_is_login_sql_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'delete_event.dart';
part 'delete_state.dart';

class DeleteBloc extends Bloc<DeleteEvent, DeleteState> {
  DeleteSqlUsecase deleteSqlUsecase;
  DeleteAllSqlUsecase deleteAllSqlUsecase;
  EditIsLoginSqlUsecase editIsLoginSqlUsecase;
  DeleteBloc(this.deleteAllSqlUsecase, this.deleteSqlUsecase,
      this.editIsLoginSqlUsecase)
      : super(DeleteInitial()) {
    on<DeleteBaseEvent>((event, emit) async {
      //   emit(DeleteBaseLoadingState());
      (await deleteSqlUsecase.execute()).fold((failure) {
        emit(DeleteBaseErrorState(failure: failure));
        return false;
      }, (data) async {
        emit(DeleteBaseState());
      });
    });

    on<DeleteAllEvent>((event, emit) async {
      //   emit(DeleteAllLoadingState());
      (await deleteAllSqlUsecase.execute()).fold((failure) {
        emit(DeleteAllErrorState(failure: failure));
        return false;
      }, (data) async {
        UserInfo.flag1 = 0;
        emit(DeleteAllState());
      });
    });

    on<Edit1EventIn>((event, emit) async {
      (await editIsLoginSqlUsecase.execute(UserInfo.repId, event.num)).fold(
          (failure) {
        emit(Edit1StatusSErrorState(failure: failure));
        return false;
      }, (data) async {
        UserInfo.isLogging = event.num;
        emit(Edit1StatusState());
      });
    });
  }
}
