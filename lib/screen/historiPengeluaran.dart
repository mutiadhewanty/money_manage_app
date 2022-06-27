import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../api/globals.dart';
import 'package:intl/intl.dart';

class HistoriPengeluaran extends StatefulWidget {
  const HistoriPengeluaran({Key? key}) : super(key: key);

  @override
  State<HistoriPengeluaran> createState() => _HistoriPengeluaranState();
}

class _HistoriPengeluaranState extends State<HistoriPengeluaran> {

  Future getPengeluaran() async {
    var response = await http.get(Uri.parse(baseURL + 'pengeluaran'));
    var responseExp =
        await http.get(Uri.parse(baseURL + 'kategoriPengeluaran'));
    print({"p": json.decode(responseExp.body)});
    return {
      "p": json.decode(response.body),
      "e": json.decode(responseExp.body)
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('Expense History'),
      ),
      body: FutureBuilder(
        future: getPengeluaran(),
        builder:
            (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            print(snapshot.data['p']['data']);
            return ListView.builder(
                itemCount: snapshot.data['p']['data'].length,
                // itemCount: 5,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  bool isSameDate = true;
                  final String dateString =
                      snapshot.data['p']['data'][index]['tanggal'];
                  final DateTime date = DateTime.parse(dateString);
                  final item = snapshot.data['p']['data'][index];
                  if (index == 0) {
                    isSameDate = false;
                  } else {
                    final String prevDateString = snapshot.data['p']
                        ['data'][index - 1]['tanggal'];
                    final DateTime prevDate =
                        DateTime.parse(prevDateString);
                    isSameDate = date.isSameDate1(prevDate);
                  }
                  if (index == 0 || !(isSameDate)) {
                    return Column(children: [
                      SizedBox(height: 20,),
                      Text(date.formatDate1()),
                      SizedBox(height: 20,),
                      Card(
                        // color: Colors.blueAccent,
                        child: Container(
                          // color: Colors.amber,
                          height: 50,
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                              Text(snapshot.data['e']['data'][index]['name'].toString()),
                              Text(snapshot.data['p']['data'][index]['pengeluaran'].toString()),
                            ],),
                          )
                        ),
                      ),
                    ]
                    );
                  } else {
                    return Card(
                        child: Container(
                          height: 50,
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                              Text(snapshot.data['e']['data'][index]['name'].toString()),
                              Text(snapshot.data['p']['data'][index]['pengeluaran'].toString()),
                            ],),
                          )
                        ),
                      );
                  }
                });
          } else {
            return Text('Wait...');
          }
        },
      ),
    );
  }
}
const String dateFormatter = 'MMMM dd, y';

extension DateHelper on DateTime {
  String formatDate1() {
    final formatter = DateFormat(dateFormatter);
    return formatter.format(this);
  }

  bool isSameDate1(DateTime other) {
    return this.year == other.year &&
        this.month == other.month &&
        this.day == other.day;
  }

  int getDifferenceInDaysWithNow() {
    final now = DateTime.now();
    return now.difference(this).inDays;
  }
}