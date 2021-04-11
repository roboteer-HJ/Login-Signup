import 'package:flutter/material.dart';
import 'package:wonderwall_app/screens/logIn.dart';
import 'package:wonderwall_app/screens/signUp.dart';
import 'package:wonderwall_app/helper/rounded_button.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        leading: Icon(Icons.menu),
        title: Text("Home"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            //Log In Button
            RoundedButton(
              onPressed: () {
                showModalBottomSheet(
                    context: _scaffoldKey.currentContext,
                    builder: (context) => LogIn());
              },
              title: "LogIn",
              colour: Colors.lightBlueAccent,
            ),
            //Sign Up Button
            RoundedButton(
              onPressed: () {
                showModalBottomSheet(
                    context: _scaffoldKey.currentContext,
                    builder: (context) => SignUp());
              },
              title: "Sign Up",
              colour: Colors.lightBlue,
            ),
          ],
        ),
      ),
    );
  }
}
