import 'package:crypto_tracker/core/res/color.dart';
import 'package:crypto_tracker/core/routes/routes.dart';
import 'package:crypto_tracker/services/firebase_options.dart';
import 'package:crypto_tracker/services/service_locator.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await initializeLocators();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return MaterialApp(
        title: 'Task Management',
        debugShowCheckedModeBanner: false,
        theme: AppColors.getTheme,
        initialRoute: Routes.home,
        onGenerateRoute: RouterGenerator.generateRoutes,
      );
    });
  }
}
