import 'package:flutter/material.dart';

class PemasukanScreen extends StatefulWidget {
  const PemasukanScreen({Key? key}) : super(key: key);

  @override
  State<PemasukanScreen> createState()=> _PemasukanScreenState();
  
}

class _PemasukanScreenState extends State<PemasukanScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('Income Monefy'),
      ),
    );
  }

}
