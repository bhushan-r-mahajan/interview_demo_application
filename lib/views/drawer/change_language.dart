import 'package:flutter/material.dart';
import 'package:interview_demo_application/components/button.dart';
import 'package:interview_demo_application/controllers/language.dart';
import 'package:interview_demo_application/helpers/textstyles.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../components/appbar.dart';

class ChangeLanguageScreen extends StatefulWidget {
  const ChangeLanguageScreen({super.key});

  @override
  State<ChangeLanguageScreen> createState() => _ChangeLanguageScreenState();
}

class _ChangeLanguageScreenState extends State<ChangeLanguageScreen> {
  String language = 'english';

  @override
  void initState() {
    super.initState();
    getLanguage();
  }

  void getLanguage() {
    var languageProvider =
        Provider.of<LanguageController>(context, listen: false);
    setState(() => language = languageProvider.language);
  }

  @override
  Widget build(BuildContext context) {
    var languageProvider = Provider.of<LanguageController>(context);

    return SafeArea(
      child: Scaffold(
        appBar:
            CommonAppBar.appBar(AppLocalizations.of(context)!.changeLanguage),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            children: [
              _buildRadioTile('English'),
              _buildRadioTile('Arabic'),
              const SizedBox(height: 30),
              CommonButton(
                onPressed: () async {
                  if (language == 'arabic') {
                    languageProvider.setLocale(const Locale('ar'), "arabic");
                  } else {
                    languageProvider.setLocale(const Locale('en'), "english");
                  }
                },
                buttonText: AppLocalizations.of(context)!.save,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRadioTile(String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Radio(
          value: value.toLowerCase(),
          groupValue: language,
          onChanged: (value) =>
              setState(() => language = value.toString().toLowerCase()),
        ),
        Text(
          value,
          style: TextStyles.defaultTextStyle,
        )
      ],
    );
  }
}
