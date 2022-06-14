import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map<String, double> dataMap = {
    "Food": 5,
    "Car": 1,
    "Pet": 3,
    "Gift": 2,
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
            Text(
              'Wednesday, 1 June',
              style:
                  TextStyle(color: Colors.green, fontWeight: FontWeight.w600),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 30),
              child: PieChart(
                dataMap: dataMap,
                chartType: ChartType.ring,
                baseChartColor: Colors.black.withOpacity(0.10),
                colorList: colorList,
                chartValuesOptions: ChartValuesOptions(
                  showChartValuesInPercentage: true,
                ),
                totalValue: 20,
              ),
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(onPressed: (){}, icon: Icon(Icons.menu), iconSize: 50, color: Colors.green,),
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
                IconButton(onPressed: (){}, icon: Icon(Icons.menu), iconSize: 50, color: Colors.green,),
              ],
            ),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  height: 120,
                  width: 120,
                  child: MaterialButton(
                    onPressed: (){},
                    color: Colors.green.shade50,
                    elevation: 0,
                    shape: CircleBorder(side: BorderSide(color: Colors.green.shade600, width: 7)), 
                    child: Text('Income', style: TextStyle(color: Colors.green.shade600),), 
                  ),
                ),
                SizedBox(
                  height: 120,
                  width: 120,
                  child: MaterialButton(
                    onPressed: (){},
                    color: Colors.red.shade50,
                    elevation: 0,
                    shape: CircleBorder(side: BorderSide(color: Colors.red.shade600, width: 7)), 
                    child: Text('Expenses', style: TextStyle(color: Colors.red.shade600),), 
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
