import 'dart:ui';
import 'package:domina_app/presentation/plase_visit/bloc/visit_place_bloc.dart';
import 'package:domina_app/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DialogFilter extends StatelessWidget {
  DialogFilter({super.key, required this.text,required this.noteText});
  final TextEditingController numController = TextEditingController();
  final formKey = new GlobalKey<FormState>();
  final String text;
  final String noteText;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(
      children: <Widget>[
        Container(
          color: Colors.transparent,
        ),
        // Blurred overlay
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
            child: Container(
              color: Colors.white.withOpacity(0.5), // Adjust opacity as needed
            ),
          ),
        ),
        Form(
          key: formKey,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: SizedBox(
                    height: size.height * 0.9,
                    width: size.width,
                    child: AlertDialog(
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.only(right: AppPadding.p8),
                            child: Text(text,
                                style: const TextStyle(fontSize: 20)),
                          ),
                          TextFormField(
                            validator: (val) =>
                                val==null? "حقل الاسم مطلوب " : null,
                            controller: numController,
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                                fillColor: Colors.grey.shade100,
                                filled: true,
                                hintText: "العدد",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                )),
                          ),
                          ElevatedButton(
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                 BlocProvider.of<VisitPlaceBloc>(context).add(SelectNumBrandAddEvent
                                   ("${noteText} : ${numController.text} \n"));
                                  Navigator.pop(context);
                                }
                              },
                              child: Text("حفظ"))
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
