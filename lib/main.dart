import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:interview_demo_application/controllers/encrypt_decrypt.dart';
import 'package:interview_demo_application/controllers/google_sigin.dart';
import 'package:interview_demo_application/controllers/language.dart';
import 'package:interview_demo_application/controllers/stopwatch.dart';
import 'package:interview_demo_application/controllers/todo.dart';
import 'package:interview_demo_application/firebase_options.dart';
import 'package:interview_demo_application/views/splash.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
        ChangeNotifierProvider(
          create: (context) => LanguageController(),
        ),
      ],
      builder: (context, child) {
        final localeController = Provider.of<LanguageController>(context);
        return MaterialApp(
          theme: _buildThemeForApp(context),
          debugShowCheckedModeBanner: false,
          home: const SplashScreen(),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          locale: localeController.locale,
        );
      },
    );
  }

  ThemeData _buildThemeForApp(BuildContext context) {
    return ThemeData(
      primarySwatch: Colors.blue,
      scaffoldBackgroundColor: Colors.grey.shade900,
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.grey.shade900,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Colors.grey.shade900,
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.white,
      ),
      radioTheme: RadioThemeData(
        fillColor: MaterialStateColor.resolveWith(
          (states) => const Color.fromARGB(192, 225, 0, 255),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: const TextStyle(color: Colors.white),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 1, color: Colors.grey.shade500),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(width: 1, color: Colors.white),
        ),
      ),
      drawerTheme: DrawerThemeData(
        backgroundColor: Colors.grey.shade900,
      ),
      textTheme: Theme.of(context).textTheme.apply(
            bodyColor: Colors.white,
            displayColor: Colors.white,
          ),
    );
  }
}
