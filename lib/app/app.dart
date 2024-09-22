import 'package:domina_app/app/di.dart';
import 'package:domina_app/app/user_info.dart';
import 'package:domina_app/presentation/async/bloc/async_bloc.dart';
import 'package:domina_app/presentation/auth/bloc/auth_bloc.dart';
import 'package:domina_app/presentation/doctors/bloc/doctors_bloc.dart';
import 'package:domina_app/presentation/hospitals/bloc/hospitals_bloc.dart';
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
        BlocProvider(create: (_) => instance<AuthBloc>()),
        BlocProvider<PharmacyBloc>(
          create: (context) {
            final bloc = instance<PharmacyBloc>();
            bloc.add(AllPharmacyEvent());
            return bloc;
          },
        ),
        BlocProvider<VisitPlaceBloc>(
          create: (context) {
            final bloc = instance<VisitPlaceBloc>();
            bloc.add(BrandFlagEvent());
            return bloc;
          },
        ),
        BlocProvider<PlaceBloc>(
          create: (context) {
            final bloc = instance<PlaceBloc>();
            bloc.add(AllPlaceEvent());
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
        BlocProvider<HospitalsBloc>(
          create: (context) {
            final bloc = instance<HospitalsBloc>();
            bloc.add(AllHospitalEvent());
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
        BlocProvider(create: (_) => instance<AsyncBloc>()),
        BlocProvider(create: (_) => instance<VisitBloc>()..add(VisitPharmacyEvent()))

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
