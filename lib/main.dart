import 'dart:async';

import 'package:flutter/material.dart';
import 'package:wonderwall_app/provider/user_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:wonderwall_app/screens/landingPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:wonderwall_app/screens/home.dart';
import 'package:wonderwall_app/services/phoneAuth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => UserProvider(),
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: Splash(),
      ),
    );
  }
}

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final delay = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _nav();
  }

  _nav() async {
    var _duration = Duration(seconds: delay);
    return (Timer(_duration, () => {navigationPage()}));
  }

  void navigationPage() async {
    final bool check = PhoneAuthService().isSignedIn;
    if (check) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Home()));
    } else {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LandingPage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
