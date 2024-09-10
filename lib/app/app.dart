import 'package:domina_app/app/di.dart';
import 'package:domina_app/app/user_info.dart';
import 'package:domina_app/presentation/async/bloc/async_bloc.dart';
import 'package:domina_app/presentation/auth/bloc/auth_bloc.dart';
import 'package:domina_app/presentation/doctors/bloc/doctors_bloc.dart';
import 'package:domina_app/presentation/hospitals/bloc/hospitals_bloc.dart';
import 'package:domina_app/presentation/brand/bloc/brand_bloc.dart';
import 'package:domina_app/presentation/pharmacy/bloc/pharmacy_bloc.dart';
import 'package:domina_app/presentation/places/bloc/place_bloc.dart';
import 'package:domina_app/presentation/plase_visit/bloc/place_visit_bloc.dart';
import 'package:domina_app/presentation/specialization/bloc/specialization_bloc.dart';
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
        BlocProvider(create: (_) => instance<AuthBloc>()),
        BlocProvider(create: (_) => instance<PlaceBloc>()),
        BlocProvider(create: (_) => instance<SpecializationBloc>()),
        BlocProvider(create: (_) => instance<DoctorsBloc>()),
        BlocProvider(create: (_) => instance<HospitalsBloc>()),
        BlocProvider(create: (_) => instance<BrandBloc>()),
        BlocProvider(create: (_) => instance<PharmacyBloc>()),
        BlocProvider(create: (_) => instance<AsyncBloc>()),
        BlocProvider(create: (_) => instance<PlaceVisitBloc>()),

      ],
      child: MaterialApp(
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
        initialRoute: UserInfo.isLogging == 0 ? Routes.login : Routes.places,
        theme: getApplicationTheme(),
      ),
    );
  }
}
