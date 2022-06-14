import 'package:flutter/material.dart';
import 'package:money_manage_app/screen/home.dart';

import 'screen/register.dart';



void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Euphoria',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: Colors.white,
          visualDensity: VisualDensity.adaptivePlatformDensity),
      home: const ExpenseScreen(),
    );
  }
}

class ExpenseScreen extends StatefulWidget {
  const ExpenseScreen({ Key? key }) : super(key: key);

  @override
  State<ExpenseScreen> createState() => _ExpenseScreenState();
}

class _ExpenseScreenState extends State<ExpenseScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Expense'),
        backgroundColor: Colors.green,
      ),
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.date_range_rounded),
                Text('Tuesday, 7 June')
              ],
            ),
            SizedBox(
              
            )
          ],
        ),
      ),
    );
  }
}

