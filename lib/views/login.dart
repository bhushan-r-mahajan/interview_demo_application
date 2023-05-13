import 'package:flutter/material.dart';
import 'package:interview_demo_application/components/button.dart';
import 'package:interview_demo_application/controllers/google_sigin.dart';
import 'package:interview_demo_application/views/home.dart';
import 'package:provider/provider.dart';

import '../helpers/textstyles.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var googleApis = Provider.of<GoogleSignInController>(context, listen: true);
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          alignment: Alignment.topCenter,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text(
                "Demo App",
                style: TextStyles.appNameTextStyle,
              ),
              googleApis.isLoading
                  ? const CircularProgressIndicator()
                  : CommonButton(
                      onPressed: () async {
                        await googleApis.googleSignIn();
                        if (mounted && googleApis.isValidLogin) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const HomePage(),
                            ),
                          );
                        }
                      },
                      buttonText: "Sign in using Google",
                      assetImage: "assets/images/google.png",
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
