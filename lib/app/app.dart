import 'package:domina_app/app/di.dart';
import 'package:domina_app/app/user_info.dart';
import 'package:domina_app/presentation/Recipes/bloc/recipes_brand_bloc.dart';
import 'package:domina_app/presentation/async/bloc/async_bloc.dart';
import 'package:domina_app/presentation/brand_plan/bloc/brand_plan_bloc.dart';
import 'package:domina_app/presentation/delete/bloc/delete_bloc.dart';
import 'package:domina_app/presentation/order/bloc/order_bloc.dart';
import 'package:domina_app/presentation/senior/active_plan/bloc/bloc/active_plan_bloc.dart';
import 'package:domina_app/presentation/senior/all_city/bloc/bloc/all_city_bloc.dart';
import 'package:domina_app/presentation/senior/edit_brand_plan/bloc/edit_brand_plan_bloc.dart';
import 'package:domina_app/presentation/senior/finished_plan/bloc/finished_plan_bloc.dart';
import 'package:domina_app/presentation/senior/general_reports/bloc/bloc/general_reports_bloc.dart';
import 'package:domina_app/presentation/senior/manage_future/bloc/manage_future_bloc.dart';
import 'package:domina_app/presentation/senior/plan_management/bloc/plan_management_bloc.dart';
import 'package:domina_app/presentation/senior/plan_review/bloc/future_rep_bloc.dart';
import 'package:domina_app/presentation/senior/places/bloc/senior_reps_bloc.dart';
import 'package:domina_app/presentation/senior/report_Inventory/bloc/report_inventory_bloc.dart';
import 'package:domina_app/presentation/senior/report_issue_note/bloc/report_issue_bloc.dart';
import 'package:domina_app/presentation/senior/report_sience_note/bloc/report_science_bloc.dart';
import 'package:domina_app/presentation/senior/report_visit_doctor/bloc/report_visit_doctor_bloc.dart';
import 'package:domina_app/presentation/senior/representative/bloc/senior_prof_bloc.dart';
import 'package:domina_app/presentation/senior/search_doctors/bloc/search_doctors_bloc.dart';
import 'package:domina_app/presentation/upload_delete/bloc/async_in_bloc.dart';
import 'package:domina_app/presentation/auth/bloc/auth_bloc.dart';
import 'package:domina_app/presentation/doctors/bloc/doctors_bloc.dart';
import 'package:domina_app/presentation/brand/bloc/brand_bloc.dart';
import 'package:domina_app/presentation/pharmacy/bloc/pharmacy_bloc.dart';
import 'package:domina_app/presentation/places/bloc/place_bloc.dart';
import 'package:domina_app/presentation/plase_visit/bloc/visit_place_bloc.dart';
import 'package:domina_app/presentation/specialization/bloc/specialization_bloc.dart';
import 'package:domina_app/presentation/visits/bloc/visit_bloc.dart';
import 'package:flutter/material.dart';
import 'package:domina_app/presentation/resources/routes_manager.dart';
import 'package:domina_app/presentation/resources/them_manager.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => instance<PlanManagementBloc>()),

        BlocProvider(create: (_) => instance<FinishedPlanBloc>()),
        BlocProvider(create: (_) => instance<AuthBloc>()),
        BlocProvider(create: (_) => instance<ReportVisitDoctorBloc>()),
        BlocProvider(create: (_) => instance<AsyncInBloc>()),
        BlocProvider(create: (_) => instance<ActivePlanBloc>()),
        BlocProvider<PharmacyBloc>(
          create: (context) {
            final bloc = instance<PharmacyBloc>();
            bloc.add(AllPharmacyEvent());
            return bloc;
          },
        ),
        BlocProvider<EditBrandPlanBloc>(
          create: (context) {
            final bloc = instance<EditBrandPlanBloc>();
            return bloc;
          },
        ),

        BlocProvider<RecipesBrandBloc>(
          create: (context) {
            final bloc = instance<RecipesBrandBloc>();
            bloc.add(AllRecipesEvent());
            bloc.add(AllNumEvent());
            return bloc;
          },
        ),
        BlocProvider<SeniorProfBloc>(
          create: (context) {
            final bloc = instance<SeniorProfBloc>();
            //   bloc.add(AllRecipesEvent());
            //   bloc.add(AllNumEvent());
            return bloc;
          },
        ),
        BlocProvider<OrderBloc>(
          create: (context) {
            final bloc = instance<OrderBloc>();
            return bloc;
          },
        ),
        BlocProvider<SeniorRepsBloc>(
          create: (context) {
            final bloc = instance<SeniorRepsBloc>();
          //  bloc.add(AllSeniorRepEvent(UserInfo.cityId,UserInfo.repId));
            //   bloc.add(AllNumEvent());
            return bloc;
          },
        ),
        BlocProvider<VisitPlaceBloc>(
          create: (context) {
            final bloc = instance<VisitPlaceBloc>();
            bloc.add(BrandFlagEvent());
            bloc.add(BrandAnyFlagEvent());
            return bloc;
          },
        ),
        BlocProvider<PlaceBloc>(
          create: (context) {
            final bloc = instance<PlaceBloc>();
            bloc.add(AllPlaceEvent());
            bloc.add(CheckRepEvent());
            bloc.add(NumVisitEvent());
            return bloc;
          },
        ),
        BlocProvider<BrandBloc>(
          create: (context) {
            final bloc = instance<BrandBloc>();
            bloc.add(AllBrandEvent());
            return bloc;
          },
        ),
        BlocProvider<DoctorsBloc>(
          create: (context) {
            final bloc = instance<DoctorsBloc>();
            bloc.add(AllDoctorEvent());
            return bloc;
          },
        ),
        BlocProvider<ReportScienceBloc>(
          create: (context) {
            final bloc = instance<ReportScienceBloc>();
            return bloc;
          },
        ),
        BlocProvider<ReportIssueBloc>(
          create: (context) {
            final bloc = instance<ReportIssueBloc>();
            return bloc;
          },
        ),
        BlocProvider<ReportInventoryBloc>(
          create: (context) {
            final bloc = instance<ReportInventoryBloc>();
            return bloc;
          },
        ),
        BlocProvider<DeleteBloc>(
          create: (context) {
            final bloc = instance<DeleteBloc>();
            return bloc;
          },
        ),
        BlocProvider<BrandPlanBloc>(
          create: (context) {
            final bloc = instance<BrandPlanBloc>();
            bloc.add(AllBrandPlanEvent(0));
            return bloc;
          },
        ),
        BlocProvider<SpecializationBloc>(
          create: (context) {
            final bloc = instance<SpecializationBloc>();
            bloc.add(SpecEvent());
            return bloc;
          },
        ),
        BlocProvider<VisitBloc>(
          create: (context) {
            final bloc = instance<VisitBloc>();
            bloc.add(VisitDoctorEvent());
            bloc.add(BrandFlagEditeEvent());
            return bloc;
          },
        ),
        BlocProvider(create: (_) => instance<AsyncBloc>()),
        BlocProvider(create: (_) => instance<SearchDoctorsBloc>()),

        BlocProvider<ManageFutureBloc>(
          create: (context) {
            final bloc = instance<ManageFutureBloc>();
            bloc.add(AllSeniorRepFutureEvent());
            return bloc;
          },
        ),
        BlocProvider<AllCityBloc>(
          create: (context) {
            final bloc = instance<AllCityBloc>();
            bloc.add(const GetAllCityEvent());
            return bloc;
          },
        ),
        BlocProvider<GeneralReportsBloc>(
          create: (context) {
            final bloc = instance<GeneralReportsBloc>();
            bloc.add(const TeamLeaderAndCityEvent());
            return bloc;
          },
        ),
        BlocProvider<FutureRepBloc>(
          create: (context) {
            final bloc = instance<FutureRepBloc>();
            return bloc;
          },
        ),
      ],
      child: MaterialApp(
        //  navigatorKey: navigatorKey,
        locale: Locale('ar'),
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [Locale('ar')],
        localeResolutionCallback: (locale, supportedLocales) {
          return Locale('ar');
        },
        debugShowCheckedModeBanner: false,
        onGenerateRoute: RouteGenerator.getRoute,
        initialRoute: _getInitialRoute()

        //  UserInfo.isLogging == 0
        //     ? Routes.login
        //     : UserInfo.isLogging == 1
        //         ? Routes.syncData
        //         : UserInfo.isLogging == 4
        //             ? (Routes.syncData)
        //             : UserInfo.isLogging == 5
        //                 ? Routes.asyncIn
        //                 : Routes.places,

        ,
        theme: getApplicationTheme(),
      ),
    );
  }
}

String _getInitialRoute() {
  if (UserInfo.isLogging == 0) return Routes.login;
  if (UserInfo.isLogging == 1) return Routes.syncData;
  if (UserInfo.isLogging == 4) return Routes.syncData;
  if (UserInfo.isLogging == 5) return Routes.asyncIn;
  if (UserInfo.isLogging == 2) {
    if(UserInfo.repType=="7"){
      return Routes.places;

    }else if( UserInfo.repType=="6"){
      return Routes.AllRepSenior;
    }else{
      return Routes.adminControl;
    }
  };
  return Routes.places;
}
