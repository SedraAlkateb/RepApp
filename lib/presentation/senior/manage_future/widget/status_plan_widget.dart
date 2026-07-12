import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/senior/plan_review/bloc/future_rep_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void showStatusBottomSheet(BuildContext context,int repTypeI,int repPlanId) {
  List<FlagModel> statusPlan = getAllFlags(repTypeI);

  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'اختر الحالة الجديدة',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 20),
            ...statusPlan.map((status) => ListTile(
              title: Text(status.name),
              onTap: () {
                Navigator.pop(context);
                BlocProvider.of<FutureRepBloc>(context).add(
                  EditePlanStatusEvent(repPlanId, status.flag),
                );
              },
            )),
          ],
        ),
      );
    },
  );
}