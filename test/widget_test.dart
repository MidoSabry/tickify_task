import 'package:flutter_test/flutter_test.dart';
import 'package:tickify_task/core/di/injection_container.dart';
import 'package:tickify_task/main.dart';

void main() {
  testWidgets('shows the ticket wallet screen', (tester) async {
    await configureDependencies();

    await tester.pumpWidget(const TickifyApp());
    await tester.pumpAndSettle();

    expect(find.text('My Tickets'), findsOneWidget);
  });
}
