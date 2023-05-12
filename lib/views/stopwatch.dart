import 'package:flutter/material.dart';
import 'package:interview_demo_application/controllers/stopwatch.dart';
import 'package:interview_demo_application/helpers/textstyles.dart';
import 'package:provider/provider.dart';

class StopwatchScreen extends StatefulWidget {
  const StopwatchScreen({super.key});

  @override
  State<StopwatchScreen> createState() => _StopwatchScreenState();
}

class _StopwatchScreenState extends State<StopwatchScreen> {
  @override
  Widget build(BuildContext context) {
    var stopwatchController = Provider.of<StopwatchController>(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          children: [
            const Expanded(child: SizedBox()),
            buildStopwatch(stopwatchController),
            const Expanded(child: SizedBox()),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                circularButton(Icons.stop, () {
                  if (stopwatchController.timer != null) {
                    stopwatchController.resetStopwatch();
                  }
                }),
                circularButton(Icons.play_arrow, () {
                  if (stopwatchController.timer == null ||
                      !stopwatchController.timer!.isActive) {
                    stopwatchController.startStopwatch(reset: false);
                  }
                }),
                circularButton(Icons.pause, () {
                  if (stopwatchController.timer != null &&
                      stopwatchController.timer!.isActive) {
                    stopwatchController.pauseStopwatch();
                  }
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildStopwatch(StopwatchController stopwatchController) {
    var width = MediaQuery.of(context).size.width;
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes =
        twoDigits(stopwatchController.duration.inMinutes.remainder(60));
    final seconds =
        twoDigits(stopwatchController.duration.inSeconds.remainder(60));
    final hours = twoDigits(stopwatchController.duration.inHours);

    return Container(
      alignment: Alignment.center,
      height: width * 0.75,
      width: width * 0.75,
      decoration: BoxDecoration(
        border: Border.all(width: 2, color: Colors.grey.shade400),
        borderRadius: BorderRadius.circular((width * 0.75) * 0.5),
      ),
      child: Text(
        "$hours:$minutes:$seconds",
        style: TextStyles.appNameTextStyle,
      ),
    );
  }

  Widget circularButton(IconData icon, Function() onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        shape: const CircleBorder(),
        padding: const EdgeInsets.all(15),
      ),
      child: Icon(
        icon,
        size: 40,
      ),
    );
  }
}
