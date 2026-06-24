import 'package:domina_app/app/di.dart';
import 'package:domina_app/app/user_info.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/Recipes/pages/all_recip.dart';
import 'package:domina_app/presentation/Recipes/pages/recipe_d_h.dart';
import 'package:domina_app/presentation/async/pages/async_login_page.dart';
import 'package:domina_app/presentation/brand_plan/pages/brand_plan_page.dart';
import 'package:domina_app/presentation/doctors/pages/doctor_page/doctor_details%20.dart';
import 'package:domina_app/presentation/doctors/pages/doctor_page/doctors.dart';
import 'package:domina_app/presentation/doctors/pages/hospital_page/hospital.dart';
import 'package:domina_app/presentation/doctors/pages/hospital_page/hospital_details.dart';
import 'package:domina_app/presentation/order/page/add_order_page.dart';
import 'package:domina_app/presentation/places/pages/place_visit_archive_page.dart';
import 'package:domina_app/presentation/places/pages/places_archive.dart';
import 'package:domina_app/presentation/plase_visit/pages/visit_doctor.dart';
import 'package:domina_app/presentation/plase_visit/pages/visit_hospital.dart';
import 'package:domina_app/presentation/senior/admin/page/admin_dashboard_page.dart';
import 'package:domina_app/presentation/senior/all_city/pages/all_city_for_rep_super.dart';
import 'package:domina_app/presentation/senior/finished_plan/page/all_city-plan.dart';
import 'package:domina_app/presentation/senior/finished_plan/page/finished_plan_page.dart';
import 'package:domina_app/presentation/senior/finished_plan/page/plan_reps_page.dart';
import 'package:domina_app/presentation/senior/general_reports/pages/all_city-seniors.dart';
import 'package:domina_app/presentation/senior/general_reports/pages/team_leader.dart';
import 'package:domina_app/presentation/senior/manage_future/page/all_rep_with_future.dart';
import 'package:domina_app/presentation/senior/plan_management/page/create_current_plan_page.dart';
import 'package:domina_app/presentation/senior/plan_review/page/rep_plan_brand_sp.dart';
import 'package:domina_app/presentation/senior/places/pages/all_rep_senior.dart';
import 'package:domina_app/presentation/senior/edit_brand_plan/page/auditing_plan.dart';
import 'package:domina_app/presentation/senior/representative/page/all_brand.dart';
import 'package:domina_app/presentation/senior/representative/page/all_recip.dart';
import 'package:domina_app/presentation/senior/representative/page/doctor_senioir.dart';
import 'package:domina_app/presentation/senior/representative/page/hos_senior.dart';
import 'package:domina_app/presentation/senior/representative/page/no_visit_doctor.dart';
import 'package:domina_app/presentation/senior/representative/page/place_senior.dart';
import 'package:domina_app/presentation/senior/representative/page/remaining_visits.dart';
import 'package:domina_app/presentation/senior/representative/page/rep_profile.dart';
import 'package:domina_app/presentation/senior/representative/page/sen_visit_doctor.dart';
import 'package:domina_app/presentation/senior/representative/page/spec_senior.dart';
import 'package:domina_app/presentation/senior/representative/page/view_recipe.dart';
import 'package:domina_app/presentation/senior/search_doctors/page/doctor_info.dart';
import 'package:domina_app/presentation/senior/search_doctors/page/main_search.dart';
import 'package:domina_app/presentation/uniti/animation/curve%20.dart';
import 'package:domina_app/presentation/upload_delete/page/async_logout_page.dart';
import 'package:domina_app/presentation/upload_delete//page/async_page.dart';
import 'package:domina_app/presentation/delete/page/delete_logout_page.dart';
import 'package:domina_app/presentation/delete/page/delete_page.dart';
import 'package:domina_app/presentation/auth/pages/loginUser.dart';
import 'package:domina_app/presentation/brand/pages/brand_page.dart';
import 'package:domina_app/presentation/pharmacy/pages/pharmacy_page.dart';
import 'package:domina_app/presentation/places/pages/places.dart';
import 'package:domina_app/presentation/plase_visit/pages/place_visit_page.dart';
import 'package:domina_app/presentation/resources/strings_manager.dart';
import 'package:domina_app/presentation/specialization/pages/spec.dart';
import 'package:domina_app/presentation/specialization/pages/spec_d_h.dart';
import 'package:domina_app/presentation/visits/pages/info_visit_doctor.dart';
import 'package:domina_app/presentation/visits/pages/info_visit_hospital.dart';
import 'package:domina_app/presentation/visits/pages/visits_page.dart';
import 'package:flutter/material.dart';
import '../Recipes/pages/Recipes.dart';

class Routes {
  static const String login = "/login";
  static const String places = "/Places";
  static const String placesArchive = "/placesArchive";

  static const String searchdoctors = "/searchdoctors";
  static const String spec = "/spec";
  static const String doctors = "/doctors";
  static const String hospital = "/hospital";
  static const String brand = "/brand";
  static const String pharmacy = "/pharmacy";
  static const String syncData = "/syncData";
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
 // static const String cities = "/cities";

  static const String repProfile = "/RepProfile";
  static const String seniorPlaces = "/seniorPlaces";
  static const String seniorSpec = "/seniorSpec";
  static const String seniorHos = "/seniorHos";
  static const String seniorDoc = "/seniorDoc";
  static const String allBrand = "/allBrand";
  static const String noVisitDoctor = "/noVisitDoctor";
  static const String remainingVisitsDoctor = "/remainingVisitsDoctor";
  static const String senVisitDoctor = "/senVisitDoctor";
  static const String EditingPlan = "/EditingPlan";
  static const String RepPlanBrandSp = "/RepPlanBrandSp";
  static const String allRecip = "/allRecip";
  static const String doctorInfo = "/doctorInfo";
  static const String allRecipe = "/allRecipe";
  static const String viewRecipe = "/viewRecipe";
  static const String placeVisitPage = "/placeVisitPage";
  static const String visitDoctor = "/VisitDoctor";
  static const String visitHospital = "/visitHospital";
  static const String hospitalDetails = "/hospitalDetails";
  static const String doctorDetails = "/doctorDetails";

  static const String infoVisitHospital = "/infoVisitHospital";
  static const String infoVisitDoctor= "/infoVisitDoctor";
  static const String recipesHospital = "/recipesHospital";
  static const String recipesDoctor= "/recipesDoctor";

  static const String createOrder = "/createOrder";
  static const String recipeDH = "/recipeDH";
  static const String allRepWithFuture = "/allRepWithFuture";
  static const String seniorByCityId = "/seniorByCityId";
  static const String adminControl = "/adminControl";

  static const String allCitySeniors = "/allCitySeniors";
  static const String teamLeader = "/teamLeader";
  static const String doctorAndHospitalArchive = "/doctorAndHospitalArchive";
  static const String finishedPlan = "/finishedPlan";
  static const String planReps = "/planReps";
  static const String createCurrentPlan = "/createCurrentPlan";
  static const String cityPlan = "/cityPlan";
  static const String allCitySupervisor = "/allCitySupervisor";

}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.login:
        initLoginModule();
        return _animatedRoute(const MyLogin());
      case Routes.allBrand:
        return _animatedRoute(AllBrand());
      case Routes.createOrder:
        initOrderBradModule();
        return _animatedRoute(CreateOrderPage());
      case Routes.placeVisitPage:
        final args = settings.arguments as int; // ننتظر الـ ID هنا كـ Integer

        return _animatedRoute(
          PlaceVisitPage(placeId: args),
        );
      case Routes.visitDoctor:
        final args = settings.arguments as DoctorModel; // ننتظر الـ ID هنا كـ Integer
        return _animatedRoute(
          VisitDoctor(doctorModel: args),
        );
      case Routes.hospitalDetails:
        final args = settings.arguments as HospitalSpAllModel; // ننتظر الـ ID هنا كـ
        return _animatedRoute(
          HospitalDetails(

              hospital: args),
        );
      case Routes.doctorDetails:
        final args = settings.arguments as DoctorModel; // ننتظر الـ ID هنا كـ
        return _animatedRoute(
          DoctorDetails(

              doctor: args),
        );
      case Routes.infoVisitHospital:
        final args = settings.arguments as VisitHospitalAndHospital; // ننتظر الـ ID هنا كـ Integer
        return _animatedRoute(
          InfoVisitHospital(

              hospitalModel: args),
        );
      case Routes.infoVisitDoctor:
        final args = settings.arguments as VisitDoctorAndDoctor; // ننتظر الـ ID هنا كـ Integer
        return _animatedRoute(
          InfoVisitDoctor(

              doctorModel: args),
        );
      case Routes.visitHospital:
        final args = settings.arguments as HospitalModel; // ننتظر الـ ID هنا كـ Integer
        return _animatedRoute(
          VisitHospital(hospitalModel: args),
        );
      case Routes.fadeInWidget:
        return _animatedRoute(FadeInWidget());

      case Routes.places:
        initPlacesModule();
        initPlaceVisitModule();
        initDoctorAndHospitalModule();
        return _animatedRoute(Places());
      case Routes.placesArchive:
        initPlacesModule();
       // initPlaceVisitModule();
        initDoctorAndHospitalModule();
        return _animatedRoute(PlacesArchive());
      case Routes.spec:
        initSpecModule();
        return _animatedRoute(SpecializationsPage());

      case Routes.doctors:
        return _animatedRoute(Doctors());

      case Routes.hospital:
        return _animatedRoute(Hospital());

      case Routes.brand:
        initBrandModule();
        return _animatedRoute(BrandPage());

      case Routes.pharmacy:
        initPharmacyModule();
        return _animatedRoute(PharmacyPage());

      case Routes.syncData:
        initAsyncModule();
        return _animatedRoute(AsyncLoginPage());

      case Routes.visits:
        initVisitsModule();
        return _animatedRoute(VisitsPage());

      case Routes.asyncIn:
        initAsyncInModule();
        return _animatedRoute(AsyncPage());

      case Routes.logout:
        initAsyncInModule();
        return _animatedRoute(AsyncLogoutPage());

      case Routes.specDH:
        return _animatedRoute(SpecDH(spId: 0));

      case Routes.brandPlan:
        initBrandPlanModule();
        return _animatedRoute(BrandPlanPage());

      case Routes.delete:
        initDeleteModule();
        return _animatedRoute(DeletePage());

      case Routes.allRecip:
        initBrandRecModule();
        return _animatedRoute(AllRecip());

        case Routes.Recipes:
        initBrandRecModule();
        return _animatedRoute(
            RecipesPage(
                  docId: 0,
                  st: 433,
                ));
      case Routes.repProfile:
        initSeniorProfModule();
        return _animatedRoute(
           RepProfile(
                  id: 3,
                  repPlanId: 3,
                  index: 3,
            //      cityId: 1,
                ));
      case Routes.AllRepSenior:
        initSeniorModule();
        final args = settings.arguments as int?; // ننتظر الـ ID هنا كـ Integer

        return _animatedRoute( AllRepSenior(
          cityId:args!=null?args: UserInfo.cityId,
          cityname: UserInfo.cityTitle,
          repId: UserInfo.repId,
        ));
      // case Routes.cities:
      //
      //   return _animatedRoute( AllCitySenior());

      case Routes.seniorPlaces:
        return _animatedRoute( PlaceSenior());
      case Routes.seniorSpec:
        return _animatedRoute( SpecSeniorPage());
      case Routes.seniorHos:
        return _animatedRoute( HospitalSenior());
      case Routes.seniorDoc:
        return _animatedRoute( DoctorSenior());
      // case Routes.seniorNoteDoc:
      //   return MaterialPageRoute(builder: (_) => NoteDoctor());
      case Routes.noVisitDoctor:
        return _animatedRoute(NoVisitDoctor());
      case Routes.remainingVisitsDoctor:
        return _animatedRoute( RemainingVisits());
      case Routes.senVisitDoctor:
        return _animatedRoute( SenVisitDoctor());
      case Routes.EditingPlan:
        iniEditBrandPlanModule();
        return _animatedRoute(
           EditingPlan(
            repPlan: 7,
          )
        );
      case Routes.searchdoctors:
        iniSearchDoctorsModule();
        return _animatedRoute(
           MainSearchPage()
        );
      case Routes.RepPlanBrandSp:
        iniFutureModule();
        final args = settings.arguments as Map<String, dynamic>?;
        final title = args?['title'];
        final flag = args?['flag'];
        return _animatedRoute(
           RepPlanBrandSpPage(
            title: title,
            flag: flag,
          )
        );
      case Routes.deleteLogout:
        initDeleteModule();
        return _animatedRoute(DeleteLogoutPage());
      case Routes.doctorInfo:
        return _animatedRoute( DoctorInfo());
      case Routes.allRecipe:
        initBrandRecModule();

        return _animatedRoute( AllRecipesForView());
      case Routes.viewRecipe:
        return _animatedRoute( ViewRecipePage());
      case Routes.recipeDH:
        initDoctorAndHospitalModule() ;
        return _animatedRoute( RecipeDH());
      case Routes.allRepWithFuture:
        initSeniorManageFutureModule();
        return _animatedRoute( AllRepWithFuture());
      case Routes.seniorByCityId:
        initGeneralReportsModule();
        return _animatedRoute( AllRepWithFuture());
      case Routes.adminControl:
        return _animatedRoute( AdminDashboardPage());
      case Routes.doctorAndHospitalArchive:
        final args = settings.arguments as int; // ننتظر الـ ID هنا كـ Integer

        return _animatedRoute( PlaceVisitArchivePage(placeId: args));
      case Routes.teamLeader:
        initGeneralReportsModule();
        return _animatedRoute( TeamLeader());
      case Routes.allCitySeniors:
        iniAllCityModule();
        return _animatedRoute( AllCitySeniors());
      case Routes.allCitySupervisor:
        iniAllCityModule();
        return _animatedRoute( AllCityForRepSuper());
      case Routes.finishedPlan:
        initFinishedPlan();
        final args = settings.arguments as int; // ننتظر الـ ID هنا كـ Integer

        return _animatedRoute( FinishedPlanPage(cityId: args));
      case Routes.planReps:

        return _animatedRoute( PlanRepsPage());
      case Routes.createCurrentPlan:
        initCurrentPlanModule();
        return _animatedRoute( CreateCurrentPlanPage());
      case Routes.cityPlan:
        initFinishedPlan();
        return _animatedRoute(AllCityPlan());


      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return _animatedRoute(
      Scaffold(
        appBar: AppBar(title: const Text(StringsManager.noRouteFound)),
        body: const Center(child: Text(StringsManager.noRouteFound)),
      ),
    );
  }

  static Route<dynamic> _animatedRoute(Widget page) {
    return PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 600),
      pageBuilder: (_, __, ___) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final begin = const Offset(1.0, 0.0); // تغيير الاتجاه إلى اليمين لليسار
        final end = Offset.zero;
        final curve = Curves.easeInOut;
        final tween = Tween(
          begin: begin,
          end: end,
        ).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: FadeTransition(opacity: animation, child: child),
        );
      },
    );
  }

  // ignore: unused_element
  static Route<dynamic> _Route(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
    );
  }
}
