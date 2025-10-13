import 'package:domina_app/presentation/delete/bloc/delete_bloc.dart';
import 'package:domina_app/presentation/resources/assets_manager.dart';
import 'package:domina_app/presentation/resources/routes_manager.dart';
import 'package:domina_app/presentation/resources/values_manager.dart';
import 'package:domina_app/presentation/uniti/stateWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DeletePage extends StatefulWidget {
  const DeletePage({super.key});

  @override
  State<DeletePage> createState() => _DeletePageState();
}

class _DeletePageState extends State<DeletePage> {
  @override
  Widget build(BuildContext context) {
   // success(context);
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
            left: AppPaddingW.p40, right: AppPaddingW.p40, top: 20),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: AppSize.s30),
                SizedBox(
                  height: 400,
                  width: 400,
                  child: Image.asset(
                    ImageAssets.delete,
                    height: 500,
                  ),
                ),
                Text(
                  textAlign: TextAlign.center,
                  "سوف نحذف الداتا لاعادة تنزيلها  ",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                SizedBox(height: AppSize.s25),
                BlocListener<DeleteBloc, DeleteState>(
                  listener: (context, state) {
                    if (state is DeleteBaseErrorState) {
                      error(context, state.failure.massage, state.failure.code);
                    }
                    if (state is Edit1StatusSErrorState) {
                      error(context, state.failure.massage, state.failure.code);
                    }
                    if (state is Edit1StatusState) {
                      print("object");
                      // success(context);
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        Routes.syncData,
                        (route) => false,
                      );
                    }
                    if (state is DeleteBaseState) {
                      BlocProvider.of<DeleteBloc>(context).add(Edit1EventIn(1));
                    }
                  },
                  child: ElevatedButton(
                      onPressed: () {
                        BlocProvider.of<DeleteBloc>(context)
                            .add(DeleteBaseEvent());
                      },
                      child: Text(
                        " حذف البيانات ",
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
