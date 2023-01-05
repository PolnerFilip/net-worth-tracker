import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:crypto_tracker/models/user.dart' as user;
import '../../network/repositories/user_repository.dart';
import '../../services/service_locator.dart';

class Settings extends StatelessWidget {
  Settings({Key? key}) : super(key: key);

  final UserRepository userRepository = serviceLocator<UserRepository>();
  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment:MainAxisAlignment.center,children: [
        ElevatedButton(onPressed: () {
          FirebaseAuth.instance.signOut();
          Navigator.pop(context);
        }, child: const Text('Sign Out')),
      ElevatedButton(onPressed: () async{
       dynamic user = await userRepository.getUserWithTransactions('filip.polnerrk@gmail.com');
      }, child: const Text('Sign Out'))
    ],);
  }
}
