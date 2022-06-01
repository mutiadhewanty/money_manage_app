import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class Home extends StatefulWidget {
  const Home({ Key? key }) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Map<String, double> dataMap = {
    "Flutter": 5,
    "React": 3,
    "Xamarin": 2,
    "Ionic": 2,
  };

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
            Text('Wednesday, 1 June'),

            Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
        child: PieChart(
          dataMap: dataMap,
          chartType: ChartType.ring,
          baseChartColor: Colors.black!.withOpacity(0.10),
          colorList: colorList,
          chartValuesOptions: ChartValuesOptions(
            showChartValuesInPercentage: true,
          ),
          totalValue: 20,
        ),
            )

          ],
        ),
      ),
    );
  }
}