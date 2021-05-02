import 'package:api_test/views/home_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MaterialApp(
    title: "Aplicativo API",
    debugShowCheckedModeBanner: false,
    home: HomePage(),
  ));
}
