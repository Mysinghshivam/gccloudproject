import 'dart:convert';
import 'package:gccloudproject/success.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import 'colors.dart';
import 'error.dart';

class loginPage extends StatefulWidget {
  const loginPage({super.key});

  @override
  State<loginPage> createState() => _loginPageState();
}

class _loginPageState extends State<loginPage> {
  ///define all the variables
  String? selectedChief;
  String? selectedSE;
  String? selectedEE;
  List<String> chiefs = [];
  List<String> seList = [];
  List<String> eeList = [];
  final TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchChiefs();
  }

  ///fetching first dropdown list from api
  Future<void> fetchChiefs() async {
    try {
      final response =
          await http.get(Uri.parse("http://117.250.2.226:6060/mobile/ce2"));
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        final List<dynamic> uniqueChiefs = responseData['data'].toList();
        setState(() {
          chiefs = uniqueChiefs.cast<String>();
        });
      } else {
        throw Exception('Failed to load chiefs');
      }
    } catch (error) {
      print(error);
    }
  }

  ///fetching second dropdown list from api
  Future<void> fetchSEs(String chief) async {
    try {
      final response = await http
          .get(Uri.parse("http://117.250.2.226:6060/mobile/se/$chief"));
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        final List<dynamic> uniqueSEs = responseData['data'].toSet().toList();
        setState(() {
          seList = uniqueSEs.cast<String>();
        });
      } else {
        throw Exception('Failed to load SEs');
      }
    } catch (error) {
      print(error);
    }
  }

  ///fetching third dropdown list from api
  Future<void> fetchEEs(String se) async {
    try {
      final response =
          await http.get(Uri.parse("http://117.250.2.226:6060/mobile/ee/$se"));
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        final List<dynamic> uniqueEEs = responseData['data'].toList();
        setState(() {
          eeList = uniqueEEs.cast<String>();
        });
      } else {
        throw Exception('Failed to load EEs');
      }
    } catch (error) {
      print(error);
    }
  }

  ///triggering the login api
  Future<void> loginUser() async {
    if (selectedEE != null) {
      final String username = selectedEE!;
      final String password = passwordController.text;
      final response = await http.post(
        Uri.parse(
            "http://117.250.2.226:6060/mobile/login?username=$username&password=$password"),
      );
      if (response.statusCode == 200) {
         Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => successPage()),
        );
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => errorPage()),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        //main body container
        padding: const EdgeInsets.symmetric(horizontal: 15),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Container(
            //middle Textfields container
            decoration: BoxDecoration(
              color: Colors.blue,
              // Background color
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3), // Shadow position
                ),
              ],
              gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.blue, Colors.green], // Gradient colors
              ),
              border: Border.all(
                color: Colors.red, // Border color
                width: 2, // Border width
              ),
              // Border radius
            ),
            height: 550,
            child: Padding(
              padding: EdgeInsets.only(left: 30, right: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    "Select Your Division",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(
                    height: 45,
                  ),
                  _dropdown1(),
                  const SizedBox(height: 20),
                  _dropdown2(),
                  const SizedBox(height: 20),
                  _dropdown3(),
                   const SizedBox(height: 20),
                  _passTextField(),
                  const SizedBox(height: 25),
                  _signInButton()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// gclogo
  /*Widget _gcLogo() {
    return Container(
      height: 160,
      width: 160,
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/gccloudlogoremovebg.png'),
              fit: BoxFit.cover)),
    );
  }*/

  ///all the dropdowns one by one with 1,2,3
  Widget _dropdown1() {
    return DropdownButton<String>(
      value: selectedChief,
      hint: const Text(
        'Select Chief',
        style: TextStyle(fontSize: 22, fontWeight: FontWeight.w400),
      ),
      onChanged: (String? newValue) {
        setState(() {
          selectedChief = newValue;
          selectedSE = null; // Reset SE selection when Chief changes
          selectedEE = null; // Reset EE selection when Chief changes
          fetchSEs(selectedChief!);
        });
      },
      items: chiefs.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),

      // DropdownButton decoration
      iconSize: 30,
      // Dropdown icon size
      elevation: 16,
      // Elevation
      style: const TextStyle(color: Colors.black),
      // Text style
      dropdownColor: Colors.white,
      // Dropdown background color
      isExpanded: true, // Expand dropdown to fit width
    );
  }

  Widget _dropdown2() {
    return DropdownButton<String>(
      value: selectedSE,
      hint:const Text(
        'Select SE',
        style: TextStyle(fontSize: 22, fontWeight: FontWeight.w400),
      ),
      onChanged: (String? newValue) {
        setState(() {
          selectedSE = newValue;
          selectedEE = null; // Reset EE selection when SE changes
          fetchEEs(selectedSE!);
        });
      },
      items: seList.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      // DropdownButton decoration
      iconSize: 30,
      // Dropdown icon size
      elevation: 16,
      // Elevation
      dropdownColor: Colors.white,
      // Dropdown background color
      isExpanded: true,
    );
  }

  Widget _dropdown3() {
    return DropdownButton<String>(
      value: selectedEE,
      hint: const Text(
        'Select EE',
        style: TextStyle(fontSize: 22, fontWeight: FontWeight.w400),
      ),
      onChanged: (String? newValue) {
        setState(() {
          selectedEE = newValue;
        });
      },
      items: eeList.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),

      // DropdownButton decoration
      iconSize: 24,
      // Dropdown icon size
      elevation: 16,
      // Elevation
      style: const TextStyle(
        color: Colors.black,
      ),
      // Text style
      dropdownColor: Colors.white,
      // Dropdown background color
      isExpanded: true,
    );
  }

  Widget _passTextField() {
    return TextFormField(
      controller: passwordController,
      obscureText: true,
      decoration: const InputDecoration(
          hintText: 'password',
          hintStyle: TextStyle(fontSize: 22, fontWeight: FontWeight.w400)),
    );
  }

  Widget _signInButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: const StadiumBorder(),
        elevation: 10,
        shadowColor: buttoncolor,
        minimumSize: const Size.fromHeight(40),
      ),
      onPressed: () {
        loginUser();
      },
      child: const Text(
        'SIGN IN',
        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
      ),
    );
  }
}
