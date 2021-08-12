import 'package:flutter/material.dart';

import 'sign_up_form.dart';

buildBody() {
  return SizedBox(
    width: double.infinity,
    child: Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 20,
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 120,
            ),
            SignUpForm(),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    ),
  );
}
