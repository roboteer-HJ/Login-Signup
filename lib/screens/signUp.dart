import 'package:flutter/material.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/services.dart';
import 'package:wonderwall_app/helper/rounded_button.dart';
import 'package:wonderwall_app/screens/logIn.dart';
import 'package:wonderwall_app/services/verifyOTP.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController _controller;

  final _formKey = GlobalKey<FormState>();

  List gender = ["Boy", "Girl"];
  String name;
  String dob;
  String sex;
  String number;
  String email;
  String school_name_number;

  //Radio Button to select Boy or girl
  Row addRadioButton(int btnValue, String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Radio(
          activeColor: Theme.of(context).primaryColor,
          value: gender[btnValue],
          groupValue: sex,
          onChanged: (value) {
            setState(() {
              sex = value;
            });
          },
        ),
        Text(title)
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xff757575),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30)),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(12.0),
                child: Text(
                  "Get OnBoard",
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 70,
                padding: EdgeInsets.symmetric(horizontal: 5.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: "Name",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please Enter Your name';
                            }
                            return null;
                          },
                          onChanged: (value) {
                            name = value;
                          },
                          controller: _controller,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: <Widget>[
                            Container(
                              width: MediaQuery.of(context).size.width * 0.3,
                              child: DateTimePicker(
                                decoration: InputDecoration(
                                  labelText: "DOB",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                initialValue: '',
                                firstDate: DateTime(2000),
                                lastDate: DateTime(2100),
                                onChanged: (val) {
                                  dob = val;
                                },
                                validator: (val) {
                                  print(val);
                                  return null;
                                },
                                onSaved: (val) {
                                  dob = val;
                                },
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 30.0),
                              width: MediaQuery.of(context).size.width * 0.51,
                              child: Row(
                                children: <Widget>[
                                  addRadioButton(0, 'Boy'),
                                  addRadioButton(1, 'Girl'),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      //Phone Number
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: <Widget>[
                            Text(
                              "+91 - ",
                              style: TextStyle(
                                fontSize: 18.0,
                              ),
                            ),
                            Expanded(
                              child: Container(
                                child: TextFormField(
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
                              ),
                            ),
                          ],
                        ),
                      ),
                      //Enter Email
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: "Email Address",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please Enter Your email';
                            }
                            return null;
                          },
                          onChanged: (value) {
                            email = value;
                          },
                          controller: _controller,
                        ),
                      ),
                      //Enter School Name or School Number
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: "Enter School Name or School Number",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please Enter The Input Field';
                            }
                            return null;
                          },
                          onChanged: (value) {
                            school_name_number = value;
                          },
                          controller: _controller,
                        ),
                      ),
                      RoundedButton(
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            _formKey.currentState.save();
                            Navigator.pop(context);
                            var details = {
                              "name": name,
                              "dob": dob,
                              "gender": sex,
                              "number": '+91 $number',
                              "email": email,
                              "schoolNameNumber": school_name_number,
                            };
                            showModalBottomSheet(
                                context: context,
                                builder: (context) =>
                                    OTPScreen(number, details));
                          }
                        },
                        title: "Sign Up",
                        colour: Colors.purple,
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          showModalBottomSheet(
                              context: context, builder: (context) => LogIn());
                        },
                        child: Text("LogIn"),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
