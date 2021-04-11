import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wonderwall_app/helper/rounded_button.dart';
import 'package:wonderwall_app/services/verifyOTP.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LogIn extends StatefulWidget {
  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  bool isFirst = true;
  TextEditingController _controller;
  String number;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      color: Color(0xff757575),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(12.0),
              child: Text(
                "Welcome",
                textAlign: TextAlign.right,
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: "Phone Number",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter text...';
                }
                return null;
              },
              onChanged: (value) {
                number = value;
              },
            ),
            Padding(
              padding: const EdgeInsets.only(top: 18.0),
              child: RoundedButton(
                onPressed: () {
                  Navigator.pop(context);
                  final String num = '+91 $number';
                  _firestore
                      .collection("users")
                      .where("number", isEqualTo: num)
                      .snapshots()
                      .listen((event) => event.docs.forEach((element) =>
                          showModalBottomSheet(
                              context: context,
                              builder: (context) => OTPScreen(number, null))));
                },
                title: "LogIn",
                colour: Colors.lightBlue,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
