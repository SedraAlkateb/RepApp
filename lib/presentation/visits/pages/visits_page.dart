import 'package:domina_app/presentation/visits/bloc/visit_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class VisitsPage extends StatelessWidget {
  const VisitsPage({super.key});

  @override
  Widget build(BuildContext context) {
 //   BlocProvider.of<VisitBloc>(context).add(VisitPharmacyEvent());
    BlocProvider.of<VisitBloc>(context).add(VisitDoctorEvent());

    return const Placeholder();
  }
}
