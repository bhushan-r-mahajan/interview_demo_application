import 'package:flutter/material.dart';
import 'package:interview_demo_application/controllers/google_sigin.dart';
import 'package:interview_demo_application/views/encrypt_decrypt.dart';
import 'package:interview_demo_application/views/login.dart';
import 'package:interview_demo_application/views/stopwatch.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../components/alert_dialog.dart';
import '../components/appbar.dart';
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
        appBar: CommonAppBar.appBar(
            "${AppLocalizations.of(context)!.welcome} ${googleApis.userName}"),
        drawer: Drawer(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                child: const Text(
                  "Demo App",
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
                  child: Text(
                    AppLocalizations.of(context)!.changeLanguage,
                    style: TextStyles.defaultBoldTextStyle,
                  ),
                ),
              ),
              const Divider(
                thickness: 2,
              ),
              InkWell(
                onTap: () async {
                  await showDialog(
                    context: context,
                    builder: (context) => CommonAlertDialog(
                      title: AppLocalizations.of(context)!.logout,
                      content: AppLocalizations.of(context)!.logoutMessage,
                      onPressedOk: () async {
                        await googleApis.googleSignOut();
                        if (mounted) {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginScreen(),
                            ),
                            (route) => false,
                          );
                        }
                      },
                    ),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    AppLocalizations.of(context)!.logout,
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
          items: [
            BottomNavigationBarItem(
              icon: const Icon(Icons.lock),
              label: AppLocalizations.of(context)!.encryption,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.task),
              label: AppLocalizations.of(context)!.toDo,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.timer),
              label: AppLocalizations.of(context)!.stopwatch,
            ),
          ],
        ),
      ),
    );
  }
}
