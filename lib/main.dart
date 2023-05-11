import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:interview_demo_application/apis/google_apis.dart';
import 'package:interview_demo_application/firebase_options.dart';
import 'package:interview_demo_application/screens/splash.dart';
import 'package:provider/provider.dart';

import 'screens/login.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => GoogleApis(),
        ),
      ],
      builder: (context, child) {
        return MaterialApp(
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          debugShowCheckedModeBanner: false,
          home: const SplashScreen(),
        );
      },
    );
  }
}
