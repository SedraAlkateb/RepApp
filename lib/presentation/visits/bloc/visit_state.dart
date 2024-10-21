part of 'visit_bloc.dart';

@immutable
sealed class VisitState extends Equatable {}

final class VisitInitial extends VisitState {
  @override
  List<Object?> get props => throw UnimplementedError();
}

// final class VisitPharmacyErrorState extends VisitState {
//   final Failure failure;
//   VisitPharmacyErrorState({required this.failure});
//   @override
//
//   List<Object?> get props =>[failure];
// }
final class VisitHospitalErrorState extends VisitState {
  final Failure failure;
  VisitHospitalErrorState({required this.failure});
  @override
  List<Object?> get props => [failure];
}

final class SearchState extends VisitState {
  final List<VisitDoctorAndDoctor> doctors;
  SearchState({required this.doctors});
  @override
  List<Object?> get props => [doctors];
}
// final class VisitPharmacyState extends VisitState {
//   @override
//   VisitPharmacyState();
//   @override
//   List<Object?> get props =>[];
// }

final class VisitDoctorErrorState extends VisitState {
  final Failure failure;
  VisitDoctorErrorState({required this.failure});
  @override
  List<Object?> get props => [failure];
}

final class VisitDoctorState extends VisitState {
  final List<VisitDoctorAndDoctor> doctors;
  VisitDoctorState(this.doctors);
  @override
  List<Object?> get props => [doctors];
}
final class SearchVisitDoctorState extends VisitState {
  final List<VisitDoctorAndDoctor> doctors;
  SearchVisitDoctorState(this.doctors);
  @override
  List<Object?> get props => [doctors];
}

final class VisitHospitalState extends VisitState {
  @override
  VisitHospitalState();
  @override
  List<Object?> get props => [];
}

final class BrandPharmacyVisitErrorState extends VisitState {
  final Failure failure;
  BrandPharmacyVisitErrorState({required this.failure});
  @override
  List<Object?> get props => [failure];
}

final class BrandHospitalVisitErrorState extends VisitState {
  final Failure failure;
  BrandHospitalVisitErrorState({required this.failure});
  @override
  List<Object?> get props => [failure];
}

final class BrandPharmacyVisitState extends VisitState {
  final List<PharmacyBrandModel> brands;
  @override
  BrandPharmacyVisitState(this.brands);
  @override
  List<Object?> get props => [brands];
}

final class BrandHospitalVisitState extends VisitState {
  final List<PharmacyBrandModel> brands;
  @override
  BrandHospitalVisitState(this.brands);
  @override
  List<Object?> get props => [brands];
}

/*

final class UpdateVisitDoctorErrorState extends VisitState {
  final Failure failure;
  UpdateVisitDoctorErrorState({required this.failure});
  @override

  List<Object?> get props =>[failure];
}
final class UpdateVisitDoctorState extends VisitState {
  @override
  UpdateVisitDoctorState();
  @override
  List<Object?> get props =>[];
}

final class UpdateVisitHospitalErrorState extends VisitState {
  final Failure failure;
  UpdateVisitHospitalErrorState({required this.failure});
  @override

  List<Object?> get props =>[failure];
}
final class UpdateVisitHospitalState extends VisitState {
  @override
  UpdateVisitHospitalState();
  @override
  List<Object?> get props =>[];
}

final class UpdateVisitPharmacyErrorState extends VisitState {
  final Failure failure;
  UpdateVisitPharmacyErrorState({required this.failure});
  @override

  List<Object?> get props =>[failure];
}
final class UpdateVisitPharmacyState extends VisitState {
  @override
  UpdateVisitPharmacyState();
  @override
  List<Object?> get props =>[];
}
 */
