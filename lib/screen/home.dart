import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money_manage_app/screen/pengeluaran.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../api/globals.dart';
import 'pemasukan.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final dateString = '2022-06-16T10:31:12.000Z';

  Future getPengeluaran() async {
    var response = await http.get(Uri.parse(baseURL + 'pengeluaran'));
    var responseExp =
        await http.get(Uri.parse(baseURL + 'kategoriPengeluaran'));
    print({"e": json.decode(responseExp.body)});
    return {
      "p": json.decode(response.body),
      "e": json.decode(responseExp.body)
    };
  }

  final colorList = <Color>[
    Colors.greenAccent,
    Colors.amberAccent,
    Colors.blueAccent,
    Colors.redAccent
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('Home'),
      ),
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 320,
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: FutureBuilder(
                future: getPengeluaran(),
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.hasData) {
                    print(snapshot.data['p']['data'].length);
                    return ListView.builder(
                        itemCount: snapshot.data['p']['data'].length,
                        // itemCount: 5,
                        // scrollDirection: Axis.horizontal,
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
                            isSameDate = date.isSameDate(prevDate);
                          }
                          if (index == 0 || !(isSameDate)) {
                            return Column(children: [
                              Text(date.formatDate()),
                              Container(
                                height: 250,
                                child: PieChart(
                                  dataMap: {
                                    snapshot.data['e']['data'][index]['name']
                                            .toString():
                                        double.parse(snapshot.data['p']['data']
                                                [index]['pengeluaran']
                                            .toString()),
                                  },
                                  chartType: ChartType.ring,
                                  baseChartColor:
                                      Colors.black.withOpacity(0.10),
                                  colorList: colorList,
                                  chartValuesOptions: ChartValuesOptions(
                                    showChartValuesInPercentage: true,
                                  ),
                                  totalValue: 20,
                                ),
                              ),
                            ]);
                          } else {
                            return Container(
                              height: 250,
                              child: PieChart(
                                dataMap: {
                                  snapshot.data['e']['data'][index]['name']
                                          .toString():
                                      double.parse(snapshot.data['p']['data']
                                              [index]['pengeluaran']
                                          .toString()),
                                },
                                chartType: ChartType.ring,
                                baseChartColor: Colors.black.withOpacity(0.10),
                                colorList: colorList,
                                chartValuesOptions: ChartValuesOptions(
                                  showChartValuesInPercentage: true,
                                ),
                                totalValue: 100,
                              ),
                            );
                          }
                        });
                  } else {
                    return Text('Wait...');
                  }
                },
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.menu),
                  iconSize: 50,
                  color: Colors.green,
                ),
                Container(
                  height: 47,
                  width: 200,
                  child: ElevatedButton(
                    onPressed: null,
                    child: Text('data'),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.menu),
                  iconSize: 50,
                  color: Colors.green,
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  height: 120,
                  width: 120,
                  child: MaterialButton(
                    onPressed: () {Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => PemasukanScreen()));},
                    color: Colors.green.shade50,
                    elevation: 0,
                    shape: CircleBorder(
                        side:
                            BorderSide(color: Colors.green.shade600, width: 7)),
                    child: Text(
                      'Income',
                      style: TextStyle(color: Colors.green.shade600),
                    ),
                  ),
                ),
                SizedBox(
                  height: 120,
                  width: 120,
                  child: MaterialButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => PengeluaranScreen()));
                    },
                    color: Colors.red.shade50,
                    elevation: 0,
                    shape: CircleBorder(
                        side: BorderSide(color: Colors.red.shade600, width: 7)),
                    child: Text(
                      'Expenses',
                      style: TextStyle(color: Colors.red.shade600),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

const String dateFormatter = 'MMMM dd, y';

extension DateHelper on DateTime {
  String formatDate() {
    final formatter = DateFormat(dateFormatter);
    return formatter.format(this);
  }

  bool isSameDate(DateTime other) {
    return this.year == other.year &&
        this.month == other.month &&
        this.day == other.day;
  }

  int getDifferenceInDaysWithNow() {
    final now = DateTime.now();
    return now.difference(this).inDays;
  }
}
