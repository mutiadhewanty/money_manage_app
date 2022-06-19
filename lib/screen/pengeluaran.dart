import 'dart:convert';

import 'package:flutter/material.dart';
import 'dart:core';
import 'package:intl/intl.dart';
import 'package:money_manage_app/button/buttons.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:http/http.dart' as http;

class PengeluaranScreen extends StatefulWidget {
  const PengeluaranScreen({Key? key}) : super(key: key);

  @override
  State<PengeluaranScreen> createState() => _PengeluaranScreenState();
}

class _PengeluaranScreenState extends State<PengeluaranScreen> {
  // Tanggal Sekarang
  static var today = new DateTime.now();
  var formatedTanggal = new DateFormat.yMMMd().format(today);

  // Action
  var userInput = '';
  var answer = '0';

  // kalkulator
  final List<String> buttons = [
    // 'C',
    // '+/-',
    // '%',
    // 'DEL',
    '7',
    '8',
    '9',
    '/',
    '4',
    '5',
    '6',
    'x',
    '1',
    '2',
    '3',
    '-',
    '0',
    '.',
    '=',
    '+',
  ];
  final String url = 'http://10.0.2.2:8000/api/pengeluaran';
  Future saveOrder() async {
    final response = await http.post(Uri.parse(url), body: {
      "pengeluaran": userInput,
      "tanggal": formatedTanggal.toString()
    });
    print(response.body);

    return json.decode(response.body);
  }

  Future getPengeluaran() async {
    var response = await http.get(Uri.parse(url));
    print(json.decode(response.body));
    return json.decode(response.body);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 242, 248, 220),
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: Text('New Expense'),
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
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          width: 250,
                          decoration: BoxDecoration(
                              color: Colors.green.shade200,
                              borderRadius: BorderRadius.circular(10)),
                          padding: EdgeInsets.all(10),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            userInput,
                            style: TextStyle(fontSize: 20),
                          )),
                      SizedBox(
                        width: 20,
                      ),
                      IconButton(
                          onPressed: () {
                            setState(() {
                              userInput = userInput.substring(0,userInput.length-1);
                            });
                          },
                          icon: Icon(Icons.delete, color: Colors.green.shade900,)),
                    ],
                  ),
                  Container(
                      padding: EdgeInsets.all(10),
                      alignment: Alignment.centerRight,
                      child: Text(
                        answer,
                        style: TextStyle(fontSize: 20),
                      )),
                ],
              ),
              // padding: EdgeInsets.all(7.0),
              // margin: EdgeInsets.all(7.0),
              // child: TextField(
              //   decoration: InputDecoration(
              //       filled: true,
              //       fillColor: Color.fromARGB(255, 195, 238, 145),
                    // suffixIcon: Icon(Icons.delete_forever),
              //       border: OutlineInputBorder(
              //         borderRadius: BorderRadius.circular(9),
              //         borderSide: BorderSide.none,
              //       )),
              // ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
                // padding: EdgeInsets.all(7.0),
                // margin: EdgeInsets.all(7.0),
                // child: TextField(
                //   decoration: InputDecoration(
                //       enabled: false,
                //       hintText: 'hint',
                //       helperText: 'helper',
                //       labelText: 'Note',
                //       prefixIcon: Icon(Icons.pending_actions_outlined),
                //       counterText: 'counter'),
                // ),
                ),

            // Expanded(
            //     flex: 4,
            //     child: Container(
            //       child: Center(
            //         child: GridView.builder(
            //             itemCount: buttons.length,
            //             gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            //                 crossAxisCount: 4),
            //             itemBuilder: (BuildContext context, int index) {
            //               if (index == 15) {
            //                 return ButtonsPengeluaran(
            //                   buttonText: buttons[index],
            //                   color: Colors.blue,
            //                   textColor: Colors.white,
            //                 );
            //               }
            //               // tanda =
            //               else if (index == buttons.length - 1) {
            //                 return ButtonsPengeluaran(
            //                   buttonTapped: () {
            //                     setState(() {
            //                       equalPressed();
            //                     });
            //                   },
            //                   buttonText: buttons[index],
            //                   color: Colors.lightGreen,
            //                   textColor: Colors.white,
            //                 );
            //               } else {
            //                 return ButtonsPengeluaran(
            //                   buttonTapped: () {
            //                     setState(() {
            //                       userQuestion += buttons[index];
            //                     });
            //                   },
            //                   buttonText: buttons[index],
            //                   color: isOperator(buttons[index])
            //                       ? Colors.lightGreen
            //                       : Colors.lightGreen,
            //                   textColor: isOperator(buttons[index])
            //                       ? Colors.white
            //                       : Colors.white,
            //                 );
            //               }
            //             }),
            //       ),
            //     )),

            Expanded(
            flex: 3,
            child: Container(
              child: GridView.builder(
                  itemCount: buttons.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4),
                  itemBuilder: (BuildContext context, int index) {
                    
                    // Equal_to Button
                    if (index == 14) {
                      return ButtonsPengeluaran(
                        buttonTapped: () {
                          setState(() {
                            equalPressed();
                          });
                        },
                        buttonText: buttons[index],
                        color: Colors.orange[700],
                        textColor: Colors.white,
                      );
                    }
 
                    //  other buttons
                    else {
                      return ButtonsPengeluaran(
                        buttonTapped: () {
                          setState(() {
                            userInput += buttons[index];
                          });
                        },
                        buttonText: buttons[index],
                        color: isOperator(buttons[index])
                            ? Colors.blueAccent
                            : Colors.white,
                        textColor: isOperator(buttons[index])
                            ? Colors.white
                            : Colors.black,
                      );
                    }
                  }), // GridView.builder
            ),
          ),
            // choose category
            // Container(
            //   margin: EdgeInsets.all(10),
            //   height: 50.0,
            //   width: 200.0,
            //   child: RaisedButton(
            //     shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(7.0),
            //         side: BorderSide(color: Color.fromARGB(255, 146, 240, 24))),
            //     onPressed: () {},
            //     padding: EdgeInsets.all(10.0),
            //     color: Colors.white,
            //     textColor: Color.fromARGB(255, 39, 219, 22),
            //     child: Text("Choose Category", style: TextStyle(fontSize: 15)),
            //   ),
            // ),
            Center(
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: const Color.fromARGB(255, 25, 27, 193),
                          padding: EdgeInsets.only(
                              left: 80, right: 80, top: 15, bottom: 15)),
                      child: const Text(
                        'Submit',
                        style: TextStyle(fontSize: 15),
                      ),
                      onPressed: () {
                        saveOrder();
                        
                      }),
                )
          ],
        ));
  }

  bool isOperator(String x) {
    if (x == '%' || x == '/' || x == 'x' || x == '-' || x == '+' || x == '=') {
      return true;
    }
    return false;
  }

  void equalPressed() {
    String finalQuestion = userInput;

    Parser p = Parser();
    Expression exp = p.parse(finalQuestion);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);

    answer = eval.toString();
  }
}
