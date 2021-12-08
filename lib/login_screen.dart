import 'dart:math';
import 'dart:async';
import 'dart:convert';

import 'package:assessment_task/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

dynamic my_login = '';
dynamic my_password = '';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _controller = TextEditingController()
    ..text = my_login;
  final TextEditingController _password = TextEditingController()
    ..text = my_password;

  bool showProgress = false;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
        body: Container(
      height: height,
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 0,
            left: 0,
            child: Container(
              //padding: EdgeInsets.symmetric(horizontal: 0),
              height: MediaQuery.of(context).size.height * 0.5,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/illus_intro.png"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: height * .55),
                  SizedBox(height: 5),
                  Column(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            TextField(
                                controller: _controller,
                                obscureText: false,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  fillColor: Color(0xfff3f3f4),
                                  filled: true,
                                  labelText: 'login',
                                ))
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            TextField(
                                controller: _password,
                                obscureText: true,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  fillColor: Color(0xfff3f3f4),
                                  filled: true,
                                  labelText: 'password',
                                ))
                          ],
                        ),
                      )
                    ],
                  ),
                  //SizedBox(height: 20),

                  Card(
                    color: Color(0xff242424),
                    child: InkWell(
                      child: Container(
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.symmetric(vertical: 15),
                        child:


                            Text(
                              'CONNEXION',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),


                      ),

                      onTap: () async {
                        setState(() {
                          showProgress = true;
                        });
                        my_login = _controller.text;
                        my_password = _password.text;
                        var result = await http.post(
                          Uri.parse(
                              'https://kinosnap.com/wp-admin/admin-ajax.php'),
                          body: {
                            'action': 'kinosnap_ajax_login',
                            'user_login': _controller.text,
                            'user_password': _password.text
                          },
                        );
                        setState(() {
                          showProgress = false;
                        });
                        print(jsonDecode(result.body)['loggedin']);
                        if (result.statusCode == 200) {
                          print('status = 200');

                          if (jsonDecode(result.body)['loggedin'] == true) {
                            print('Successfully signed in.');
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return HomeScreen();
                                },
                              ),
                            );
                          } else {
                            _showDialog('Wrong credentials');
                          }
                        } else if (result.statusCode == 401) {
                          _showDialog('Unable to sign in.');
                          print('Unable to sign in.');
                        } else {
                          _showDialog(
                              'Something went wrong. Please try again.');
                          print('Something went wrong. Please try again.');
                        }
                        ;
                      },
                    ),
                    elevation: 2,
                  ),
                  SizedBox(height: 15),
                  Column(
                      children: [
                        new Container(
                          height: 60,
                          alignment: Alignment.center,
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.symmetric(vertical: 5),
                          child: showProgress ? CircularProgressIndicator() : Text(''),
                        ),
                      ]
                  ),
                  SizedBox(height: height * .055),

                ],
              ),
            ),
          ),
          Positioned(
            top: 40,
            left: 0,
            child: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(left: 0, top: 10, bottom: 10),
                      child:
                          Icon(Icons.keyboard_arrow_left, color: Colors.black),
                    ),
                    Text('Back',
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w500))
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    ));
  }

  void _showDialog(String message) {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(message),
        actions: [
          TextButton(
            child: const Text('OK'),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }

  void _showLoadingDialog(String message) {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(message),
        actions: [
          TextButton(
            child: const Text('OK'),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }
}
