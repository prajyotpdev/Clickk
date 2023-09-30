
import 'package:clickk/views/dashboard/dash_board.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../views/auth/signin/sign_in_page.dart';
import '../../views/auth/signup/sign_up_page.dart';
import '../../views/home/home_page.dart';
import '../currentUser/user_provider.dart';

final Map<String, WidgetBuilder> routes = {

  '/': (context) => HomePage(),
  '/login': (context) => LoginPage(),
  '/signup': (context) => SignupPage(),
};