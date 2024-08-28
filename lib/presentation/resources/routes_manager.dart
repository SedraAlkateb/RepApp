import 'package:domina_app/places.dart';
import 'package:domina_app/presentation/auth/pages/loginUser.dart';
import 'package:domina_app/presentation/resources/strings_manager.dart';
import 'package:flutter/material.dart';
class Routes {
  static const String login = "/login";
  static const String places = "/Places";
  static const String createAdmin = "/createAdmin";

}
class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.login:
   //     initLoginModule();
        return MaterialPageRoute(builder: (_) =>    const MyLogin());
      case Routes.places:
      //     initLoginModule();
        return MaterialPageRoute(builder: (_) =>    const Places());
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

