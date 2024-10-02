import 'package:domina_app/app/di.dart';
import 'package:domina_app/presentation/async/pages/async_login_page.dart';
import 'package:domina_app/presentation/async_in/page/async_page.dart';
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

}
class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.login:
        initLoginModule();
        return MaterialPageRoute(builder: (_) =>    const MyLogin());
      case Routes.places:
        initPlacesModule();
        initPlaceVisitModule();
        return MaterialPageRoute(builder: (_) =>     Places());
      case Routes.spec:
        initSpecModule();
        return MaterialPageRoute(builder: (_) =>     SpecializationsPage());
         case Routes.doctors:
        initdoctorModule();
        return MaterialPageRoute(builder: (_) =>     Doctors());
           case Routes.hospital:
        inithospitalModule();
        return MaterialPageRoute(builder: (_) =>     Hospital());
      case Routes.brand:
        initBrandModule();
        return MaterialPageRoute(builder: (_) =>     BrandPage());
      case Routes.pharmacy:
        initPharmacyModule();
        return MaterialPageRoute(builder: (_) =>     PharmacyPage());
      case Routes.syncData:
        initAsyncModule();
        return MaterialPageRoute(builder: (_) =>     AsyncLoginPage());
      case Routes.visits:
        initVisitsModule();
        return MaterialPageRoute(builder: (_) =>     VisitsPage());
      case Routes.asyncIn:
        initAsyncInModule();
        return MaterialPageRoute(builder: (_) =>     AsyncPage());
      case Routes.placeVisit:
        return MaterialPageRoute(builder: (_) =>     PlaceVisitPage(placeId: 2));
      case Routes.specDH:
        return MaterialPageRoute(builder: (_) =>     SpecDH(spId: 0,));
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

