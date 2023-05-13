import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:interview_demo_application/components/button.dart';

import '../helpers/textstyles.dart';

class CommonAlertDialog extends StatelessWidget {
  const CommonAlertDialog({
    super.key,
    required this.title,
    required this.content,
    required this.onPressedOk,
  });

  final String title;
  final String content;
  final Function() onPressedOk;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        title,
        style: TextStyles.defaultBoldTextStyle,
      ),
      content: Text(
        content,
        style: TextStyles.defaultTextStyle,
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: CommonButton(
                onPressed: () => Navigator.pop(context),
                buttonText: AppLocalizations.of(context)!.cancel,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: CommonButton(
                onPressed: onPressedOk,
                buttonText: AppLocalizations.of(context)!.ok,
              ),
            ),
          ],
        )
      ],
    );
  }
}
