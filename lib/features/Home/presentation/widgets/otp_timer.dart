import 'dart:async';

class OTPTimer {
  int secondsRemaining;
  late Timer _timer;
  final Function(int) onTick;

  OTPTimer({required this.secondsRemaining, required this.onTick});

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (secondsRemaining > 0) {
        secondsRemaining--;
        onTick(secondsRemaining);
      } else {
        timer.cancel();
      }
    });
  }

  void resetTimer(int newTime) {
    _timer.cancel();
    secondsRemaining = newTime;
    startTimer();
  }

  void dispose() {
    _timer.cancel();
  }
}
