import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../api/globals.dart';
import 'package:intl/intl.dart';

class HistoriPemasukan extends StatefulWidget {
  const HistoriPemasukan({Key? key}) : super(key: key);

  @override
  State<HistoriPemasukan> createState() => _HistoriPemasukanState();
}

class _HistoriPemasukanState extends State<HistoriPemasukan> {
  Future getPemasukan() async {
    var response = await http.get(Uri.parse(baseURL + 'pemasukan'));
    var responseExp = await http.get(Uri.parse(baseURL + 'kategoriPemasukan'));
    print({"e": json.decode(responseExp.body)});
    return {
      "p": json.decode(response.body),
      "e": json.decode(responseExp.body)
    };
  }

  @override
  Widget build(BuildContext context) {
    getPemasukan();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('Income History'),
      ),
      body: SingleChildScrollView(
        child: FutureBuilder(
          future: getPemasukan(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasData) {
              print(snapshot.data['p']['data'].length);
              return ListView.builder(
                  itemCount: snapshot.data['p']['data'].length,
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
                      final String prevDateString =
                          snapshot.data['p']['data'][index - 1]['tanggal'];
                      final DateTime prevDate = DateTime.parse(prevDateString);
                      isSameDate = date.isSameDate1(prevDate);
                    }
                    if (index == 0 || !(isSameDate)) {
                      return Column(children: [
                        SizedBox(
                          height: 20,
                        ),
                        Text(date.formatDate1()),
                        SizedBox(
                          height: 20,
                        ),
                        
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
                                  
                                Text(snapshot.data['e']['data'][0]['name']),
                                Text(snapshot.data['p']['data'][index]['pemasukan'].toString()),
                              ],),
                            )),
                        ),
                      ]);
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
                                Text(snapshot.data['e']['data'][1]['name']),
                                Text(snapshot.data['p']['data'][index]['pemasukan'].toString()),
                              ],),
                            )),
                      );
                    }
                  });
            } else {
              return Text('Wait...');
            }
          },
        ),
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
