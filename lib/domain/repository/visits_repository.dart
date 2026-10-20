import 'package:dartz/dartz.dart';
import 'package:domina_app/domain/failure.dart';
import 'package:domina_app/domain/models/models.dart';

abstract class VisitsRepository {
  Future<Either<Failure, MessageModel>> visitPharmacy(
      VisitPharmacyRequestBody list1);

  Future<Either<Failure, MessageModel>> visitDoctor(
      VisitDoctorRequestBody list1);

  Future<Either<Failure, MessageModel>> visitHospital(
      VisitHospitalRequestBody list1);

  Future<Either<Failure, VisitHospitalBase>> getHosVisit(
      int repPlanId, int representativeId);

  Future<Either<Failure, VisitDoctorBase>> getDocVisit(
      String repPlanId, String representativeId);

  Future<Either<Failure, List<DoctorNoteModel>>> visitNotes(int depId);

  Future<Either<Failure, List<NoVisitDocModel>>> noVisitDoc(
      int repDet, int planId);

  Future<Either<Failure, List<NoVisitDocModel>>> visitDoc(
      int repDet, int planId);

  Future<Either<Failure, List<NoVisitDocModel>>> getUnfinishedDoctorVisits(
      int repDet, int planId);

  Future<Either<Failure, List<DoctorIssueModel>>> getVisitIssue(int repDet);

  Future<Either<Failure, List<RepVisitsModel>>> getRepVisits(
      VisitRepSen visitRepSen);

  Future<Either<Failure, MessageModel>> readVisit(AsRead asRead);

  Future<Either<Failure, List<RepVisitsModel>>> getRepVisitsHos(
      VisitRepSen visitRepSen);

  Future<Either<Failure, MessageModel>> readAllVisits(ReadAll readAll);

  Future<Either<Failure, MessageModel>> pharmacyOrder(
      PharmacyOrderRequestBody order);

  Future<Either<Failure, List<WhoReadModel>>> getVisitReadStatus(
    String visitId,
    String visitType,
    int repType,
  );

  Future<Either<Failure, List<NoVisitDocModel>>> noVisitHos(
    int repDet,
    int planId,
  );

  Future<Either<Failure, List<NoVisitDocModel>>> visitHos(
    int repPlanId,
  );

  Future<Either<Failure, List<NoVisitDocModel>>> getUnfinishedHosVisits(
    int repPlanId,
  );
}
