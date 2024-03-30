import 'package:flutter/material.dart';
import 'colors.dart';

class errorPage extends StatefulWidget {
  const errorPage({super.key});

  @override
  State<errorPage> createState() => _errorPageState();
}

class _errorPageState extends State<errorPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: buttoncolor,
        title: Text('Error'),
      ),
      body: Center(
        child: Text('Login Failed',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 40),),
      ),
    );
  }
}
