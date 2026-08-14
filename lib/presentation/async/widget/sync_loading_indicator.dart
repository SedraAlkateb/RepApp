import 'package:domina_app/presentation/async/bloc/async_bloc.dart';
import 'package:domina_app/presentation/uniti/circle_number_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SyncLoadingIndicator extends StatelessWidget {
  const SyncLoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: Center(
        child: BlocBuilder<AsyncBloc, AsyncState>(
          builder: (context, state) {
            if (state is LoadingState) {
              return CircleNumberWidget(
                number: state.loading,
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}