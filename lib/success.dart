import 'package:flutter/material.dart';
import 'colors.dart';

class successPage extends StatefulWidget {
  const successPage({super.key});

  @override
  State<successPage> createState() => _successPageState();
}

class _successPageState extends State<successPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: buttoncolor,
        title: Text('Success'),
      ),
      body: Center(
        child: Text('Login Successful',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 40)),
      ),
    );
  }
}
