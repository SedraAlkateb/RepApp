// ignore_for_file: deprecated_member_use

import 'package:domina_app/app/di/di.dart';
import 'package:domina_app/presentation/resources/assets_manager.dart';
import 'package:domina_app/presentation/resources/routes_manager.dart';
import 'package:domina_app/presentation/uniti/stateWidget.dart';
import 'package:domina_app/presentation/upload_delete/bloc/async_in_bloc.dart';
import 'package:domina_app/presentation/upload_delete/widget/async/async_responsive_layout.dart';
import 'package:domina_app/presentation/upload_delete/widget/dialog_change_plan.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AsyncPage extends StatefulWidget {
  const AsyncPage({
    super.key,
  });

  @override
  State<AsyncPage> createState() => _AsyncPageState();
}

class _AsyncPageState extends State<AsyncPage>
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
      create: (_) => instance(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: BlocListener<AsyncInBloc, AsyncInState>(
          listener: _listener,
          child: SafeArea(
            child: AsyncResponsiveLayout(
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
        Routes.delete,
      );
    }

    if (state is IsActiveState) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) {
          return dialogChangePlan(
            context,
            false,
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