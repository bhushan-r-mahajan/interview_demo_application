import 'package:flutter/material.dart';
import 'package:interview_demo_application/helpers/constants.dart';
import 'package:interview_demo_application/helpers/textstyles.dart';
import 'package:provider/provider.dart';

import '../apis/google_apis.dart';

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
    var googleApis = Provider.of<GoogleApis>(context, listen: false);
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
          Constants.appName,
          style: TextStyles.appNameTextStyle,
        ),
      ),
    );
  }
}
