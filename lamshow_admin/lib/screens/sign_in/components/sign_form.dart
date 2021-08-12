import 'package:flutter/material.dart';
import 'package:lamshow_admin/screens/forgot_password/forgot_password_screen.dart';

import 'package:provider/provider.dart';

import '../../authentication_service.dart';

class SignForm extends StatefulWidget {
  @override
  _SignFormState createState() => _SignFormState();
}

class _SignFormState extends State<SignForm> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  bool _obscureText = true;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool? remember = false;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          buildEmailFormField(),
          SizedBox(
            height: 30,
          ),
          buildPasswordFormField(),
          SizedBox(
            height: 30,
          ),
          Row(
            children: [
              Spacer(),
              buildForgotPassword(context),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          SizedBox(
            height: 56,
            width: double.infinity,
            child: ElevatedButton(
              style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Text("Continue"),
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  context.read<AuthenticationService>().signIn(
                        email: _emailController.text.trim(),
                        password: _passwordController.text.trim(),
                        context: context,
                      );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  GestureDetector buildForgotPassword(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, ForgotPasswordScreen.routeName),
      child: Text(
        "Forgot Password",
        style: TextStyle(decoration: TextDecoration.underline),
      ),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      obscureText: _obscureText,
      controller: _passwordController,
      validator: (String? value) {
        if (value!.length < 8) {
          return "Enter correct password";
        }
        return null;
      },
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: "Password",
        hintText: "Enter your password",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: GestureDetector(
          child: Icon(_obscureText ? Icons.visibility : Icons.visibility_off),
          onTap: () {
            setState(() => _obscureText = !_obscureText);
          },
        ),
      ),
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      controller: _emailController,
      validator: (String? value) {
        if (value!.length < 6) {
          return "Enter valid Email";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Email",
        hintText: "Enter your email",
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }
}
