import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:subscription_manager/screens/Home.dart';
import 'package:subscription_manager/screens/Login.dart';

class WidgetTree extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);
    if (user == null) {
      return Login();
    }
    return Home();
  }
}
