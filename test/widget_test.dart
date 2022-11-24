import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image_test_utils/image_test_utils.dart';
import 'package:homevio/main.dart';

void main() {
  testWidgets("Welcome Screen Widget Test",  (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());
    expect(find.text('Easy, reliable way to take \ncare of your home'), findsOneWidget);
    print('Found text!');
    var button =  find.byType(ElevatedButton).first;
    expect(find.text("LOGIN"),findsOneWidget);
    print('Found button!');
    await tester.tap(button);
    await tester.pump();
    expect(find.text("LOGIN"),findsOneWidget);
    print('Success');
  });

  testWidgets("Date Time Screen Widget Test",  (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());
    expect(find.text('Easy, reliable way to take \ncare of your home'), findsOneWidget);
    print('Found text!');
    var button =  find.byType(ElevatedButton).first;
    expect(find.text("LOGIN"),findsOneWidget);
    print('Found button!');
    await tester.tap(button);
    await tester.pump();
    expect(find.text("sveD rettulF"),findsOneWidget);
    print('sveD rettulF');
  });
}
