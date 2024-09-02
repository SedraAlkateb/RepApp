import 'package:domina_app/app/di.dart';
import 'package:domina_app/presentation/auth/pages/async_page.dart';
import 'package:domina_app/presentation/auth/pages/loginUser.dart';
import 'package:domina_app/presentation/brand/pages/brand_page.dart';
import 'package:domina_app/presentation/pharmacy/pages/pharmacy_page.dart';
import 'package:domina_app/presentation/places/bloc/place_bloc.dart';
import 'package:domina_app/presentation/places/pages/places.dart';
import 'package:domina_app/presentation/resources/strings_manager.dart';
import 'package:domina_app/presentation/specialization/pages/spec.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class Routes {
  static const String login = "/login";
  static const String places = "/Places";
  static const String spec = "/spec";
  static const String brand = "/brand";
  static const String pharmacy = "/pharmacy";
  static const String syncData = "/syncData";

}
class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.login:
        initLoginModule();
        return MaterialPageRoute(builder: (_) =>    const MyLogin());
      case Routes.places:
        initPlacesModule();
        return MaterialPageRoute(builder: (_) =>     Places());
      case Routes.spec:
        initSpecModule();
        return MaterialPageRoute(builder: (_) =>     SpecializationsPage());
      case Routes.brand:
        initBrandModule();
        return MaterialPageRoute(builder: (_) =>     BrandPage());
      case Routes.pharmacy:
        initPharmacyModule();
        return MaterialPageRoute(builder: (_) =>     PharmacyPage());
      case Routes.syncData:
        return MaterialPageRoute(builder: (_) =>     AsyncPage());

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

