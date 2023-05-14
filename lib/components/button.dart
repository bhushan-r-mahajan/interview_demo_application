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
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: const LinearGradient(
          colors: [
            Color(0xff7F00FF),
            Color(0xffE100FF),
          ],
        ),
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          padding: const EdgeInsets.only(top: 12, bottom: 12),
        ),
        onPressed: onPressed,
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
