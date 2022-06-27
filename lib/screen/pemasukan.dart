import 'dart:convert';
import 'package:money_manage_app/screen/home.dart';

import '../../api/globals.dart';
import 'package:flutter/material.dart';
import 'dart:core';
import 'package:intl/intl.dart';
import 'package:money_manage_app/button/buttons.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:http/http.dart' as http;

class PemasukanScreen extends StatefulWidget {
  const PemasukanScreen({Key? key}) : super(key: key);

  @override
  State<PemasukanScreen> createState() => _PemasukanScreenState();
}

class _PemasukanScreenState extends State<PemasukanScreen> {
// Tanggal Sekarang
  static var today = new DateTime.now();
  var formatedTanggal = DateFormat('yyyy/MM/dd').format(today);

  // Action
  var userInput = '';
  bool showKeyboard = true;
  bool showList = false;
  var id_kategori;

  // kalkulator
  final List<String> buttons = [
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
  Future savePemasukan() async {
    final response = await http.post(Uri.parse(baseURL+'pemasukan'), body: {
      "pemasukan": userInput,
      "tanggal": formatedTanggal.toString(),
      "id_kategoriPemasukan": id_kategori.toString()
    });
    print(response.body);

    return json.decode(response.body);
  }

  Future getPemasukan() async {
    var response = await http.get(Uri.parse(baseURL + 'pemasukan'));
    var responseExp =
        await http.get(Uri.parse(baseURL + 'kategoriPemasukan'));
    print({"p": json.decode(response.body)});
    return {
      "p": json.decode(response.body),
      "e": json.decode(responseExp.body)
    };
  }

  @override
  Widget build(BuildContext context) {
    getPemasukan();
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 242, 248, 220),
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
                              userInput =
                                  userInput.substring(0, userInput.length - 1);
                            });
                          },
                          icon: Icon(
                            Icons.delete,
                            color: Colors.green.shade900,
                          )),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            //switch screen
            showKeyboard ? keyboard() : Container(),
            showList ? expenseList() : Container(),
            Divider(),
            // choose category
            Container(
              margin: EdgeInsets.all(10),
              height: 50.0,
              width: 200.0,
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7.0),
                    side: BorderSide(color: Color.fromARGB(255, 146, 240, 24))),
                onPressed: () {
                  setState(() {
                    showKeyboard = false;
                    showList = true;
                  });
                },
                padding: EdgeInsets.all(10.0),
                color: Colors.white,
                textColor: Color.fromARGB(255, 39, 219, 22),
                child: Text("Choose Category", style: TextStyle(fontSize: 15)),
              ),
            ),
          ],
        ));
  }
FutureBuilder expenseList() {
    return FutureBuilder(
      future: getPemasukan(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasData) {
          return GridView.builder(
              itemCount: snapshot.data['e']['data'].length,
              shrinkWrap: true,
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
              itemBuilder: (context, index) {
                if (index == 0) {
                  return ButtonsPengeluaran(
                    buttonTapped: () {
                    setState(() {
                      id_kategori = snapshot.data['e']['data'][index]['id'] = 1;
                      savePemasukan();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => Home()));
                    });
                  },
                    buttonText: snapshot.data['e']['data'][index]['name'].toString(),
                  );
                  
                }else if (index == 1) {
                  return ButtonsPengeluaran(
                    buttonTapped: () {
                    setState(() {
                      id_kategori = snapshot.data['e']['data'][index]['id'] = 2;
                      savePemasukan();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => Home()));
                    });
                  },
                    buttonText: snapshot.data['e']['data'][index]['name'].toString(),
                  );
                  
                }else if (index == 2) {
                  return ButtonsPengeluaran(
                    buttonTapped: () {
                    setState(() {
                      id_kategori = snapshot.data['e']['data'][index]['id'] = 3;
                      savePemasukan();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => Home()));
                    });
                  },
                    buttonText: snapshot.data['e']['data'][index]['name'].toString(),
                  );
                  
                }else if (index == 3) {
                  return ButtonsPengeluaran(
                    buttonTapped: () {
                    setState(() {
                      id_kategori = snapshot.data['e']['data'][index]['id'] = 4;
                      savePemasukan();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => Home()));
                    });
                  },
                    buttonText: snapshot.data['e']['data'][index]['name'].toString(),
                  );
                  
                }else if (index == 4) {
                  return ButtonsPengeluaran(
                    buttonTapped: () {
                    setState(() {
                      id_kategori = snapshot.data['e']['data'][index]['id'] = 5;
                      savePemasukan();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => Home()));
                    });
                  },
                    buttonText: snapshot.data['e']['data'][index]['name'].toString(),
                  );
                  
                }else if (index == 5) {
                   return ButtonsPengeluaran(
                    buttonTapped: () {
                    setState(() {
                      id_kategori = snapshot.data['e']['data'][index]['id'] = 6;
                      savePemasukan();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => Home()));
                    });
                  },
                    buttonText: snapshot.data['e']['data'][index]['name'].toString(),
                  );
                  
                }
                 return InkWell(
                  onTap: () {
                    savePemasukan();
                    
                  },
                  child: ButtonsPengeluaran(
                    buttonText: snapshot.data['e']['data'][index]['name'].toString(),
                  ),
                );
              });
        } else {
          return Text('Wait...');
        }
      },
    );
  }

  Expanded keyboard() {
    return Expanded(
      flex: 3,
      child: Container(
        child: GridView.builder(
            itemCount: buttons.length,
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
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
                  color: Color.fromARGB(255, 29, 103, 141),
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
                      ? Colors.green.shade700
                      : Colors.green.shade300,
                  textColor:
                      isOperator(buttons[index]) ? Colors.white : Colors.white,
                );
              }
            }), // GridView.builder
      ),
    );
  }

  bool isOperator(String x) {
    if (x == '%' || x == '/' || x == 'x' || x == '-' || x == '+' || x == '=') {
      return true;
    }
    return false;
  }

  void equalPressed() {
    String finalQuestion = userInput;
    finalQuestion = userInput.replaceAll('x', '*');

    Parser p = Parser();
    Expression exp = p.parse(finalQuestion);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);

    userInput = eval.toString();
  }
}
