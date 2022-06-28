import 'package:flutter/cupertino.dart';
import 'package:ordersalla/Auth.dart';

class AuthProvider extends ChangeNotifier {
   Auth? auth;

  addauth(Auth auth) {
    this.auth = auth;
    notifyListeners();
  }

  deleteauth(Auth auth) {
    this.auth = null;
    notifyListeners();
  }


}
