import 'package:bloc/bloc.dart';
import 'package:domina_app/data/network/failure.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:meta/meta.dart';
part 'report_issue_event.dart';
part 'report_issue_state.dart';

class ReportIssueBloc extends Bloc<ReportIssueEvent, ReportIssueState> {
  ReportIssueBloc() : super(ReportIssueInitial()) {
    on<ReportIssueEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
