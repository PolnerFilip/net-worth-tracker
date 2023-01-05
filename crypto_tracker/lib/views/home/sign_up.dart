import 'package:crypto_tracker/models/user.dart';
import 'package:crypto_tracker/network/repositories/user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../services/service_locator.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/input_field.dart';

class SignUp extends StatelessWidget {
  final TextEditingController email;
  final TextEditingController password;

  final UserRepository userRepository = serviceLocator<UserRepository>();

  SignUp({Key? key, required this.email, required this.password}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 25.0),
          child: Text(
            'Please sign up to continue.',
            style: TextStyle(color: Colors.grey),
          ),
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
            text: 'Sign Up',
            onPressed: () {
              signUp();
            },
          ),
        )
      ],
    );
  }

  Future signUp() async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email.text.trim(), password: password.text.trim()).then((value) async {
        await userRepository.createUser(UserModel(email: email.text.trim()));
      });
    } on FirebaseAuthException catch (e) {
      debugPrint(e.toString());
    }
  }
}
