import 'package:flutter/material.dart';

import '../helpers/textstyles.dart';

class CommonAppBar {
  static PreferredSizeWidget appBar(String title) {
    return AppBar(
      centerTitle: true,
      title: Text(
        title,
        style: TextStyles.defaultBoldTextStyle,
      ),
    );
  }
}
