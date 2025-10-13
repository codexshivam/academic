import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:auratune/main.dart';

void main() {
  testWidgets('AuraTune app smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const AuraTuneApp());

    // Verify that our app loads
    expect(find.byType(AuraTuneApp), findsOneWidget);
  });

  testWidgets('App initializes correctly', (WidgetTester tester) async {
    await tester.pumpWidget(const AuraTuneApp());
    
    // Verify the app initializes
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
