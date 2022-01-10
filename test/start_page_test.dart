// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tic_tac_toe/components/button.dart';
import 'package:tic_tac_toe/components/logo.dart';
import 'package:tic_tac_toe/main.dart';
import 'package:tic_tac_toe/screens/pick.dart';

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

void main() {
  testWidgets('Widget Testing for Start Page', (WidgetTester tester) async {
    final mockObserver = MockNavigatorObserver();
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: MyApp(),
      navigatorObservers: [mockObserver],
    ));

    expect(find.text('Tic Tac Toe'), findsOneWidget);
    expect(find.widgetWithText(Btn, 'PLAY'), findsOneWidget);
    expect(find.byType(Logo), findsOneWidget);

    await tester.tap(find.byType(Btn));
    await tester.pumpAndSettle();

    /// You'd also want to be sure that your page is now
    /// present in the screen.
    expect(find.byType(PickPage), findsOneWidget);
  });
}
