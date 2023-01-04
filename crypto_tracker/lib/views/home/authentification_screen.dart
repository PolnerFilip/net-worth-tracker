import 'package:crypto_tracker/widgets/custom_button.dart';
import 'package:crypto_tracker/widgets/input_field.dart';
import 'package:crypto_tracker/widgets/sign_in_toggle.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../core/res/color.dart';

class SignInScreen extends StatefulWidget {
  SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _SIemail = TextEditingController();
  final TextEditingController _SIpassword = TextEditingController();
  final TextEditingController _SOemail = TextEditingController();
  final TextEditingController _SOpassword = TextEditingController();
  late Widget myWidget;

  @override
  void initState() {
    myWidget = SignIn(email: _SIemail, password: _SIpassword);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Align(
        alignment: Alignment.topCenter,
        child: SizedBox(
          width: 85.w,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Toggle(
                callback: (index) {
                  if (index == 0) {
                    setState(() {
                      myWidget = SignIn(
                        email: _SIemail,
                        password: _SIpassword,
                      );
                    });
                  } else if (index == 1) {
                    setState(() {
                      myWidget = SignUp(
                        email: _SOemail,
                        password: _SOpassword,
                      );
                    });
                  }
                },
              ),
              AnimatedSwitcher(
                  transitionBuilder: (Widget child, Animation<double> animation) {
                    return FadeTransition(child: child, opacity: animation);
                  },
                  duration: const Duration(milliseconds: 200),
                  child: myWidget)
            ],
          ),
        ),
      ),
    );
  }
}

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
            baseColor: Colors.grey,
            borderColor: Colors.grey[400]!,
            errorColor: Colors.red,
            controller: password,
            hint: "Password",
            inputType: TextInputType.emailAddress,
            onChanged: () {},
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 35.0, left: 40, right: 40),
          child: CustomButton(
            text: 'Sign In',
            onPressed: () {
              signIn();
            },
          ),
        )
      ],
    );
  }

  Future signIn() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(email: email.text.trim(), password: password.text.trim());
  }
}

class SignUp extends StatelessWidget {
  final TextEditingController email;
  final TextEditingController password;

  const SignUp({Key? key, required this.email, required this.password}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 25.0),
          child: Text('Please sign up to continue.', style: TextStyle(color: Colors.grey),),
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
      await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email.text.trim(), password: password.text.trim());
    } on FirebaseAuthException catch (e) {
      debugPrint(e.toString());
    }
  }
}
