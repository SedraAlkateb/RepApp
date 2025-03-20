import 'package:domina_app/app/di.dart';
import 'package:domina_app/presentation/async/pages/async_login_page.dart';
import 'package:domina_app/presentation/brand_plan/pages/brand_plan_page.dart';
import 'package:domina_app/presentation/senior/plan_review/page/rep_plan_brand_sp.dart';
import 'package:domina_app/presentation/senior/manage_future/page/all_rep_with_future.dart';
import 'package:domina_app/presentation/senior/places/pages/all_rep_senior.dart';
import 'package:domina_app/presentation/senior/edit_brand_plan/page/auditing_plan.dart';
import 'package:domina_app/presentation/senior/representative/page/all_brand.dart';
import 'package:domina_app/presentation/senior/representative/page/doctor_senioir.dart';
import 'package:domina_app/presentation/senior/representative/page/hos_senior.dart';
import 'package:domina_app/presentation/senior/representative/page/no_visit_doctor.dart';
import 'package:domina_app/presentation/senior/representative/page/place_senior.dart';
import 'package:domina_app/presentation/senior/representative/page/rep_profile.dart';
import 'package:domina_app/presentation/senior/representative/page/sen_visit_doctor.dart';
import 'package:domina_app/presentation/senior/representative/page/spec_senior.dart';
import 'package:domina_app/presentation/uniti/animation/curve%20.dart';
import 'package:domina_app/presentation/upload_delete/page/async_logout_page.dart';
import 'package:domina_app/presentation/upload_delete//page/async_page.dart';
import 'package:domina_app/presentation/delete/page/delete_logout_page.dart';
import 'package:domina_app/presentation/delete/page/delete_page.dart';
import 'package:domina_app/presentation/auth/pages/loginUser.dart';
import 'package:domina_app/presentation/doctors/pages/doctors.dart';
import 'package:domina_app/presentation/hospitals/page/hospital.dart';
import 'package:domina_app/presentation/brand/pages/brand_page.dart';
import 'package:domina_app/presentation/pharmacy/pages/pharmacy_page.dart';
import 'package:domina_app/presentation/places/pages/places.dart';
import 'package:domina_app/presentation/plase_visit/pages/place_visit_page.dart';
import 'package:domina_app/presentation/resources/strings_manager.dart';
import 'package:domina_app/presentation/specialization/pages/spec.dart';
import 'package:domina_app/presentation/specialization/pages/spec_d_h.dart';
import 'package:domina_app/presentation/visits/pages/visits_page.dart';
import 'package:flutter/material.dart';
import '../Recipes/pages/Recipes.dart';

class Routes {
  static const String login = "/login";
  static const String places = "/Places";
  static const String spec = "/spec";
  static const String doctors = "/doctors";
  static const String hospital = "/hospital";
  static const String brand = "/brand";
  static const String pharmacy = "/pharmacy";
  static const String syncData = "/syncData";
  static const String placeVisit = "/placeVisit";
  static const String visitPharmacy = "/visitPharmacy";
  static const String visits = "/visits";
  static const String asyncIn = "/asyncIn";
  static const String specDH = "/specDH";
  static const String logout = "/logout";
  static const String brandPlan = "/brandPlan";
  static const String delete = "/delete";
  static const String deleteLogout = "/deleteLogout";
  static const String Recipes = "/Recipes";
  static const String fadeInWidget = "/fadeInWidget";
  static const String AllRepSenior = "/AllRepSenior";
  static const String repProfile = "/RepProfile";
  static const String seniorPlaces = "/seniorPlaces";
  static const String seniorSpec = "/seniorSpec";
  static const String seniorHos = "/seniorHos";
  static const String seniorDoc = "/seniorDoc";
  static const String allBrand = "/allBrand";
  static const String noVisitDoctor = "/noVisitDoctor";
  static const String senVisitDoctor = "/senVisitDoctor";
  static const String AuditingPlan = "/AuditingPlan";
  static const String RepPlanBrandSp = "/RepPlanBrandSp";
  static const String manageFuture = "/manageFuture";
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.login:
        initLoginModule();
        return MaterialPageRoute(builder: (_) => const MyLogin());
      case Routes.allBrand:
        return MaterialPageRoute(builder: (_) => AllBrand());
      case Routes.fadeInWidget:
        return MaterialPageRoute(builder: (_) => FadeInWidget());
      case Routes.places:
        initPlacesModule();
        initPlaceVisitModule();
        return MaterialPageRoute(builder: (_) => Places());
      case Routes.spec:
        initSpecModule();
        return MaterialPageRoute(builder: (_) => SpecializationsPage());
      case Routes.doctors:
        initDoctorModule();
        return MaterialPageRoute(builder: (_) => Doctors());
      case Routes.hospital:
        initHospitalModule();
        return MaterialPageRoute(builder: (_) => Hospital());
      case Routes.brand:
        initBrandModule();
        return MaterialPageRoute(builder: (_) => BrandPage());
      case Routes.pharmacy:
        initPharmacyModule();
        return MaterialPageRoute(builder: (_) => PharmacyPage());

      case Routes.syncData:
        initAsyncModule();
        return MaterialPageRoute(builder: (_) => AsyncLoginPage());
      case Routes.visits:
        initVisitsModule();
        return MaterialPageRoute(builder: (_) => VisitsPage());
      case Routes.asyncIn:
        initAsyncInModule();
        return MaterialPageRoute(builder: (_) => AsyncPage());
      case Routes.logout:
        initAsyncInModule();
        return MaterialPageRoute(builder: (_) => AsyncLogoutPage());
      case Routes.placeVisit:
        return MaterialPageRoute(builder: (_) => PlaceVisitPage(placeId: 2));
      case Routes.specDH:
        return MaterialPageRoute(builder: (_) => SpecDH(spId: 0));
      case Routes.brandPlan:
        initBrandPlanModule();
        return MaterialPageRoute(builder: (_) => BrandPlanPage());
      case Routes.delete:
        initDeleteModule();
        return MaterialPageRoute(builder: (_) => DeletePage());

      case Routes.Recipes:
        initBrandRecModule();
        return MaterialPageRoute(
            builder: (_) => RecipesPage(
                  docId: 0,
                  st: 433,
                ));
      case Routes.repProfile:
        initSeniorProfModule();
        return MaterialPageRoute(
            builder: (_) => RepProfile(
                  id: 3,
                  repPlanId: 3,
                  index: 3,
                ));
      case Routes.AllRepSenior:
        initSeniorModule();
        return MaterialPageRoute(builder: (_) => AllRepSenior());

      case Routes.seniorPlaces:
        return MaterialPageRoute(builder: (_) => PlaceSenior());
      case Routes.seniorSpec:
        return MaterialPageRoute(builder: (_) => SpecSeniorPage());
      case Routes.seniorHos:
        return MaterialPageRoute(builder: (_) => HospitalSenior());
      case Routes.manageFuture:
        initSeniorManageFutureModule();
        return MaterialPageRoute(builder: (_) => AllRepWithFuture());
      case Routes.seniorDoc:
        return MaterialPageRoute(builder: (_) => DoctorSenior());
      // case Routes.seniorNoteDoc:
      //   return MaterialPageRoute(builder: (_) => NoteDoctor());
      case Routes.noVisitDoctor:
        return MaterialPageRoute(builder: (_) => NoVisitDoctor());
      case Routes.senVisitDoctor:
        return MaterialPageRoute(builder: (_) => SenVisitDoctor());
      case Routes.AuditingPlan:
        iniEditBrandPlanModule();
        return MaterialPageRoute(builder: (_) {
          return AuditingPlan( repPlan: 7,);
        });
      case Routes.RepPlanBrandSp:
        iniFutureModule();
        final args = settings.arguments as Map<String, dynamic>?;
        final title = args?['title'];

        return MaterialPageRoute(builder: (_) {
          return RepPlanBrandSpPage(title: title);
        });
      case Routes.deleteLogout:
        initDeleteModule();
        return MaterialPageRoute(builder: (_) => DeleteLogoutPage());
      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
        builder: (_) => Scaffold(
              appBar: AppBar(
                title: const Text(
                    StringsManager.noRouteFound), // string to strings manager
              ),
              body: const Center(
                  child: Text(
                      StringsManager.noRouteFound)), //string to strings manager
            ));
  }
}
