import 'package:domina_app/app/constants.dart';
import 'package:domina_app/app/user_info.dart';
import 'package:domina_app/data/responses/responses.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:html/parser.dart';

extension VisitPharmacyRequestMapper on VisitPharmacyModel? {
  VisitPharmacyRequest toDomain() {
    return VisitPharmacyRequest(
      this?.id.toString() ?? Constants.empty,
      UserInfo.activePlanId.toString(),
      UserInfo.repId.toString(),
      this!.pharmacyId.toString(),
      this?.data ?? Constants.empty,
      this?.note ?? Constants.empty,
    );
  }
}

extension AllVisitDoctorRepSenMapper on AllRepVisitsResponseBaseResponse? {
  List<RepVisitsModel> toDomain() {
    List<RepVisitsModel> repVisitsModel =
        (this?.data?.repVisits?.map((response) => response.toDomain()) ??
                const Iterable.empty())
            .cast<RepVisitsModel>()
            .toList();
    return repVisitsModel;
  }
}

extension visitDoctorRepSenMapper on RepVisitsResponse? {
  RepVisitsModel toDomain() {
    return RepVisitsModel(
      this?.visitId.toString() ?? Constants.empty,
      this?.visitDate.toString() ?? Constants.empty,
      this?.placeTitle.toString() ?? Constants.empty,
      this?.docTitle.toString() ?? Constants.empty,
      this?.rate.toString() ?? Constants.empty,
      this?.spTitle.toString() ?? Constants.empty,
      this?.note.toString() ?? Constants.empty,
      this?.issue.toString() ?? Constants.empty,
      this?.special.toString() ?? Constants.empty,
      this?.target.toString() ?? Constants.empty,
      this?.flag == "1" ? true : false,
      this!.samples?.toList() ?? [],
    );
  }
}

extension InfoRepMapper on AllRepInfoResponseBaseResponse? {
  InfoRep toDomain() {
    return InfoRep(
      int.parse(this?.data?.repInfoResponse![0].id ?? "0"),
      this?.data?.repInfoResponse![0].name ?? Constants.empty,
      this?.data?.repInfoResponse![0].mobile ?? Constants.empty,
      this?.data?.repInfoResponse![0].address ?? Constants.empty,
      this?.data?.repInfoResponse![0].sampleCount ?? Constants.empty,
      this?.data?.repInfoResponse![0].recipesCount ?? Constants.empty,
      this?.data?.repInfoResponse![0].repPlanId ?? Constants.zero,
      this?.data?.repInfoResponse![0].totalVisit ?? Constants.zero,
      this?.data?.repInfoResponse![0].visitDon ?? Constants.zero,
      this?.data?.repInfoResponse![0].visitnotYet ?? Constants.zero,
    );
  }
}

extension ActiveResposeMapper on CheckBaseResponse? {
  ActiveModel toDomain() {
    return ActiveModel(
      int.parse(this?.data.id ?? "0"),
      int.parse(this?.data.active ?? "0"),
    );
  }
}

extension CheckActiveResposeMapper on CheckActiveBaseResponse? {
  CheckActiveModel toDomain() {
    return CheckActiveModel(
        int.parse(this?.data.activePlanId ?? "0"),
        int.parse(this?.data.otherPlanId ?? "0"),
        int.parse(this?.data.otherstatus ?? "-1"));
  }
}

extension BrandsSpRequestMapper on BrandSpResponse? {
  BrandSpModel toDomain() {
    return BrandSpModel(
      int.parse(this?.id ?? "0"),
      int.parse(this?.spId ?? "0"),
      int.parse(this?.brandId ?? "0"),
      this?.brandType ?? Constants.empty,
    );
  }
}

extension ListBrandsSpRequestMapper on AllBrandSpBaseResponse? {
  List<BrandSpModel> toDomain() {
    List<BrandSpModel> brandSpModels = (this
                ?.data
                ?.brandsSpecializations
                ?.map((response) => response.toDomain()) ??
            const Iterable.empty())
        .cast<BrandSpModel>()
        .toList();
    return brandSpModels;
  }
}

extension ListVisitPharmacyRequestMapper on List<VisitPharmacyModel>? {
  List<VisitPharmacyRequest> toDomain() {
    List<VisitPharmacyRequest> visitPharmacyRequest =
        (this?.map((response) => response.toDomain()) ?? const Iterable.empty())
            .cast<VisitPharmacyRequest>()
            .toList();
    return visitPharmacyRequest;
  }
}

extension ListReciNumMapper on ReciNumResponse? {
  List<int> toDomain() {
    List<int> reci = (this?.recICounts?.map((response) => response) ??
            const Iterable.empty())
        .cast<int>()
        .toList();
    return reci;
  }
}

extension AllPlaceResponseMapper on AllPlaceBaseResponse? {
  List<PlaceModel> toDomain() {
    List<PlaceModel> places =
        (this?.data?.places?.map((response) => response.toDomain()) ??
                const Iterable.empty())
            .cast<PlaceModel>()
            .toList();
    return places;
  }
}

extension AllRepresentativeMapper on AllRepresentativeBaseResponse? {
  List<AllRepresentative> toDomain() {
    List<AllRepresentative> allRepresentative =
        (this?.data?.data?.map((response) => response.toDomain()) ??
                const Iterable.empty())
            .cast<AllRepresentative>()
            .toList();
    return allRepresentative;
  }
}

extension RepresentativeMapper on RepresentativeResponse? {
  AllRepresentative toDomain() {
    return AllRepresentative(
      int.parse(this?.id ?? "0"),
      this?.name ?? Constants.empty,
      this?.unRead ?? Constants.zero,
      int.parse(this?.activePlan ?? "0"),
    );
  }
}

extension PlaceResponseMapper on PlaceResponse? {
  PlaceModel toDomain() {
    return PlaceModel(
      int.parse(this?.id ?? "0"),
      this?.title ?? Constants.empty,
    );
  }
}

extension SpecResponseMapper on SpecResponse? {
  SpecDModel toDomain() {
    return SpecDModel(int.parse(this?.id ?? "0"),
        this?.title ?? Constants.empty, this?.flag ?? Constants.zero, 0, 0, 0);
  }
}

extension AllSpecResponseMapper on AllSpcBaseResponse? {
  List<SpecDModel> toDomain() {
    List<SpecDModel> spec =
        (this?.data?.specializations?.map((response) => response.toDomain()) ??
                const Iterable.empty())
            .cast<SpecDModel>()
            .toList();
    return spec;
  }
}

extension PharmacyResponseMapper on PharmacyResponse? {
  PharmacyModel toDomain() {
    return PharmacyModel(
      int.parse(this?.id ?? "0"),
      this?.title ?? Constants.empty,
      int.parse(this?.placeId ?? "0"),
      this?.address ?? Constants.empty,
    );
  }
}

extension AllPharmacyResponseMapper on AllPharmacyBaseResponse? {
  List<PharmacyModel> toDomain() {
    List<PharmacyModel> Pharmacy =
        (this?.data?.pharmacy?.map((response) => response.toDomain()) ??
                const Iterable.empty())
            .cast<PharmacyModel>()
            .toList();
    return Pharmacy;
  }
}

extension BrandResponseMapper on BrandResponse? {
  BrandModel toDomain() {
    return BrandModel(
      int.parse(this?.id ?? "0"),
      this?.title ?? Constants.empty,
      this?.phTitle ?? Constants.empty,
      this?.falg ?? Constants.zero,
      int.parse(this?.sampleCoast ?? "0"),
    );
  }
}

extension AllBrandResponseMapper on AllBrandBaseResponse? {
  List<BrandModel> toDomain() {
    List<BrandModel> Brand =
        (this?.data?.brands?.map((response) => response.toDomain()) ??
                const Iterable.empty())
            .cast<BrandModel>()
            .toList();
    return Brand;
  }
}

extension CityResponseMapper on CityResponse? {
  CityModel toDomain() {
    return CityModel(
      int.parse(this?.id ?? "0"),
      this?.name ?? Constants.empty,
    );
  }
}

extension AllCityResponseMapper on AllCityBaseResponse? {
  List<CityModel> toDomain() {
    List<CityModel> City =
        (this?.data?.city?.map((response) => response.toDomain()) ??
                const Iterable.empty())
            .cast<CityModel>()
            .toList();
    return City;
  }
}

extension LoginResponseMapper on LoginResponse? {
  LoginModel toDomain() {
    return LoginModel(
      int.parse(this?.data?.samplesCount ?? "0"),
      this?.data?.token ?? Constants.empty,
      int.parse(this?.data?.repId ?? "0"),
      int.parse(this?.data?.otherPlanId ?? "0"),
      int.parse(this?.data?.activePlanId ?? "0"),
      int.parse(this?.data?.otherStatus ?? "-1"),
      this?.data?.name ?? Constants.empty,
      this?.data?.percentage ?? Constants.zero,
      1,
      this?.data?.startDate ?? Constants.empty,
      this?.data?.endDate ?? Constants.empty,
      0,
      int.parse(this?.data?.recipesCount ?? "0"),
      UserInfo.flag1,
      int.parse(this?.data?.cityId ?? "0"),
      this?.data?.cityTitle ?? Constants.empty,
      this?.data?.repType ?? Constants.empty,
      otherEndDate: this?.data?.otherEndDate ?? Constants.empty,
      otherStartDate: this?.data?.otherStartDate ?? Constants.empty,
    );
  }
}

extension MedicalRepresentativeResponseMapper
    on AllMedicalRepresentativeBaseResponse? {
  List<CityModel> toDomain() {
    List<CityModel> City = (this
                ?.data
                ?.MedicalRepresentative
                ?.map((response) => response.toDomain()) ??
            const Iterable.empty())
        .cast<CityModel>()
        .toList();
    return City;
  }
}

extension AllDoctorResponseMapper on AllDoctorsBaseResponse? {
  List<DoctorModel> toDomain() {
    List<DoctorModel> doctorModel =
        (this?.data?.doctor?.map((response) => response.toDomain()) ??
                const Iterable.empty())
            .cast<DoctorModel>()
            .toList();
    return doctorModel;
  }
}

extension BrandResResponseMapper on BrandReResponse? {
  BrandRes toDomain() {
    var document = parse(this?.title_en ?? Constants.empty);
    String plainText = document.body!.text;
    return BrandRes(
      int.parse(this?.id ?? "0"),
      plainText,
    );
  }
}

extension AllBrandResResponseMapper on AllBrandResResponse? {
  List<BrandRes> toDomain() {
    List<BrandRes> brand =
        (this?.brandRes?.map((response) => response.toDomain()) ??
                const Iterable.empty())
            .cast<BrandRes>()
            .toList();
    return brand;
  }
}

extension HospitalResponseMapper on HospitalResponse? {
  HospitalModel toDomain() {
    return HospitalModel(
        int.parse(this?.id ?? "0"),
        this?.title ?? Constants.empty,
        int.parse(this?.placeId ?? "0"),
        this?.address ?? Constants.empty,
        this?.note ?? Constants.empty,
        this?.placeTitle ?? Constants.empty);
  }
}

extension PlanBrandMapper on PlanBrandResponse? {
  PlanBrandModel toDomain() {
    return PlanBrandModel(
      int.parse(this?.id ?? "0"),
      int.parse(this?.spId ?? "0"),
      int.parse(this?.brandId ?? "0"),
      int.parse(this?.repPlanId ?? "0"),
      Type.fromIntS(this?.brandType ?? Constants.empty),
      this?.title ?? Constants.empty,
      this?.amount ?? Constants.empty,
      this?.pharmaceuticalForm ?? Constants.empty,
    );
  }
}

extension RepBrandSpMapper on PlanBrandSpecResponse? {
  PlanBrandSp toDomain() {
    return PlanBrandSp(
      int.parse(this?.id ?? "0"),
      int.parse(this?.brandId ?? "0"),
      Type.fromIntS(this?.brandType),
      this?.titleAr ?? Constants.empty,
      int.parse(this?.spId ?? "0"),
      this?.phTitle ?? Constants.empty,
      int.parse(this?.totalAmount ?? "0"),
    );
  }
}

extension ActivePlanMapper on PlanBrandModel? {
  PlanBrandSp toDomain() {
    return PlanBrandSp(
      this?.id ?? Constants.zero,
      this?.brandId ?? Constants.zero,
      this?.brandType??Type.fromIntS(null),
      this?.title ?? Constants.empty,
      this?.spId ?? Constants.zero,
      "",
      int.parse(this?.amount ?? Constants.empty),
    );
  }
}

extension AllActivePlansMapper on List<PlanBrandModel>? {
  List<PlanBrandSp> toDomain() {
    List<PlanBrandSp> planBrands =
        (this?.map((response) => response.toDomain()) ?? const Iterable.empty())
            .cast<PlanBrandSp>()
            .toList();
    return planBrands;
  }
}

extension CurrentPlanMapper on PlanBrandSp? {
  PlanBrandModel toDomain(int planId) {
    return PlanBrandModel(
      this?.id ?? Constants.zero,
      this?.spId ?? Constants.zero,
      this?.brandId ?? Constants.zero,
      planId,
      this?.brandType??Type.fromIntS(null),
      this?.titleAr ?? Constants.empty,
      this?.totalAmount.toString() ?? Constants.empty,
      this?.phTitle ?? Constants.empty,
    );
  }
}

extension AllCurrentPlansMapper on List<PlanBrandSp>? {
  List<PlanBrandModel> toDomain(int planId) {
    List<PlanBrandModel> planBrands =
        (this?.map((response) => response.toDomain(planId)) ??
                const Iterable.empty())
            .cast<PlanBrandModel>()
            .toList();
    return planBrands;
  }
}

extension AllPlanBrandMapper on AllPlanBrandsBaseResponse? {
  List<PlanBrandModel> toDomain() {
    List<PlanBrandModel> planBrands =
        (this?.data?.planBrand?.map((response) => response.toDomain()) ??
                const Iterable.empty())
            .cast<PlanBrandModel>()
            .toList();
    return planBrands;
  }
}

extension BrandAmountMapper on BrandAmountResponse? {
  BrandAmountModel toDomain() {
    return BrandAmountModel(
      this?.totalSamplesDoctors ?? Constants.zero,
      this?.totalSamplesHospitals ?? Constants.zero,
      this?.totalSamplesDepartments ?? Constants.zero,
    );
  }
}

extension RepPlanBrandSpMapper on PlanBrandsBaseSpResponse? {
  AllPlanBrandSp toDomain() {
    if (this?.data == null) {
      return AllPlanBrandSp([], 0);
    }
    List<PlanBrandSp>? planBrands =
        (this?.data?.PlanBrands?.map((response) => response.toDomain()) ??
                const Iterable.empty())
            .cast<PlanBrandSp>()
            .toList();
    BrandAmountModel brand =
        this?.data!.Brands.toDomain() ?? BrandAmountModel(0, 0, 0);
    int sum = brand.numDoctor + brand.numHospital + brand.numDepartment;
    return AllPlanBrandSp(planBrands, sum);
  }
}

extension DoctorResponseMapper on DoctorResponse? {
  DoctorModel toDomain() {
    if (this?.note == null || this?.note == "" || this?.note == " ") {
      this?.note = Constants.empty;
    }
    return DoctorModel(
      int.parse(this?.id ?? "0"),
      this?.title ?? Constants.empty,
      int.parse(this?.placeId ?? "0"),
      this?.address ?? Constants.empty,
      this?.placeTitle ?? Constants.empty,
      int.parse(this?.visits ?? "0"),
      this?.note ?? Constants.empty,
      this?.rate ?? Constants.empty,
      this?.spTitle ?? Constants.empty,
      int.parse(this?.spId ?? "0"),
      this?.workHours ?? Constants.empty,
    );
  }
}

extension AllHospitalResponseMapper on AllHospitalBaseResponse? {
  List<HospitalModel> toDomain() {
    List<HospitalModel> doctorModel =
        (this?.data?.hospital?.map((response) => response.toDomain()) ??
                const Iterable.empty())
            .cast<HospitalModel>()
            .toList();
    return doctorModel;
  }
}

extension HospitalSpResponseMapper on HospitalSpResponse? {
  HospitalSpModel toDomain() {
    return HospitalSpModel(
      int.parse(this?.id ?? "0"),
      int.parse(this?.hospitalId ?? "0"),
      int.parse(this?.spId ?? "0"),
      int.parse(this?.totalDocs ?? "0"),
      this?.rate ?? Constants.empty,
      int.parse(this?.visit ?? "0"),
      0,
      address: this?.address ?? Constants.empty,
      title: this?.title ?? Constants.empty,
      placeTitle: this?.place ?? Constants.empty,
      SpName: this?.spTitle ?? Constants.empty,
      note: this?.note ?? Constants.empty,
    );
  }
}

extension VisitDoctorModelMapper on VisitDoctorModel? {
  VisitDoctorRequest toDomain() {
    return VisitDoctorRequest(
      (this?.id ?? Constants.zero).toString(),
      (this?.data ?? Constants.zero).toString(),
      (this?.kaswn ?? Constants.zero).toString(),
      (this?.science ?? Constants.zero).toString(),
      (this?.additaion ?? Constants.zero).toString(),
      (this?.doctorId ?? Constants.zero).toString(),
      UserInfo.activePlanId.toString(),
      UserInfo.repId.toString(),
      0,
      (this?.target ?? Constants.zero).toString(),
    );
  }
}

extension VisitDoctorResponseMapper on VisitResponse? {
  VisitDoctorModel toDomain() {
    return VisitDoctorModel(
      int.parse((this?.id ?? "0")),
      (this?.visitDate ?? Constants.zero).toString(),
      (this?.issue ?? Constants.zero).toString(),
      (this?.note ?? Constants.zero).toString(),
      (this?.special ?? Constants.zero).toString(),
      int.parse((this?.docId ?? "0")),
      1,
      (this?.target ?? Constants.zero).toString(),
    );
  }
}

extension VisitHospitalResponseMapper on VisitHosResponse? {
  VisitHospitalModel toDomain() {
    return VisitHospitalModel(
      int.parse((this?.id ?? "0")),
      (this?.visitDate ?? Constants.zero).toString(),
      (this?.issue ?? Constants.zero).toString(),
      (this?.note ?? Constants.zero).toString(),
      (this?.special ?? Constants.zero).toString(),
      int.parse((this?.docId ?? "0")),
      1,
      (this?.target ?? Constants.zero).toString(),
    );
  }
}

extension VisitDoctorBrandResponseMapper on VisitBrandPharmacyResponse? {
  VisitBrandPharmacyModel toDomain() {
    return VisitBrandPharmacyModel(
        int.parse((this?.id ?? "0")),
        int.parse((this?.visitId ?? "0")),
        int.parse((this?.brandId ?? "0")),
        int.parse((this?.amount ?? "0")),
        1);
  }
}

extension BrandRecipesResponseMapper on BrandRecipesResponse? {
  BrandRes toDomain() {
    return BrandRes(
      this?.id ?? Constants.zero,
      this?.title_en ?? Constants.empty,
    );
  }
}

extension VisitDoctorBrandsResponseMapper on VisitDoctorBrandResponse? {
  List<VisitBrandPharmacyModel>? toDomain() {
    List<VisitBrandPharmacyModel>? doctorVisitModel =
        (this?.brand!.map((response) => response.toDomain()) ??
                const Iterable.empty())
            .cast<VisitBrandPharmacyModel>()
            .toList();
    return doctorVisitModel;
  }
}

extension AllHospitalSpResponseMapper on AllHospitalSpBaseResponse? {
  List<HospitalSpModel> toDomain() {
    List<HospitalSpModel> hospitalSpModel =
        (this?.data?.HospitalSp?.map((response) => response.toDomain()) ??
                const Iterable.empty())
            .cast<HospitalSpModel>()
            .toList();
    return hospitalSpModel;
  }
}

extension visitHospitalBrandResponseMapper on VisitHospitalBaseResponse? {
  VisitHospitalBase toDomain() {
    return VisitHospitalBase(
        this?.brandsVisit.toDomain() ?? [], this?.data.toDomain() ?? []);
  }
}

extension visitDoctorResponseMapper on VisitDoctorResponse? {
  List<VisitDoctorModel>? toDomain() {
    List<VisitDoctorModel>? doctorVisitModel =
        (this?.visitDoctor?.map((response) => response.toDomain()) ??
                const Iterable.empty())
            .cast<VisitDoctorModel>()
            .toList();
    return doctorVisitModel;
  }
}

extension getVisitHospitalResponseMapper on VisitHospitalResponse? {
  List<VisitHospitalModel>? toDomain() {
    List<VisitHospitalModel>? doctorVisitModel =
        (this?.visitHospital?.map((response) => response.toDomain()) ??
                const Iterable.empty())
            .cast<VisitHospitalModel>()
            .toList();
    return doctorVisitModel;
  }
}

extension visitDoctorBrandResponseMapper on VisitDoctorBaseResponse? {
  VisitDoctorBase toDomain() {
    return VisitDoctorBase(
        this?.brandsVisit.toDomain() ?? [], this?.data.toDomain() ?? []);
  }
}

extension DoctorInfoResponseMapper on InfoDoctorBaseResponse? {
  DoctorModel toDomain() {
    return DoctorModel(
      int.parse(this?.data?.id ?? "0"),
      this?.data?.title ?? Constants.empty,
      int.parse(this?.data?.placeId ?? "0"),
      this?.data?.address ?? Constants.empty,
      this?.data?.placeTitle ?? Constants.empty,
      int.parse(this?.data?.visits ?? "0"),
      this?.data?.note ?? Constants.empty,
      this?.data?.rate ?? Constants.empty,
      this?.data?.spTitle ?? Constants.empty,
      int.parse(this?.data?.spId ?? "0"),
      this?.data?.workHours ?? Constants.empty,
    );
  }
}

extension CopyRecResponseMapper on CopyRecResponse {
  CopyReciRequest toDomain() {
    return CopyReciRequest(
      int.parse(this.recip?.id ?? "0"),
      int.parse(this.recip?.repId ?? "0"),
      int.parse(this.recip?.type ?? "0"),
      int.parse(this.recip?.docId ?? "0"),
      this.recip?.spName ?? Constants.empty,
      this.recip!.brand_1.toDomain(),
      this.recip?.address ?? Constants.empty,
      this.recip?.phone ?? Constants.empty,
      this.recip?.total ?? Constants.empty,
      this.recip?.create_date ?? Constants.empty,
      this.recip?.print_date ?? Constants.empty,
      note1: this.recip?.note1 ?? Constants.empty,
      note2: this.recip?.note2 ?? Constants.empty,
      note_emp: this.recip?.note_emp ?? Constants.empty,
      image1: this.recip?.image1 == "" ? null : this.recip?.image1,
      image2: this.recip?.image2 == "" ? null : this.recip?.image2,
      brand_2: this.recip?.brand_2.toDomain(),
      brand_3: this.recip?.brand_3.toDomain(),
      brand_4: this.recip?.brand_4.toDomain(),
    );
  }
}

extension VisitNotesMapper on VisitNotesResponse? {
  DoctorNoteModel toDomain() {
    return DoctorNoteModel(
      this?.docTitle ?? Constants.empty,
      this?.spTitle ?? Constants.empty,
      this?.address ?? Constants.empty,
      this?.visitDate ?? Constants.empty,
      this?.note ?? Constants.empty,
    );
  }
}

extension AllVisitNotesMapper on AllVisitNotesBaseResponse? {
  List<DoctorNoteModel> toDomain() {
    List<DoctorNoteModel> visitNotes =
        (this?.data?.notes?.map((response) => response.toDomain()) ??
                const Iterable.empty())
            .cast<DoctorNoteModel>()
            .toList();
    return visitNotes;
  }
}

//
extension VisitIssueMapper on VisitIssueResponse? {
  DoctorIssueModel toDomain() {
    return DoctorIssueModel(
      this?.docTitle ?? Constants.empty,
      this?.spTitle ?? Constants.empty,
      this?.address ?? Constants.empty,
      this?.visitDate ?? Constants.empty,
      this?.issue ?? Constants.empty,
    );
  }
}

//
extension InventoryMapper on InventoryResponse? {
  InventoryModel toDomain() {
    return InventoryModel(
        this?.title ?? Constants.empty,
        this?.used ?? Constants.empty,
        this?.total ?? Constants.empty,
        this?.rest ?? Constants.zero,
        Type.fromIntS(this?.type ?? Constants.empty));
  }
}

extension AllInventoryMapper on InventoryResponseBaseResponse? {
  List<InventoryModel> toDomain() {
    List<InventoryModel> Inventory =
        (this?.brand?.map((response) => response.toDomain()) ??
                const Iterable.empty())
            .cast<InventoryModel>()
            .toList();
    return Inventory;
  }
}

//

extension AllVisitIssueMapper on AllVisitIssueBaseResponse? {
  List<DoctorIssueModel> toDomain() {
    List<DoctorIssueModel> visitIssue =
        (this?.data?.notes?.map((response) => response.toDomain()) ??
                const Iterable.empty())
            .cast<DoctorIssueModel>()
            .toList();
    return visitIssue;
  }
}
//

extension NoVisitDocMapper on NoVisitDoctorResponse? {
  NoVisitDocModel toDomain() {
    return NoVisitDocModel(
      this?.docTitle ?? Constants.empty,
      this?.spTitle ?? Constants.empty,
      this?.address ?? Constants.empty,
      this?.rate ?? Constants.empty,
      this?.visits ?? Constants.empty,
      this?.remainingVisits ?? Constants.zero,
      this?.doneVisits ?? Constants.empty,
    );
  }
}

extension ReciMapper on ReciResponse? {
  ReciModel toDomain() {
    return ReciModel(
        this?.id ?? Constants.empty,
        this?.docName ?? Constants.empty,
        this?.create_date ?? Constants.empty,
        this?.total ?? Constants.empty,
        this?.note_emp ?? Constants.empty,
        this?.docId ?? Constants.empty,
        this?.recipeType ?? Constants.empty);
  }
}

extension AllReciMapper on AllReciBaseResponse? {
  List<ReciModel> toDomain() {
    List<ReciModel> visitNotes =
        (this?.data?.reci.map((response) => response.toDomain()) ??
                const Iterable.empty())
            .cast<ReciModel>()
            .toList();
    return visitNotes;
  }
}

extension AllNoVisitDocMapper on AllNoVisitDoctorBaseResponse? {
  List<NoVisitDocModel> toDomain() {
    List<NoVisitDocModel> visitNotes =
        (this?.data?.res?.map((response) => response.toDomain()) ??
                const Iterable.empty())
            .cast<NoVisitDocModel>()
            .toList();
    return visitNotes;
  }
}

extension SearchDocMapper on SearchDoctorsJsonResponse? {
  doctorsModel toDomain() {
    return doctorsModel(
      int.parse(this?.id ?? "0"),
      this?.name ?? Constants.empty,
      this?.spTitle ?? Constants.empty,
      this?.placeTitle ?? Constants.empty,
    );
  }
}

extension SearchDoctorsMapper on SearchDoctorsBaseSpResponse? {
  List<doctorsModel> toDomain() {
    List<doctorsModel> doctors =
        (this?.data?.Representative?.map((response) => response.toDomain()) ??
                const Iterable.empty())
            .cast<doctorsModel>()
            .toList();
    return doctors;
  }
}

extension DocDoctorsMapper on DocDoctorsJsonResponse? {
  DocdoctorsModel toDomain() {
    return DocdoctorsModel(
      this?.repName ?? Constants.empty,
      this?.visitDate ?? Constants.empty,
      this?.issue ?? Constants.empty,
      this?.note ?? Constants.empty,
    );
  }
}

extension DocDoctorBaseMapper on DocDoctorsBaseResponse? {
  List<DocdoctorsModel> toDomain() {
    List<DocdoctorsModel> doctors =
        (this?.data?.Representative?.map((response) => response.toDomain()) ??
                const Iterable.empty())
            .cast<DocdoctorsModel>()
            .toList();
    return doctors;
  }
}

extension PalnSpMapper on SpecializationPlanResponse? {
  SpecPlan toDomain() {
    return SpecPlan(
      this?.name.toString() ?? Constants.empty,
      this?.amount ?? Constants.empty,
    );
  }
}

extension ActivePlanBrandMapper on ActiveBrandPlanResponse? {
  ActivePlanBrandModel toDomain() {
    List<SpecPlan> specPlans =
        (this?.specializations?.map((response) => response.toDomain()) ??
                const Iterable.empty())
            .cast<SpecPlan>()
            .toList();
    return ActivePlanBrandModel(
      specPlans,
      Type.fromName(this?.type.toString() ?? Constants.empty),
      this?.title ?? Constants.empty,
      this?.pharmaceuticalFormTitle ?? Constants.empty,
    );
  }
}

extension ActivePlanBrandBaseMapper on ActiveBrandPlanBaseResponse? {
  List<ActivePlanBrandModel> toDomain() {
    List<ActivePlanBrandModel> activePlanBrands =
        (this?.data.map((response) => response.toDomain()) ??
                const Iterable.empty())
            .cast<ActivePlanBrandModel>()
            .toList();
    return activePlanBrands;
  }
}

extension SeniorByCityidjsonMapper on SeniorByCityidBaseResponse? {
  List<SeniorCityModel> toDomain() {
    List<SeniorCityModel> data =
        (this?.data?.map((response) => response.toDomain()) ??
                const Iterable.empty())
            .cast<SeniorCityModel>()
            .toList();
    return data;
  }
}

extension SeniorByCityidMapper on SeniorByCityidResponse? {
  SeniorCityModel toDomain() {
    return SeniorCityModel(
      this?.rep_id ?? Constants.empty,
      this?.rep_name ?? Constants.empty,
      this?.city_id ?? Constants.empty,
      this?.city_name ?? Constants.empty,
    );
  }
}

extension AllRepresentativeFutureMapper
    on AllRepresentativeFutureBaseResponse? {
  List<AllRepresentativeFuture> toDomain() {
    List<AllRepresentativeFuture> allRepresentative =
        (this?.data?.data?.map((response) => response.toDomain()) ??
                const Iterable.empty())
            .cast<AllRepresentativeFuture>()
            .toList();
    return allRepresentative;
  }
}

extension RepresentativeFutureMapper on RepresentativeFutureResponse? {
  AllRepresentativeFuture toDomain() {
    return AllRepresentativeFuture(
      int.parse(this?.id ?? "0"),
      this?.name ?? Constants.empty,
      FlagModel(int.parse(this?.flag ?? "0")),
      int.parse(this?.futurePlan ?? "0"),
      int.parse(this?.samplesCount ?? "0"),
      this?.reptype ?? Constants.empty,
    );
  }
}

extension AllSearchHospitalMapper on AllSearchHospitalBaseResponse? {
  List<SearchHospitalModel> toDomain() {
    List<SearchHospitalModel> allSearchHospital = (this
                ?.allSearchHospitalResponse
                .searchHospital
                .map((response) => response.toDomain()) ??
            const Iterable.empty())
        .cast<SearchHospitalModel>()
        .toList();
    return allSearchHospital;
  }
}

extension SearchHospitalMapper on SearchHospitalResponse? {
  SearchHospitalModel toDomain() {
    return SearchHospitalModel(
      this?.hosId ?? Constants.empty,
      this?.name ?? Constants.empty,
      this?.spId ?? Constants.empty,
    );
  }
}

extension AllSearchHospitalNoteMapper on AllSearchHospitalNoteBaseResponse? {
  List<SearchHospitalNoteModel> toDomain() {
    List<SearchHospitalNoteModel> allSearchHospital = (this
                ?.allSearchHospitalNoteResponse
                .searchHospitalNote
                .map((response) => response.toDomain()) ??
            const Iterable.empty())
        .cast<SearchHospitalNoteModel>()
        .toList();
    return allSearchHospital;
  }
}

extension SearchHospitalNoteMapper on SearchHospitalNoteResponse? {
  SearchHospitalNoteModel toDomain() {
    return SearchHospitalNoteModel(
      this?.hosId ?? Constants.empty,
      this?.name ?? Constants.empty,
      this?.spId ?? Constants.empty,
      this?.note ?? Constants.empty,
      this?.issue ?? Constants.empty,
      this?.visitDate ?? Constants.empty,
    );
  }
}

extension AllReadMapper on AllReadResponse? {
  List<WhoReadModel> toDomain() {
    List<WhoReadModel> whoReadModel =
        (this?.readResponse?.map((response) => response.toDomain()) ??
                const Iterable.empty())
            .cast<WhoReadModel>()
            .toList();
    return whoReadModel;
  }
}

extension WhoReadMapper on ReadResponse? {
  WhoReadModel toDomain() {
    return WhoReadModel(
      this?.userId ?? Constants.empty,
      this?.name ?? Constants.empty,
      this?.repType ?? Constants.empty,
      this?.role ?? Constants.empty,
    );
  }
}

extension FinishedPlansMapper on FinishedPlansBaseResponse? {
  List<FinishedPlanModel> toDomain() {
    List<FinishedPlanModel> plans =
        (this?.plans?.map((response) => response.toDomain()) ??
                const Iterable.empty())
            .cast<FinishedPlanModel>()
            .toList();
    return plans;
  }
}

extension FinishedPlanMapper on FinishedPlanResponse? {
  FinishedPlanModel toDomain() {
    return FinishedPlanModel(
      this?.id ?? Constants.empty,
      this?.cityId ?? Constants.empty,
      this?.startDate ?? Constants.empty,
      this?.endDate ?? Constants.empty,
      this?.active ?? Constants.empty,
    );
  }
}

extension PlanRepsMapper on PlanRepsResponse? {
  PlanRepsModel toDomain() {
    return PlanRepsModel(
      this?.id ?? Constants.empty,
      this?.name ?? Constants.empty,
      this?.repPlan ?? Constants.empty,
    );
  }
}

extension PlanRepsBaseMapper on PlanRepsBaseResponse? {
  List<PlanRepsModel> toDomain() {
    List<PlanRepsModel> rep =
        (this?.rep?.map((response) => response.toDomain()) ??
                const Iterable.empty())
            .cast<PlanRepsModel>()
            .toList();
    return rep;
  }
}
