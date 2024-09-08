import 'package:domina_app/app/di.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/auth/bloc/auth_bloc.dart';
import 'package:domina_app/presentation/doctors/bloc/doctors_bloc.dart';
import 'package:domina_app/presentation/hospitals/bloc/hospitals_bloc.dart';
import 'package:domina_app/presentation/brand/bloc/brand_bloc.dart';
import 'package:domina_app/presentation/pharmacy/bloc/pharmacy_bloc.dart';
import 'package:domina_app/presentation/places/bloc/place_bloc.dart';
import 'package:domina_app/presentation/specialization/bloc/specialization_bloc.dart';
import 'package:flutter/material.dart';
import 'package:domina_app/presentation/resources/routes_manager.dart';
import 'package:domina_app/presentation/resources/them_manager.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (_) => instance<AuthBloc>()
        ),
        BlocProvider(
            create: (_) =>instance<PlaceBloc>()
        ),
        BlocProvider(
            create: (_) =>instance<SpecializationBloc>()
        ),
        BlocProvider(
            create: (_) =>instance<DoctorsBloc>()
        ),
    BlocProvider(
    create: (_) =>instance<HospitalsBloc>()
    ),
    BlocProvider(
    create: (_) =>instance<BrandBloc>()
    ),
        BlocProvider(
            create: (_) =>instance<PharmacyBloc>()

        ),
    ],
    child: MaterialApp(
      debugShowCheckedModeBanner:false,
      onGenerateRoute: RouteGenerator.getRoute,
       initialRoute:Routes.login,
        //UserInfo.isLogging==false?
     //  (Constants.type==0?
     //  Routes.homeAdmin :Constants.type==1?
     // Routes.services: Routes.userNav ),
      theme: getApplicationTheme(),
    ),

    );
  }

}
