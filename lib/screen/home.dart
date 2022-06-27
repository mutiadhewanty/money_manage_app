import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money_manage_app/screen/historiPengeluaran.dart';
import 'package:money_manage_app/screen/pengeluaran.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../api/globals.dart';
import 'historiPemasukan.dart';
import 'pemasukan.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final dateString = '2022-06-16T10:31:12.000Z';
  late List<GDPData> _chartData;
  late TooltipBehavior _tooltipBehavior;

  void initState() {
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }


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

  Future getPemasukan() async {
    var response = await http.get(Uri.parse(baseURL + 'pemasukan'));
    var responseExp =
        await http.get(Uri.parse(baseURL + 'kategoriPemasukan'));
    print({"p": json.decode(response.body)});
    return {
      "p1": json.decode(response.body),
      "i": json.decode(responseExp.body)
    };
  }

  void jumlahPemasukan(AsyncSnapshot<dynamic> snapshot, int index){
    final jumlahPemasukan = snapshot.data['p1']['data'][index]['pemasukan'] += snapshot.data['p1']['data'][index]['pemasukan'];
  }

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
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          _chartData = getChartData(snapshot, index);
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
                                
                                child: SfCircularChart(
                                  legend: Legend(
                                      isVisible: true,
                                      overflowMode:
                                          LegendItemOverflowMode.wrap),
                                  tooltipBehavior: _tooltipBehavior,
                                  series: <CircularSeries>[
                                    DoughnutSeries<GDPData, String>(
                                        dataSource: _chartData,
                                        // [
                                        //   GDPData(
                                        //       snapshot.data['e']['data'][index]['name'].toString(),
                                        //       double.parse(snapshot.data['p']['data'][index]['pengeluaran'].toString())),
                                        // ],
                                        xValueMapper: (GDPData data, _) =>
                                            data.kategori,
                                        yValueMapper: (GDPData data, _) =>
                                            data.pengeluaran,
                                        dataLabelSettings:
                                            const DataLabelSettings(
                                                isVisible: true))
                                  ],
                                ),
                              ),
                            ]);
                          } else {
                            return Container(
                              height: 0,
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
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => HistoriPemasukan()));
                  },
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
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => HistoriPengeluaran()));
                  },
                  icon: Icon(Icons.menu),
                  iconSize: 50,
                  color: Colors.red,
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
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => PemasukanScreen()));
                    },
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

  List<GDPData> getChartData(AsyncSnapshot<dynamic> snapshot, int index) {

      late List<GDPData>chartData = [
      GDPData(
          snapshot.data['e']['data'][index]['name'].toString(),
          double.parse(
              snapshot.data['p']['data'][index]['pengeluaran'].toString())),
      
    ];

    return chartData;
  }

  // PieChart pieChart(AsyncSnapshot<dynamic> snapshot, int index) {
  //   final dataMap = <String, double>{
  //   snapshot.data['e']['data'][index]['name'].toString(): double.parse(
  //           snapshot.data['p']['data'][index]['pengeluaran'].toString()),
  // };
  //   return PieChart(
  //     dataMap: dataMap,
  //     animationDuration: Duration(milliseconds: 800),
  //     chartType: ChartType.ring,
  //     initialAngleInDegree: 0,
  //     baseChartColor: Colors.black.withOpacity(0.10),
  //     colorList: colorList,
  //     chartValuesOptions: ChartValuesOptions(
  //       showChartValueBackground: true,
  //       showChartValues: true,
  //       showChartValuesInPercentage: false,
  //       showChartValuesOutside: false,
  //       decimalPlaces: 1,
  //     ),
  //     totalValue: 20,
  //   );
  // }
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

class GDPData {
  GDPData(this.kategori, this.pengeluaran);
  final String kategori;
  final double pengeluaran;
}
