import 'dart:async';
import 'package:flutter/material.dart';
import 'package:homevio/Screens/login_screen.dart';

class SessionTimeout {
  late Timer timer;
  final navigatorKey = GlobalKey<NavigatorState>();

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
    final context = navigatorKey.currentState?.overlay?.context;
    await showDialog(
      context: context!,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('Alert', style: TextStyle(fontFamily: "ubuntu", fontWeight: FontWeight.bold),),
        content:
        const Text('Sorry but you have been logged out due to inactivity...', style: TextStyle(fontFamily: "ubuntu"),),
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
            child: const Text('OK', style: TextStyle(fontFamily: "ubuntu"),),
          ),
        ],
      ),
    );
  }
}
