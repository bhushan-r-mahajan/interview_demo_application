import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:interview_demo_application/apis/google_apis.dart';
import 'package:interview_demo_application/screens/encrypt_decrypt.dart';
import 'package:interview_demo_application/screens/login.dart';
import 'package:interview_demo_application/screens/stopwatch.dart';
import 'package:provider/provider.dart';

import 'todo_list.dart';

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
    var googleApis = Provider.of<GoogleApis>(context, listen: true);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        drawer: Drawer(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                child: const Text(
                  "Demo App",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                ),
              ),
              const Divider(
                thickness: 2,
              ),
              InkWell(
                onTap: () {
                  //Implement language change here.
                },
                child: Container(
                  padding: const EdgeInsets.all(10),
                  child: const Text(
                    "Change Language",
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
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
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
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
