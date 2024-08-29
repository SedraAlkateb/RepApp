import 'package:domina_app/app/app.dart';
import 'package:domina_app/app/di.dart';
import 'package:flutter/material.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await initAppModule();
  runApp(const MyApp());
}

