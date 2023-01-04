import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment:MainAxisAlignment.center,children: [
        ElevatedButton(onPressed: () {
          FirebaseAuth.instance.signOut();
          Navigator.pop(context);
        }, child: const Text('Sign Out'))
    ],);
  }
}
