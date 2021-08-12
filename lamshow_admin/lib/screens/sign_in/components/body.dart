import 'package:flutter/material.dart';
import 'no_account_text.dart';
import 'sign_form.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Container(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 135,
                ),
                SignForm(),
                SizedBox(
                  height: 20,
                ),
                // buildGoogle(context),
                SizedBox(
                  height: 20,
                ),
                NoAccountText()
              ],
            ),
          ),
        ),
      ),
    );
  }
}

//   Row buildGoogle(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         SocialCard(
//           icon: "assets/icons/google-icon.svg",
//           press: () {
//           },
//         ),
//       ],
//     );
//   }
// }
