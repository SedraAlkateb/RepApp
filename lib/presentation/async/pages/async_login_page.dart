// ignore_for_file: deprecated_member_use

import 'package:domina_app/app/user_info.dart';
import 'package:domina_app/presentation/async/bloc/async_bloc.dart';
import 'package:domina_app/presentation/async/widget/sync_responsive_layout.dart';
import 'package:domina_app/presentation/resources/routes_manager.dart';
import 'package:domina_app/presentation/uniti/stateWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

class AsyncLoginPage extends StatelessWidget {
  const AsyncLoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: _buildAppBar(context),
        body: BlocListener<AsyncBloc, AsyncState>(
          listener: _listener,
          child: const SafeArea(
            child: SyncResponsiveLayout(),
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      leading: const SizedBox.shrink(),
      actions: [
        IconButton(
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(
              context,
              Routes.login,
                  (route) => false,
            );

            context.read<AsyncBloc>().add(DeleteAllEvent());
          },
          icon: const Icon(
            Icons.arrow_forward,
            color: Color(0xFF0D47A1),
          ),
        ),
        const SizedBox(width: 8),
      ],
    );
  }

  void _listener(BuildContext context, AsyncState state) {
    if (state is DeleteAllErrorState) {
      error(
        context,
        state.failure.massage,
        state.failure.code,
      );
    }

    if (state is SyncDataErrorState) {
      error(
        context,
        state.failure.massage,
        state.failure.code,
      );
    }

    if (state is IsActiveErrorState) {
      error(
        context,
        state.failure.massage,
        state.failure.code,
      );
    }

    if (state is UpdateIsActiveErrorState) {
      error(
        context,
        state.failure.massage,
        state.failure.code,
      );
    }

    if (state is getDataSucState) {
      context.read<AsyncBloc>().add(SetDataSEvent());
    }

    if (state is IsActiveState) {
      context.read<AsyncBloc>().add(UpdateRepEvent());
    }

    if (state is UpdateIsActiveState) {
      context.read<AsyncBloc>().add(AsyncDataEvent());
    }

    if (state is SyncDataLoadingState) {
      loading(
        context,
        text: state.loading.toString(),
      );
    }

    if (state is SyncDataState) {
      context.read<AsyncBloc>().add(EditEvent(2));
    }

    if (state is EditStatusDErrorState) {
      error(
        context,
        state.failure.massage,
        state.failure.code,
      );
    }

    if (state is EditStatusDState) {
      success(context);

      UserInfo.isLogging = 2;

      Phoenix.rebirth(context);
    }
  }
}