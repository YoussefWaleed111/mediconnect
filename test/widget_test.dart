import 'package:flutter_test/flutter_test.dart';
import 'package:mediconnect/core/di/dependency_injection.dart';
import 'package:mediconnect/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    await getIt.reset();
  });

  testWidgets('App smoke test initializes properly', (WidgetTester tester) async {
    await setupGetIt();
    await tester.pumpWidget(const MediConnectApp());
    await tester.pump(const Duration(seconds: 3));
    await tester.pumpAndSettle();
  });
}
