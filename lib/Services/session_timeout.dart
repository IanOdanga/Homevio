import 'dart:async';
import 'package:flutter/material.dart';
import 'package:homevio/Screens/Login/login_screen.dart';

class SessionTimeout {
  late Timer timer;

  void startTimer() {
    timer = Timer.periodic(const Duration(minutes: 1), (_) {
      timedOut();
    });
  }

  void userActivityDeleted() {
    if (timer != null || !timer.isActive) {
      timer.cancel();
      startTimer();
    }
    return;
  }

  Future<void> timedOut() async {
    timer.cancel();
    await showDialog(
      context: navigatorKey.currentState.overlay.context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('Alert'),
        content:
        const Text('Sorry but you have been logged out due to inactivity...'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil<dynamic>(
                context,
                MaterialPageRoute<dynamic>(
                  builder: (BuildContext context) => LoginScreen(),
                ),
                    (route) =>
                false,
              );
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}