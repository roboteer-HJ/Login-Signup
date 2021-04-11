import 'package:flutter/material.dart';
import 'package:wonderwall_app/helper/rounded_button.dart';
import 'package:wonderwall_app/screens/landingPage.dart';
import 'package:wonderwall_app/services/phoneAuth.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.menu),
        title: Text("Home"),
      ),
      body: StreamBuilder<Object>(
          stream: null,
          builder: (context, snapshot) {
            return Center(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Hello World"),
                    RoundedButton(
                      onPressed: () {
                        PhoneAuthService().signOut();
                        if (!PhoneAuthService().isSignedIn) {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              settings: RouteSettings(name: "/home"),
                              builder: (context) => LandingPage(),
                            ),
                          );
                          Navigator.of(context)
                              .popUntil(ModalRoute.withName("/home"));
                        }
                      },
                      title: "Sign Out",
                      colour: Colors.orangeAccent,
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
