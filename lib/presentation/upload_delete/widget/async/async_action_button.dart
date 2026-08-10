import 'package:domina_app/presentation/upload_delete/bloc/async_in_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AsyncActionButton extends StatelessWidget {
  const AsyncActionButton({
    super.key,
    required this.height,
    required this.fontSize,
  });

  final double height;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AsyncInBloc, AsyncInState>(
      buildWhen: (previous, current) {
        return current is SyncData1LoadingState ||
            current is SyncData1ErrorState;
      },
      builder: (context, state) {
        final isLoading =
        state is SyncData1LoadingState;

        return SizedBox(
          width: double.infinity,
          height: height,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF0D47A1),
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),

            onPressed: isLoading
                ? null
                : () {
              context.read<AsyncInBloc>().add(
                Async1DataEvent(),
              );
            },

            child: Text(
              isLoading
                  ? 'جاري الرفع...'
                  : 'رفع البيانات',
              style: TextStyle(
                fontSize: fontSize,
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