import 'dart:io';
import 'package:eventos_app/pages/home_page.dart';
import 'package:flutter/material.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Eventos App',
        theme: ThemeData(
          primarySwatch: Colors.deepOrange
        ),
        home: const HomePage(),
    );
  }
}
