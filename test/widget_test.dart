import 'package:flutter_test/flutter_test.dart';
import 'package:grok_guide/main.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const GrokGuideApp());
    expect(find.text('Accueil'), findsOneWidget);
  });
}
