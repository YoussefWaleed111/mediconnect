import 'package:mediconnect/core/errors/exceptions.dart';

abstract class AuthLocalDataSource {
  Future<void> saveToken(String token);
  Future<String?> getToken();
  Future<void> clear();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  String? _cachedToken;

  @override
  Future<void> saveToken(String token) async {
    try {
      _cachedToken = token;
    } catch (e) {
      throw CacheException(message: e.toString());
    }
  }

  @override
  Future<String?> getToken() async {
    try {
      return _cachedToken;
    } catch (e) {
      throw CacheException(message: e.toString());
    }
  }

  @override
  Future<void> clear() async {
    try {
      _cachedToken = null;
    } catch (e) {
      throw CacheException(message: e.toString());
    }
  }
}
