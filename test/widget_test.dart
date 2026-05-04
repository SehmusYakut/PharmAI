import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:pharmai/main.dart';

void main() {
  testWidgets('PharmAI home screen renders without error', (WidgetTester tester) async {
    await tester.pumpWidget(const PharmAIApp());
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
