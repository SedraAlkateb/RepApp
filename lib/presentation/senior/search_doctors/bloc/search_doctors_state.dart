part of 'search_doctors_bloc.dart';

@immutable
abstract class SearchDoctorsState extends Equatable {}

final class EditBrandPlanInitial extends SearchDoctorsState {

  @override
  List<Object?> get props => [];
}
final class FutureSearchDoctorsState extends SearchDoctorsState {
  final List<doctorsModel> representative;
  FutureSearchDoctorsState(this.representative);
  @override
  List<Object?> get props => [representative];
}
final class FutureSearchDoctorsErrorState extends SearchDoctorsState {
  final Failure failure;
  FutureSearchDoctorsErrorState({required this.failure});
  @override
  List<Object?> get props => [failure];
}
final class FutureSearchDoctorsLoadingState extends SearchDoctorsState {
  @override
  FutureSearchDoctorsLoadingState();
  @override
  List<Object?> get props => [];
}
final class FutureSearchDoctorsEmptyState extends SearchDoctorsState {
  FutureSearchDoctorsEmptyState();
  @override
  List<Object?> get props =>[];
}

final class FutureDocDoctorsLoadingState extends SearchDoctorsState {
  @override
  FutureDocDoctorsLoadingState();
  @override
  List<Object?> get props => [];
}
final class FutureDocDoctorsEmptyState extends SearchDoctorsState {
  FutureDocDoctorsEmptyState();
  @override
  List<Object?> get props =>[];
}
final class FutureDocDoctorsErrorState extends SearchDoctorsState {
  final Failure
  failure;
  FutureDocDoctorsErrorState({required this.failure});
  @override
  List<Object?> get props => [failure];
}
final class FutureDocDoctorsState extends SearchDoctorsState {
  final List<DocdoctorsModel> doctordetails;
  FutureDocDoctorsState(this.doctordetails);
  @override
  List<Object?> get props => [doctordetails];
}

class DocIsExpandedNoteState extends SearchDoctorsState {
  final int index;

  DocIsExpandedNoteState({required this.index});
   @override
  List<Object?> get props =>[];
}
class DocNoIsExpandedNoteState extends SearchDoctorsState {
    @override
  List<Object?> get props =>[]; 
}
final class DoctorInfoState extends SearchDoctorsState {
  final DoctorModel doctor;
  DoctorInfoState(this.doctor);
  @override
  List<Object?> get props => [doctor];
}
final class DoctorInfoErrorState extends SearchDoctorsState {
  final Failure failure;
  DoctorInfoErrorState({required this.failure});
  @override
  List<Object?> get props => [failure];
}
final class DoctorInfoLoadingState extends SearchDoctorsState {
  @override
  DoctorInfoLoadingState();
  @override
  List<Object?> get props => [];
}



final class FutureSearchHospitalsState extends SearchDoctorsState {
  final List<SearchHospitalModel> allSearch;
  FutureSearchHospitalsState(this.allSearch);
  @override
  List<Object?> get props => [allSearch];
}
final class FutureSearchHospitalsErrorState extends SearchDoctorsState {
  final Failure failure;
  FutureSearchHospitalsErrorState({required this.failure});
  @override
  List<Object?> get props => [failure];
}
final class FutureSearchHospitalsLoadingState extends SearchDoctorsState {
  @override
  FutureSearchHospitalsLoadingState();
  @override
  List<Object?> get props => [];
}
final class FutureSearchHospitalsEmptyState extends SearchDoctorsState {
  FutureSearchHospitalsEmptyState();
  @override
  List<Object?> get props =>[];
}

final class FutureDocHospitalsLoadingState extends SearchDoctorsState {
  @override
  FutureDocHospitalsLoadingState();
  @override
  List<Object?> get props => [];
}
final class FutureDocHospitalsEmptyState extends SearchDoctorsState {
  FutureDocHospitalsEmptyState();
  @override
  List<Object?> get props =>[];
}
final class FutureDocHospitalsErrorState extends SearchDoctorsState {
  final Failure failure;
  FutureDocHospitalsErrorState({required this.failure});
  @override
  List<Object?> get props => [failure];
}
final class FutureDocHospitalsState extends SearchDoctorsState {
  final List<SearchHospitalNoteModel> allNote;
  FutureDocHospitalsState(this.allNote);
  @override
  List<Object?> get props => [allNote];
}
