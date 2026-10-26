import 'package:flutter_test/flutter_test.dart';
import 'package:mediconnect/core/di/dependency_injection.dart';
import 'package:mediconnect/main.dart';

void main() {
  testWidgets('App smoke test initializes properly', (WidgetTester tester) async {
    await setupGetIt();
    await tester.pumpWidget(const MediConnectApp());
  });
}
