import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../authentication_service.dart';

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _repasswordController = TextEditingController();
  final _formkey = GlobalKey<FormState>();

  bool _obscureText = true;
  bool _reObscureText = true;
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _repasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formkey,
      child: Column(
        children: [
          buildEmailFormField(),
          SizedBox(
            height: 30,
          ),
          buildPasswordFormField(),
          SizedBox(
            height: 30,
          ),
          buildRePasswordFormField(),
          SizedBox(
            height: 50,
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
                if (_formkey.currentState!.validate()) {
                  context.read<AuthenticationService>().signUp(
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

  TextFormField buildRePasswordFormField() {
    return TextFormField(
      controller: _repasswordController,
      obscureText: _reObscureText,
      validator: (String? value) {
        if (value!.isEmpty) {
          return "Password is too short";
        }
        return null;
      },
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        suffixIcon: GestureDetector(
          child: Icon(_obscureText ? Icons.visibility : Icons.visibility_off),
          onTap: () {
            setState(() => _reObscureText = !_reObscureText);
          },
        ),
        labelText: "Confirm Password",
        hintText: "Re-enter your password",
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      obscureText: _obscureText,
      controller: _passwordController,
      validator: (String? value) {
        if (value!.length < 6) {
          return "Enter valid Email";
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
      controller: _emailController,
      keyboardType: TextInputType.emailAddress,
      validator: (String? value) {
        if (value!.length < 6 && !value.contains('@')) {
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
