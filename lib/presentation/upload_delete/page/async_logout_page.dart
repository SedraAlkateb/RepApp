// ignore_for_file: deprecated_member_use

import 'package:domina_app/app/di/di.dart';
import 'package:domina_app/presentation/resources/assets_manager.dart';
import 'package:domina_app/presentation/resources/routes_manager.dart';
import 'package:domina_app/presentation/uniti/stateWidget.dart';
import 'package:domina_app/presentation/upload_delete/bloc/async_in_bloc.dart';
import 'package:domina_app/presentation/upload_delete/widget/async_logout/async_logout_responsive_layout.dart';
import 'package:domina_app/presentation/upload_delete/widget/dialog_change_plan.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AsyncLogoutPage extends StatefulWidget {
  const AsyncLogoutPage({
    super.key,
  });

  @override
  State<AsyncLogoutPage> createState() => _AsyncLogoutPageState();
}

class _AsyncLogoutPageState extends State<AsyncLogoutPage>
    with TickerProviderStateMixin {
  late final AnimationController _rotateCtrl;
  late final AnimationController _bounceCtrl;

  @override
  void initState() {
    super.initState();

    _rotateCtrl = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();

    _bounceCtrl = AnimationController(
      duration: const Duration(
        milliseconds: 1500,
      ),
      vsync: this,
    )..repeat(
      reverse: true,
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    precacheImage(
      AssetImage(ImageAssets.upload),
      context,
    );
  }

  @override
  void dispose() {
    _rotateCtrl.dispose();
    _bounceCtrl.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AsyncInBloc>(
      create: (_) => instance<AsyncInBloc>(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: BlocListener<AsyncInBloc, AsyncInState>(
          listener: _listener,
          child: SafeArea(
            child: AsyncLogoutResponsiveLayout(
              rotateController: _rotateCtrl,
              bounceController: _bounceCtrl,
            ),
          ),
        ),
      ),
    );
  }

  void _listener(
      BuildContext context,
      AsyncInState state,
      ) {
    if (state is SyncData1ErrorState) {
      error(
        context,
        state.failure.massage,
        state.failure.code,
      );
    }

    if (state is SyncData1State) {
      Navigator.pushReplacementNamed(
        context,
        Routes.deleteLogout,
      );
    }

    if (state is IsActiveState) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) {
          return dialogChangePlan(
            context,
            true,
          );
        },
      );
    }

    if (state is GetState) {
      context.read<AsyncInBloc>().add(
        GetEvent(),
      );
    }
  }
}