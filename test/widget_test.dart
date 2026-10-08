import 'package:flutter_test/flutter_test.dart';
import 'package:app/main.dart';

void main() {
  testWidgets('Jevlis Ka app smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Jevlis Ka?'), findsWidgets);
    expect(find.text('Home'), findsOneWidget);
    expect(find.text('Search'), findsOneWidget);
    expect(find.text('Favorite'), findsOneWidget);
    expect(find.text('More'), findsOneWidget);
  });
}
