/*
import 'package:flutter/material.dart';
void main() => runApp(new MaterialApp(
      home: MyApp(),
    ));

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  final formKey = new GlobalKey<FormState>();

  late String _email, _pass;

  _showSnackbar() {
    var snackBar = new SnackBar(content: Text("Login Successful"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextFormField(
                validator: (val) =>
                    val!.length < 3 ? " username is not Valid" : null,
                onSaved: (val) => _email = val!,
                decoration: InputDecoration(
                    labelText: "username", hintText: "Enter username"),
              ),
              SizedBox(height: 0.3),
              TextFormField(
                onSaved: (val) => _pass = val!,
                validator: (val) => val!.length < 6
                    ? "Password length should be Greater than 6"
                    : null,
                decoration: InputDecoration(
                    labelText: "Password", hintText: "Enter Password"),
              ),
              Padding(
                padding: EdgeInsets.all(15.0),
                child: ElevatedButton(
                  child: Text("LogIn"),
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      formKey.currentState!.save();

                      _showSnackbar();
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
*/