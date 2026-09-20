part of 'async_bloc.dart';

@immutable
sealed class AsyncState extends Equatable {}

final class AsyncInitial extends AsyncState {
  @override
  List<Object?> get props => [];
}

final class SyncDataState extends AsyncState {
  SyncDataState();
  @override
  List<Object?> get props => [];
}

final class SyncDataErrorState extends AsyncState {
  final Failure failure;
  SyncDataErrorState({required this.failure});
  @override
  List<Object?> get props => [failure];
}

final class SyncDataLoadingState extends AsyncState {
  final int loading;
  SyncDataLoadingState(this.loading);
  @override
  List<Object?> get props => [loading];
}

final class LoadingState extends AsyncState {
  final int loading;
  LoadingState(this.loading);
  @override
  List<Object?> get props => [loading];
}

final class EditStatusDState extends AsyncState {
  EditStatusDState();
  @override
  List<Object?> get props => [];
}

final class EditStatusDErrorState extends AsyncState {
  final Failure failure;
  EditStatusDErrorState({required this.failure});
  @override
  List<Object?> get props => [failure];
}

/// البيانات المحمّلة من السيرفر بانتظار حفظها محلياً.
class SyncPayload extends Equatable {
  final List<BrandModel> brands;
  final List<PlaceModel> places;
  final List<SpecDModel> spec;
  final List<DoctorModel> doctors;
  final List<HospitalModel> hospitals;
  final List<HospitalSpModel> hospitalSps;
  final List<BrandSpModel> brandSpModel;
  final List<PlanBrandModel> planBrands;
  final VisitDoctorBase visitDoctor;
  final VisitHospitalBase visitHospital;

  const SyncPayload({
    required this.brands,
    required this.places,
    required this.spec,
    required this.doctors,
    required this.hospitals,
    required this.hospitalSps,
    required this.brandSpModel,
    required this.planBrands,
    required this.visitDoctor,
    required this.visitHospital,
  });

  @override
  List<Object?> get props => [
        brands,
        places,
        spec,
        doctors,
        hospitals,
        hospitalSps,
        brandSpModel,
        planBrands,
        visitDoctor,
        visitHospital,
      ];
}

final class getDataSucState extends AsyncState {
  final SyncPayload payload;
  getDataSucState(this.payload);
  @override
  List<Object?> get props => [payload];
}

///////////////
final class IsActiveState extends AsyncState {
  IsActiveState();
  @override
  List<Object?> get props => [];
}

final class IsActiveErrorState extends AsyncState {
  final Failure failure;
  IsActiveErrorState({required this.failure});
  @override
  List<Object?> get props => [failure];
}

final class UpdateIsActiveState extends AsyncState {
  UpdateIsActiveState();
  @override
  List<Object?> get props => [];
}

final class UpdateIsActiveErrorState extends AsyncState {
  final Failure failure;
  UpdateIsActiveErrorState({required this.failure});
  @override
  List<Object?> get props => [failure];
}

final class DeleteAllState extends AsyncState {
  DeleteAllState();
  @override
  List<Object?> get props => [];
}

final class DeleteAllErrorState extends AsyncState {
  final Failure failure;
  DeleteAllErrorState({required this.failure});
  @override
  List<Object?> get props => [failure];
}

