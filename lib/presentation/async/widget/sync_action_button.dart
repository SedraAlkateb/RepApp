import 'package:domina_app/presentation/async/bloc/async_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SyncActionButton extends StatelessWidget {
  final double height;

  const SyncActionButton({
    super.key,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AsyncBloc, AsyncState>(
      builder: (context, state) {
        final isLoading =
            state is SyncDataLoadingState ||
                state is LoadingState;

        return SizedBox(
          width: double.infinity,
          height: height,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF0D47A1),
              disabledBackgroundColor:
              const Color(0xFF0D47A1).withOpacity(0.55),
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            onPressed: isLoading
                ? null
                : () {
              context
                  .read<AsyncBloc>()
                  .add(PlanIsActiveEvent());
            },
            child: Text(
              isLoading
                  ? 'جاري التحميل...'
                  : 'تحميل البيانات',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        );
      },
    );
  }
}