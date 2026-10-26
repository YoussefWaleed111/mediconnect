import 'package:shared_preferences/shared_preferences.dart';

abstract class OnboardingLocalDataSource {
  Future<bool> isOnboardingCompleted();
  Future<void> setOnboardingCompleted();
}

class OnboardingLocalDataSourceImpl implements OnboardingLocalDataSource {
  static const String _kOnboardingCompletedKey = 'kOnboardingCompleted';
  final SharedPreferences? _sharedPreferences;

  OnboardingLocalDataSourceImpl({SharedPreferences? sharedPreferences})
      : _sharedPreferences = sharedPreferences;

  @override
  Future<bool> isOnboardingCompleted() async {
    try {
      final prefs = _sharedPreferences ?? await SharedPreferences.getInstance();
      return prefs.getBool(_kOnboardingCompletedKey) ?? false;
    } catch (_) {
      return false;
    }
  }

  @override
  Future<void> setOnboardingCompleted() async {
    try {
      final prefs = _sharedPreferences ?? await SharedPreferences.getInstance();
      await prefs.setBool(_kOnboardingCompletedKey, true);
    } catch (_) {}
  }
}
