import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/resources/responsive/app_ui.dart';
import 'package:domina_app/presentation/senior/plan_review/bloc/future_rep_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Widget floatActionButton(BuildContext context ){
  final ui = AppUi.of(context);

  return FloatingActionButton.extended(
    elevation: 3,

    backgroundColor:
    ColorManager.secondaryColor1,

    shape:
    RoundedRectangleBorder(
      borderRadius:
      BorderRadius.circular(
        ui.cardRadius - 4,
      ),
    ),

    icon:
    Icon(
      Icons.save_as_rounded,
      color: Colors.white,
      size: ui.iconSize,
    ),

    label:
    Text(
      "حفظ التعديلات",

      style:
      TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w700,
        fontSize: ui.bodyTextSize,
      ),
    ),

// =================================================
// نفس الحدث الأصلي
// =================================================
    onPressed: () {
      BlocProvider.of<
          FutureRepBloc>(
        context,
      ).add(
        UpdateAmountEvent(),
      );
    },
  );

}