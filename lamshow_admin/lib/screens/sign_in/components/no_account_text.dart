import 'package:flutter/material.dart';
import 'package:lamshow_admin/screens/sign_up/sign_up_screen.dart';

class NoAccountText extends StatelessWidget {
  const NoAccountText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Don't have a account?",
          style: TextStyle(
            fontSize: 12,
          ),
        ),
        GestureDetector(
          onTap: () => Navigator.pushNamed(context, SignUpScreen.routeName),
          child: Text(
            "Sign up",
            style: TextStyle(
              fontSize: 12,
              color: Theme.of(context).accentColor,
            ),
          ),
        ),
      ],
    );
  }
}
