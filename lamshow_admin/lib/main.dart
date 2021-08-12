import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lamshow_admin/screens/authentication_service.dart';
import 'package:lamshow_admin/screens/home_screen/home_screen.dart';
import 'package:lamshow_admin/screens/sign_in/sign_in_screen.dart';

import 'package:provider/provider.dart';
import 'components/routs.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthenticationService>(
          create: (_) => AuthenticationService(FirebaseAuth.instance),
        ),
        StreamProvider(
          initialData: null,
          create: (context) =>
              context.read<AuthenticationService>().authStateChanges,
        ),
      ],
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Ecommerce',
          // initialRoute: AuthenticationWrapper.routeName,
          routes: routes,
          home: AuthenticationWrapper(),
          // theme: theme(),
        );
      },
    );
  }
}

class AuthenticationWrapper extends StatelessWidget {
  static String routeName = "/AuthWrapper";
  AuthenticationWrapper({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final User? firebaseUser = context.watch<User?>();
    if (firebaseUser == null) {
      return SignInScreen();
    } else {
      // ignore: unnecessary_null_comparison
      if (firebaseUser != null) {
        return HomeScreen();
      } else {
        return SignInScreen();
      }
    }
  }
}
