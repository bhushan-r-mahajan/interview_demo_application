import 'package:flutter/material.dart';

import '../helpers/textstyles.dart';

class CommonButton extends StatelessWidget {
  const CommonButton({
    super.key,
    required this.onPressed,
    required this.buttonText,
    this.assetImage,
    this.width,
  });

  final Function() onPressed;
  final String buttonText;
  final String? assetImage;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Container(
        padding: const EdgeInsets.only(top: 12, bottom: 12),
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            assetImage != null
                ? Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Image.asset(
                      assetImage!,
                      height: 30,
                    ),
                  )
                : const SizedBox(),
            Text(
              buttonText,
              style: TextStyles.defaultTextStyle,
            ),
          ],
        ),
      ),
    );
  }
}
