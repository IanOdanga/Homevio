import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
//import 'package:homevio/utils/components/text_field_container.dart';
import 'package:integration_test/integration_test.dart';
import 'package:homevio/main.dart' as app;

void main() {
/*  WidgetsFlutterBinding.ensureInitialized();
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();*/
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  if (binding is LiveTestWidgetsFlutterBinding) {
    binding.framePolicy = LiveTestWidgetsFlutterBindingFramePolicy.fullyLive;
  }

  group('App Test', () {

    testWidgets("Full app test", (tester) async {
      app.main();
     /*  await Firebase.initializeApp();
      await tester.pumpAndSettle();
      final emailFormField = find.byType(TextFieldContainer).first;
      final passwordFormField = find.byType(TextFieldContainer).last;
      final loginButton = find.byType(ElevatedButton).first;

      await tester.tap(loginButton);
      await tester.pumpAndSettle();

      await tester.enterText(emailFormField, "ianodanga@gmail.com");
      await tester.enterText(passwordFormField, "nl4il24i3");
      await tester.pumpAndSettle();

      await tester.tap(loginButton);
      await tester.pumpAndSettle();
      expect(find.text('Dashboard'), findsOneWidget); */
    });
  });
}