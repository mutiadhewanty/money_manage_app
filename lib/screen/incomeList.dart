import 'package:flutter/material.dart';

class IncomeListScreen extends StatelessWidget {
  const IncomeListScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Income List'),
        backgroundColor: Colors.green,
      ),
    );
  }
}