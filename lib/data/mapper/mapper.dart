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
        int.parse(this?.data.otherstatus ?? "4"));
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
    return SpecDModel(
        int.parse(this?.id ?? "0"), this?.title ?? Constants.empty, 0, 0, 0);
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

extension MedicalVisitsResponseMapper on MedicalVisitsResponse? {
  MedicalVisits toDomain() {
    return MedicalVisits(
        int.parse(this?.visID ?? "0"),
        this?.visitDate ?? Constants.empty,
        this?.title ?? Constants.empty,
        this?.address ?? Constants.empty,
        (this?.issue ?? Constants.zero).toString(),
        (this?.note ?? Constants.zero).toString(),
        this?.spTitle ?? Constants.empty,
        this?.special ?? Constants.empty,
        this?.brands ?? Constants.empty);
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
      int.parse(this?.data?.otherStatus ?? "0"),
      this?.data?.name ?? Constants.empty,
      this?.data?.percentage ?? Constants.zero,
      1,
      this?.data?.startDate ?? Constants.empty,
      this?.data?.endDate ?? Constants.empty,
      0,
      int.parse(this?.data?.recipesCount ?? "0"),
      0,
      otherEndDate: this?.data?.otherEndDate ?? Constants.empty,
      otherStartDate: this?.data?.otherStartDate ?? Constants.empty,
    );
  }
}

extension AllMedicalVisitsResponseMapper on AllMedicalVisitBaseResponse? {
  List<MedicalVisits> toDomain() {
    List<MedicalVisits> medicalVisits =
        (this?.data?.medicalVisits?.map((response) => response.toDomain()) ??
                const Iterable.empty())
            .cast<MedicalVisits>()
            .toList();
    return medicalVisits;
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
      this?.brandType ?? Constants.empty,
      this?.amount ?? Constants.empty,
    );
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
        0);
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



extension CopyRecResponseMapper on CopyRecResponse {
  CopyReciRequest toDomain() {
    return CopyReciRequest(
      int.parse(this?.recip?.id ?? "0"),
      int.parse(this?.recip?.repId ?? "0"),
      int.parse(this?.recip?.type ?? "0"),
      int.parse(this?.recip?.docId ?? "0"),
      this.recip?.spName ?? Constants.empty,
      int.parse(this?.recip?.brand_1 ?? "0"),
      this.recip?.address ?? Constants.empty,
      this.recip?.phone ?? Constants.empty,
      this.recip?.total ?? Constants.empty,
      note1: this.recip?.note1?? Constants.empty,
      note2:this.recip?.note2?? Constants.empty,
      note_emp: this.recip?.note_emp?? Constants.empty,
      image1: this.recip?.image1?? Constants.empty,
      image2: this.recip?.image2?? Constants.empty,
      brand_2: this.recip?.brand_2?? Constants.empty,
      brand_3: this.recip?.brand_3?? Constants.empty,
      brand_4: this.recip?.brand_4?? Constants.empty,









    );

  }
}