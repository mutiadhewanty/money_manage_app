import 'package:flutter/material.dart';
import 'package:money_manage_app/screen/home.dart';
import 'package:money_manage_app/screen/login.dart';
import 'package:money_manage_app/screen/pemasukan.dart';
import 'package:money_manage_app/screen/pengeluaran.dart';
import 'screen/register.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Euphoria',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: Colors.white,
          visualDensity: VisualDensity.adaptivePlatformDensity),

          home: const Home(),

    );
  }
}