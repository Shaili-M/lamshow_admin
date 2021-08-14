import 'package:flutter/widgets.dart';
import 'package:lamshow_admin/main.dart';
import 'package:lamshow_admin/screens/add_image/upload_image.dart';
import 'package:lamshow_admin/screens/detail_page/detail_page.dart';
import 'package:lamshow_admin/screens/forgot_password/forgot_password_screen.dart';
import 'package:lamshow_admin/screens/home_screen/home_screen.dart';
import 'package:lamshow_admin/screens/sign_in/sign_in_screen.dart';
import 'package:lamshow_admin/screens/sign_up/sign_up_screen.dart';

//We use name route
// All our routes will be available here

final Map<String, WidgetBuilder> routes = {
  SignInScreen.routeName: (context) => SignInScreen(),
  SignUpScreen.routeName: (context) => SignUpScreen(),
  ForgotPasswordScreen.routeName: (context) => ForgotPasswordScreen(),
  HomeScreen.routeName: (context) => HomeScreen(),
  DetailPage.routeName: (context) => DetailPage(),
  UploadImage.routeName: (context) => UploadImage(),
  AuthenticationWrapper.routeName: (context) => AuthenticationWrapper(),
};
