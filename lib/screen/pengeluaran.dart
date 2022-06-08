import 'package:flutter/material.dart';

class PengeluaranScreen extends StatefulWidget {
  const PengeluaranScreen({Key? key}) : super(key: key);

  @override
  State<PengeluaranScreen> createState() => _PengeluaranScreenState();
}

class _PengeluaranScreenState extends State<PengeluaranScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('New Expense'),
      ),
    );
  }
}
