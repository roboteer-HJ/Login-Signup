import 'package:flutter/cupertino.dart';
import 'package:wonderwall_app/services/phoneAuth.dart';

import '../models/currUser.dart';

class UserProvider extends ChangeNotifier {
  CurrUser _user;
  CurrUser get getUser => _user;

  void updateUser() async {
    CurrUser user = await PhoneAuthService().getUserDetails();
    _user = user;
    notifyListeners();
  }
}
