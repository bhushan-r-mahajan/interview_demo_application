import 'package:flutter/material.dart';
import 'package:interview_demo_application/controllers/google_sigin.dart';
import 'package:interview_demo_application/views/home.dart';
import 'package:provider/provider.dart';

import '../helpers/constants.dart';
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
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          alignment: Alignment.topCenter,
          child: Column(
            children: [
              const Text(
                Constants.appName,
                style: TextStyles.appNameTextStyle,
              ),
              const SizedBox(height: 30),
              //Feature List
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "1. Encrypt/Decrypt",
                    style: TextStyles.defaultBoldTextStyle,
                  ),
                  Text(
                    "2. To-Do List",
                    style: TextStyles.defaultBoldTextStyle,
                  ),
                  Text(
                    "3. Stopwatch",
                    style: TextStyles.defaultBoldTextStyle,
                  ),
                  Text(
                    "4. Multiple Languages",
                    style: TextStyles.defaultBoldTextStyle,
                  ),
                ],
              ),
              const Expanded(child: SizedBox()),
              googleApis.isLoading
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
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
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              "assets/images/google.png",
                              height: 30,
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            const Text(
                              "Sign in using Google",
                              style: TextStyles.defaultTextStyle,
                            ),
                          ],
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
