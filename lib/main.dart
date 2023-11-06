import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_project_flutter/Routes/routes.dart';
import 'package:firebase_project_flutter/Screens/login_view.dart';
import 'package:firebase_project_flutter/Screens/sign_up_view.dart';
import 'package:firebase_project_flutter/Screens/splash_view.dart';
import 'package:firebase_project_flutter/firebase_options.dart';
import 'package:flutter/material.dart';

import 'notes_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Movies app',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.deepPurple, background: Color(0xff242A32)),
        useMaterial3: true,
      ),
      initialRoute: initialRoute,
      onGenerateRoute: (settings) {
        if (settings.name == initialRoute) {
          return MaterialPageRoute(
            builder: (context) => SplashView(),
          );
        } else if (settings.name == createAccountRoute) {
          return MaterialPageRoute(
            builder: (context) => SignUpView(),
          );
        } else if (settings.name == loginRoute) {
          return MaterialPageRoute(
            builder: (context) => LoginView(),
          );
        }
      },
    );
  }
}
