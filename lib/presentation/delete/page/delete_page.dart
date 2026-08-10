// ignore_for_file: deprecated_member_use

import 'package:domina_app/presentation/delete/bloc/delete_bloc.dart';
import 'package:domina_app/presentation/delete/widget/delete/delete_responsive_layout.dart';
import 'package:domina_app/presentation/resources/routes_manager.dart';
import 'package:domina_app/presentation/uniti/stateWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DeletePage extends StatelessWidget {
  const DeletePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocListener<DeleteBloc, DeleteState>(
        listener: _listener,
        child: const SafeArea(
          child: DeleteResponsiveLayout(),
        ),
      ),
    );
  }

  void _listener(
      BuildContext context,
      DeleteState state,
      ) {
    if (state is DeleteBaseErrorState) {
      error(
        context,
        state.failure.massage,
        state.failure.code,
      );
    }

    if (state is Edit1StatusSErrorState) {
      error(
        context,
        state.failure.massage,
        state.failure.code,
      );
    }

    if (state is DeleteBaseState) {
      context.read<DeleteBloc>().add(
        Edit1EventIn(1),
      );
    }

    if (state is Edit1StatusState) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        Routes.syncData,
            (route) => false,
      );
    }
  }
}