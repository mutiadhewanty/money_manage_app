import 'package:flutter/material.dart';
import 'dart:core';
import 'package:intl/intl.dart';

class PengeluaranScreen extends StatefulWidget {
  const PengeluaranScreen({Key? key}) : super(key: key);

  @override
  State<PengeluaranScreen> createState() => _PengeluaranScreenState();
}

class _PengeluaranScreenState extends State<PengeluaranScreen> {
  // Tanggal Sekarang
  static var today = new DateTime.now();
  var formatedTanggal = new DateFormat.yMMMd().format(today);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('New Expense'),
      ),
      body: Container(
          padding: EdgeInsets.all(15.0),
          margin: EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.date_range,
                size: 20.0,
              ),
              Text(
                formatedTanggal.toString(),
              ),
            ],
          )),
    );
  }
}
