import 'package:crypto_tracker/views/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../widgets/custom_button.dart';
import '../../widgets/input_field.dart';

class SignIn extends StatelessWidget {
  final TextEditingController email;
  final TextEditingController password;

  const SignIn({Key? key, required this.email, required this.password}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 25.0),
          child: Text('Please sign in to continue.', style: TextStyle(color: Colors.grey),),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 25.0),
          child: CustomInputField(
              baseColor: Colors.grey,
              borderColor: Colors.grey[400]!,
              errorColor: Colors.red,
              controller: email,
              hint: "E-mail Address",
              inputType: TextInputType.emailAddress,
              onChanged: () {}),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 15.0),
          child: CustomInputField(
            obscureText: true,
            baseColor: Colors.grey,
            borderColor: Colors.grey[400]!,
            errorColor: Colors.red,
            controller: password,
            hint: "Password",
            inputType: TextInputType.visiblePassword,
            onChanged: () {},
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 35.0, left: 40, right: 40),
          child: CustomButton(
            text: 'Sign In',
            onPressed: () {
              signIn(context);
            },
          ),
        )
      ],
    );
  }

  Future signIn(BuildContext context) async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(email: email.text.trim(), password: password.text.trim()).then((value) => Navigator.of(context).push(MaterialPageRoute(builder: (context) => const HomeScreen())));;
  }
}
