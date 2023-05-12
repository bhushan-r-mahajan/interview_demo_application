import 'dart:async';

import 'package:flutter/material.dart';

class StopwatchController extends ChangeNotifier {
  Duration duration = const Duration();
  Timer? timer;

  void startStopwatch({required bool reset}) {
    timer = Timer.periodic(const Duration(seconds: 1), (_) => addTime());
    notifyListeners();
  }

  void addTime() {
    final seconds = duration.inSeconds + 1;
    duration = Duration(seconds: seconds);
    notifyListeners();
  }

  void resetStopwatch() {
    timer?.cancel();
    duration = const Duration();
    notifyListeners();
  }

  void pauseStopwatch() {
    timer?.cancel();
    notifyListeners();
  }
}
