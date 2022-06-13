import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:core';
import 'package:money_manage_app/button/buttonsPemasukan.dart';

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
        title: Text('New Income'),
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
          Expanded(
              flex: 4,
              child: Container(
                child: Center(
                  child: GridView.builder(
                      itemCount: buttons.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4),
                      itemBuilder: (BuildContext context, int index) {
                        if (index == 15) {
                          return ButtonsPemasukan(
                            buttonText: buttons[index],
                            color: Colors.blue,
                            textColor: Colors.white,
                          );
                        } else if (index == buttons.length - 1) {
                          return ButtonsPemasukan(
                            buttonTapped: () {
                              setState(() {
                                equalsPressed();
                              });
                            },
                            buttonText: buttons[index],
                            color: Colors.lightGreen,
                            textColor: Colors.white,
                          );
                        } else {
                          return ButtonsPemasukan(
                            buttonTapped: () {
                              setState(() {
                                userQuestion += buttons[index];
                              });
                            },
                            buttonText: buttons[index],
                            color: isOperator(buttons[index])
                                ? Colors.lightGreen
                                : Colors.lightGreen,
                            textColor: isOperator(buttons[index])
                                ? Colors.white
                                : Colors.white,
                          );
                        }
                      }),
                ),
              )),
          Container(
            margin: EdgeInsets.all(10),
            height: 50.0,
            width: 200.0,
            child: RaisedButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7.0),
                  side: BorderSide(color: Color.fromARGB(255, 146, 240, 24))),
              onPressed: () {},
              padding: EdgeInsets.all(10.0),
              color: Colors.white,
              textColor: Color.fromARGB(255, 39, 219, 22),
              child: Text("Choose Category", style: TextStyle(fontSize: 15)),
            ),
          ),
        ],
      ),
    );
  }

  bool isOperator(String x) {
    if (x == '%' || x == '/' || x == 'x' || x == '-' || x == '+' || x == '=') {
      return true;
    }
    return false;
  }

  void equalsPressed() {}
}
