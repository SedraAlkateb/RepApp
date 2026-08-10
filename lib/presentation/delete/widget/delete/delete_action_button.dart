import 'package:domina_app/presentation/delete/bloc/delete_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DeleteActionButton extends StatelessWidget {
  const DeleteActionButton({
    super.key,
    required this.height,
    required this.fontSize,
  });

  final double height;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DeleteBloc, DeleteState>(
      builder: (context, state) {
        final isLoading = state is DeleteBaseLoadingState;

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
              context.read<DeleteBloc>().add(
                DeleteBaseEvent(),
              );
            },

            child: Text(
              isLoading
                  ? 'جاري الحذف...'
                  : 'حذف البيانات',
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