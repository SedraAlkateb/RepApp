
import 'package:domina_app/app/constants.dart';
import 'package:domina_app/app/user_info.dart';
import 'package:domina_app/data/responses/responses.dart';
import 'package:domina_app/domain/models/models.dart';

extension VisitPharmacyRequestMapper on VisitPharmacyModel? {
  VisitPharmacyRequest toDomain() {
    return VisitPharmacyRequest(
        this?.id.toString() ?? Constants.empty,
        UserInfo.planId.toString(),
        UserInfo.repId.toString(),
        this!.pharmacyId.toString(),
        this?.data?? Constants.empty,
        this?.note?? Constants.empty,
    );
  }
}
extension ListVisitPharmacyRequestMapper on List<VisitPharmacyModel>? {
  List<VisitPharmacyRequest> toDomain() {
    List<VisitPharmacyRequest> visitPharmacyRequest =(this?.map((response) => response.toDomain()) ??
        const Iterable.empty())
        .cast<VisitPharmacyRequest>()
        .toList();
    return visitPharmacyRequest;
  }
}
extension AllPlaceResponseMapper on AllPlaceBaseResponse? {
  List<PlaceModel> toDomain() {
    List<PlaceModel> places =(this?.data?.places?.map((response) => response.toDomain()) ??
        const Iterable.empty())
        .cast<PlaceModel>()
        .toList();
    return places;
  }
}

extension PlaceResponseMapper on PlaceResponse? {
  PlaceModel toDomain() {
    return PlaceModel(
      int.parse(this?.id ?? "0") ,
      this?.title ?? Constants.empty,
    );
  }
}
extension SpecResponseMapper on SpecResponse? {
  SpecModel toDomain() {
    return SpecModel(
      int.parse(this?.id ?? "0") ,
      this?.title ?? Constants.empty,
    );
  }
}

extension AllSpecResponseMapper on AllSpcBaseResponse? {
  List<SpecModel> toDomain() {
    List<SpecModel> spec =(this?.data?.specializations?.map((response) => response.toDomain()) ??
        const Iterable.empty())
        .cast<SpecModel>()
        .toList();
    return spec;
  }
}

extension PharmacyResponseMapper on PharmacyResponse? {
  PharmacyModel toDomain() {
    return PharmacyModel(
      int.parse(this?.id ?? "0") ,
      this?.title ?? Constants.empty,
      int.parse(this?.placeId ?? "0") ,
      this?.address ?? Constants.empty,

    );
  }
}
extension AllPharmacyResponseMapper on AllPharmacyBaseResponse? {
  List<PharmacyModel> toDomain() {
    List<PharmacyModel> Pharmacy =(this?.data?.pharmacy?.map((response) => response.toDomain()) ??
        const Iterable.empty())
        .cast<PharmacyModel>()
        .toList();
    return Pharmacy;
  }
}

extension BrandResponseMapper on BrandResponse? {
  BrandModel toDomain() {
    return BrandModel(
      int.parse(this?.id ?? "0") ,
      this?.title ?? Constants.empty,
      this?.phTitle ?? Constants.empty,
      this?.falg ?? Constants.zero,
      int.parse(this?.sampleCoast ?? "0") ,
    );
  }
}
extension AllBrandResponseMapper on AllBrandBaseResponse? {
  List<BrandModel> toDomain() {
    List<BrandModel> Brand =(this?.data?.brands?.map((response) => response.toDomain()) ??
        const Iterable.empty())
        .cast<BrandModel>()
        .toList();
    return Brand;
  }
}

extension CityResponseMapper on CityResponse? {
  CityModel toDomain() {
    return CityModel(
      int.parse(this?.id ?? "0") ,
      this?.name ?? Constants.empty,
    );
  }
}
extension AllCityResponseMapper on AllCityBaseResponse? {
  List<CityModel> toDomain() {
    List<CityModel> City =(this?.data?.city?.map((response) => response.toDomain()) ??
        const Iterable.empty())
        .cast<CityModel>()
        .toList();
    return City;
  }
}

extension MedicalVisitsResponseMapper on MedicalVisitsResponse? {
  MedicalVisits toDomain() {
    return MedicalVisits(
        int.parse(this?.visID ?? "0") ,
      this?.visitDate ?? Constants.empty,
      this?.title ?? Constants.empty,
      this?.address ?? Constants.empty,
      this?.note ?? Constants.empty,
      this?.issue ?? Constants.empty,
      this?.spTitle ?? Constants.empty,
      this?.special ?? Constants.empty,
      this?.brands ?? Constants.empty
    );

  }
}

extension LoginResponseMapper on LoginResponse? {
  LoginModel toDomain() {
    return LoginModel(
        this?.data?.token ?? Constants.empty,
        int.parse(this?.data?.repId ?? "0") ,
        this?.data?.planId ?? Constants.zero,
      this?.data?.name ?? Constants.empty,
      this?.data?.percentage ?? Constants.zero,
      1
    );
  }
}
extension AllMedicalVisitsResponseMapper on AllMedicalVisitBaseResponse? {
  List<MedicalVisits> toDomain() {
    List<MedicalVisits> medicalVisits =(this?.data?.medicalVisits?.map((response) => response.toDomain()) ??
        const Iterable.empty())
        .cast<MedicalVisits>()
        .toList();
    return medicalVisits;
  }
}

extension MedicalRepresentativeResponseMapper on AllMedicalRepresentativeBaseResponse? {
  List<CityModel> toDomain() {
    List<CityModel> City =(this?.data?.MedicalRepresentative?.map((response) => response.toDomain()) ??
        const Iterable.empty())
        .cast<CityModel>()
        .toList();
    return City;
  }
}

extension AllDoctorResponseMapper on AllDoctorsBaseResponse? {
  List<DoctorModel> toDomain() {
    List<DoctorModel> doctorModel =(this?.data?.doctor?.map((response) => response.toDomain()) ??
        const Iterable.empty())
        .cast<DoctorModel>()
        .toList();
    return doctorModel;
  }
}
extension HospitalResponseMapper on HospitalResponse? {
  HospitalModel toDomain() {
    return HospitalModel(
      int.parse(this?.id ?? "0"),
      this?.title ?? Constants.empty,
      int.parse(this?.placeId ?? "0") ,
      this?.address ?? Constants.empty,
      this?.placeTitle ?? Constants.empty,
    );

  }
}


extension DoctorResponseMapper on DoctorResponse? {
 DoctorModel toDomain() {
    return DoctorModel(
      int.parse(this?.id ?? "0"),
      this?.title ?? Constants.empty,
      int.parse(this?.placeId ?? "0") ,
      this?.address ?? Constants.empty,
      this?.placeTitle ?? Constants.empty,
      this?.visits ?? Constants.empty,
      this?.spTitle ?? Constants.empty,      int.parse(this?.spId ?? "0") ,
    );

  }
}
extension AllHospitalResponseMapper on AllHospitalBaseResponse? {
  List<HospitalModel> toDomain() {
    List<HospitalModel> doctorModel =(this?.data?.hospital?.map((response) => response.toDomain()) ??
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
      int.parse(this?.hospitalId ?? "0") ,
      int.parse(this?.spId ?? "0") ,
      int.parse(this?.totalDocs ?? "0") ,
      this?.rate ?? Constants.empty,
      int.parse(this?.visit ?? "0") ,
    );

  }
}
extension AllHospitalSpResponseMapper on AllHospitalSpBaseResponse? {
  List<HospitalSpModel> toDomain() {
    List<HospitalSpModel> hospitalSpModel =(this?.data?.HospitalSp?.map((response) => response.toDomain()) ??
        const Iterable.empty())
        .cast<HospitalSpModel>()
        .toList();
    return hospitalSpModel;
  }
}
