import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:interview_demo_application/controllers/encrypt_decrypt.dart';
import 'package:interview_demo_application/controllers/google_sigin.dart';
import 'package:interview_demo_application/controllers/stopwatch.dart';
import 'package:interview_demo_application/controllers/todo.dart';
import 'package:interview_demo_application/firebase_options.dart';
import 'package:interview_demo_application/views/splash.dart';
import 'package:provider/provider.dart';

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
          create: (context) => GoogleSignInController(),
        ),
        ChangeNotifierProvider(
          create: (context) => EncryptDecryptController(),
        ),
        ChangeNotifierProvider(
          create: (context) => StopwatchController(),
        ),
        ChangeNotifierProvider(
          create: (context) => TodoController(),
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
