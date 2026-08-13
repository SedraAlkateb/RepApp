import 'package:domina_app/app/user_info.dart';
import 'package:domina_app/presentation/async/bloc/async_bloc.dart';
import 'package:domina_app/presentation/async/widget/sync_responsive_layout.dart';
import 'package:domina_app/presentation/resources/routes_manager.dart';
import 'package:domina_app/presentation/uniti/stateWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:domina_app/app/app.dart';
class AsyncLoginPage extends StatefulWidget {
  const AsyncLoginPage({
    super.key,
  });

  @override
  State<AsyncLoginPage> createState() =>
      _AsyncLoginPageState();
}

class _AsyncLoginPageState
    extends State<AsyncLoginPage> {
  bool _loadingDialogOpened = false;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,

      child: Scaffold(
        backgroundColor: Colors.white,

        appBar: _buildAppBar(
          context,
        ),

        body: BlocListener<
            AsyncBloc,
            AsyncState>(
          listener: _listener,

          child: const SafeArea(
            child:
            SyncResponsiveLayout(),
          ),
        ),
      ),
    );
  }

  // ===========================================================
  // AppBar
  // ===========================================================

  PreferredSizeWidget _buildAppBar(
      BuildContext context,
      ) {
    return AppBar(
      backgroundColor:
      Colors.transparent,

      surfaceTintColor:
      Colors.transparent,

      elevation: 0,

      leading:
      const SizedBox.shrink(),

      actions: [
        IconButton(
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(
              context,
              Routes.login,
                  (route) => false,
            );

            context
                .read<AsyncBloc>()
                .add(
              DeleteAllEvent(),
            );
          },

          icon: const Icon(
            Icons.arrow_forward,
            color: Color(
              0xFF0D47A1,
            ),
          ),
        ),

        const SizedBox(
          width: 8,
        ),
      ],
    );
  }

  // ===========================================================
  // Listener
  // ===========================================================

  Future<void> _listener(
      BuildContext context,
      AsyncState state,
      ) async {
    debugPrint(
      'ASYNC STATE =====> ${state.runtimeType}',
    );

    // =========================================================
    // Errors
    // =========================================================

    if (state is DeleteAllErrorState) {
      error(
        context,
        state.failure.massage,
        state.failure.code,
      );

      return;
    }

    if (state is SyncDataErrorState) {
      await _closeLoading();

      if (!context.mounted) {
        return;
      }

      error(
        context,
        state.failure.massage,
        state.failure.code,
      );

      return;
    }

    if (state is IsActiveErrorState) {
      error(
        context,
        state.failure.massage,
        state.failure.code,
      );

      return;
    }

    if (state is UpdateIsActiveErrorState) {
      error(
        context,
        state.failure.massage,
        state.failure.code,
      );

      return;
    }

    if (state is EditStatusDErrorState) {
      await _closeLoading();

      if (!context.mounted) {
        return;
      }

      error(
        context,
        state.failure.massage,
        state.failure.code,
      );

      return;
    }

    // =========================================================
    // Get Data
    // =========================================================

    if (state is getDataSucState) {
      context.read<AsyncBloc>().add(
        SetDataSEvent(),
      );

      return;
    }

    // =========================================================
    // Is Active
    // =========================================================

    if (state is IsActiveState) {
      context.read<AsyncBloc>().add(
        UpdateRepEvent(),
      );

      return;
    }

    // =========================================================
    // Update Is Active
    // =========================================================

    if (state is UpdateIsActiveState) {
      context.read<AsyncBloc>().add(
        AsyncDataEvent(),
      );

      return;
    }

    // =========================================================
    // Sync Loading
    // =========================================================

    if (state is SyncDataLoadingState) {
      // مهم جداً:
      // لا تفتح Dialog جديد مع كل progress state.
      if (!_loadingDialogOpened) {
        _loadingDialogOpened = true;

        loading(
          context,
          text: state.loading.toString(),
        );
      }

      return;
    }

    // =========================================================
    // Sync Finished
    // =========================================================

    if (state is SyncDataState) {
      debugPrint(
        'SYNC FINISHED => sending EditEvent(2)',
      );

      await _closeLoading();

      if (!context.mounted) {
        return;
      }

      context.read<AsyncBloc>().add(
        EditEvent(2),
      );

      return;
    }

    // =========================================================
    // Edit Status Finished
    // =========================================================

    if (state is EditStatusDState) {
      await _closeLoading();

      if (!context.mounted) {
        return;
      }
      UserInfo.isLogging = 2;

      resetAppNavigatorKey();

      Phoenix.rebirth(context);

      return;
    }
  }

  // ===========================================================
  // Close Loading
  // ===========================================================

  Future<void> _closeLoading() async {
    if (!_loadingDialogOpened) {
      return;
    }

    _loadingDialogOpened = false;

    if (!mounted) {
      return;
    }

    await dismissDialog(
      context,
    );
  }
}