import 'package:domina_app/app/di.dart';
import 'package:domina_app/presentation/auth/pages/loginUser.dart';
import 'package:domina_app/presentation/doctors/pages/doctors.dart';
import 'package:domina_app/presentation/hospitals/page/hospital.dart';
import 'package:domina_app/presentation/places/pages/places.dart';
import 'package:domina_app/presentation/resources/strings_manager.dart';
import 'package:domina_app/presentation/specialization/pages/spec.dart';
import 'package:flutter/material.dart';
class Routes {
  static const String login = "/login";
  static const String places = "/Places";
  static const String spec = "/spec";
  static const String doctors = "/doctors";
    static const String hospital = "/hospital";
}
class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.login:
   //     initLoginModule();
        return MaterialPageRoute(builder: (_) =>    const MyLogin());
      case Routes.places:
        initPlacesModule();
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

