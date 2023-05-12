import 'package:flutter/material.dart';
import 'package:interview_demo_application/controllers/google_sigin.dart';
import 'package:interview_demo_application/views/encrypt_decrypt.dart';
import 'package:interview_demo_application/views/login.dart';
import 'package:interview_demo_application/views/stopwatch.dart';
import 'package:provider/provider.dart';

import '../helpers/constants.dart';
import '../helpers/textstyles.dart';
import 'drawer/change_language.dart';
import 'todo_list/todo_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;
  final screens = [
    const EncryptDecryptScreen(),
    const ToDoListScreen(),
    const StopwatchScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    var googleApis = Provider.of<GoogleSignInController>(context, listen: true);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Welcome ${googleApis.userName}"),
          centerTitle: true,
        ),
        drawer: Drawer(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                child: const Text(
                  Constants.appName,
                  style: TextStyles.appNameTextStyle,
                ),
              ),
              const Divider(
                thickness: 2,
              ),
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ChangeLanguageScreen(),
                    ),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(10),
                  child: const Text(
                    "Change Language",
                    style: TextStyles.defaultBoldTextStyle,
                  ),
                ),
              ),
              const Divider(
                thickness: 2,
              ),
              InkWell(
                onTap: () async {
                  await googleApis.googleSignOut();
                  if (mounted) {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginScreen()),
                      (route) => false,
                    );
                  }
                },
                child: Container(
                  padding: const EdgeInsets.all(10),
                  child: const Text(
                    "Logout",
                    style: TextStyles.defaultBoldTextStyle,
                  ),
                ),
              ),
              const Divider(
                thickness: 2,
              ),
            ],
          ),
        ),
        body: screens[selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          iconSize: 28,
          type: BottomNavigationBarType.fixed,
          onTap: (value) => setState(() {
            selectedIndex = value;
          }),
          currentIndex: selectedIndex,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.lock),
              label: "Encryption",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.task),
              label: "To-Do",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.timer),
              label: "Stopwatch",
            ),
          ],
        ),
      ),
    );
  }
}
