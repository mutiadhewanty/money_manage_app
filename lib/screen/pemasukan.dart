import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PemasukanScreen extends StatefulWidget {
  const PemasukanScreen({Key? key}) : super(key: key);

  @override
  State<PemasukanScreen> createState() => _PemasukanScreenState();
}

class _PemasukanScreenState extends State<PemasukanScreen> {
  static var today = new DateTime.now();
  var formatedTanggal = new DateFormat.yMMMd().format(today);

  var userQuestion = '';
  var userAnswer = '';

  final List<String> buttons = [
    '1',
    '2',
    '3',
    '+',
    '4',
    '5',
    '6',
    '-',
    '7',
    '8',
    '9',
    'x',
    '.',
    '0',
    '/',
    '=',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('Income Monefy'),
      ),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(7.0),
            margin: EdgeInsets.all(7.0),
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
            ),
          ),
          Container(
            padding: EdgeInsets.all(7.0),
            margin: EdgeInsets.all(7.0),
            child: TextField(
              decoration: InputDecoration(
                  enabled: false,
                  hintText: 'hint',
                  helperText: 'helper',
                  labelText: 'Note',
                  prefixIcon: Icon(Icons.pending_actions_outlined),
                  counterText: 'counter'),
            ),
          ),
        ],
      ),
    );
  }
}
