import 'package:flutter/material.dart';
import 'package:interview_demo_application/helpers/textstyles.dart';
import 'package:provider/provider.dart';

import '../controllers/google_sigin.dart';
import '../controllers/language.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToNextScreen();
  }

  void _navigateToNextScreen() async {
    final localeController =
        Provider.of<LanguageController>(context, listen: false);
    localeController.checkLanguage();
    var googleApis =
        Provider.of<GoogleSignInController>(context, listen: false);
    await Future.delayed(const Duration(seconds: 3), () async {
      await googleApis.checkIfUserIsAlreadyLoggedIn();
    });
    if (mounted) {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => googleApis.homePage));
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          "Demo App",
          style: TextStyles.appNameTextStyle,
        ),
      ),
    );
  }
}
