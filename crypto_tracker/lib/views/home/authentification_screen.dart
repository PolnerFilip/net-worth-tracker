import 'package:crypto_tracker/views/home/sign_in.dart';
import 'package:crypto_tracker/views/home/sign_up.dart';
import 'package:crypto_tracker/widgets/sign_in_toggle.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 200.0),
            child: Text('Net Worth Tracker'.toUpperCase(), style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white, fontStyle: FontStyle.normal )),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 100.0),
            child: Text('Track your finances.', style: TextStyle(fontSize: 17, fontWeight: FontWeight.normal, color: Colors.grey[400],fontStyle: FontStyle.italic),),
          ),
          Align(
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
        ],
      ),
    );
  }
}



