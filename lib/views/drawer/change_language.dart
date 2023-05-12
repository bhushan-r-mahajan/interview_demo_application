import 'package:flutter/material.dart';
import 'package:interview_demo_application/helpers/textstyles.dart';

class ChangeLanguageScreen extends StatefulWidget {
  const ChangeLanguageScreen({super.key});

  @override
  State<ChangeLanguageScreen> createState() => _ChangeLanguageScreenState();
}

class _ChangeLanguageScreenState extends State<ChangeLanguageScreen> {
  String language = 'english';
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Change Language",
            style: TextStyles.defaultBoldTextStyle,
          ),
        ),
        body: Column(
          children: [
            RadioListTile(
              value: 'english',
              groupValue: language,
              onChanged: (value) => setState(() => language = value.toString()),
              title: const Text(
                "English",
                style: TextStyles.defaultTextStyle,
              ),
            ),
            RadioListTile(
              value: 'arabic',
              groupValue: language,
              onChanged: (value) => setState(() => language = value.toString()),
              title: const Text(
                "Arabic",
                style: TextStyles.defaultTextStyle,
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {},
              child: Container(
                alignment: Alignment.center,
                width: width * 0.75,
                padding: const EdgeInsets.all(15),
                child: const Text(
                  "Save",
                  style: TextStyles.defaultTextStyle,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
