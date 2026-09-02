import 'package:domina_app/app/di/di.dart';
import 'package:domina_app/app/user_info.dart';

import 'package:domina_app/presentation/Recipes/bloc/recipes_brand_bloc.dart';
import 'package:domina_app/presentation/async/bloc/async_bloc.dart';
import 'package:domina_app/presentation/brand_plan/bloc/brand_plan_bloc.dart';
import 'package:domina_app/presentation/delete/bloc/delete_bloc.dart';
import 'package:domina_app/presentation/doctors/bloc/doctors_bloc.dart';
import 'package:domina_app/presentation/places/bloc/place_bloc.dart';
import 'package:domina_app/presentation/plase_visit/bloc/visit_place_bloc.dart';
import 'package:domina_app/presentation/resources/routes_manager.dart';
import 'package:domina_app/presentation/resources/them_manager.dart';
import 'package:domina_app/presentation/senior/all_city/bloc/bloc/all_city_bloc.dart';
import 'package:domina_app/presentation/senior/edit_brand_plan/bloc/edit_brand_plan_bloc.dart';
import 'package:domina_app/presentation/senior/finished_plan/bloc/finished_plan_bloc.dart';
import 'package:domina_app/presentation/senior/general_reports/bloc/bloc/general_reports_bloc.dart';
import 'package:domina_app/presentation/senior/manage_future/bloc/manage_future_bloc.dart';
import 'package:domina_app/presentation/senior/places/bloc/senior_reps_bloc.dart';
import 'package:domina_app/presentation/senior/plan_management/bloc/plan_management_bloc.dart';
import 'package:domina_app/presentation/senior/plan_review/bloc/future_rep_bloc.dart';
import 'package:domina_app/presentation/senior/report_Inventory/bloc/report_inventory_bloc.dart';
import 'package:domina_app/presentation/senior/report_visit_doctor/bloc/report_visit_doctor_bloc.dart';
import 'package:domina_app/presentation/senior/representative/bloc/senior_prof_bloc.dart';
import 'package:domina_app/presentation/senior/search_doctors/bloc/search_doctors_bloc.dart';
import 'package:domina_app/presentation/specialization/bloc/specialization_bloc.dart';
import 'package:domina_app/presentation/uniti/app_bar_theme.dart';
import 'package:domina_app/presentation/visits/bloc/visit_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

GlobalKey<NavigatorState> appNavigatorKey = GlobalKey<NavigatorState>();
void resetAppNavigatorKey() {
  appNavigatorKey = GlobalKey<NavigatorState>();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => instance<FinishedPlanBloc>()),

        BlocProvider(create: (_) => instance<PlanManagementBloc>()),
        BlocProvider(create: (_) => instance<DeleteBloc>()),
        BlocProvider(create: (_) => instance<ReportVisitDoctorBloc>()),
        BlocProvider<EditBrandPlanBloc>(
            create: (_) => instance<EditBrandPlanBloc>()),
        BlocProvider<RecipesBrandBloc>(
          create: (_) => instance<RecipesBrandBloc>()
            ..add(AllRecipesEvent())
            ..add(AllNumEvent()),
        ),
        BlocProvider<SeniorProfBloc>(create: (_) => instance<SeniorProfBloc>()),
        BlocProvider<SeniorRepsBloc>(create: (_) => instance<SeniorRepsBloc>()),
        BlocProvider<VisitPlaceBloc>(
          create: (_) => instance<VisitPlaceBloc>()
            ..add(BrandFlagEvent())
            ..add(BrandAnyFlagEvent()),
        ),
        BlocProvider<PlaceBloc>(
          create: (_) => instance<PlaceBloc>()
            ..add(AllPlaceEvent())
            ..add(CheckRepEvent())
            ..add(NumVisitEvent()),
        ),
        BlocProvider<DoctorsBloc>(
          create: (_) => instance<DoctorsBloc>()..add(AllDoctorEvent()),
        ),
        //  BlocProvider<ReportIssueBloc>(create: (_) => instance<ReportIssueBloc>()),
        BlocProvider<ReportInventoryBloc>(
            create: (_) => instance<ReportInventoryBloc>()),
        BlocProvider<BrandPlanBloc>(
          create: (_) => instance<BrandPlanBloc>()..add(AllBrandPlanEvent(0)),
        ),
        BlocProvider<SpecializationBloc>(
          create: (_) => instance<SpecializationBloc>()..add(SpecEvent()),
        ),
        BlocProvider<VisitBloc>(
          create: (_) => instance<VisitBloc>()
            ..add(VisitDoctorEvent())
            ..add(BrandFlagEditeEvent()),
        ),
        BlocProvider(create: (_) => instance<AsyncBloc>()),
        BlocProvider(create: (_) => instance<SearchDoctorsBloc>()),
        BlocProvider<ManageFutureBloc>(
            create: (_) => instance<ManageFutureBloc>()),
        BlocProvider<AllCityBloc>(
            create: (_) => instance<AllCityBloc>()
              ..add(
                const GetAllCityEvent(),
              )
              ..add(CheckUserEvent())),
        BlocProvider<GeneralReportsBloc>(
            create: (_) => instance<GeneralReportsBloc>()),
        BlocProvider<FutureRepBloc>(create: (_) => instance<FutureRepBloc>()),
      ],
      child: Builder(builder: (materialContext) {
        return MaterialApp(
          navigatorKey: appNavigatorKey, // تم الربط بمفتاح الملاحة الموحد
          locale: const Locale('ar'),
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [Locale('ar')],
          localeResolutionCallback: (locale, supportedLocales) =>
              const Locale('ar'),
          debugShowCheckedModeBanner: false,
          onGenerateRoute: RouteGenerator.getRoute,
          initialRoute: _getInitialRoute(),
          theme: getApplicationTheme().copyWith(
            appBarTheme: buildResponsiveAppBarTheme(context),
          ),
        );
      }),
    );
  }

  // دالة تحديد المسار الابتدائي (مباشرة دون async)
  String _getInitialRoute() {
    if (UserInfo.isLogging == 0) return Routes.login;
    if (UserInfo.isLogging == 2) {
      if (UserInfo.repType.i == 4 || UserInfo.repType.i == 5) {
        return Routes.adminControl;
      }
      if (UserInfo.repType.i == 7) {
        return Routes.places;
      }
      if (UserInfo.repType.i == 6) {
        return Routes.AllRepSenior;
      }
    }
    if (UserInfo.isLogging == 1) return Routes.syncData;
    if (UserInfo.isLogging == 4) return Routes.syncData;
    if (UserInfo.isLogging == 5) return Routes.asyncIn;

    return Routes.places;
  }
}
