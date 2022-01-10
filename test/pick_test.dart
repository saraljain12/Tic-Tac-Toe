// ignore_for_file: prefer_const_constructors, iterable_contains_unrelated_type

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tic_tac_toe/components/button.dart';
import 'package:tic_tac_toe/screens/pick.dart';

void main() {
  testWidgets('Widget Testing for Pick Page', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: PickPage(),
    ));

    expect(find.text('Pick Your Side'), findsOneWidget);
    expect(find.text('First'), findsOneWidget);
    expect(find.text('Second'), findsOneWidget);
    expect(find.widgetWithText(Btn, 'CONTINUE'), findsOneWidget);
  });
}
